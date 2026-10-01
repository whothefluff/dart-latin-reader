// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../core/value_list.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import '../library/catalog_api.dart';
import '../library/proper_noun_state.dart';
import 'resolved_freq_morph_form_api.dart' show WorkIds;
import 'text_coverage_api.dart';
import 'word_frequency.drift.dart';

part 'lookup_frequency_api.g.dart';

//infrastructure

/// Returns the most frequent candidate lemma's count for each form in [lookupForms],
/// plus any-candidate text coverage for the works selected by [scope] and [workId].
@riverpod
Future<LookupFrequencies> lookupFrequencies(
  Ref ref,
  String workId,
  FrequencyScope scope,
  LookupForms lookupForms,
) async {
  log.info(() => '@riverpod - ${lookupForms.length} forms within the ${scope.name} of $workId');
  ref.cacheFor(const Duration(minutes: 2));
  final catalog = await ref.watch(libraryCatalogProvider.future);
  final workIds = scope.workIdsFor(workId, catalog);
  final coverage = await ref.watch(
    textCoverageProvider(workIds, CoverageBasis.anyCandidateLemma).future,
  );
  final db = await ref.watch(dbProvider.future);
  final repo = WordFrequencyRepository(db.wordFrequencyDrift);
  final counts = await GetLookupBestCountsUseCase(repo, workIds, lookupForms).invoke();
  return LookupFrequencies(counts: counts, coverage: coverage);
}

class WordFrequencyRepository implements IWordFrequencyRepository {
  WordFrequencyRepository(
    this._db,
  );

  final WordFrequencyDrift _db;

  @override
  Future<List<LookupCount>> getBestCounts(workIds, lookupForms) async {
    log.fine(() => 'reading the best candidate counts of ${lookupForms.length} forms from db');
    return _db.getLookupBestCounts(workIds: workIds, lookupForms: lookupForms).get();
  }

  //
}

//interactors

abstract interface class IWordFrequencyRepository {
  //
  Future<List<LookupCount>> getBestCounts(WorkIds workIds, LookupForms lookupForms);
  //
}

class GetLookupBestCountsUseCase implements IGetLookupBestCountsUseCase {
  GetLookupBestCountsUseCase(
    this._repository,
    this._workIds,
    this._lookupForms,
  );

  final IWordFrequencyRepository _repository;
  final WorkIds _workIds;
  final LookupForms _lookupForms;

  @override
  Future<List<LookupCount>> invoke() async => _repository.getBestCounts(_workIds, _lookupForms);
  //
}

//domain

abstract interface class IGetLookupBestCountsUseCase {
  //
  Future<List<LookupCount>> invoke();
  //
}

/// Which works frequencies are counted in.
enum FrequencyScope {
  work,
  author,
  library;

  /// The works of [workId].
  /// Sorted and deduplicated, so equal scopes are equal provider keys.
  WorkIds workIdsFor(String workId, LibraryCatalog catalog) {
    final ids = switch (this) {
      FrequencyScope.work => [workId],
      //a work with several authors takes the works of all of them
      FrequencyScope.author =>
        catalog.authors
            .where((author) => author.works.any((work) => work.id == workId))
            .expand((author) => author.works.map((work) => work.id))
            .followedBy([workId]),
      FrequencyScope.library => catalog.allWorkIds,
    };
    return WorkIds(ids.toSet().sorted((a, b) => a.compareTo(b)));
  }
}

/// A word's frequency category, based on its most frequent candidate lemma.
enum FrequencyBand { common, uncommon }

/// Lookup forms that compare equal regardless of their original order or duplicates.
@immutable
extension type const LookupForms._(ValueList<String> unm) implements ValueList<String> {
  LookupForms(
    Iterable<String> iter,
  ) : this._(ValueList(iter.toSet().sorted((a, b) => a.compareTo(b))));
}

/// How a word is looked up in the analyses, which decides its candidate lemmas
@immutable
class Lookup {
  const Lookup({
    required this.lookupForm,
    required this.alsoLowercase,
  });

  /// Creates a lookup that also searches lowercase when [properNounState] is
  /// [ProperNounState.either].
  const Lookup.of(
    String lookupForm,
    ProperNounState? properNounState,
  ) : this(lookupForm: lookupForm, alsoLowercase: properNounState == ProperNounState.either);

  final String lookupForm;
  final bool alsoLowercase;

