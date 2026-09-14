import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/provider_ext.dart';
import '../dictionary/lewis_and_short_basic_info_api.dart';
import '../dictionary/lns_enricher.dart';
import 'morphological_search_api.dart';

part 'enriched_morph_search_api.g.dart';

//infrastructure

@riverpod
Future<EnrichedResults> enrichedMorphologicalSearch(Ref ref, String form) async {
  log.info(() => '@riverpod - using $form');
  ref.cacheFor(const Duration(minutes: 5));
  final results = await ref.watch(morphologicalSearchProvider(form).future);
  final enrichedItems = await enrichWithLns(
    ref: ref,
    items: results,
    getDictRef: (result) => result.dictionaryRef,
    createEnriched: (result, lnsInfo) => EnrichedResult(base: result, lns: lnsInfo),
  );
  return EnrichedResults(enrichedItems);
  //
}

//domain

@immutable
extension type const EnrichedResults._(UnmodifiableListView<EnrichedResult> unm)
    implements UnmodifiableListView<EnrichedResult> {
  EnrichedResults(
    Iterable<EnrichedResult> iter,
  ) : this._(UnmodifiableListView(iter));
}

@immutable
class EnrichedResult {
  const EnrichedResult({
    required this.base,
    required this.lns,
  });

  final Result base;
  final LnsBasicInfoEntry lns;

  // Delegate properties for easier access
  String get form => base.form;
  int get item => base.item;
  int get cnt => base.cnt;
  String? get macronizedForm => base.macronizedForm;

  /// Contains the value as it is found in the morphological analysis (which
  /// does not match the dictionary perfectly)
  String get dictionaryRef => base.dictionaryRef;
  String? get partOfSpeech => base.partOfSpeech;
  String? get additional => base.additional;

  /// Contains the value as it is actually found in the dictionary
  String? get lnsLemma => lns.lemma;
  String? get lnsInflection => lns.inflection;
  String? get lnsPartOfSpeech => lns.partOfSpeech;

  @override
  String toString() => 'EnrichedResult{form: $form, item: $item, cnt: $cnt}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is EnrichedResult && other.base == base);

  @override
  int get hashCode => base.hashCode;
  //
}
