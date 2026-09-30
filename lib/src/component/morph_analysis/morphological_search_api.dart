// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../core/search_term.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'morph_analysis.drift.dart';

part 'morphological_search_api.g.dart';

//infrastructure

@riverpod
Future<Results> morphologicalSearch(Ref ref, String form) async {
  log.info(() => '@riverpod - using $form');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = MorphologicalDataRepository(db.morphAnalysisDrift);
  return SearchMorphologicalDataUseCase(repo, form).invoke();
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
  }

  final MorphAnalysisDrift _db;

  // dart format off
  late final Map<({bool hasMacrons, bool useLike}),
                 MultiSelectable<Result> Function(String form)>
      _runnableQueries;
  // dart format on

  @override
  Future<Results> getSearchResults(SearchTerm term) async {
    final runQuery = _runnableQueries[(hasMacrons: term.hasMacrons, useLike: term.useLike)]!;
    return Results(await runQuery(term.query).get());
  }

  //
}

//interactors

abstract interface class IMorphologicalDataRepository {
  //
  Future<Results> getSearchResults(SearchTerm term);
  //
}

class SearchMorphologicalDataUseCase implements ISearchMorphologicalDataUseCase {
  SearchMorphologicalDataUseCase(
    this._repository,
    this._form,
  );

  final IMorphologicalDataRepository _repository;
  final String _form;

  @override
  Future<Results> invoke() async {
    final term = SearchTerm(_form);
    return term.isEmpty ? Results(const []) : await _repository.getSearchResults(term);
  }

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
