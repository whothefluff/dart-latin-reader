import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/data_version.drift.dart';
import 'package:latin_reader/src/external/database.drift.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@riverpod
Future<AppDb> db(Ref ref) async {
  log.info(() => '@riverpod - initializing AppDb');
  return AppDb();
}

@DriftDatabase(
  include: {
    'data_version.drift',
    'library.drift',
    'analysis.drift',
    '../component/dictionary/dictionary.drift'
  },
)
class AppDb extends $AppDb {
  AppDb() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          log.info(() => 'DB events - creation migration started');
          await customStatement('PRAGMA journal_mode = MEMORY;');
          await customStatement('PRAGMA synchronous = OFF;');
          await customStatement('PRAGMA foreign_keys = ON;');
          await m.createAll();
          await util.populateDatabaseFromCsv(this);
          await util.updateDatabaseVersion(this);
        },
        beforeOpen: (d) async {
          log.info(() => 'DB events - database ready');
          await customStatement('PRAGMA journal_mode = OFF;');
          await customStatement('PRAGMA temp_store = MEMORY;');
        },
      );

  Future<LatestDataVersionData?> getLatestDataVersion() =>
      select(latestDataVersion).getSingleOrNull();

  @override
  int get schemaVersion => 1;
//
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      log.info(() => '_openConnection() - getting path');
      final supportDirectory = await getApplicationSupportDirectory();
      final filePath = p.join(supportDirectory.path, 'data.db');
      log.info(() => '_openConnection() - using directory at $filePath');
      final file = File(filePath);
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }
      log.info(() => '_openConnection() - handling database file');
      return NativeDatabase.createInBackground(
        file,
        // logStatements: true,
        setup: (db) {
          log.info(() => '_openConnection() - setting functions');
          util.setupRegExp(db);
        },
      );
    });
