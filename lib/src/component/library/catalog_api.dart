// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'library.drift.dart';

part 'catalog_api.g.dart';

//infrastructure

@riverpod
Future<LibraryCatalog> libraryCatalog(Ref ref) async {
  log.info(() => '@riverpod');
  ref.cacheFor(const Duration(minutes: 120));
  final db = await ref.watch(dbProvider.future);
  final repo = LibraryRepository(db.libraryDrift);
  return GetLibraryCatalogUseCase(repo).invoke();
}

class LibraryRepository implements ILibraryRepository {
  LibraryRepository(
    this._db,
  );

  final LibraryDrift _db;

  @override
  Future<LibraryCatalog> getCatalog() async {
    log.fine('reading library catalog from db');
    final rows = await _db.getLibraryCatalog().get();
    final byAuthor = groupBy(rows.where((r) => r.authorId != null), (r) => r.authorId);
    final authors = byAuthor.entries
        .map(
          (e) => CatalogAuthor(
            id: e.key!,
            name: e.value.first.authorName!,
            works: UnmodifiableListView(
              e.value.map((r) => CatalogWork(id: r.workId, name: r.workName)),
            ),
          ),
        )
        .sortedBy((a) => a.name);
    final anonymous = rows
        .where((r) => r.authorId == null)
        .map((r) => CatalogWork(id: r.workId, name: r.workName));
    return LibraryCatalog(
      authors: UnmodifiableListView(authors),
      anonymousWorks: UnmodifiableListView(anonymous),
    );
  }

  //
}

// interactors

abstract interface class ILibraryRepository {
  //
  Future<LibraryCatalog> getCatalog();
  //
}

class GetLibraryCatalogUseCase implements IGetLibraryCatalogUseCase {
  GetLibraryCatalogUseCase(
    this._repo,
  );

  final ILibraryRepository _repo;

  @override
  Future<LibraryCatalog> invoke() => _repo.getCatalog();
  //
}

// domain

abstract interface class IGetLibraryCatalogUseCase {
  //
  Future<LibraryCatalog> invoke();
  //
}

@immutable
class CatalogWork {
  const CatalogWork({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  String toString() => 'CatalogWork{name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CatalogWork && other.id == id);

  @override
  int get hashCode => id.hashCode;
  //
}

@immutable
class CatalogAuthor {
  const CatalogAuthor({
    required this.id,
    required this.name,
    required this.works,
  });

  final String id;
  final String name;
  final UnmodifiableListView<CatalogWork> works;

  @override
  String toString() => 'CatalogAuthor{name: $name, works: ${works.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CatalogAuthor && other.id == id);

  @override
  int get hashCode => id.hashCode;
  //
}

@immutable
class LibraryCatalog {
  const LibraryCatalog({
    required this.authors,
    required this.anonymousWorks,
  });

  final UnmodifiableListView<CatalogAuthor> authors;
  final UnmodifiableListView<CatalogWork> anonymousWorks;

  Iterable<String> get allWorkIds =>
      authors.expand((a) => a.works).followedBy(anonymousWorks).map((w) => w.id).toList();

  @override
  String toString() =>
      'LibraryCatalog{authors: ${authors.length}, anonymousWorks: ${anonymousWorks.length}}';
  //
}
