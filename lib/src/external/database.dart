import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/data_version.drift.dart';
import 'package:latin_reader/src/external/database.drift.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;
import 'package:package_info_plus/package_info_plus.dart';
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
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) async {
        log.info(() => 'DB events - creation migration started');
        await m.createAll();
        await util.populateDatabaseFromCsv(this);
        await util.updateDatabaseVersion(this);
      });

  Future<LatestDataVersionData?> getLatestDataVersion() =>
      select(latestDataVersion).getSingleOrNull();

  @override
  int get schemaVersion => 1;
//
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      log.info(() => '_openConnection() - getting path');
      final dbFolder = await getApplicationSupportDirectory();
      final packageInfo = await PackageInfo.fromPlatform();
      final folderPath = p.join(dbFolder.path, packageInfo.appName);
      final directory = Directory(folderPath);
      if (directory.existsSync()) {
        log.info(() => '_openConnection() - creating directory at $folderPath');
        await directory.create(recursive: true);
      }
      final filePath = p.join(folderPath, 'library.db');
      final file = File(filePath);
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }
      log.info(() => '_openConnection() - handling database file');
      return NativeDatabase.createInBackground(
        file,
        // logStatements: true,
        setup: (db) {
          log.info(() => '_openConnection() - setting PRAGMAs and functions');
          util.setupRegExp(db);
          db.execute('PRAGMA journal_mode = WAL;');
        },
      );
    });
