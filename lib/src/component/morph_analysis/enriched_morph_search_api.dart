import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/dictionary/lewis_and_short_basic_info_api.dart'
    hide IDictionaryRepository;
import 'package:latin_reader/src/component/morph_analysis/enriched_resolver.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_search_api.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enriched_morph_search_api.g.dart';

//infrastructure

@riverpod
Future<EnrichedResults> enrichedMorphologicalSearch(
  Ref ref,
  String form,
) async {
  log.info(() => '@riverpod - enrichedMorphologicalSearch');
  ref.cacheFor(const Duration(minutes: 5));
  final results = await ref.watch(morphologicalSearchProvider(form).future);
  return SearchEnrichedMorphologicalDataUseCase(
    results: results,
    repo: DictionaryDataService(ref),
  ).invoke();
}

class DictionaryDataService implements IDictionaryRepository {
  DictionaryDataService(
    this._ref,
  );

  final Ref _ref;

  @override
  Future<LnsBasicInfo> getLnsInfoFor(lemmas) async =>
      _ref.watch(lnsBasicInfoProvider(lemmas).future);
//
}

// interactors

class SearchEnrichedMorphologicalDataUseCase
    implements ISearchEnrichedMorphologicalDataUseCase {
  SearchEnrichedMorphologicalDataUseCase({
    required this.results,
    required this.repo,
  });

  final Results results;
  final IDictionaryRepository repo;

  @override
  Future<EnrichedResults> invoke() async {
    final resolver = DictionaryRefResolver(repo);
    final lnsInfoByMorphDictRef = await resolver.resolveDictionaryRefs(
      results.map((r) => r.dictionaryRef).toSet(),
    );
    // Only return results for which dictionary entries are found, since
    // the Results contains data of low quality otherwise
    return EnrichedResults(results
        .where((r) => lnsInfoByMorphDictRef.containsKey(r.dictionaryRef))
        .map((r) => EnrichedResult(
              base: r,
              lns: lnsInfoByMorphDictRef[r.dictionaryRef]!,
            )));
  }
//
}

//domain

abstract interface class ISearchEnrichedMorphologicalDataUseCase {
  Future<EnrichedResults> invoke();
}

@immutable
extension type const EnrichedResults._(UnmodifiableListView<EnrichedResult> unm)
    implements UnmodifiableListView<EnrichedResult> {
  EnrichedResults(Iterable<EnrichedResult> iter)
      : this._(UnmodifiableListView(iter));
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
