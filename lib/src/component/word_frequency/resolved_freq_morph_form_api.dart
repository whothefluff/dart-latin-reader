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
import 'lemma.dart';
import 'word_frequency.drift.dart';

part 'resolved_freq_morph_form_api.g.dart';

//infrastructure

/// Returns the stored morphological matches for [form] in [workIds].
///
/// If [macronForm] is provided, results must also match that macronized spelling.
/// Page size, page offset, and sort order do not affect this lookup.
@riverpod
Future<FrequencyMorphCandidates> resolvedFreqMorphForms(
  Ref ref,
  WorkIds workIds,
  String form, {
  String? macronForm,
}) async {
  log.info(() => '@riverpod - using $form (macronForm: $macronForm) in ${workIds.length} works');
  ref.cacheFor(const Duration(minutes: 5));
  final db = await ref.watch(dbProvider.future);
  final repo = WordFrequencyRepository(db.wordFrequencyDrift);
  return GetFormMorphCandidatesUseCase(repo, workIds, form, macronForm).invoke();
}

/// Returns the stored morphological matches for [lemma] in [workIds].
///
/// Results may include several inflected forms of the lemma.
@riverpod
Future<FrequencyMorphCandidates> resolvedFreqMorphFormsOfLemma(
  Ref ref,
  WorkIds workIds,
  Lemma lemma,
) async {
  log.info(() => '@riverpod - using $lemma in ${workIds.length} works');
  ref.cacheFor(const Duration(minutes: 5));
  final db = await ref.watch(dbProvider.future);
  final repo = WordFrequencyRepository(db.wordFrequencyDrift);
  return GetLemmaMorphCandidatesUseCase(repo, workIds, lemma).invoke();
}

class WordFrequencyRepository implements IWordFrequencyRepository {
  WordFrequencyRepository(
    this._db,
  );

  final WordFrequencyDrift _db;

  /// A null [macronForm] allows all macronized spellings of [form].
  /// Otherwise, both [form] and [macronForm] must match.
  @override
  Future<FrequencyMorphCandidates> getCandidatesOfForm(workIds, form, macronForm) async {
    log.fine(() => 'reading the morph identities of "${macronForm ?? form}" from db');
    final query = macronForm == null
        ? _db.getFormMorphIdentities(workIds: workIds, form: form)
        : _db.getMacronFormMorphIdentities(workIds: workIds, form: form, macronForm: macronForm);
    return FrequencyMorphCandidates(await query.get());
  }

  @override
  Future<FrequencyMorphCandidates> getCandidatesOfLemma(workIds, lemma) async {
    log.fine(() => 'reading the morph identities of lemma $lemma from db');
    return FrequencyMorphCandidates(
      await _db
          .getLemmaMorphIdentities(
            workIds: workIds,
            dictionaryRef: lemma.dictionaryRef,
            sublemma: lemma.sublemma,
          )
          .get(),
    );
  }

  //
}

//interactors

abstract interface class IWordFrequencyRepository {
  //
  Future<FrequencyMorphCandidates> getCandidatesOfForm(
    WorkIds workIds,
    String form,
    String? macronForm,
  );

  Future<FrequencyMorphCandidates> getCandidatesOfLemma(
    WorkIds workIds,
    Lemma lemma,
  );
  //
}

class GetFormMorphCandidatesUseCase implements IGetFormMorphCandidatesUseCase {
  GetFormMorphCandidatesUseCase(
    this._repository,
    this._workIds,
    this._form,
    this._macronForm,
  );

  final IWordFrequencyRepository _repository;
  final WorkIds _workIds;
  final String _form;
  final String? _macronForm;

  @override
  Future<FrequencyMorphCandidates> invoke() async =>
      _repository.getCandidatesOfForm(_workIds, _form, _macronForm);
  //
}

class GetLemmaMorphCandidatesUseCase implements IGetLemmaMorphCandidatesUseCase {
  GetLemmaMorphCandidatesUseCase(
    this._repository,
    this._workIds,
    this._lemma,
  );

  final IWordFrequencyRepository _repository;
  final WorkIds _workIds;
  final Lemma _lemma;

  @override
  Future<FrequencyMorphCandidates> invoke() async =>
      _repository.getCandidatesOfLemma(_workIds, _lemma);
  //
}

//domain

abstract interface class IGetFormMorphCandidatesUseCase {
  //
  Future<FrequencyMorphCandidates> invoke();
  //
}

abstract interface class IGetLemmaMorphCandidatesUseCase {
  //
  Future<FrequencyMorphCandidates> invoke();
  //
}

/// The works a lookup is restricted to
@immutable
extension type const WorkIds._(ValueList<String> unm) implements ValueList<String> {
  WorkIds(
    Iterable<String> iter,
  ) : this._(ValueList(iter));
}

@immutable
extension type const FrequencyMorphCandidates._(UnmodifiableListView<FrequencyMorphCandidate> unm)
    implements UnmodifiableListView<FrequencyMorphCandidate> {
  FrequencyMorphCandidates(
    Iterable<FrequencyMorphCandidate> iter,
  ) : this._(UnmodifiableListView(iter));
}

/// A stored morphological match for a form counted in the frequency report.
@immutable
class FrequencyMorphCandidate {
  const FrequencyMorphCandidate({
    required this.form,
    required this.morphForm,
    required this.morphItem,
    required String dictionaryRef,
    required String sublemma,
  }) : lemma = (dictionaryRef: dictionaryRef, sublemma: sublemma);

  final int morphItem;
  final Lemma lemma;

  /// The plain form counted in the report.
  /// When counting `populus` from `populusque`, this is `populus`
  /// and [morphForm] is `populusque`.
  final String form;

  /// The spelling stored in the matching `MorphologicalDetails` record.
  /// When counting `populus` from `populusque`, this is `populusque`
  /// and [form] is `populus`.
  final String morphForm;

  @override
  String toString() =>
      'FrequencyMorphCandidate{form: $form, morphForm: $morphForm, item: $morphItem}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyMorphCandidate &&
          other.form == form &&
          other.morphForm == morphForm &&
          other.morphItem == morphItem &&
          other.lemma == lemma);

  @override
  int get hashCode => Object.hash(morphForm, morphItem, lemma);
  //
}
