// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'work_details_api.g.dart';

//infrastructure

@riverpod
Future<WorkDetails> workDetails(Ref ref, String work) async {
  log.info(() => '@riverpod - using $work');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = LibraryRepository(db);
  return GetWorkDetailsUseCase(repo, work).invoke();
}

class LibraryRepository implements ILibraryRepository {
  LibraryRepository(this._db);

  final AppDb _db;

  @override
  Future<WorkDetails> getWorkDetailsOf(String work) async {
    log.fine('reading details of work "$work" from db');
    final dbData = await _db.libraryDrift.getLibraryWorkDetails(work).getSingle();
    return dbData;
  }

  //
}

//interactors

abstract interface class ILibraryRepository {
  //
  Future<WorkDetails> getWorkDetailsOf(String work);
  //
}

class GetWorkDetailsUseCase implements IGetWorkDetailsUseCase {
  GetWorkDetailsUseCase(
    this._repository,
    this._work,
  );

  final ILibraryRepository _repository;
  final String _work;

  @override
  Future<WorkDetails> invoke() async => _repository.getWorkDetailsOf(_work);
  //
}

//domain

abstract interface class IGetWorkDetailsUseCase {
  //
  Future<WorkDetails> invoke();
  //
}

@immutable
class WorkDetails {
  const WorkDetails({
    required this.id,
    required this.name,
    required this.about,
    required this.numberOfWords,
    required this.authorId,
    required this.authorName,
  });

  final String id;
  final String name;
  final String about;
  final int numberOfWords;
  final String? authorId;
  final String? authorName;

  @override
  String toString() => 'WorkDetails{name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is WorkDetails && other.id == id);

  @override
  int get hashCode => id.hashCode;
  //
}
