// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'concordance.drift.dart';
import 'concordance_query.dart';

part 'lemma_choices_api.g.dart';

//infrastructure

/// Lemmas starting with [prefix], exact match first, then shortest first
@riverpod
Future<LemmaChoices> lemmaChoices(Ref ref, String prefix) async {
  log.info(() => '@riverpod - using $prefix');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = ConcordanceRepository(db.concordanceDrift);
  return SearchLemmaChoicesUseCase(repo, prefix).invoke();
}

class ConcordanceRepository implements IConcordanceRepository {
  ConcordanceRepository(
    this._db,
  );

  final ConcordanceDrift _db;

  @override
  Future<LemmaChoices> searchLemmas(prefix, limit) async {
    log.fine('reading lemmas starting with "$prefix" from db');
    return LemmaChoices(await _db.searchConcordanceLemmas(prefix: prefix, limit: limit).get());
  }

  //
}

//interactors

abstract interface class IConcordanceRepository {
  //
  Future<LemmaChoices> searchLemmas(String prefix, int limit);
  //
}

class SearchLemmaChoicesUseCase implements ISearchLemmaChoicesUseCase {
  SearchLemmaChoicesUseCase(
    this._repository,
    this._prefix,
  );

  static const _limit = 30;

  final IConcordanceRepository _repository;
  final String _prefix;

  @override
  Future<LemmaChoices> invoke() async {
    // Lemmas are written without macrons, and LIKE's wildcards aren't lemma letters
    final prefix = _prefix.trim().replaceAll(RegExp('[%_]'), '').replaceAllMapped(
      RegExp('[āēīōūȳĀĒĪŌŪȲ]'),
      (match) => _plain[match[0]]!,
    );
    return prefix.isEmpty ? LemmaChoices(const []) : await _repository.searchLemmas(prefix, _limit);
  }

  static const Map<String, String> _plain = {
    'ā': 'a', 'ē': 'e', 'ī': 'i', 'ō': 'o', 'ū': 'u', 'ȳ': 'y', //
    'Ā': 'A', 'Ē': 'E', 'Ī': 'I', 'Ō': 'O', 'Ū': 'U', 'Ȳ': 'Y',
  };
  //
}

//domain

abstract interface class ISearchLemmaChoicesUseCase {
  //
  Future<LemmaChoices> invoke();
  //
}

@immutable
extension type const LemmaChoices._(UnmodifiableListView<LemmaChoice> unm)
    implements UnmodifiableListView<LemmaChoice> {
  LemmaChoices(
    Iterable<LemmaChoice> iter,
  ) : this._(UnmodifiableListView(iter));
}
