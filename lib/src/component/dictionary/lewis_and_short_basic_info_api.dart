// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../core/value_list.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'dictionary.drift.dart';

part 'lewis_and_short_basic_info_api.g.dart';

//infrastructure

@riverpod
Future<LnsBasicInfoByRef> lnsBasicInfo(Ref ref, PossibleLemmas lnsRefs) async {
  log.info(() => '@riverpod - using $lnsRefs');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = DictionaryRepository(db.dictionaryDrift);
  return GetLnsBasicInfoUseCase(repo, lnsRefs).invoke();
}

class DictionaryRepository implements IDictionaryRepository {
  DictionaryRepository(
    this._db,
  );

  final DictionaryDrift _db;

  @override
  Future<LnsBasicInfoByRef> getLnsInfoFor(lemmas) async {
    log.fine('reading L&S info for dictionary refs $lemmas from db');
    final dbData = await _db.getBasicLnsInfo(lemmas.toSet().toList()).get();
    return LnsBasicInfoByRef(
      Map.fromEntries(
        dbData.map(
          (row) => MapEntry(
            row.dictionaryRef,
            LnsBasicInfoEntry(
              lemma: row.lemma,
              inflection: row.inflection,
              partOfSpeech: row.partOfSpeech,
            ),
          ),
        ),
      ),
    );
  }

  //
}

//interactors

abstract interface class IDictionaryRepository {
  //
  Future<LnsBasicInfoByRef> getLnsInfoFor(Iterable<String> lemmas);
  //
}

class GetLnsBasicInfoUseCase implements IGetLnsBasicInfoUseCase {
  GetLnsBasicInfoUseCase(
    this._repository,
    this._dictionaryRefs,
  );

  final IDictionaryRepository _repository;
  final Iterable<String> _dictionaryRefs;

  @override
  Future<LnsBasicInfoByRef> invoke() async => _repository.getLnsInfoFor(_dictionaryRefs);
  //
}

//domain

abstract interface class IGetLnsBasicInfoUseCase {
  //
  Future<LnsBasicInfoByRef> invoke();
  //
}

/// Associates requested dictionary references with their matched L&S entries
@immutable
extension type const LnsBasicInfoByRef._(UnmodifiableMapView<String, LnsBasicInfoEntry> unm)
    implements UnmodifiableMapView<String, LnsBasicInfoEntry> {
  LnsBasicInfoByRef(
    Map<String, LnsBasicInfoEntry> map,
  ) : this._(UnmodifiableMapView(Map.of(map)));
}

/// Represents a pure L&S entry
@immutable
class LnsBasicInfoEntry {
  const LnsBasicInfoEntry({
    required this.lemma,
    this.inflection,
    this.partOfSpeech,
  });

  final String lemma;
  final String? inflection;
  final String? partOfSpeech;

  @override
  String toString() => 'LnsBasicInfoEntry{lemma: $lemma}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LnsBasicInfoEntry && other.lemma == lemma);

  @override
  int get hashCode => lemma.hashCode;
  //
}

/// These are **not _necessarily_** L&S lemmas, although they will often match
@immutable
extension type const PossibleLemmas._(ValueList<String> unm) implements ValueList<String> {
  PossibleLemmas(
    Iterable<String> iter,
  ) : this._(ValueList(iter));
}
