import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/dictionary/db_util.dart'
    as dict_util;
import 'package:latin_reader/src/external/data_version.drift.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/library.drift.dart';
import 'package:sqlite3/sqlite3.dart';

const path = 'assets/preprocessed_data/';

void setupRegExp(Database db) {
  db.createFunction(
    functionName: 'regexp',
    argumentCount: const AllowedArgumentCount(2),
    function: (args) {
      final regexPattern = args[0]! as String;
      final input = args[1]! as String;
      return RegExp(regexPattern).hasMatch(input) ? 1 : 0;
    },
  );
}

Future<int> getDataVersion() async {
  final data = await rootBundle.loadString('${path}data_version.txt');
  return int.parse(data.trim());
}

Future<bool> shouldPopulate(AppDb db) async {
  final dataVersion = await getDataVersion();
  final dbVersion = await getDbDataVersion(db);
  return dataVersion > dbVersion;
}

Future<int> getDbDataVersion(AppDb db) async {
  final latest = await db.getLatestDataVersion();
  return latest?.idx ?? 0;
}

Future<void> populateDatabaseFromCsv(AppDb db) async {
  final operations = [
    (
      id: 'Authors',
      delete: (AppDb db) async {
        await db.delete(db.authors).go();
      },
      insert: (AppDb db) async {
        final csvData = await rootBundle.loadString('${path}authors.csv');
        final rows = const CsvToListConverter().convert(csvData);
        await db.batch((b) => b.insertAll(
            db.authors,
            rows.skip(1).map((row) => AuthorsCompanion(
                  id: Value(row[0].toString()),
                  name: Value(row[1].toString()),
                  about: Value(row[2].toString()),
                  image: Value(base64Decode(row[3].toString())),
                )),
            mode: InsertMode.insertOrRollback));
      }
    ),
    (
      id: 'AuthorAbbreviations',
      delete: (AppDb db) async {
        await db.delete(db.authorAbbreviations).go();
      },
      insert: (AppDb db) async {
        final csvData =
            await rootBundle.loadString('${path}author_abbreviations.csv');
        final rows = const CsvToListConverter().convert(csvData);
        await db.batch((b) => b.insertAll(
              db.authorAbbreviations,
              rows.skip(1).map((row) => AuthorAbbreviationsCompanion(
                    authorId: Value(row[0].toString()),
                    id: Value(row[1] as int),
                    val: Value(row[2].toString()),
                  )),
              mode: InsertMode.insertOrRollback,
            ));
      }
    ),
    (
      id: 'Works',
      delete: (AppDb db) async {
        await db.delete(db.works).go();
      },
      insert: (AppDb db) async {
        final csvData = await rootBundle.loadString('${path}works.csv');
        final rows = const CsvToListConverter().convert(csvData);
        await db.batch((b) => b.insertAll(
              db.works,
              rows.skip(1).map((row) => WorksCompanion(
                    id: Value(row[0].toString()),
                    name: Value(row[1].toString()),
                    about: Value(row[2].toString()),
                  )),
              mode: InsertMode.insertOrRollback,
            ));
      },
    ),
    (
      id: 'WorkContents',
      delete: (AppDb db) async {
        await db.delete(db.workContents).go();
      },
      insert: (AppDb db) async {
        final csvData = await rootBundle.loadString('${path}work_contents.csv');
        final rows = const CsvToListConverter().convert(csvData);
        await db.batch((b) => b.insertAll(
              db.workContents,
              rows.skip(1).map((row) => WorkContentsCompanion(
                    workId: Value(row[0].toString()),
                    idx: Value(row[1] as int),
                    word: Value(row[2].toString()),
                    sourceReference: Value(row[3].toString()),
                  )),
              mode: InsertMode.insertOrRollback,
            ));
      },
    ),
    (
      id: 'WorkContentSubdivisions',
      delete: (AppDb db) async {
        await db.delete(db.workContentSubdivisions).go();
      },
      insert: (AppDb db) async {
        final csvData =
            await rootBundle.loadString('${path}work_content_subdivisions.csv');
        final rows = const CsvToListConverter().convert(csvData);
        await db.batch((b) => b.insertAll(
              db.workContentSubdivisions,
              rows.skip(1).map((row) => WorkContentSubdivisionsCompanion(
                    workId: Value(row[0].toString()),
                    node: Value(row[1].toString()),
                    typ: Value(row[2].toString()),
                    cnt: Value(row[3] as int),
                    name: Value(row[4].toString()),
                    parent: Value(
                        row[5].toString().isEmpty ? null : row[5].toString()),
                    fromIndex: Value(row[6] as int),
                    toIndex: Value(row[7] as int),
                  )),
              mode: InsertMode.insertOrRollback,
            ));
      },
    ),
    (
      id: 'WorkContentSupplementary',
      delete: (AppDb db) async {
        await db.delete(db.workContentSupplementary).go();
      },
      insert: (AppDb db) async {
        final csvData = await rootBundle
            .loadString('${path}work_content_supplementary.csv');
        final rows = const CsvToListConverter().convert(csvData);
        await db.batch((b) => b.insertAll(
              db.workContentSupplementary,
              rows.skip(1).map((row) => WorkContentSupplementaryCompanion(
                    workId: Value(row[0].toString()),
                    typ: Value(row[1].toString()),
                    cnt: Value(row[2] as int),
                    fromIndex: Value(row[3] as int),
                    toIndex: Value(row[4] as int),
                    val: Value(row[5].toString()),
                  )),
              mode: InsertMode.insertOrRollback,
            ));
      },
    ),
    (
      id: 'AuthorsAndWorks',
      delete: (AppDb db) async {
        await db.delete(db.authorsAndWorks).go();
      },
      insert: (AppDb db) async {
        final csvData =
            await rootBundle.loadString('${path}authors_and_works.csv');
        final rows = const CsvToListConverter().convert(csvData);
        await db.batch((b) => b.insertAll(
              db.authorsAndWorks,
              rows.skip(1).map((row) => AuthorsAndWorksCompanion(
                    authorId: Value(row[0].toString()),
                    workId: Value(row[1].toString()),
                  )),
              mode: InsertMode.insertOrRollback,
            ));
      },
    ),
    ...dict_util.operations
  ];
  await db.transaction(() async {
    await operations.fold(
        Future<void>.value(),
        (previousFuture, operation) => previousFuture.then((_) async {
              log.info(
                  () => 'populateDatabaseFromCsv() - deleting ${operation.id}');
              await operation.delete(db);
              log.info(() =>
                  'populateDatabaseFromCsv() - inserting ${operation.id}');
              await operation.insert(db);
            }));
  });
}

Future<void> updateDatabaseVersion(AppDb db) async {
  log.info(() => 'updateDatabaseVersion() - updating data version');
  final assetVersion = await getDataVersion();
  await db.into(db.dataVersion).insertOnConflictUpdate(
        DataVersionCompanion(
          idx: Value(assetVersion),
        ),
      );
}
