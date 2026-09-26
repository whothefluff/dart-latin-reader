// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'concordance.drift.dart';
import 'concordance_query.dart';

part 'grammar_values_api.g.dart';

//infrastructure

/// What each grammatical feature can be, for the grammar criteria
@riverpod
Future<GrammarValues> grammarValues(Ref ref) async {
  log.info(() => '@riverpod');
  ref.cacheFor(const Duration(minutes: 30));
  final db = await ref.watch(dbProvider.future);
  final repo = ConcordanceRepository(db.concordanceDrift);
  return GetGrammarValuesUseCase(repo).invoke();
}

class ConcordanceRepository implements IConcordanceRepository {
  ConcordanceRepository(
    this._db,
  );

  final ConcordanceDrift _db;

  @override
  Future<GrammarValues> getGrammarValues() async {
    log.fine('reading grammatical values from db');
    return GrammarValues(await _db.getConcordanceGrammarValues().get());
  }

  //
}

//interactors

abstract interface class IConcordanceRepository {
  //
  Future<GrammarValues> getGrammarValues();
  //
}

class GetGrammarValuesUseCase implements IGetGrammarValuesUseCase {
  GetGrammarValuesUseCase(
    this._repository,
  );

  final IConcordanceRepository _repository;

  @override
  Future<GrammarValues> invoke() => _repository.getGrammarValues();
  //
}

//domain

abstract interface class IGetGrammarValuesUseCase {
  //
  Future<GrammarValues> invoke();
  //
}

/// A row of "concordance.GrammarValues"
@immutable
class GrammarValueRow {
  const GrammarValueRow.fromSql({
    required this.partOfSpeech,
    required this.feature,
    required this.value,
  });

  final String? partOfSpeech;

  /// A [GrammarFeature] name
  final String? feature;
  final String? value;

  @override
  String toString() => 'GrammarValueRow{$partOfSpeech, $feature: $value}';
  //
}

/// The values each [GrammarFeature] takes in the analyses, by part of speech
@immutable
class GrammarValues {
  GrammarValues(
    Iterable<GrammarValueRow> rows,
  ) : _byPartOfSpeech = UnmodifiableMapView(_index(rows));

  final Map<String, Map<GrammarFeature, Set<String>>> _byPartOfSpeech;

  /// Every part of speech, alphabetically
  List<String> get partsOfSpeech => _byPartOfSpeech.keys.sorted((a, b) => a.compareTo(b));

  /// Values of [feature] for [partOfSpeech] (for every part of speech when
  /// null). Combined values count as each of theirs, so
  /// masculine/feminine/neuter adds nothing to masculine, feminine and neuter
  Set<String> valuesOf(GrammarFeature feature, {String? partOfSpeech}) =>
      UnmodifiableSetView(
        (partOfSpeech == null
                ? _byPartOfSpeech.values
                : [_byPartOfSpeech[partOfSpeech] ?? const <GrammarFeature, Set<String>>{}])
            .expand((features) => features[feature] ?? const <String>{})
            .toSet(),
      );

  static Map<String, Map<GrammarFeature, Set<String>>> _index(Iterable<GrammarValueRow> rows) {
    final features = GrammarFeature.values.asNameMap();
    final known = rows.where(
      (row) =>
          row.partOfSpeech != null &&
          row.value != null &&
          features.containsKey(row.feature) &&
          row.feature != GrammarFeature.partOfSpeech.name,
    );
    final parts = rows.map((row) => row.partOfSpeech).nonNulls.toSet();
    return Map.fromEntries(
      parts.map(
        (part) => MapEntry(
          part,
          groupBy(
            known.where((row) => row.partOfSpeech == part),
            (row) => features[row.feature]!,
          ).map(
            (feature, values) => MapEntry(
              feature,
              values.expand((row) => row.value!.split('/')).toSet(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  String toString() => 'GrammarValues{partsOfSpeech: ${_byPartOfSpeech.keys}}';
  //
}
