import 'dart:collection';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'morphological_search_api.g.dart';

//infrastructure

@riverpod
Future<Results> morphologicalSearch(Ref ref, String form) async {
  log.info(() => '@riverpod - morphologicalSearch');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = MorphologicalDataRepository(db);
  return SearchMorphologicalDataUseCase(repo, form).invoke();
}

class MorphologicalDataRepository implements IMorphologicalDataRepository {
  MorphologicalDataRepository(
    this._db,
  ) {
    _runnableQueries = {
      (hasMacrons: true, useLike: true): (String form) => 
          _db.morphAnalysisDrift.searchMacronizedMorphologicalDataWithLike(form),
      (hasMacrons: true, useLike: false): (String form) =>
          _db.morphAnalysisDrift.searchMacronizedMorphologicalDataWithFts(form),
      (hasMacrons: false, useLike: true): (String form) =>
          _db.morphAnalysisDrift.searchMorphologicalDataWithLike(form),
      (hasMacrons: false, useLike: false): (String form) =>
          _db.morphAnalysisDrift.searchMorphologicalDataWithFts(form),
    };
  }

  final AppDb _db;
  late final Map<({bool hasMacrons, bool useLike}),
             MultiSelectable<Result> Function(String form)> 
      _runnableQueries;

  /// If the input contains macrons, the query will look for them explicitely
  /// and as they were specified 
  ///
  /// If the input contains no macrons, the query will ignore them (which means
  /// the result can contain macrons or not contain any)
  ///
  /// If the input contains wildcards (`*` or `%` for any number of
  /// characters and `?` or `_` for a single character) or is made of less than
  /// three characters, the query will use `LIKE` instead of doing an FTS5 
  /// search
  ///
  /// If the input does not contain any wildcards and is made of three 
  /// characters or more, the query looks for matches using full-text search 
  @override
  Future<Results> getSearchResults(String form) async {
    if (form.isNotEmpty) {
      final parsedInput = form.replaceAll('*', '%').replaceAll('?', '_');
      log.info('MorphologicalDataRepository - searching $parsedInput in db');
      final key = (
        hasMacrons: _hasMacrons(parsedInput),
        useLike: _useLikeLogic(parsedInput)
      );
      final runQuery = _runnableQueries[key]!;
      final dbData = await runQuery(parsedInput).get();
      return Results(dbData);
    } else {
      return Results(List.empty());
    }
  }

  bool _hasMacrons(String form) => form.contains(RegExp('[āēīōūĀĒĪŌŪ]'));

  bool _useLikeLogic(String form) => form.length < 3 || form.contains(RegExp('[%_]'));

//
}

//interactors

abstract interface class IMorphologicalDataRepository {
//
  Future<Results> getSearchResults(String form);
//
}

class SearchMorphologicalDataUseCase
    implements ISearchMorphologicalDataUseCase {
  SearchMorphologicalDataUseCase(this._repository, this._form);

  final IMorphologicalDataRepository _repository;
  final String _form;

  @override
  Future<Results> invoke() async => _repository.getSearchResults(_form);
//
}

//domain

abstract interface class ISearchMorphologicalDataUseCase {
//
  Future<Results> invoke();
//
}

@immutable
extension type const Results._(UnmodifiableListView<Result> unm)
    implements UnmodifiableListView<Result> {
  Results(Iterable<Result> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class Result {
  const Result({
    required this.form,
    this.macronizedForm,
    this.partOfSpeech,
    required this.dictionaryRef,
    this.additional,
    required this.item,
    required this.cnt,
  });

  final String form;
  final String? macronizedForm;
  final String? partOfSpeech;
  final String dictionaryRef;
  final String? additional;
  final int item;
  final int cnt;

  @override
  String toString() =>
      'Result{form: $form, item: $item, cnt: $cnt}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result &&
        other.form == form &&
        other.item == item &&
        other.cnt == cnt;
  }

  @override
  int get hashCode => Object.hash(form, item, cnt);
//
}
