// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'author_details_api.g.dart';

//infrastructure

@riverpod
Future<AuthorDetails> authorDetails(Ref ref, String author) async {
  log.info(() => '@riverpod - using $author');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = LibraryRepository(db);
  return GetAuthorDetailsUseCase(repo, author).invoke();
}

class LibraryRepository implements ILibraryRepository {
  LibraryRepository(this._db);

  final AppDb _db;

  @override
  Future<AuthorDetails> getAuthorDetailsOf(String author) async {
    log.fine(() => 'reading details of author "$author" from db');
    final dbData = await _db.libraryDrift.getLibraryAuthorDetails(author).get();
    final firstLine = dbData.first;
    return AuthorDetails(
      id: firstLine.id,
      name: firstLine.name,
      about: firstLine.about,
      image: firstLine.image,
      works: UnmodifiableListView(
        dbData.map(
          (e) => (
            id: e.workId,
            name: e.workName,
            numberOfWords: e.numberOfWords,
          ),
        ),
      ),
    );
  }

  //
}

//interactors

abstract interface class ILibraryRepository {
  //
  Future<AuthorDetails> getAuthorDetailsOf(String author);
  //
}

class GetAuthorDetailsUseCase implements IGetAuthorDetailsUseCase {
  GetAuthorDetailsUseCase(
    this._repository,
    this._author,
  );

  final ILibraryRepository _repository;
  final String _author;

  @override
  Future<AuthorDetails> invoke() async => _repository.getAuthorDetailsOf(_author);
  //
}

//domain

abstract interface class IGetAuthorDetailsUseCase {
  //
  Future<AuthorDetails> invoke();
  //
}

@immutable
class AuthorDetails {
  const AuthorDetails({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.works,
  });

  final String id;
  final String name;
  final String about;
  final Uint8List image;
  final UnmodifiableListView<({String id, String name, int numberOfWords})> works;

  @override
  String toString() => 'AuthorDetails{name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is AuthorDetails && other.id == id);

  @override
  int get hashCode => id.hashCode;
  //
}
