// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'word_frequency_api.g.dart';

// infrastructure

@riverpod
Future<FrequencyReport> frequencyReport(Ref ref, FrequencyFilter filter) async {
  log.info(() => '@riverpod - $filter');
  ref.cacheFor(const Duration(minutes: 5));
  final db = await ref.watch(dbProvider.future);
  final repo = WordFrequencyRepository(db);
  return GetFrequencyReportUseCase(repo, filter).invoke();
}

class WordFrequencyRepository implements IWordFrequencyRepository {
  WordFrequencyRepository(
    this._db,
  );

  final AppDb _db;

  @override
  Future<FrequencyReport> getReport(FrequencyFilter f) async => switch (f) {
    FrequencyFilter(groupByLemma: true) => await _lemmaReport(f),
    FrequencyFilter(showMacrons: true) => await _macronReport(f),
    _ => await _plainReport(f),
  };

  Future<FrequencyReport> _plainReport(FrequencyFilter f) async {
    final rows = await _db.wordFrequencyDrift
        .getFormFrequencies(f.workIds, limit: f.limit, offset: f.offset)
        .get();
    final totalLemmas = await _db.wordFrequencyDrift.getTotalLemmasInScope(f.workIds).getSingle();
    return FrequencyReport(
      rows: FrequencyRows(
        rows.map(
          // Macrons OFF: plain form is both display AND lookup
          (r) => FrequencyRow(
            displayForm: r.form,
            lookupForm: r.form,
            occurrences: r.occurrences ?? 0,
          ),
        ),
      ),
      totalForms: rows.firstOrNull?.totalForms ?? 0,
      totalTokens: rows.firstOrNull?.totalTokens ?? 0,
      totalLemmas: totalLemmas,
      offset: f.offset,
    );
  }

  Future<FrequencyReport> _macronReport(FrequencyFilter f) async {
    final rows = await _db.wordFrequencyDrift
        .getMacronFormFrequencies(f.workIds, limit: f.limit, offset: f.offset)
        .get();
    final totalLemmas = await _db.wordFrequencyDrift.getTotalLemmasInScope(f.workIds).getSingle();
    return FrequencyReport(
      rows: FrequencyRows(
        rows.map(
          // Macrons ON: macronForm is display, form (=MIN plain) is lookup
          (r) => FrequencyRow(
            displayForm: r.macronForm,
            lookupForm: r.form!,
            occurrences: r.occurrences ?? 0,
          ),
        ),
      ),
      totalForms: rows.firstOrNull?.totalForms ?? 0,
      totalTokens: rows.firstOrNull?.totalTokens ?? 0,
      totalLemmas: totalLemmas,
      offset: f.offset,
    );
  }

  Future<FrequencyReport> _lemmaReport(FrequencyFilter f) async {
    final rows = await _db.wordFrequencyDrift
        .getLemmaFrequencies(f.workIds, limit: f.limit, offset: f.offset)
        .get();
    return FrequencyReport(
      rows: FrequencyRows(
        rows.map(
          // Lemma mode: dictionaryRef is both display AND lookup
          (r) => FrequencyRow(
            displayForm: r.dictionaryRef,
            lookupForm: r.dictionaryRef,
            occurrences: r.occurrences ?? 0,
          ),
        ),
      ),
      totalForms: 0,
      totalTokens: rows.firstOrNull?.totalTokens ?? 0,
      totalLemmas: rows.firstOrNull?.totalLemmas ?? 0,
      offset: f.offset,
    );
  }

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
    this.limit = 100,
    this.offset = 0,
    this.groupByLemma = false,
    this.showMacrons = true,
  });

  final List<String> workIds;
  final int limit;
  final int offset;
  final bool groupByLemma;
  final bool showMacrons;

  FrequencyFilter copyWith({
    List<String>? workIds,
    int? limit,
    int? offset,
    bool? groupByLemma,
    bool? showMacrons,
  }) => FrequencyFilter(
    workIds: workIds ?? this.workIds,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    groupByLemma: groupByLemma ?? this.groupByLemma,
    showMacrons: showMacrons ?? this.showMacrons,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyFilter &&
          const ListEquality<String>().equals(other.workIds, workIds) &&
          other.limit == limit &&
          other.offset == offset &&
          other.groupByLemma == groupByLemma &&
          other.showMacrons == showMacrons);

  @override
  int get hashCode => Object.hash(
    const ListEquality<String>().hash(workIds),
    limit,
    offset,
    groupByLemma,
    showMacrons,
  );

  @override
  String toString() =>
      'FrequencyFilter{works: ${workIds.length}, '
      'limit: $limit, offset: $offset, '
      'lemma: $groupByLemma, macrons: $showMacrons}';
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
class FrequencyRow {
  const FrequencyRow({
    required this.displayForm,
    required this.lookupForm,
    required this.occurrences,
  });

  final String displayForm;
  final String lookupForm;
  final int occurrences;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FrequencyRow && other.displayForm == displayForm);

  @override
  int get hashCode => displayForm.hashCode;
  //
}

@immutable
class FrequencyReport {
  const FrequencyReport({
    required this.rows,
    required this.totalForms,
    required this.totalTokens,
    required this.totalLemmas,
    required this.offset,
  });

  final FrequencyRows rows;
  final int totalForms;
  final int totalTokens;
  final int totalLemmas;
  final int offset;

  double relativeFrequency(int occurrences) =>
      totalTokens > 0 ? occurrences / totalTokens * 1000 : 0;
  //
}

@immutable
class LemmaFrequencyRow {
  const LemmaFrequencyRow({
    required this.dictionaryRef,
    required this.occurrences,
    required this.totalLemmas,
    required this.totalTokens,
  });

  final String dictionaryRef;
  final int occurrences;
  final int totalLemmas;
  final int totalTokens;
  //
}
