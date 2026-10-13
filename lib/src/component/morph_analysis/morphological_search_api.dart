// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../core/search_term.dart';
import '../../core/semivowel_search.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import '../settings/general_settings_api.dart';
import 'morph_analysis.drift.dart';

part 'morphological_search_api.g.dart';

//infrastructure

@riverpod
Future<Results> morphologicalSearch(Ref ref, String form) async {
  log.info(() => '@riverpod - using $form');
  ref.cacheFor(const Duration(minutes: 2));
  final settings = await ref.watch(generalSettingsNotifierProvider.future);
  final db = await ref.watch(dbProvider.future);
  final repo = MorphologicalDataRepository(db.morphAnalysisDrift);
  return SearchMorphologicalDataUseCase(repo, form, settings.semivowelSearchRules).invoke();
}

class MorphologicalDataRepository implements IMorphologicalDataRepository {
  MorphologicalDataRepository(
    this._db,
  ) {
    _runnableQueries = {
      (hasMacrons: true, useLike: true): (String form) {
        log.fine(() => 'WHERE macronizedForm LIKE "$form"');
        return _db.searchMacronizedMorphologicalDataWithLike(form);
      },
      (hasMacrons: true, useLike: false): (String form) {
        log.fine(() => 'WHERE macronizedForm MATCH "$form"');
        return _db.searchMacronizedMorphologicalDataWithFts(form);
      },
      (hasMacrons: false, useLike: true): (String form) {
        log.fine(() => 'WHERE form LIKE "$form"');
        return _db.searchMorphologicalDataWithLike(form);
      },
      (hasMacrons: false, useLike: false): (String form) {
        log.fine(() => 'WHERE form MATCH "$form"');
        return _db.searchMorphologicalDataWithFts(form);
      },
    };
    _runnableInVowelLettersQueries = {
      (hasMacrons: true, useLike: true): (String form) {
        log.fine(() => 'WHERE macronizedFormInVowelLetters LIKE "$form"');
        return _db.searchMacronizedMorphologicalDataInVowelLettersWithLike(form);
      },
      (hasMacrons: true, useLike: false): (String form) {
        log.fine(() => 'WHERE macronizedFormInVowelLetters MATCH "$form"');
        return _db.searchMacronizedMorphologicalDataInVowelLettersWithFts(form);
      },
      (hasMacrons: false, useLike: true): (String form) {
        log.fine(() => 'WHERE formInVowelLetters LIKE "$form"');
        return _db.searchMorphologicalDataInVowelLettersWithLike(form);
      },
      (hasMacrons: false, useLike: false): (String form) {
        log.fine(() => 'WHERE formInVowelLetters MATCH "$form"');
        return _db.searchMorphologicalDataInVowelLettersWithFts(form);
      },
    };
  }

  final MorphAnalysisDrift _db;

  // dart format off
  late final Map<({bool hasMacrons, bool useLike}),
                 MultiSelectable<Result> Function(String form)>
      _runnableQueries;
  late final Map<({bool hasMacrons, bool useLike}),
                 MultiSelectable<Result> Function(String form)>
      _runnableInVowelLettersQueries;
  // dart format on

  @override
  Future<Results> getSearchResults(SearchTerm term) async {
    final runQuery = _runnableQueries[(hasMacrons: term.hasMacrons, useLike: term.useLike)]!;
    return Results(await runQuery(term.query).get());
  }

  @override
  Future<Results> getSearchResultsInVowelLetters(SearchTerm term) async {
    final runQuery =
        _runnableInVowelLettersQueries[(hasMacrons: term.hasMacrons, useLike: term.useLike)]!;
    return Results(await runQuery(term.query).get());
  }

  //
}

//interactors

abstract interface class IMorphologicalDataRepository {
  //
  Future<Results> getSearchResults(SearchTerm term);

  Future<Results> getSearchResultsInVowelLetters(SearchTerm term);
  //
}

class SearchMorphologicalDataUseCase implements ISearchMorphologicalDataUseCase {
  SearchMorphologicalDataUseCase(
    this._repository,
    this._form,
    this._semivowelSearchRules,
  );

  final IMorphologicalDataRepository _repository;
  final String _form;
  final SemivowelSearchRules _semivowelSearchRules;

  @override
  Future<Results> invoke() async {
    final term = SearchTerm(_form);
    return term.isEmpty ? Results(const []) : await _resultsMatching(term);
  }

  Future<Results> _resultsMatching(SearchTerm term) async {
    final found = await _repository.getSearchResults(term);
    final foundInVowelLetters = await _repository.getSearchResultsInVowelLetters(
      term.inVowelLetters,
    );
    final semivowelPattern = term.semivowelPatternWith(_semivowelSearchRules);
    return Results({
      ...found,
      ...foundInVowelLetters.where(
        (result) => semivowelPattern.hasMatch(_searchedValue(result, term)),
      ),
    });
  }

  /// Returns the value that [term] compares: the macronized form when it has macrons.
  static String _searchedValue(Result result, SearchTerm term) =>
      term.hasMacrons ? result.macronizedForm ?? '' : result.form;
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
  Results(
    Iterable<Result> iter,
  ) : this._(UnmodifiableListView(iter));
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Result && other.form == form && other.item == item && other.cnt == cnt);

  @override
  int get hashCode => Object.hash(form, item, cnt);
  //
}
