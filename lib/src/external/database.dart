import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../../app_config.dart';
import '../../logger.dart';
import 'data_version.drift.dart';
import 'database.drift.dart';
import 'db_util.dart' as util;

part 'database.g.dart';

@riverpod
Future<AppDb> db(Ref ref) async {
  log.info(() => '@riverpod');
  return AppDb();
}

@DriftDatabase(
  include: {
    'data_version.drift',
    '../component/library/library.drift',
    '../component/dictionary/dictionary.drift',
    '../component/morph_analysis/morph_analysis.drift',
  },
)
class AppDb extends $AppDb {
  AppDb() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      log.fine(() => 'DB events - creation migration started');
      await customStatement('PRAGMA journal_mode = MEMORY;');
      await customStatement('PRAGMA synchronous = OFF;');
      await customStatement('PRAGMA foreign_keys = ON;');
      await m.createAll();
      await util.populateDatabaseFromCsv(this);
      await util.updateDatabaseVersion(this);
    },
    beforeOpen: (d) async {
      log.fine(() => 'DB events - database ready');
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
  log.fine(() => 'getting path');
  final supportDirectory = await getApplicationCacheDirectory();
  final filePath = p.join(supportDirectory.path, 'data.db');
  log.info(() => 'using directory at $filePath');
  final file = File(filePath);
  if (Platform.isAndroid) {
    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  }
  log.info(() => 'handling database file');
  return NativeDatabase.createInBackground(
    file,
    logStatements: AppConfig.instance.logDbStatements,
    setup: (db) {
      log.fine(() => 'setting functions');
      util.setupRegExp(db);
    },
  );
});
