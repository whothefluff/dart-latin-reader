import 'dart:collection';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_details.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_author_details.dart';
import 'package:latin_reader/src/component/library/repository_author.dart' as i;
import 'package:latin_reader/src/component/library/repository_work.dart' as i;
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
  Future<UnmodifiableListView<AuthorView>> getLibraryAuthors() async {
    final db = AppDb();
    log.info(() => 'AuthorRepository - reading library authors from db');
    final dbAuthors = await db.getLibraryAuthors().get();
    return UnmodifiableListView(dbAuthors as Iterable<AuthorView>);
  }

  @override
  Future<AuthorDetailsView> getLibraryAuthorDetails(String id) async {
    final db = AppDb();
    log.info(() => 'AuthorRepository - reading author details from db');
    final dbAuthorDetails = await db.getLibraryAuthorDetails(id).get();
    final firstLine = dbAuthorDetails.first;
    return AuthorDetailsView(
        id: firstLine.id,
        name: firstLine.name,
        about: firstLine.about,
        image: firstLine.image,
        works: UnmodifiableListView(dbAuthorDetails.map((e) => ((
              id: e.workId,
              name: e.workName,
              numberOfWords: e.numberOfWords,
            )))));
  }
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
  Future<WorkDetailsView> getLibraryWorkDetails(String id) async {
    final db = AppDb();
    log.info(() => 'WorkRepository - reading work details from db');
    final dbWorkDetails = await db.getLibraryWorkDetails(id).getSingle();
    return dbWorkDetails;
  }

//
}
