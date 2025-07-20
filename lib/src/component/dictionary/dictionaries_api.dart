// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'dictionaries_api.g.dart';

//infrastructure

@riverpod
Future<Dictionaries> dictionaries(Ref ref) async {
  log.info(() => '@riverpod');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = DictionaryRepository(db);
  return GetDictionariesUseCase(repo).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(
    this._db,
  );

  final AppDb _db;

  @override
  Future<Dictionaries> getDictionaries() async {
    log.fine('reading all dictionaries from db');
    final dbData = await _db.dictionaryDrift.getDictionaries().get();
    return Dictionaries(dbData);
  }

  //
}

//interactors

abstract interface class IDictionaryRepository {
  //
  Future<Dictionaries> getDictionaries();
  //
}

class GetDictionariesUseCase implements IGetDictionariesUseCase {
  GetDictionariesUseCase(
    this._repository,
  );

  final IDictionaryRepository _repository;

  @override
  Future<Dictionaries> invoke() async => _repository.getDictionaries();
  //
}

//domain

abstract interface class IGetDictionariesUseCase {
  //
  Future<Dictionaries> invoke();
  //
}

@immutable
extension type const Dictionaries._(UnmodifiableListView<Dictionary> unm)
    implements UnmodifiableListView<Dictionary> {
  Dictionaries(Iterable<Dictionary> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class Dictionary {
  const Dictionary({
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
  String toString() => 'Dictionary{name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Dictionary && other.id == id);

  @override
  int get hashCode => id.hashCode;
  //
}
