import 'dart:collection';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/library/author_repository.dart' as i;
import 'package:latin_reader/src/component/library/work_repository.dart' as i;
import 'package:latin_reader/src/component/library/usecase/entity/author.dart'
    as e;
import 'package:latin_reader/src/component/library/usecase/entity/authors.dart'
    as e;
import 'package:latin_reader/src/component/library/usecase/entity/work.dart'
    as e;
import 'package:latin_reader/src/component/library/usecase/entity/works.dart'
    as e;
import 'package:latin_reader/src/component/library/author_view.dart';
import 'package:latin_reader/src/external/database.dart';

class AuthorRepository implements i.AuthorRepository {
//
  static AuthorRepository? _instance;
  late final AppDb db;

  AuthorRepository._(this.db);

  factory AuthorRepository(AppDb db) {
    _instance ??= AuthorRepository._(db);
    return _instance!;
  }

  @override
  Future<e.Authors> getAllAuthors() async {
    final db = AppDb();
    var dbAuthors = await db.select(db.authors).get();
    var eAuthors = dbAuthors.map(dbToEntity).toList();
    return e.Authors(list: eAuthors);
  }

  @override
  Future<e.Author> getAuthor(String authorId) async {
    final db = AppDb();
    var dbAuthor = await (db.select(db.authors)
          ..where((a) => a.id.equals(authorId)))
        .getSingle();
    return dbToEntity(dbAuthor);
  }

  @override
  Future<e.Authors> getAuthorsByWork(String workId) async {
    final db = AppDb();
    var dbAuthors = await (db.select(db.workAuthors)
          ..where((wa) => wa.workId.equals(workId)))
        .get();
    var eAuthors = dbAuthors
        .map((a) => e.Author(
              id: a.id,
              name: a.name,
              about: a.about,
              image: a.image,
            ))
        .toList();
    return e.Authors(list: eAuthors);
  }

  @override
  Future<UnmodifiableListView<AuthorView>> getLibraryAuthors() async {
    final db = AppDb();
    log.info(() => 'AuthorRepository - reading library authors from db');
    var dbAuthors = await db.getLibraryAuthors().get();
    return UnmodifiableListView(dbAuthors as Iterable<AuthorView>);
  }

  e.Author dbToEntity(Author a) =>
      e.Author(id: a.id, name: a.name, about: a.about, image: a.image);
//
}

class WorkRepository implements i.WorkRepository {
//
  static WorkRepository? _instance;
  late final AppDb db;

  WorkRepository._(this.db);

  factory WorkRepository(AppDb db) {
    _instance ??= WorkRepository._(db);
    return _instance!;
  }

  @override
  Future<e.Works> getAllWorks() async {
    final db = AppDb();
    var dbWorks = await db.select(db.works).get();
    var eWorks = dbWorks.map(dbToEntity).toList();
    return e.Works(list: eWorks);
  }

  @override
  Future<e.Work> getWork(String workId) async {
    final db = AppDb();
    var dbWork = await (db.select(db.works)..where((w) => w.id.equals(workId)))
        .getSingle();
    return dbToEntity(dbWork);
  }

  @override
  Future<e.Works> getWorksByAuthor(String authorId) async {
    final db = AppDb();
    var dbWorks = await (db.select(db.authorWorks)
          ..where((aw) => aw.authorId.equals(authorId)))
        .get();
    var eWorks = dbWorks
        .map((w) => e.Work(
              id: w.id,
              name: w.name,
              about: '',
            ))
        .toList();
    return e.Works(list: eWorks);
  }

  e.Work dbToEntity(Work w) =>
      e.Work(id: w.id, name: w.name, about: w.about?.toString() ?? '');
//
}
