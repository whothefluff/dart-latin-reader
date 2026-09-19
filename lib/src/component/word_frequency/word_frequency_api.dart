// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'resolved_freq_morph_form_api.dart' show WorkIds;
import 'word_frequency.drift.dart';

part 'word_frequency_api.g.dart';

//infrastructure

@riverpod
Future<FrequencyReport> frequencyReport(Ref ref, FrequencyFilter filter) async {
  log.info(() => '@riverpod - using $filter');
  ref.cacheFor(const Duration(minutes: 5));
  final db = await ref.watch(dbProvider.future);
  final repo = WordFrequencyRepository(db.wordFrequencyDrift);
  return GetFrequencyReportUseCase(repo, filter).invoke();
}

class WordFrequencyRepository implements IWordFrequencyRepository {
  WordFrequencyRepository(
    this._db,
  );

  final WordFrequencyDrift _db;

  @override
  Future<FrequencyReport> getReport(filter) async {
    final totals = await _getTotals(filter);
    final rows = await switch (filter) {
      FrequencyFilter(groupByLemma: true, ascending: true) => _lemmaRowsAsc(filter),
      FrequencyFilter(groupByLemma: true, ascending: false) => _lemmaRowsDesc(filter),
      FrequencyFilter(showMacrons: true, ascending: true) => _macronRowsAsc(filter),
      FrequencyFilter(showMacrons: true, ascending: false) => _macronRowsDesc(filter),
      FrequencyFilter(ascending: true) => _plainRowsAsc(filter),
      FrequencyFilter(ascending: false) => _plainRowsDesc(filter),
    };
    return FrequencyReport(
      rows: rows,
      totalForms: totals.totalForms,
      coverage: totals.coverage,
      totalLemmas: totals.totalLemmas,
      offset: filter.offset,
    );
  }

  // ── Totals ──

  Future<_Totals> _getTotals(FrequencyFilter f) async {
    final coverage = await _db.getFrequencyCoverage(f.workIds).getSingle();
    final totalLemmas = await _db.getTotalLemmas(f.workIds).getSingle();
    final totalForms = f.groupByLemma
        ? 0
        : (f.showMacrons
              ? await _db.getTotalMacronForms(f.workIds).getSingle()
              : await _db.getTotalForms(f.workIds).getSingle());
    return _Totals(
      totalForms: totalForms,
      coverage: coverage,
      totalLemmas: totalLemmas,
    );
  }

  Future<FrequencyRows> _plainRowsDesc(FrequencyFilter f) async {
    final rows = await _db
        .getFormFrequenciesDesc(workIds: f.workIds, limit: f.pageSize, offset: f.offset)
        .get();
    return FrequencyRows(rows);
  }

  Future<FrequencyRows> _plainRowsAsc(FrequencyFilter f) async {
    final rows = await _db
        .getFormFrequenciesAsc(workIds: f.workIds, limit: f.pageSize, offset: f.offset)
        .get();
    return FrequencyRows(rows);
  }

  Future<FrequencyRows> _macronRowsDesc(FrequencyFilter f) async {
    final rows = await _db
        .getMacronFormFrequenciesDesc(workIds: f.workIds, limit: f.pageSize, offset: f.offset)
        .get();
    return FrequencyRows(rows);
  }

  Future<FrequencyRows> _macronRowsAsc(FrequencyFilter f) async {
    final rows = await _db
        .getMacronFormFrequenciesAsc(workIds: f.workIds, limit: f.pageSize, offset: f.offset)
        .get();
    return FrequencyRows(rows);
  }

  Future<FrequencyRows> _lemmaRowsDesc(FrequencyFilter f) async {
    final rows = await _db
        .getLemmaFrequenciesDesc(f.workIds, limit: f.pageSize, offset: f.offset)
        .get();
    return FrequencyRows(rows);
  }

  Future<FrequencyRows> _lemmaRowsAsc(FrequencyFilter f) async {
    final rows = await _db
        .getLemmaFrequenciesAsc(f.workIds, limit: f.pageSize, offset: f.offset)
        .get();
    return FrequencyRows(rows);
  }

  //
}

class _Totals {
  const _Totals({
    required this.totalForms,
    required this.coverage,
    required this.totalLemmas,
  });

  final int totalForms;
  final FrequencyCoverage coverage;
  final int totalLemmas;
  //
}

// interactors

abstract interface class IWordFrequencyRepository {
  //
  Future<FrequencyReport> getReport(FrequencyFilter filter);
  //
}

class GetFrequencyReportUseCase {
  GetFrequencyReportUseCase(
    this._repo,
    this._filter,
  );

  final IWordFrequencyRepository _repo;
  final FrequencyFilter _filter;

  Future<FrequencyReport> invoke() => _repo.getReport(_filter);
  //
}

// domain

@immutable
class FrequencyFilter {
  const FrequencyFilter({
    required this.workIds,
    required this.pageSize,
    this.offset = 0,
    this.ascending = false,
    this.groupByLemma = false,
    this.showMacrons = true,
  });

  final WorkIds workIds;
  final int pageSize;
  final int offset;
  final bool ascending;
  final bool groupByLemma;
  final bool showMacrons;

  FrequencyFilter copyWith({
    WorkIds? workIds,
    int? pageSize,
    int? offset,
    bool? ascending,
    bool? groupByLemma,
    bool? showMacrons,
  }) => FrequencyFilter(
    workIds: workIds ?? this.workIds,
    pageSize: pageSize ?? this.pageSize,
    offset: offset ?? this.offset,
    ascending: ascending ?? this.ascending,
    groupByLemma: groupByLemma ?? this.groupByLemma,
    showMacrons: showMacrons ?? this.showMacrons,
  );