  @override
  String toString() => 'Lookup{lookupForm: $lookupForm, alsoLowercase: $alsoLowercase}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lookup && other.lookupForm == lookupForm && other.alsoLowercase == alsoLowercase);

  @override
  int get hashCode => Object.hash(lookupForm, alsoLowercase);
  //
}

/// A lookup and the occurrence count of its most frequent candidate lemma.
@immutable
class LookupCount {
  // nullable: drift types the MAX as nullable
  const LookupCount({
    required this.lookupForm,
    required this.alsoLowercase,
    required int? occurrences,
  }) : occurrences = occurrences ?? 0;

  final String lookupForm;
  final bool alsoLowercase;
  final int occurrences;

  @override
  String toString() =>
      'LookupCount{lookupForm: $lookupForm, alsoLowercase: $alsoLowercase, '
      'occurrences: $occurrences}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LookupCount &&
          other.lookupForm == lookupForm &&
          other.alsoLowercase == alsoLowercase &&
          other.occurrences == occurrences);

  @override
  int get hashCode => Object.hash(lookupForm, alsoLowercase, occurrences);
  //
}

/// Lookup counts, each the one its units enter [coverage] at, so they compare with its cutoffs.
@immutable
class LookupFrequencies {
  LookupFrequencies({
    required Iterable<LookupCount> counts,
    required this.coverage,
  }) : _counts = Map.unmodifiable(
         Map.fromEntries(
           counts.map(
             (count) => MapEntry(
               Lookup(lookupForm: count.lookupForm, alsoLowercase: count.alsoLowercase),
               count.occurrences,
             ),
           ),
         ),
       );

  final Map<Lookup, int> _counts;
  final TextCoverage coverage;

  /// Cutoffs for at least [commonPercent]% and [uncommonPercent]% of the text, computed once.
  /// A band left out gets no cutoff, so it never takes words from the other.
  FrequencyBands bandsFor({
    required int commonPercent,
    required int uncommonPercent,
    required bool markCommon,
    required bool markUncommon,
  }) => FrequencyBands._(
    _counts,
    commonCutoff: markCommon ? coverage.cutoffFor(commonPercent / 100) : null,
    uncommonCutoff: markUncommon ? coverage.rareCutoffFor(uncommonPercent / 100) : null,
  );

  @override
  String toString() => 'LookupFrequencies{lookups: ${_counts.length}, coverage: $coverage}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LookupFrequencies &&
          other.coverage == coverage &&
          const MapEquality<Lookup, int>().equals(other._counts, _counts));

  @override
  int get hashCode => Object.hash(coverage, const MapEquality<Lookup, int>().hash(_counts));
  //
}

/// Classifies lookups by comparing their highest candidate lemma count with
/// the common and uncommon cutoffs.
@immutable
class FrequencyBands {
  const FrequencyBands._(
    this._counts, {
    required this.commonCutoff,
    required this.uncommonCutoff,
  });

  final Map<Lookup, int> _counts;

  /// Minimum count for a common lookup.
  /// `null` if the band is left out or the requested coverage cannot be reached.
  final int? commonCutoff;

  /// Maximum count for an uncommon lookup.
  /// `null` if the band is left out or the requested coverage cannot be reached.
  final int? uncommonCutoff;

  /// Returns [lookup]'s band, or `null` if it has no count or falls outside both bands.
  /// Returns [FrequencyBand.common] if both bands match.
  FrequencyBand? bandOf(Lookup lookup) {
    final count = _counts[lookup];
    final commonCutoff = this.commonCutoff;
    final uncommonCutoff = this.uncommonCutoff;
    return count == null
        ? null
        : commonCutoff != null && count >= commonCutoff
        ? FrequencyBand.common
        : uncommonCutoff != null && count <= uncommonCutoff
        ? FrequencyBand.uncommon
        : null;
  }

  @override
  String toString() =>
      'FrequencyBands{commonCutoff: $commonCutoff, uncommonCutoff: $uncommonCutoff}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyBands &&
          other.commonCutoff == commonCutoff &&
          other.uncommonCutoff == uncommonCutoff &&
          const MapEquality<Lookup, int>().equals(other._counts, _counts));

  @override
  int get hashCode => Object.hash(
    commonCutoff,
    uncommonCutoff,
    const MapEquality<Lookup, int>().hash(_counts),
  );
  //
}
