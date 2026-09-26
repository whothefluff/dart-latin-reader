// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'library.drift.dart';

part 'reading_start_api.g.dart';

//infrastructure

/// The token a reader page has to start at to show [tokenIndex] of [workId]
@riverpod
Future<int> readingStart(Ref ref, String workId, int tokenIndex) async {
  log.info(() => '@riverpod - using $workId, $tokenIndex');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = LibraryRepository(db.libraryDrift);
  return GetReadingStartUseCase(repo, workId, tokenIndex).invoke();
}

class LibraryRepository implements ILibraryRepository {
  LibraryRepository(
    this._db,
  );

  final LibraryDrift _db;

  @override
  Future<int> getReadingStart(String workId, int tokenIndex) async {
    log.fine('reading where to start reading token $tokenIndex of work "$workId" from db');
    final start = await _db
        .getLibraryReadingStart(workId: workId, idx: tokenIndex)
        .getSingleOrNull();
    //an index outside the work has no row, so start where the caller asked
    return start ?? tokenIndex;
  }

  //
}

//interactors

abstract interface class ILibraryRepository {
  //
  Future<int> getReadingStart(String workId, int tokenIndex);
  //
}

class GetReadingStartUseCase implements IGetReadingStartUseCase {
  GetReadingStartUseCase(
    this._repository,
    this._workId,
    this._tokenIndex,
  );

  final ILibraryRepository _repository;
  final String _workId;
  final int _tokenIndex;

  @override
  Future<int> invoke() async => _repository.getReadingStart(_workId, _tokenIndex);
  //
}

//domain

abstract interface class IGetReadingStartUseCase {
  //
  Future<int> invoke();
  //
}
