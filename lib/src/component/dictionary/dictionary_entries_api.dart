import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_entries_api.g.dart';

//infrastructure

@riverpod
Future<UnmodifiableListView<Entry>> dictionaryEntries(
  Ref ref,
  String dictionary,
) async {
  log.info(() => '@riverpod - dictionaryEntries');
  final db = await ref.watch(dbProvider.future);
  ref.cacheFor(const Duration(minutes: 2));
  return await GetEntriesUseCase(DictionaryRepository(db), dictionary).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(this.db);

  final AppDb db;

  @override
  Future<UnmodifiableListView<Entry>> getEntriesOf(String dictionary) async {
    log.info('DictionaryRepository - reading dictionary entries from db');
    final dbData =
        await db.dictionaryDrift.getDictionaryEntries(dictionary).get();
    return UnmodifiableListView(dbData as Iterable<Entry>);
  }
//
}

//interactors

abstract interface class IDictionaryRepository {
//
  Future<UnmodifiableListView<Entry>> getEntriesOf(String dictionary);
//
}

class GetEntriesUseCase implements IGetEntriesUseCase {
  GetEntriesUseCase(
    this._repository,
    this._dictionary,
  );

  final IDictionaryRepository _repository;
  final String _dictionary;

  @override
  Future<UnmodifiableListView<Entry>> invoke() async =>
      await _repository.getEntriesOf(_dictionary);
//
}

//domain

abstract interface class IGetEntriesUseCase {
//
  Future<UnmodifiableListView<Entry>> invoke();
//
}

class Entry {
  Entry({
    required this.dictionary,
    required this.lemma,
    required this.inflection,
    required this.partOfSpeech,
    required this.numberOfSenses,
  });

  final String dictionary;
  final String lemma;
  final String? inflection;
  final String? partOfSpeech;
  final int numberOfSenses;

  @override
  String toString() {
    return 'DictionaryEntry{lemma: $lemma}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Entry &&
        other.dictionary == dictionary &&
        other.lemma == lemma;
  }

  @override
  int get hashCode => dictionary.hashCode ^ lemma.hashCode;
//
}
