import 'dart:collection';

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
Future<Analyses> morphologicalDetailsByKeys(Ref ref, AnalysisKeys keys) async {
  log.info(() => '@riverpod - morphologicalDetailsByKeys');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = MorphologicalDataRepository(db);
  return GetMorphologicalDetailsByKeysUseCase(repo, keys).invoke();
}

@riverpod
Future<Analyses> morphologicalDetailsByForm(Ref ref, String form) async {
  log.info(() => '@riverpod - morphologicalDetailsByForm');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = MorphologicalDataRepository(db);
  return GetMorphologicalDetailsByFormUseCase(repo, form).invoke();
}

class MorphologicalDataRepository implements IMorphologicalDataRepository {
  MorphologicalDataRepository(this._db);

  final AppDb _db;

  @override
  Future<Analyses> getMorphDetailsByKeys(AnalysisKeys keys) async {
    log.info('MorphologicalDataRepository - retrieving analyses from db');
    final dbData = await (_db.select(_db.morphAnalysisDrift.morphologyAnalyses)
          ..where((t) => Expression.or(
                keys.map((k) => Expression.and([
                      t.form.equals(k.form),
                      t.item.equals(k.item),
                      t.cnt.equals(k.cnt)
                    ])),
              )))
        .get();
    return Analyses(dbData.map(_toDomain));
  }

  @override
  Future<Analyses> getMorphDetailsByForm(String form) async {
    log.info('MorphologicalDataRepository - retrieving $form analyses from db');
    final dbData =
        await _db.morphAnalysisDrift.getMorphologicalDetailsOfForm(form).get();
    return Analyses(dbData);
  }

  Analysis _toDomain(morphologyAnalysis e) => Analysis(
        form: e.form,
        item: e.item,
        cnt: e.cnt,
        dictionaryRef: e.dictionaryRef,
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
      );
//
}

//interactors

abstract interface class IMorphologicalDataRepository {
//
  Future<Analyses> getMorphDetailsByKeys(AnalysisKeys keys);

  Future<Analyses> getMorphDetailsByForm(String form);
//
}

class GetMorphologicalDetailsByKeysUseCase
    implements IGetMorphologicalDetailsUseCase {
  GetMorphologicalDetailsByKeysUseCase(
    this._repository,
    this._keys,
  );

  final IMorphologicalDataRepository _repository;
  final AnalysisKeys _keys;

  @override
  Future<Analyses> invoke() async => _repository.getMorphDetailsByKeys(_keys);
//
}

class GetMorphologicalDetailsByFormUseCase
    implements IGetMorphologicalDetailsUseCase {
  GetMorphologicalDetailsByFormUseCase(
    this._repository,
    this._form,
  );

  final IMorphologicalDataRepository _repository;
  final String _form;

  @override
  Future<Analyses> invoke() async => _repository.getMorphDetailsByForm(_form);
//
}

@immutable
extension type const AnalysisKeys._(UnmodifiableListView<AnalysisKey> unm)
    implements UnmodifiableListView<AnalysisKey> {
  AnalysisKeys(Iterable<AnalysisKey> iter) : this._(UnmodifiableListView(iter));
}

extension type const AnalysisKey._(({String form, int item, int cnt}) _record) {
  AnalysisKey({
    required String form,
    required int item,
    required int cnt,
  }) : this._((form: form, item: item, cnt: cnt));

  String get form => _record.form;
  int get item => _record.item;
  int get cnt => _record.cnt;
  //
}

//domain

abstract interface class IGetMorphologicalDetailsUseCase {
//
  Future<Analyses> invoke();
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
    required this.dictionaryRef,
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
  });

  final String form;
  final int item;
  final int cnt;
  final String dictionaryRef;
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
