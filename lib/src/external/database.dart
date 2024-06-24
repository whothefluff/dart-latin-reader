import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {'library.drift'},
)
class AppDb extends _$AppDb {
  AppDb._() : super(_openConnection()) {
    _initializeDatabase();
  }

  static final AppDb _instance = AppDb._();

  factory AppDb() {
    return _instance;
  }

  Future<LatestDataVersionData?> getLatestDataVersion() =>
      select(latestDataVersion).getSingleOrNull();

  @override
  int get schemaVersion => 1;

  Future<void> _initializeDatabase() async {
    final shouldPopulate = await _shouldPopulate(this);
    if (shouldPopulate) {
      await _populateDatabaseFromCsv(this);
      await _updateDatabaseVersion(this);
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final packageInfo = await PackageInfo.fromPlatform();
    final file =
        File(p.join(dbFolder.path, packageInfo.appName, 'userdata.sqlite'));
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    return NativeDatabase.createInBackground(file);
  });
}

Future<int> _getDataVersion() async {
  final data =
      await rootBundle.loadString('assets/preprocessed_data/data_version.txt');
  return int.parse(data.trim());
}

Future<bool> _shouldPopulate(AppDb db) async {
  final dataVersion = await _getDataVersion();
  final dbVersion = await _getDbDataVersion(db);
  return dataVersion > dbVersion;
}

Future<int> _getDbDataVersion(AppDb db) async {
  var latest = await db.getLatestDataVersion();
  return latest?.idx ?? 0;
}

Future<void> _populateDatabaseFromCsv(AppDb db) async {
  const path = 'assets/preprocessed_data/';
  final csvFiles = {
    // 'MorphologicalDetails': '${path}morphological_details.csv',
    // 'MorphologicalDetailInflections': '${path}morphological_detail_inflections.csv',
    // 'Macronizations': '${path}macronizations.csv',
    'Authors': '${path}authors.csv',
    'AuthorAbbreviations': '${path}author_abbreviations.csv',
    'Works': '${path}works.csv',
    // 'WorkAbbreviations': '${path}work_abbreviations.csv',
    'WorkContents': '${path}work_contents.csv',
    'WorkContentSubdivisions': '${path}work_content_subdivisions.csv',
    'WorkContentSupplementary': '${path}work_content_supplementary.csv',
    'AuthorsAndWorks': '${path}authors_and_works.csv',
  };

  await db.transaction(() async {
    // TODO make better
    await Future.wait([
      db.delete(db.authors).go(),
      db.delete(db.authorAbbreviations).go(),
      db.delete(db.works).go(),
      db.delete(db.workContents).go(),
      db.delete(db.workContentSubdivisions).go(),
      db.delete(db.workContentSupplementary).go(),
      db.delete(db.authorsAndWorks).go(),
    ]);
    var operations = {
      'Authors': (List<dynamic> rows, AppDb db) async {
        for (var row in rows.skip(1)) {
          await db.into(db.authors).insert(
                AuthorsCompanion(
                  id: Value(row[0].toString()),
                  name: Value(row[1].toString()),
                  about: Value(row[2].toString()),
                  image: Value(base64Decode(row[3].toString())),
                ),
                mode: InsertMode.insertOrRollback,
              );
        }
      },
      'AuthorAbbreviations': (List<dynamic> rows, AppDb db) async {
        for (var row in rows.skip(1)) {
          await db.into(db.authorAbbreviations).insert(
                AuthorAbbreviationsCompanion(
                  authorId: Value(row[0].toString()),
                  id: Value(row[1] as int),
                  val: Value(row[2].toString()),
                ),
                mode: InsertMode.insertOrRollback,
              );
        }
      },
      'Works': (List<dynamic> rows, AppDb db) async {
        for (var row in rows.skip(1)) {
          await db.into(db.works).insert(
                WorksCompanion(
                  id: Value(row[0].toString()),
                  name: Value(row[1].toString()),
                  // about: Value(row[2].toString()),
                ),
                mode: InsertMode.insertOrRollback,
              );
        }
      },
      'WorkContents': (List<dynamic> rows, AppDb db) async {
        for (var row in rows.skip(1)) {
          await db.into(db.workContents).insert(
                WorkContentsCompanion(
                  workId: Value(row[0].toString()),
                  idx: Value(row[1] as int),
                  word: Value(row[2].toString()),
                  sourceReference: Value(row[3].toString()),
                ),
                mode: InsertMode.insertOrRollback,
              );
        }
      },
      'WorkContentSubdivisions': (List<dynamic> rows, AppDb db) async {
        for (var row in rows.skip(1)) {
          await db.into(db.workContentSubdivisions).insert(
              WorkContentSubdivisionsCompanion(
                workId: Value(row[0].toString()),
                node: Value(row[1].toString()),
                typ: Value(row[2].toString()),
                cnt: Value(row[3] as int),
                name: Value(row[4].toString()),
                parent:
                    Value(row[5].toString().isEmpty ? null : row[5].toString()),
                fromIndex: Value(row[6] as int),
                toIndex: Value(row[7] as int),
              ),
              mode: InsertMode.insertOrRollback);
        }
      },
      'WorkContentSupplementary': (List<dynamic> rows, AppDb db) async {
        for (var row in rows.skip(1)) {
          await db.into(db.workContentSupplementary).insert(
                WorkContentSupplementaryCompanion(
                  workId: Value(row[0].toString()),
                  typ: Value(row[1].toString()),
                  cnt: Value(row[2] as int),
                  fromIndex: Value(row[3] as int),
                  toIndex: Value(row[4] as int),
                  val: Value(row[5].toString()),
                ),
                mode: InsertMode.insertOrRollback,
              );
        }
      },
      'AuthorsAndWorks': (List<dynamic> rows, AppDb db) async {
        for (var row in rows.skip(1)) {
          await db.into(db.authorsAndWorks).insert(
                AuthorsAndWorksCompanion(
                  authorId: Value(row[0].toString()),
                  workId: Value(row[1].toString()),
                ),
                mode: InsertMode.insertOrRollback,
              );
        }
      }
    };
    for (var entry in csvFiles.entries) {
      final csvData = await rootBundle.loadString(entry.value);
      List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
      final tableName = entry.key;
      if (operations.containsKey(tableName)) {
        await operations[tableName]!(rows, db);
      } else {
        throw Exception('Operation for table $tableName not found.');
      }
    }
  });
}

Future<void> _updateDatabaseVersion(AppDb db) async {
  final assetVersion = await _getDataVersion();
  await db.into(db.dataVersion).insertOnConflictUpdate(
        DataVersionCompanion(
          idx: Value(assetVersion),
          createdAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
}
