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
  /// If the input contains non-word characters (i.e. anything that is not a
  /// Latin letter or an arabic numeral) or is made of less than three
  /// characters three characters, the query will use `LIKE` instead of doing
  /// an FTS5 search:
  /// - If the input contains wildcards (`*` or `%` for any number of
  /// characters and `?` or `_` for a single character), these will be used by
  /// the SQL engine
  /// - If the input begins and ends with single `'` or double `"` quotes, the
  /// query runs without them so that they are found as exact strings
  ///
  /// If the input does not contain any strange characters and is made of three
  /// characters or more, the query looks for matches using full-text search
  @override
  Future<Results> getSearchResults(String form) async {
    if (form.isNotEmpty) {
      final key = (
        hasMacrons: _hasMacrons(form),
        useLike: _useLikeLogic(form),
      );
      final runQuery = _runnableQueries[key]!;
      final parsedInput = _sanitizeQuotes(_sanitizeWildcards(form));
      log.info('MorphologicalDataRepository - searching $parsedInput in db');
      final dbData = await runQuery(parsedInput).get();
      return Results(dbData);
    } else {
      return Results(List.empty());
    }
  }

  String _sanitizeWildcards(String form) => form.replaceAll('*', '%').replaceAll('?', '_');

  bool _hasMacrons(String form) => form.contains(RegExp('[āēīōūĀĒĪŌŪ]'));

  /// Any weird characters default to LIKE, since MATCH can return errors and
  /// we can't use advanced FTS5 syntax for a table column that exclusively 
  /// stores single words
  bool _useLikeLogic(String form) => form.length < 3 || form.contains(RegExp(r'[^\wāēīōūĀĒĪŌŪ]'));

  /// If a user types leading *and* trailing quotes, either single or double,
  /// we strip them off so that the LIKE logic will look for a match without
  /// query characters
  ///
  /// In any other case return the original string
  String _sanitizeQuotes(String form) =>
      ((form.startsWith('"') && form.endsWith('"')) ||
              (form.startsWith("'") && form.endsWith("'")))
          ? form.substring(1, form.length - 1)
          : form;

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
  String toString() => 'Result{form: $form, item: $item, cnt: $cnt}';

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
