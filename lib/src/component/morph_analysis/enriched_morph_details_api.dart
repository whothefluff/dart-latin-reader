// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/provider_ext.dart';
import '../dictionary/lewis_and_short_basic_info_api.dart' hide IDictionaryRepository;
import 'enriched_resolver.dart';
import 'morphological_details_api.dart';

part 'enriched_morph_details_api.g.dart';

//infrastructure

@riverpod
Future<EnrichedAnalyses> enrichedMorphologicalAnalyses(Ref ref, AnalysisKeys keys) async {
  log.info(() => '@riverpod - enrichedMorphologicalAnalyses');
  ref.cacheFor(const Duration(minutes: 5));
  final analyses = await ref.watch(morphologicalAnalysesProvider(keys).future);
  return GetEnrichedMorphologicalAnalysesUseCase(
    analyses: analyses,
    repo: RiverpodDictionaryRepository(ref),
  ).invoke();
}

// interactors

class GetEnrichedMorphologicalAnalysesUseCase implements IGetEnrichedMorphologicalAnalysesUseCase {
  GetEnrichedMorphologicalAnalysesUseCase({
    required this.analyses,
    required this.repo,
  });

  final Analyses analyses;
  final IDictionaryRepository repo;

  @override
  Future<EnrichedAnalyses> invoke() async {
    final resolver = DictionaryRefResolver(repo);
    final enrichedItems = await resolver.resolveAndEnrich(
      items: analyses,
      getDictRef: (analysis) => analysis.dictionaryRef,
      createEnriched: (analysis, lnsInfo) => EnrichedAnalysis(base: analysis, lns: lnsInfo),
    );
    return EnrichedAnalyses(enrichedItems);
  }

  //
}

//domain

abstract interface class IGetEnrichedMorphologicalAnalysesUseCase {
  Future<EnrichedAnalyses> invoke();
}

@immutable
extension type const EnrichedAnalyses._(UnmodifiableListView<EnrichedAnalysis> unm)
    implements UnmodifiableListView<EnrichedAnalysis> {
  EnrichedAnalyses(Iterable<EnrichedAnalysis> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class EnrichedAnalysis {
  const EnrichedAnalysis({
    required this.base,
    required this.lns,
  });

  final Analysis base;
  final LnsBasicInfoEntry lns;

  // Delegate properties for easier access
  String get form => base.form;
  int get item => base.item;
  int get cnt => base.cnt;
  String get macronizedForm => base.macronizedForm;
  String get dictionaryRef => base.dictionaryRef;
  String get partOfSpeech => base.partOfSpeech;
  String get stem => base.stem;
  String? get suffix => base.suffix;
  String? get segmentsInfo => base.segmentsInfo;
  String? get gender => base.gender;
  String? get number => base.number;
  String? get declension => base.declension;
  String? get gramCase => base.gramCase;
  String? get verbForm => base.verbForm;
  String? get tense => base.tense;
  String? get voice => base.voice;
  String? get person => base.person;
  String? get additional => base.additional;
  String get lnsLemma => lns.lemma;
  String? get lnsInflection => lns.inflection;
  String? get lnsPartOfSpeech => lns.partOfSpeech;

  @override
  String toString() => 'EnrichedAnalysis{form: $form, item: $item, cnt: $cnt}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is EnrichedAnalysis && other.base == base);

  @override
  int get hashCode => base.hashCode;
  //
}
