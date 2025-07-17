// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'dictionary.drift.dart';

part 'lewis_and_short_basic_info_api.g.dart';

//infrastructure

@riverpod
Future<LnsBasicInfo> lnsBasicInfo(Ref ref, Iterable<String> lemmas) async {
  log.info(() => '@riverpod - lnsBasicInfo');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = DictionaryRepository(db.dictionaryDrift);
  return GetLnsBasicInfoUseCase(repo, lemmas).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(
    this._db,
  );

  final DictionaryDrift _db;

  @override
  Future<LnsBasicInfo> getLnsInfoFor(lemmas) async {
    log.info('DictionaryRepository - reading L&S from db');
    final dictId = _db.selectOnly(_db.dictionaries)
      ..addColumns([_db.dictionaries.id])
      ..where(_db.dictionaries.name.equals('Lewis & Short'));
    final dbData =
        await (_db.selectOnly(_db.dictionaryEntries)
              ..addColumns([
                _db.dictionaryEntries.lemma,
                _db.dictionaryEntries.partOfSpeech,
                _db.dictionaryEntries.inflection,
              ])
              ..where(
                _db.dictionaryEntries.dictionary.equalsExp(subqueryExpression(dictId)) &
                    _db.dictionaryEntries.lemma.isIn(lemmas),
              ))
            .get();
    return LnsBasicInfo(
      dbData
          .map(
            (row) => LnsBasicInfoEntry(
              lemma: row.read(_db.dictionaryEntries.lemma)!,
              inflection: row.read(_db.dictionaryEntries.inflection),
              partOfSpeech: row.read(_db.dictionaryEntries.partOfSpeech),
            ),
          )
          .toList(),
    );
  }

  //
}

//interactors

abstract interface class IDictionaryRepository {
  //
  Future<LnsBasicInfo> getLnsInfoFor(Iterable<String> lemmas);
  //
}

class GetLnsBasicInfoUseCase implements IGetLnsBasicInfoUseCase {
  GetLnsBasicInfoUseCase(
    this._repository,
    this._lemmas,
  );

  final IDictionaryRepository _repository;
  final Iterable<String> _lemmas;

  @override
  Future<LnsBasicInfo> invoke() async => _repository.getLnsInfoFor(_lemmas);
  //
}

//domain

abstract interface class IGetLnsBasicInfoUseCase {
  //
  Future<LnsBasicInfo> invoke();
  //
}

@immutable
extension type const LnsBasicInfo._(UnmodifiableListView<LnsBasicInfoEntry> unm)
    implements UnmodifiableListView<LnsBasicInfoEntry> {
  LnsBasicInfo(Iterable<LnsBasicInfoEntry> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class LnsBasicInfoEntry {
  const LnsBasicInfoEntry({
    required this.lemma,
    this.inflection,
    this.partOfSpeech,
  });

  final String lemma;
  final String? inflection;
  final String? partOfSpeech;

  @override
  String toString() => 'LnsBasicInfoEntry{lemma: $lemma}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LnsBasicInfoEntry && other.lemma == lemma);

  @override
  int get hashCode => lemma.hashCode;
  //
}
