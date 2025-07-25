import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../external/database.dart';
import '../../external/value_util.dart';
import 'library.drift.dart';

const path = 'assets/preprocessed_data/';

// Type not important
// ignore: specify_nonobvious_property_types
final operations = [
  (
    id: 'Authors',
    delete: (AppDb db) async {
      await db.delete(db.authors).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}authors.csv');
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.authors,
          rows
              .skip(1)
              .map(
                (row) => AuthorsCompanion(
                  id: Value(row[0].toString()),
                  name: Value(row[1].toString()),
                  about: Value(row[2].toString()),
                  image: Value(base64Decode(row[3].toString())),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'AuthorAbbreviations',
    delete: (AppDb db) async {
      await db.delete(db.authorAbbreviations).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}author_abbreviations.csv');
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.authorAbbreviations,
          rows
              .skip(1)
              .map(
                (row) => AuthorAbbreviationsCompanion(
                  authorId: Value(row[0].toString()),
                  id: Value(row[1] as int),
                  val: Value(row[2].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'Works',
    delete: (AppDb db) async {
      await db.delete(db.works).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}works.csv');
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.works,
          rows
              .skip(1)
              .map(
                (row) => WorksCompanion(
                  id: Value(row[0].toString()),
                  name: Value(row[1].toString()),
                  about: Value(row[2].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
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
      await db.batch(
        (b) => b.insertAll(
          db.workContents,
          rows
              .skip(1)
              .map(
                (row) => WorkContentsCompanion(
                  workId: Value(row[0].toString()),
                  idx: Value(row[1] as int),
                  word: Value(row[2].toString()),
                  sourceReference: Value(row[3].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'WorkContentSubdivisions',
    delete: (AppDb db) async {
      await db.delete(db.workContentSubdivisions).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}work_content_subdivisions.csv');
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.workContentSubdivisions,
          rows
              .skip(1)
              .map(
                (row) => WorkContentSubdivisionsCompanion(
                  workId: Value(row[0].toString()),
                  node: Value(row[1].toString()),
                  typ: Value(row[2].toString()),
                  cnt: Value(row[3] as int),
                  name: Value(row[4].toString()),
                  parent: stringValue(row[5].toString()),
                  fromIndex: Value(row[6] as int),
                  toIndex: Value(row[7] as int),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'WorkContentSupplementary',
    delete: (AppDb db) async {
      await db.delete(db.workContentSupplementary).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}work_content_supplementary.csv');
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.workContentSupplementary,
          rows
              .skip(1)
              .map(
                (row) => WorkContentSupplementaryCompanion(
                  workId: Value(row[0].toString()),
                  typ: Value(row[1].toString()),
                  cnt: Value(row[2] as int),
                  fromIndex: Value(row[3] as int),
                  toIndex: Value(row[4] as int),
                  val: Value(row[5].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'AuthorsAndWorks',
    delete: (AppDb db) async {
      await db.delete(db.authorsAndWorks).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}authors_and_works.csv');
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.authorsAndWorks,
          rows
              .skip(1)
              .map(
                (row) => AuthorsAndWorksCompanion(
                  authorId: Value(row[0].toString()),
                  workId: Value(row[1].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
];
