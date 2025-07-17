// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'dictionary_entry_senses_api.g.dart';

//infrastructure

@riverpod
Future<DictionaryEntrySenses> dictionaryEntrySenses(
  Ref ref,
  String dictionary,
  String lemma,
) async {
  log.info(() => '@riverpod - dictionaryEntrySenses');
  ref.cacheFor(const Duration(minutes: 5));
  final db = await ref.watch(dbProvider.future);
  final repo = DictionaryRepository(db);
  return GetEntrySensesUseCase(repo, dictionary, lemma).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(
    this._db,
  );

  final AppDb _db;

  @override
  Future<DictionaryEntrySenses> getEntrySensesOf(String dictionary, String lemma) async {
    log.info('DictionaryRepository - reading dictionary entry senses from db');
    final dbData = await _db.dictionaryDrift.getDictionaryEntrySenses(dictionary, lemma).get();
    return DictionaryEntrySenses(dbData);
  }

  //
}

//interactors

abstract interface class IDictionaryRepository {
  //
  Future<DictionaryEntrySenses> getEntrySensesOf(String dictionary, String lemma);
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
  Future<DictionaryEntrySenses> invoke() async => _repository.getEntrySensesOf(_dictionary, _lemma);
  //
}

//domain

abstract interface class IGetEntrySensesUseCase {
  //
  Future<DictionaryEntrySenses> invoke();
  //
}

@immutable
extension type const DictionaryEntrySenses._(UnmodifiableListView<EntrySense> unm)
    implements UnmodifiableListView<EntrySense> {
  DictionaryEntrySenses(Iterable<EntrySense> iter) : this._(UnmodifiableListView(iter));
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
  late final UnmodifiableListView<EntrySenseQuote> quotes = UnmodifiableListView(_quotes);

  @override
  String toString() => 'EntrySense{prettyLevel: $prettyLevel}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is EntrySense && other.prettyLevel == prettyLevel);

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
  bool operator ==(Object other) =>
      identical(this, other) || (other is EntrySenseQuote && other.seq == seq);

  @override
  int get hashCode => seq.hashCode;
  //
}
