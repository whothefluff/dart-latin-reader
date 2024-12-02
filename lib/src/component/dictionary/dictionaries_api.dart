import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionaries_api.g.dart';

//infrastructure

@riverpod
Future<UnmodifiableListView<Dictionary>> dictionaries(Ref ref) async {
  log.info(() => '@riverpod - dictionaries');
  final db = await ref.watch(dbProvider.future);
  ref.cacheFor(const Duration(minutes: 2));
  return await GetDictionariesUseCase(DictionaryRepository(db)).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(this.db);

  final AppDb db;

  @override
  Future<UnmodifiableListView<Dictionary>> getDictionaries() async {
    log.info('DictionaryRepository - reading dictionaries from db');
    final dbDicts = await db.dictionaryDrift.getDictionaries().get();
    return UnmodifiableListView(dbDicts as Iterable<Dictionary>);
  }
//
}

//interactors

abstract interface class IDictionaryRepository {
//
  Future<UnmodifiableListView<Dictionary>> getDictionaries();
//
}

class GetDictionariesUseCase implements IGetDictionariesUseCase {
  GetDictionariesUseCase(
    this._repository,
  );

  final IDictionaryRepository _repository;

  @override
  Future<UnmodifiableListView<Dictionary>> invoke() async =>
      await _repository.getDictionaries();
//
}

//domain

abstract interface class IGetDictionariesUseCase {
//
  Future<UnmodifiableListView<Dictionary>> invoke();
//
}

class Dictionary {
  Dictionary({
    required this.id,
    required this.name,
    required this.language,
    required this.publisher,
    required this.publicationDate,
    required this.numberOfEntries,
  });

  final String id;
  final String name;
  final String language;
  final String publisher;
  final DateTime publicationDate;
  final int numberOfEntries;

  @override
  String toString() {
    return 'Dictionary{name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Dictionary && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
