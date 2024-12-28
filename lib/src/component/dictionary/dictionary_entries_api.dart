import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_entries_api.g.dart';

//infrastructure

@riverpod
Future<DictionaryEntries> dictionaryEntries(Ref ref, String dictionary) async {
  log.info(() => '@riverpod - dictionaryEntries');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = DictionaryRepository(db);
  return GetEntriesUseCase(repo, dictionary).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(
    this._db,
  );

  final AppDb _db;

  @override
  Future<DictionaryEntries> getEntriesOf(String dictionary) async {
    log.info('DictionaryRepository - reading dictionary entries from db');
    final dbData =
        await _db.dictionaryDrift.getDictionaryEntries(dictionary).get();
    return DictionaryEntries(dbData);
  }
//
}

//interactors

abstract interface class IDictionaryRepository {
//
  Future<DictionaryEntries> getEntriesOf(String dictionary);
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
  Future<DictionaryEntries> invoke() async =>
      _repository.getEntriesOf(_dictionary);
//
}

//domain

abstract interface class IGetEntriesUseCase {
//
  Future<DictionaryEntries> invoke();
//
}

@immutable
extension type const DictionaryEntries._(UnmodifiableListView<Entry> unm)
    implements UnmodifiableListView<Entry> {
  DictionaryEntries(Iterable<Entry> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class Entry {
  const Entry({
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
  String toString() => 'Entry{lemma: $lemma}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Entry &&
        other.dictionary == dictionary &&
        other.lemma == lemma;
  }

  @override
  int get hashCode => Object.hash(dictionary, lemma);
//
}
