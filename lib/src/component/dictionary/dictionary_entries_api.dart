// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../core/search_term.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'dictionary_entries_api.g.dart';

//infrastructure

@riverpod
Future<DictionaryEntries> dictionaryEntries(Ref ref, String dictionary) async {
  log.info(() => '@riverpod - using $dictionary');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = DictionaryRepository(db);
  return GetEntriesUseCase(repo, dictionary).invoke();
}

@riverpod
Future<DictionaryEntries> dictionaryEntriesSearch(
  Ref ref,
  String dictionary,
  String headword,
) async {
  log.info(() => '@riverpod - using $headword in $dictionary');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = DictionaryRepository(db);
  return SearchEntriesUseCase(repo, dictionary, headword).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(
    this._db,
  );

  final AppDb _db;

  @override
  Future<DictionaryEntries> getEntriesOf(String dictionary) async {
    log.fine('reading all entries of dictionary "$dictionary" from db');
    final dbData = await _db.dictionaryDrift.getDictionaryEntries(dictionary).get();
    return DictionaryEntries(dbData);
  }

  @override
  Future<DictionaryEntries> getEntriesMatching(String dictionary, SearchTerm term) async {
    log.fine(() => 'reading entries of "$dictionary" whose headword matches ${term.query} from db');
    final drift = _db.dictionaryDrift;
    final query = term.useLike
        ? drift.searchDictionaryEntriesWithLike(term: term.query, dictionary: dictionary)
        : drift.searchDictionaryEntriesWithFts(term: term.query, dictionary: dictionary);
    return DictionaryEntries(await query.get());
  }

  //
}

//interactors

abstract interface class IDictionaryRepository {
  //
  Future<DictionaryEntries> getEntriesOf(String dictionary);

  Future<DictionaryEntries> getEntriesMatching(String dictionary, SearchTerm term);
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
  Future<DictionaryEntries> invoke() async => _repository.getEntriesOf(_dictionary);
  //
}

class SearchEntriesUseCase implements ISearchEntriesUseCase {
  SearchEntriesUseCase(
    this._repository,
    this._dictionary,
    this._headword,
  );

  final IDictionaryRepository _repository;
  final String _dictionary;
  final String _headword;

  @override
  Future<DictionaryEntries> invoke() async {
    // headwords are written without macrons
    final term = SearchTerm(_headword).withoutMacrons;
    return term.isEmpty
        ? DictionaryEntries(const [])
        : await _repository.getEntriesMatching(_dictionary, term);
  }

  //
}

//domain

abstract interface class IGetEntriesUseCase {
  //
  Future<DictionaryEntries> invoke();
  //
}

abstract interface class ISearchEntriesUseCase {
  //
  Future<DictionaryEntries> invoke();
  //
}

@immutable
extension type const DictionaryEntries._(UnmodifiableListView<Entry> unm)
    implements UnmodifiableListView<Entry> {
  DictionaryEntries(
    Iterable<Entry> iter,
  ) : this._(UnmodifiableListView(iter));
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entry && other.dictionary == dictionary && other.lemma == lemma);

  @override
  int get hashCode => Object.hash(dictionary, lemma);
  //
}
