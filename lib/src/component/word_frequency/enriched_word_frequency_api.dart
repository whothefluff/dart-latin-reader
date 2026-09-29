import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/provider_ext.dart';
import 'text_coverage_api.dart' show TextCoverage, textCoverageProvider;
import 'word_frequency_api.dart';

part 'enriched_word_frequency_api.g.dart';

//infrastructure

@riverpod
Future<EnrichedFrequencyReport> enrichedFrequencyReport(
  Ref ref,
  FrequencyFilter filter,
) async {
  log.info(() => '@riverpod - using $filter');
  ref.cacheFor(const Duration(minutes: 5));
  final report = await ref.watch(frequencyReportProvider(filter).future);
  final textCoverage = await ref.watch(
    textCoverageProvider(filter.workIds, filter.coverageBasis).future,
  );
  final certainBasis = filter.certainCoverageBasis;
  final certainCoverage = certainBasis == null
      ? null
      : await ref.watch(textCoverageProvider(filter.workIds, certainBasis).future);
  return EnrichedFrequencyReport(
    base: report,
    textCoverage: textCoverage,
    certainCoverage: certainCoverage,
    rows: EnrichedFrequencyRows(
      report.rows.map(
        (r) => EnrichedFrequencyRow(
          base: r,
          possibleLemmas: switch (r) {
            // for lemmas, displayForm *is* the dictionaryRef
            LemmaFrequencyRow() => [r.displayForm],
            FormFrequencyRow(:final possibleLemmas) => possibleLemmas?.split(','),
          },
        ),
      ),
    ),
  );
  //
}

//domain

@immutable
extension type const EnrichedFrequencyRows._(UnmodifiableListView<EnrichedFrequencyRow> unm)
    implements UnmodifiableListView<EnrichedFrequencyRow> {
  EnrichedFrequencyRows(
    Iterable<EnrichedFrequencyRow> iter,
  ) : this._(UnmodifiableListView(iter));
}

@immutable
class EnrichedFrequencyRow {
  const EnrichedFrequencyRow({
    required this.base,
    this.possibleLemmas,
  });

  final FrequencyRow base;
  final List<String>? possibleLemmas;

  String get displayForm => base.displayForm;
  String get lookupForm => base.lookupForm;
  int get occurrences => base.occurrences;
  String? get lemmaDisplay => possibleLemmas?.join(', ');

  @override
  String toString() => 'EnrichedFrequencyRow{form: $displayForm, lemmas: $lemmaDisplay}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is EnrichedFrequencyRow && other.base == base);

  @override
  int get hashCode => base.hashCode;
  //
}

@immutable
class EnrichedFrequencyReport {
  const EnrichedFrequencyReport({
    required this.base,
    required this.textCoverage,
    required this.certainCoverage,
    required this.rows,
  });

  final FrequencyReport base;

  /// Coverage for the full work selection, independent of pagination.
  final TextCoverage textCoverage;

  /// Lower bound for lemma reports.
  /// Null for form reports.
  final TextCoverage? certainCoverage;
  final EnrichedFrequencyRows rows;

  int get totalForms => base.totalForms;
  int get totalTokens => base.totalTokens;
  int get totalLemmas => base.totalLemmas;
  int get offset => base.offset;

  /// Distinct candidate lemmas among [rows]
  int get representedLemmas =>
      rows.expand((r) => r.possibleLemmas ?? const <String>[]).toSet().length;

  @override
  String toString() =>
      'EnrichedFrequencyReport{rows: ${rows.length}, totalTokens: $totalTokens, offset: $offset}';
  //
}
