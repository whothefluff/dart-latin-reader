// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'authors_api.g.dart';

//infrastructure

@riverpod
Future<Authors> authors(Ref ref) async {
  log.info(() => '@riverpod');
  ref.cacheFor(const Duration(minutes: 2));
  final db = await ref.watch(dbProvider.future);
  final repo = LibraryRepository(db);
  return GetAuthorsUseCase(repo).invoke();
}

class LibraryRepository implements ILibraryRepository {
  LibraryRepository(this._db);

  final AppDb _db;

  @override
  Future<Authors> getAuthors() async {
    log.fine('reading all authors from db');
    final dbData = await _db.libraryDrift.getLibraryAuthors().get();
    return Authors(dbData);
  }

  //
}

//interactors

abstract interface class ILibraryRepository {
  //
  Future<Authors> getAuthors();
  //
}

class GetAuthorsUseCase implements IGetAuthorsUseCase {
  GetAuthorsUseCase(
    this._repository,
  );

  final ILibraryRepository _repository;

  @override
  Future<Authors> invoke() async => _repository.getAuthors();
  //
}

//domain

abstract interface class IGetAuthorsUseCase {
  //
  Future<Authors> invoke();
  //
}

@immutable
extension type const Authors._(UnmodifiableListView<Author> unm)
    implements UnmodifiableListView<Author> {
  Authors(Iterable<Author> iter) : this._(UnmodifiableListView(iter));
}

@immutable
class Author {
  const Author({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.numberOfWorks,
  });

  final String id;
  final String name;
  final String about;
  final Uint8List image;
  final int numberOfWorks;

  @override
  String toString() => 'Author{name: $name}';

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Author && other.id == id);

  @override
  int get hashCode => id.hashCode;
  //
}
