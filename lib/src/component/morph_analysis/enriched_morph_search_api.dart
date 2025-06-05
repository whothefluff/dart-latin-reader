import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/dictionary/lewis_and_short_basic_info_api.dart';
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

abstract interface class IDictionaryRepository {
//
  Future<LnsBasicInfo> getLnsInfoFor(Iterable<String> lemmas);
//
}

/// First, look for exact lemmas but with '-' replacements (d-p = pp, etc.) TODO
///
/// Then, for the lemmas with no matches, look for lemma AND '1'
///
/// Then, for the lemmas still with no matches, look for lema
/// WITHOUT trailing '1'
///
/// Return forms with at least one match (assumption: no match in dict = wrong
/// analysis)
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
    final pureLemmas = results.map((r) => r.dictionaryRef).toSet();
    // First try to find exact matches
    final pureMatches = (await repo.getLnsInfoFor(pureLemmas)).map(
      (e) => (
        morphDictRef: e.lemma,
        lnsLemma: e.lemma,
        lnsPos: e.partOfSpeech,
        lnsInflection: e.inflection,
      ),
    );
    // A few dozen entries will not be found as is, but only adding '1'
    // E.g. 'principum' has dictionaryRef 'princeps',
    // but the dictionary has lemma 'princeps1'
    final matchedPLemmas = pureMatches.map((e) => e.morphDictRef).toSet();
    final unmatchedPLemmas = pureLemmas.difference(matchedPLemmas);
    final suffixedLemmas = unmatchedPLemmas
        .where((e) => !e.endsWith('1'))
        .map((e) => '${e}1')
        .toSet();
    final suffixedMatches =
        (await repo.getLnsInfoFor(suffixedLemmas)).map((e) => (
              morphDictRef: e.lemma.replaceFirst(r'1$', ''),
              lnsLemma: e.lemma,
              lnsPos: e.partOfSpeech,
              lnsInflection: e.inflection,
            ));
    // A small handful of entries entries still not be found, so we delete '1'
    // E.g. 'equus' has has dictionaryRef 'equus1',
    // but the dictionary only has lemma 'equus'
    final matchedSLemmas = suffixedMatches.map((e) => e.morphDictRef).toSet();
    final unmatchedSLemmas = unmatchedPLemmas.difference(matchedSLemmas);
    final normalizedLemmas = unmatchedSLemmas
        .where((e) => e.endsWith('1'))
        .map((e) => e.replaceFirst(RegExp(r'1$'), ''))
        .toSet();
    final normalizedMatches =
        (await repo.getLnsInfoFor(normalizedLemmas)).map((e) => (
              morphDictRef: '${e.lemma}1',
              lnsLemma: e.lemma,
              lnsPos: e.partOfSpeech,
              lnsInflection: e.inflection,
            ));
    // Put all found results together
    final comb = [...pureMatches, ...suffixedMatches, ...normalizedMatches];
    final lnsInfoByMorphDictRef = Map.fromEntries(
      comb.map((e) => MapEntry(
            e.morphDictRef,
            LnsBasicInfoEntry(
              lemma: e.lnsLemma,
              inflection: e.lnsInflection,
              partOfSpeech: e.lnsPos,
            ),
          )),
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