  @override
  String toString() =>
      'FrequencyFilter{'
      'works: ${workIds.length}, '
      'pageSize: $pageSize, '
      'offset: $offset, '
      'ascending: $ascending, '
      'lemma: $groupByLemma, '
      'macrons: $showMacrons}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyFilter &&
          other.workIds == workIds &&
          other.pageSize == pageSize &&
          other.offset == offset &&
          other.ascending == ascending &&
          other.groupByLemma == groupByLemma &&
          other.showMacrons == showMacrons);

  @override
  int get hashCode => Object.hash(
    workIds,
    pageSize,
    offset,
    ascending,
    groupByLemma,
    showMacrons,
  );
  //
}

@immutable
extension type const FrequencyRows._(UnmodifiableListView<FrequencyRow> unm)
    implements UnmodifiableListView<FrequencyRow> {
  FrequencyRows(
    Iterable<FrequencyRow> iter,
  ) : this._(UnmodifiableListView(iter));
}

@immutable
sealed class FrequencyRow {
  const FrequencyRow({
    required this.displayForm,
    required this.lookupForm,
  });

  final String displayForm;
  final String lookupForm;

  /// The form's occurrence count, or the lemma's possible occurrence count
  int get occurrences;

  @override
  String toString() => 'FrequencyRow{form: $displayForm, occurrences: $occurrences}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyRow &&
          other.runtimeType == runtimeType &&
          other.displayForm == displayForm &&
          other.lookupForm == lookupForm);

  @override
  int get hashCode => Object.hash(runtimeType, displayForm, lookupForm);
  //
}

/// A word form and its occurrence count in the selected works
final class FormFrequencyRow extends FrequencyRow {
  const FormFrequencyRow({
    required super.displayForm,
    required super.lookupForm,
    required this.occurrences,
    this.possibleLemmas,
  });

  const FormFrequencyRow.fromFormSql({
    required String form,
    required int? occurrences,
    String? possibleLemmas,
  }) : this(
         displayForm: form,
         lookupForm: form,
         occurrences: occurrences ?? 0,
         possibleLemmas: possibleLemmas,
       );

  const FormFrequencyRow.fromMacronFormSql({
    required String macronForm,
    required String? form,
    required int? occurrences,
    String? possibleLemmas,
  }) : this(
         displayForm: macronForm,
         lookupForm: form ?? '',
         occurrences: occurrences ?? 0,
         possibleLemmas: possibleLemmas,
       );

  @override
  final int occurrences;
  final String? possibleLemmas;
  //
}

/// A lemma and its possible occurrence counts in the selected works
final class LemmaFrequencyRow extends FrequencyRow {
  const LemmaFrequencyRow.fromLemmaSql({
    required String dictionaryRef,
    required int? possibleOccurrences,
    required int? singleCandidateOccurrences,
  }) : possibleOccurrences = possibleOccurrences ?? 0,
       singleCandidateOccurrences = singleCandidateOccurrences ?? 0,
       super(displayForm: dictionaryRef, lookupForm: dictionaryRef);

  /// Occurrences that could belong to this lemma.
  /// The same occurrence can count towards several lemmas.
  final int possibleOccurrences;

  /// Occurrences for which no other candidate lemma was found.
  final int singleCandidateOccurrences;

  @override
  int get occurrences => possibleOccurrences;
  //
}

@immutable
class FrequencyReport {
  const FrequencyReport({
    required this.rows,
    required this.totalForms,
    required this.coverage,
    required this.totalLemmas,
    required this.offset,
  });

  final FrequencyRows rows;
  final int totalForms;
  final FrequencyCoverage coverage;
  final int totalLemmas;
  final int offset;

  int get totalTokens => coverage.totalTokens;

  // TODO(whothefluff): FREQ is COUNT times a constant, so it adds nothing within a report.
  //  Replace it with something like a cumulative text coverage.
  //  The page's FREQ. column changes with it
  double relativeFrequency(int occurrences) =>
      totalTokens > 0 ? occurrences / totalTokens * 1000 : 0;

  @override
  String toString() =>
      'FrequencyReport{rows: ${rows.length}, totalTokens: $totalTokens, offset: $offset}';
  //
}

@immutable
class FrequencyCoverage {
  const FrequencyCoverage({
    required int? totalTokens,
    required int? noCandidateTokens,
    required int? singleCandidateTokens,
    required int? multipleCandidateTokens,
  }) : totalTokens = totalTokens ?? 0,
       noCandidateTokens = noCandidateTokens ?? 0,
       singleCandidateTokens = singleCandidateTokens ?? 0,
       multipleCandidateTokens = multipleCandidateTokens ?? 0;

  final int totalTokens;
  final int noCandidateTokens;
  final int singleCandidateTokens;
  final int multipleCandidateTokens;

  @override
  String toString() =>
      'FrequencyCoverage{'
      'totalTokens: $totalTokens, '
      'noCandidateTokens: $noCandidateTokens, '
      'singleCandidateTokens: $singleCandidateTokens, '
      'multipleCandidateTokens: $multipleCandidateTokens}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyCoverage &&
          other.totalTokens == totalTokens &&
          other.noCandidateTokens == noCandidateTokens &&
          other.singleCandidateTokens == singleCandidateTokens &&
          other.multipleCandidateTokens == multipleCandidateTokens);

  @override
  int get hashCode => Object.hash(
    totalTokens,
    noCandidateTokens,
    singleCandidateTokens,
    multipleCandidateTokens,
  );
  //
}
