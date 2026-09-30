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

part 'text_coverage_api.g.dart';

//infrastructure

@riverpod
Future<TextCoverage> textCoverage(
  Ref ref,
  WorkIds workIds,
  CoverageBasis basis,
) async {
  log.info(() => '@riverpod - by ${basis.name} in ${workIds.length} works');
  ref.cacheFor(const Duration(minutes: 5));
  final db = await ref.watch(dbProvider.future);
  final repo = WordFrequencyRepository(db.wordFrequencyDrift);
  return GetTextCoverageUseCase(repo, workIds, basis).invoke();
}

class WordFrequencyRepository implements IWordFrequencyRepository {
  WordFrequencyRepository(
    this._db,
  );

  final WordFrequencyDrift _db;

  @override
  Future<TextCoverage> getTextCoverage(workIds, basis) async {
    log.fine(() => 'reading the text coverage by ${basis.name} from db');
    final totals = await _db.getFrequencyCoverage(workIds).getSingle();
    final query = switch (basis) {
      CoverageBasis.form => _db.getFormCoverageSteps(workIds: workIds),
      CoverageBasis.macronForm => _db.getMacronFormCoverageSteps(workIds: workIds),
      CoverageBasis.anyCandidateLemma => _db.getAnyCandidateLemmaCoverageSteps(workIds: workIds),
      CoverageBasis.allCandidateLemmas => _db.getAllCandidateLemmasCoverageSteps(workIds: workIds),
    };
    return TextCoverage(steps: await query.get(), totalUnits: totals.totalTokens);
  }

  //
}

//interactors

abstract interface class IWordFrequencyRepository {
  //
  Future<TextCoverage> getTextCoverage(WorkIds workIds, CoverageBasis basis);
  //
}

class GetTextCoverageUseCase implements IGetTextCoverageUseCase {
  GetTextCoverageUseCase(
    this._repository,
    this._workIds,
    this._basis,
  );

  final IWordFrequencyRepository _repository;
  final WorkIds _workIds;
  final CoverageBasis _basis;

  @override
  Future<TextCoverage> invoke() async => _repository.getTextCoverage(_workIds, _basis);
  //
}

//domain

abstract interface class IGetTextCoverageUseCase {
  //
  Future<TextCoverage> invoke();
  //
}

/// Lemma bounds use the available analyses; units without candidates stay uncovered.
enum CoverageBasis {
  form,
  macronForm,

  /// Upper bound: each unit uses its most frequent candidate lemma.
  anyCandidateLemma,

  /// Lower bound: each unit uses its least frequent candidate lemma.
  allCandidateLemmas,
}

/// Units covered by all items occurring at least [minOccurrences] times.
@immutable
class TextCoverageStep {
  // nullable: drift types the SUM/MAX/MIN behind both columns as nullable
  const TextCoverageStep({
    required int? minOccurrences,
    required int? coveredUnits,
  }) : minOccurrences = minOccurrences ?? 0,
       coveredUnits = coveredUnits ?? 0;

  final int minOccurrences;
  final int coveredUnits;

  @override
  String toString() =>
      'TextCoverageStep{minOccurrences: $minOccurrences, coveredUnits: $coveredUnits}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TextCoverageStep &&
          other.minOccurrences == minOccurrences &&
          other.coveredUnits == coveredUnits);

  @override
  int get hashCode => Object.hash(minOccurrences, coveredUnits);
  //
}

/// Cumulative text coverage, with equally frequent items included together.
@immutable
class TextCoverage {
  TextCoverage({
    required Iterable<TextCoverageStep> steps,
    required this.totalUnits,
  }) : _steps = List.unmodifiable(steps.sortedBy<num>((s) => s.minOccurrences));

  final List<TextCoverageStep> _steps;

  /// Includes units with no candidate lemma.
  final int totalUnits;

  /// Units covered by items occurring at least [atLeast] times.
  int unitsCovered({required int atLeast}) =>
      _steps.firstWhereOrNull((s) => s.minOccurrences >= atLeast)?.coveredUnits ?? 0;

  /// Fraction of all units covered; zero for an empty selection.
  double share({required int atLeast}) => _shareOf(unitsCovered(atLeast: atLeast));

  /// Highest occurrence threshold that reaches [share] (0–1), or null if unreachable.
  int? cutoffFor(double share) {
    assert(share >= 0 && share <= 1, 'A share goes from 0 to 1, not $share');
    //multiplying the target by totalUnits can round above an exact match
    return _steps.lastWhereOrNull((s) => _shareOf(s.coveredUnits) >= share)?.minOccurrences;
  }

  /// Highest count among the rarest items that make up [share] (0–1), or null if unreachable.
  int? rareCutoffFor(double share) {
    assert(share >= 0 && share <= 1, 'A share goes from 0 to 1, not $share');
    final coveredAll = unitsCovered(atLeast: 0);
    return _steps
        .mapIndexed(
          (i, step) => (
            count: step.minOccurrences,
            units: coveredAll - (i + 1 < _steps.length ? _steps[i + 1].coveredUnits : 0),
          ),
        )
        .firstWhereOrNull((rarest) => _shareOf(rarest.units) >= share)
        ?.count;
  }

  double _shareOf(int units) => totalUnits > 0 ? units / totalUnits : 0;

  @override
  String toString() => 'TextCoverage{steps: ${_steps.length}, totalUnits: $totalUnits}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TextCoverage &&
          other.totalUnits == totalUnits &&
          const ListEquality<TextCoverageStep>().equals(other._steps, _steps));

  @override
  int get hashCode => Object.hash(totalUnits, const ListEquality<TextCoverageStep>().hash(_steps));
  //
}
