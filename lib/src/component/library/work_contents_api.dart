// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'work_contents_api.g.dart';

//infrastructure

@riverpod
Future<WorkContentsSegments> workContents(Ref ref, String id, int fromIndex, int toIndex) async {
  log.info(() => '@riverpod - workContents');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = LibraryRepository(db);
  return GetPartialWorkContentsUseCase(repo, id, fromIndex, toIndex).invoke();
}

class LibraryRepository implements ILibraryRepository {
  LibraryRepository(this._db);

  final AppDb _db;

  @override
  Future<WorkContentsSegments> getWorkContents(String id, int fromIndex, int toIndex) async {
    log.info('LibraryRepository - reading work contents ($fromIndex - $toIndex) from db');
    final dbData = await _db.libraryDrift
        .getLibraryWorkContentsPartial(id, fromIndex, toIndex)
        .get();
    return WorkContentsSegments(dbData);
  }

  //
}

//interactors

abstract interface class ILibraryRepository {
  //
  Future<WorkContentsSegments> getWorkContents(String id, int fromIndex, int toIndex);
  //
}

class GetPartialWorkContentsUseCase implements IGetPartialWorkContentsUseCase {
  GetPartialWorkContentsUseCase(
    this._repository,
    this._id,
    this._fromIndex,
    this._toIndex,
  );

  final ILibraryRepository _repository;
  final String _id;
  final int _fromIndex;
  final int _toIndex;

  @override
  Future<WorkContentsSegments> invoke() async =>
      _repository.getWorkContents(_id, _fromIndex, _toIndex);
  //
}

//domain

abstract interface class IGetPartialWorkContentsUseCase {
  //
  Future<WorkContentsSegments> invoke();
  //
}

@immutable
extension type const WorkContentsSegments._(UnmodifiableListView<WorkContentsSegment> unm)
    implements UnmodifiableListView<WorkContentsSegment> {
  WorkContentsSegments(Iterable<WorkContentsSegment> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class WorkContentsSegment {
  const WorkContentsSegment({
    required this.workId,
    required this.parent,
    required this.node,
    required this.idx,
    required this.word,
    required this.typ,
    required this.depth,
    required this.sourceReference,
  });

  final String workId;
  final String? parent;
  final String node;
  final int idx;
  final String word;
  final String typ;
  final int depth;
  final String sourceReference;

  @override
  String toString() => 'WorkContentsSegment{index: $idx, word: $word}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkContentsSegment && other.workId == workId && other.idx == idx);

  @override
  int get hashCode => Object.hash(workId, idx);
  //
}
