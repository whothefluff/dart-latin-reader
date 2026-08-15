// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../core/value_list.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import '../morph_analysis/morph_analysis.drift.dart';

part 'form_lemmas_api.g.dart';
// infrastructure

@riverpod
Future<FormLemmaMap> formLemmas(Ref ref, Forms forms) async {
  log.info(() => '@riverpod - using $forms');
  ref.cacheFor(const Duration(minutes: 5));
  final db = await ref.watch(dbProvider.future);
  final repo = MorphRepository(db.morphAnalysisDrift);
  return GetFormLemmasUseCase(repo, forms).invoke();
}

class MorphRepository implements IMorphRepository {
  MorphRepository(
    this._db,
  );

  final MorphAnalysisDrift _db;

  @override
  Future<FormLemmaMap> getLemmasFor(Iterable<String> forms) async {
    log.fine('reading dictionaryRefs for $forms from db');
    final dbData =
        await (_db.selectOnly(_db.morphologicalDetails)
              ..addColumns([
                _db.morphologicalDetails.form,
                _db.morphologicalDetails.dictionaryRef,
              ])
              ..where(_db.morphologicalDetails.form.isIn(forms)))
            .get();
    final rowsByForm = groupBy(dbData, (row) => row.read(_db.morphologicalDetails.form)!);
    final formToLemmas = FormLemmaMap(
      rowsByForm.map(
        (form, rows) => MapEntry(
          form,
          rows.map((row) => row.read(_db.morphologicalDetails.dictionaryRef)!).toSet().toList(),
        ),
      ),
    );
    return formToLemmas;
  }

  //
}

// interactors

abstract interface class IMorphRepository {
  //
  Future<FormLemmaMap> getLemmasFor(Iterable<String> forms);
  //
}

class GetFormLemmasUseCase {
  GetFormLemmasUseCase(
    this._repo,
    this._forms,
  );

  final IMorphRepository _repo;
  final Iterable<String> _forms;

  Future<FormLemmaMap> invoke() => _repo.getLemmasFor(_forms);
  //
}

// domain

@immutable
extension type const Forms._(ValueList<String> unm) implements ValueList<String> {
  Forms(
    Iterable<String> iter,
  ) : this._(ValueList(iter));
}

@immutable
extension type const FormLemmaMap._(UnmodifiableMapView<String, List<String>> unm)
    implements UnmodifiableMapView<String, List<String>> {
  FormLemmaMap(
    Map<String, List<String>> map,
  ) : this._(UnmodifiableMapView(map));
}
