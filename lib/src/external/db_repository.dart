import 'dart:collection';

import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/library/repository_author.dart' as i;
import 'package:latin_reader/src/component/library/repository_work.dart' as i;
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_author_details.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_details.dart';
import 'package:latin_reader/src/external/database.dart';

class AuthorRepository implements i.AuthorRepository {
  AuthorRepository(this.db);

  final AppDb db;

  @override
  Future<UnmodifiableListView<AuthorView>> getLibraryAuthors() async {
    log.info(() => 'AuthorRepository - reading library authors from db');
    final dbAuthors = await db.libraryDrift.getLibraryAuthors().get();
    return UnmodifiableListView(dbAuthors as Iterable<AuthorView>);
  }

  @override
  Future<AuthorDetailsView> getLibraryAuthorDetails(String id) async {
    log.info(() => 'AuthorRepository - reading author details from db');
    final dbAuthorDetails =
        await db.libraryDrift.getLibraryAuthorDetails(id).get();
    final firstLine = dbAuthorDetails.first;
    return AuthorDetailsView(
        id: firstLine.id,
        name: firstLine.name,
        about: firstLine.about,
        image: firstLine.image,
        works: UnmodifiableListView(dbAuthorDetails.map((e) => (
              id: e.workId,
              name: e.workName,
              numberOfWords: e.numberOfWords,
            ))));
  }
//
}

class WorkRepository implements i.WorkRepository {
  WorkRepository(this.db);

  final AppDb db;

  @override
  Future<WorkDetailsView> getLibraryWorkDetails(String id) async {
    log.info(() => 'WorkRepository - reading work details from db');
    final dbWorkDetails =
        await db.libraryDrift.getLibraryWorkDetails(id).getSingle();
    return dbWorkDetails;
  }

  @override
  Future<UnmodifiableListView<WorkContentsElementView>>
      getLibraryWorkContentsPartially(
          String id, int fromIndex, int toIndex) async {
    log.info(() =>
        'WorkRepository - reading work contents ($fromIndex - $toIndex) from db');
    final dbWorkContents = await db.libraryDrift
        .getLibraryWorkContentsPartial(id, fromIndex, toIndex)
        .get();
    return UnmodifiableListView(
        dbWorkContents as Iterable<WorkContentsElementView>);
  }

//
}
