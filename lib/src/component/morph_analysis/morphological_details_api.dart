import 'dart:collection';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/morph_analysis/morph_analysis.drift.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'morphological_details_api.g.dart';

//infrastructure

@riverpod
Future<Analyses> morphologicalAnalyses(Ref ref, AnalysisKeys keys) async {
  log.info(() => '@riverpod - morphologicalAnalyses');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = MorphologicalDataRepository(db);
  return GetMorphologicalAnalysesUseCase(repo, keys).invoke();
}

@riverpod
Future<AnalysisKeys> morphologicalAnalysisKeys(Ref ref, String form) async {
  log.info(() => '@riverpod - morphologicalAnalysisKeys');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = MorphologicalDataRepository(db);
  return GetMorphologicalAnalysisKeysUseCase(repo, form).invoke();
}

class MorphologicalDataRepository implements IMorphologicalDataRepository {
  MorphologicalDataRepository(
    this._db,
  ) {
    _analysisKeysQueries = {
      (hasMacrons: true): (String form) =>
          _db.morphAnalysisDrift.getAnalysisKeysOfMacronized(form),
      (hasMacrons: false): (String form) =>
          _db.morphAnalysisDrift.getAnalysisKeysOf(form),
    };
  }

  final AppDb _db;
  late final Map<({bool hasMacrons}),
                 MultiSelectable<AnalysisKey> Function(String form)> 
      _analysisKeysQueries;

  @override
  Future<Analyses> getMorphAnalyses(AnalysisKeys keys) async {
    log.info('MorphologicalDataRepository - retrieving analyses from db');
    final dbData = 
         await (_db.select(_db.morphAnalysisDrift.morphologyAnalyses)..where(_keysMatch(keys))).get();
    return Analyses(dbData.map(_toDomain));
  }

  /// If the input contains macrons, the query will look for them explicitely
  /// and as they were specified
  ///
  /// If the input contains no macrons, the query will ignore them (which means
  /// the result can contain macrons or not contain any)
  @override
  Future<AnalysisKeys> getMorphAnalysisKeys(String form) async {
    log.info('MorphologicalDataRepository - retrieving $form analyses from db');
    final formHasMacrons = form.contains(RegExp('[āēīōūĀĒĪŌŪ]'));
    final dbData =
        await _analysisKeysQueries[(hasMacrons: formHasMacrons)]!(form).get();
    return AnalysisKeys(dbData);
  }

  Expression<bool> Function(MorphologyAnalyses a) _keysMatch(
    AnalysisKeys keys,
  ) =>
      (a) => Expression.or(
            keys.map((k) => Expression.and([
                  a.form.equals(k.form),
                  a.item.equals(k.item),
                  a.cnt.equals(k.cnt)
                ])),
          );

  Analysis _toDomain(MorphologyAnalysis e) => Analysis(
        form: e.form,
        item: e.item,
        cnt: e.cnt,
        macronizedForm: e.macronizedForm,
        dictionaryRef: e.dictionaryRef,
        partOfSpeech: e.partOfSpeech,
        stem: e.stem,
        suffix: e.suffix,
        segmentsInfo: e.segmentsInfo,
        gender: e.gender,
        number: e.number,
        declension: e.declension,
        gramCase: e.gramCase,
        verbForm: e.verbForm,
        tense: e.tense,
        voice: e.voice,
        person: e.person,
        additional: e.additional,
      );
//
}

//interactors

abstract interface class IMorphologicalDataRepository {
//
  Future<Analyses> getMorphAnalyses(AnalysisKeys keys);

  Future<AnalysisKeys> getMorphAnalysisKeys(String form);
//
}

class GetMorphologicalAnalysesUseCase
    implements IGetMorphologicalAnalysesUseCase {
  GetMorphologicalAnalysesUseCase(
    this._repository,
    this._keys,
  );

  final IMorphologicalDataRepository _repository;
  final AnalysisKeys _keys;

  @override
  Future<Analyses> invoke() async => _repository.getMorphAnalyses(_keys);
//
}

class GetMorphologicalAnalysisKeysUseCase
    implements IGetMorphologicalAnalysisKeysUseCase {
  GetMorphologicalAnalysisKeysUseCase(
    this._repository,
    this._form,
  );

  final IMorphologicalDataRepository _repository;
  final String _form;

  @override
  Future<AnalysisKeys> invoke() async => _repository.getMorphAnalysisKeys(_form);
//
}

//domain

abstract interface class IGetMorphologicalAnalysesUseCase {
//
  Future<Analyses> invoke();
//
}

abstract interface class IGetMorphologicalAnalysisKeysUseCase {
//
  Future<AnalysisKeys> invoke();
//
}

@immutable
extension type const Analyses._(UnmodifiableListView<Analysis> unm)
    implements UnmodifiableListView<Analysis> {
  Analyses(Iterable<Analysis> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class Analysis {
  const Analysis({
    required this.form,
    required this.item,
    required this.cnt,
    required this.macronizedForm,
    required this.dictionaryRef,
    required this.partOfSpeech,
    required this.stem,
    this.suffix,
    this.segmentsInfo,
    this.gender,
    this.number,
    this.declension,
    this.gramCase,
    this.verbForm,
    this.tense,
    this.voice,
    this.person,
    this.additional,
  });

  final String form;
  final int item;
  final int cnt;
  final String macronizedForm;
  final String dictionaryRef;
  final String partOfSpeech;
  final String stem;
  final String? suffix;
  final String? segmentsInfo;
  final String? gender;
  final String? number;
  final String? declension;
  final String? gramCase;
  final String? verbForm;
  final String? tense;
  final String? voice;
  final String? person;
  final String? additional;

  @override
  String toString() => 'Analysis{form: $form, item: $item, cnt: $cnt}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Analysis &&
        other.form == form &&
        other.item == item &&
        other.cnt == cnt;
  }

  @override
  int get hashCode => Object.hash(form, item, cnt);
//
}

@immutable
extension type const AnalysisKeys._(UnmodifiableListView<AnalysisKey> unm)
    implements UnmodifiableListView<AnalysisKey> {
  AnalysisKeys(Iterable<AnalysisKey> iter) : this._(UnmodifiableListView(iter));

  AnalysisKeys.fromJson(String source)
      : this((jsonDecode(source) as List).expand((formEntry) {
          final formData = formEntry as List;
          final items = formData[1] as List;
          return items.expand((itemEntry) {
            final itemData = itemEntry as List;
            final counts = itemData[1] as List;
            return counts.map((cnt) => AnalysisKey(
                  form: formData[0] as String,
                  item: itemData[0] as int,
                  cnt: cnt as int,
                ));
          });
        }));

  String toJson() {
    final forms = <String, Map<int, List<int>>>{};
    forEach((k) {
      final l = (forms[k.form] ??= {})[k.item] ??= [];
      return l.add(k.cnt);
    });
    final compact = forms.entries
        .map((form) => [
              form.key,
              form.value.entries.map((i) => [i.key, i.value]).toList()
            ])
        .toList();
    return jsonEncode(compact);
  }
//
}

extension type const AnalysisKey._(({String form, int item, int cnt}) _record) {
  AnalysisKey({
    required String? form,
    required int? item,
    required int? cnt,
  }) : this._((form: form!, item: item!, cnt: cnt!));

  String get form => _record.form;
  int get item => _record.item;
  int get cnt => _record.cnt;
  //
}
