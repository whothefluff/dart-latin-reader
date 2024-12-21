import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_entry_api.g.dart';

//infrastructure

@riverpod
Future<UnmodifiableListView<EntrySense>> dictionaryEntrySenses(
  Ref ref,
  String dictionary,
  String lemma,
) async {
  log.info(() => '@riverpod - dictionaryEntrySenses');
  final db = await ref.watch(dbProvider.future);
  ref.cacheFor(const Duration(minutes: 5));
  return GetEntrySensesUseCase(DictionaryRepository(db), dictionary, lemma)
      .invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(this.db);

  final AppDb db;

  @override
  Future<UnmodifiableListView<EntrySense>> getEntrySensesOf(
      String dictionary, String lemma) async {
    log.info('DictionaryRepository - reading dictionary entry senses from db');
    final dbData = await db.dictionaryDrift
        .getDictionaryEntrySenses(dictionary, lemma)
        .get();
    return UnmodifiableListView(dbData as Iterable<EntrySense>);
  }
//
}

//interactors

abstract interface class IDictionaryRepository {
//
  Future<UnmodifiableListView<EntrySense>> getEntrySensesOf(
      String dictionary, String lemma);
//
}

class GetEntrySensesUseCase implements IGetEntrySensesUseCase {
  GetEntrySensesUseCase(
    this._repository,
    this._dictionary,
    this._lemma,
  );

  final IDictionaryRepository _repository;
  final String _dictionary;
  final String _lemma;

  @override
  Future<UnmodifiableListView<EntrySense>> invoke() async =>
      _repository.getEntrySensesOf(_dictionary, _lemma);
//
}

//domain

abstract interface class IGetEntrySensesUseCase {
//
  Future<UnmodifiableListView<EntrySense>> invoke();
//
}

@immutable
class EntrySense {
  EntrySense({
    required this.prettyLevel,
    required this.content,
    required List<EntrySenseQuote> quotes,
  }) : _quotes = quotes;

  final String prettyLevel;
  final String content;
  final List<EntrySenseQuote> _quotes;
  late final UnmodifiableListView<EntrySenseQuote> quotes =
      UnmodifiableListView(_quotes);

  @override
  String toString() => 'EntrySense{prettyLevel: $prettyLevel}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EntrySense && other.prettyLevel == prettyLevel;
  }

  @override
  int get hashCode => prettyLevel.hashCode;
//
}

@immutable
class EntrySenseQuote {
  const EntrySenseQuote({
    required this.seq,
    required this.content,
    this.translation,
  });

  final int seq;
  final String content;
  final String? translation;

  @override
  String toString() => 'EntrySenseQuote{seq: $seq}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EntrySenseQuote && other.seq == seq;
  }

  @override
  int get hashCode => seq.hashCode;
//
}
