// Exception for APIs

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/provider_ext.dart';
import 'form_lemmas_api.dart';
import 'word_frequency_api.dart';

part 'enriched_word_frequency_api.g.dart';

//infrastructure

@riverpod
Future<EnrichedFrequencyReport> enrichedFrequencyReport(
  Ref ref,
  FrequencyFilter filter,
) async {
  log.info(() => '@riverpod - $filter');
  ref.cacheFor(const Duration(minutes: 5));
  final report = await ref.watch(frequencyReportProvider(filter).future);
  if (filter.groupByLemma) {
    // Lemma mode: displayForm is the dictionaryRef, no enrichment needed
    return EnrichedFrequencyReport(
      base: report,
      rows: EnrichedFrequencyRows(
        report.rows.map(
          (r) => EnrichedFrequencyRow(base: r, possibleLemmas: [r.displayForm]),
        ),
      ),
    );
  }
  // Form mode: batch-fetch lemmas using the plain-domain lookup form
  final lookupForms = Forms(report.rows.map((r) => r.lookupForm).toSet());
  final lemmaMap = lookupForms.isNotEmpty
      ? await ref.read(formLemmasProvider(lookupForms).future)
      : FormLemmaMap(const {});
  return EnrichedFrequencyReport(
    base: report,
    rows: EnrichedFrequencyRows(
      report.rows.map(
        (r) => EnrichedFrequencyRow(
          base: r,
          possibleLemmas: lemmaMap[r.lookupForm],
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
    required this.rows,
  });

  final FrequencyReport base;
  final EnrichedFrequencyRows rows;

  int get totalForms => base.totalForms;
  int get totalTokens => base.totalTokens;
  int get totalLemmas => base.totalLemmas;
  int get offset => base.offset;
  double relativeFrequency(int occ) => base.relativeFrequency(occ);
  //
}
