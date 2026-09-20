import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/sqlite3.dart' show sqlite3;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../../app_config.dart';
import '../../logger.dart';
import 'data_version.drift.dart';
import 'database.drift.dart';
import 'db_util.dart' as util;

part 'database.g.dart';

// A content hash selects the bundled database and names its installed copy
// ignore: do_not_use_environment
const _bundledDatabaseId = String.fromEnvironment('BUNDLED_DATABASE_ID');

const _useBundledDatabase = _bundledDatabaseId != '';

/// Provides one db connection for the lifetime of the app
@Riverpod(keepAlive: true)
Future<AppDb> db(Ref ref) async {
  log.info(() => '@riverpod');
  final database = AppDb();
  // Ensure the connection closes if the provider is ever destroyed
  ref.onDispose(() {
    log.info(() => 'Closing DB connection');
    unawaited(database.close());
  });
  return database;
}

@DriftDatabase(
  include: {
    'data_version.drift',
    '../component/library/library.drift',
    '../component/dictionary/dictionary.drift',
    '../component/morph_analysis/morph_analysis.drift',
    '../component/word_frequency/word_frequency.drift',
  },
)
class AppDb extends $AppDb {
  AppDb({
    QueryExecutor? executor,
    bool? populateFromCsv,
  }) : _populateFromCsv = populateFromCsv ?? !_useBundledDatabase,
       super(executor ?? _openConnection());

  final bool _populateFromCsv;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      if (_populateFromCsv) {
        log.fine(() => 'DB events - creation migration started');
        await m.createAll();
      } else {
        throw StateError('The bundled database is missing its schema.');
      }
    },
    beforeOpen: (_) => _initializeDatabase(),
  );

  Future<void> _initializeDatabase() async {
    try {
      log.fine(() => 'DB events - database ready');
      await customStatement('PRAGMA foreign_keys = ON;');
      if (_populateFromCsv) {
        await _populateDatabaseIfNeeded();
      } else {
        await _checkBundledDataVersion();
      }
      log.fine(() => 'Setting pragmas for normal DB operation');
      await customStatement('PRAGMA journal_mode = OFF;');
      await customStatement('PRAGMA temp_store = MEMORY;');
    } on Object catch (error, stack) {
      log.severe('Database initialization failed', error, stack);
      rethrow;
    }
  }

  Future<void> _populateDatabaseIfNeeded() async {
    if (await util.shouldPopulate(this)) {
      log.fine(() => 'Setting pragmas for DB population');
      await customStatement('PRAGMA journal_mode = MEMORY;');
      await customStatement('PRAGMA synchronous = OFF;');
      log.info(() => 'Populating or updating database from CSVs');
      await util.populateDatabaseFromCsv(this);
      await util.updateDatabaseVersion(this);
      log.info(() => 'Database population complete.');
    } else {
      log.info(() => 'Skipping DB population');
    }
  }

  Future<void> _checkBundledDataVersion() async {
    final expected = await util.getDataVersion();
    final actual = await util.getDbDataVersion(this);
    if (actual <= 0 || actual != expected) {
      throw StateError(
        'The bundled database has an invalid data version: $actual; expected $expected.',
      );
    }
  }

  Future<LatestDataVersionData?> getLatestDataVersion() =>
      select(latestDataVersion).getSingleOrNull();

  @override
  int get schemaVersion => 1;
  //
}

LazyDatabase _openConnection() => LazyDatabase(() async {
  final file = await _databaseFile();
  log.info(() => 'Using database at ${file.path}');
  if (Platform.isAndroid) {
    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  }
  sqlite3.tempDirectory = (await getTemporaryDirectory()).path;
  return NativeDatabase.createInBackground(
    file,
    logStatements: AppConfig.instance.logDbStatements,
    setup: util.setupRegExp,
  );
});

Future<File> _databaseFile() async {
  final directory = _useBundledDatabase
      ? await getApplicationSupportDirectory()
      : await getApplicationCacheDirectory();
  const filename = _useBundledDatabase ? 'bundled-data-$_bundledDatabaseId.db' : 'data.db';
  final file = File(p.join(directory.path, filename));
  if (_useBundledDatabase) {
    await _installBundledDatabase(file);
  }
  return file;
}

/// Installs one copy of each database bundle, without loading any CSVs.
///
/// The temporary file keeps an interrupted copy from becoming the installed database.
Future<void> _installBundledDatabase(File file) async {
  if (RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(_bundledDatabaseId)) {
    if (!file.existsSync()) {
      log.info(() => 'Installing bundled database');
      final data = await rootBundle.load('${util.path}data.db');
      await file.parent.create(recursive: true);
      final temporary = File('${file.path}.tmp');
      await temporary.writeAsBytes(Uint8List.sublistView(data), flush: true);
      await temporary.rename(file.path);
      await _deleteOldBundledDatabases(file);
    }
  } else {
    throw StateError(
      'Bundled builds require BUNDLED_DATABASE_ID containing letters, digits, "-" or "_".',
    );
  }
}

Future<void> _deleteOldBundledDatabases(File current) async {
  await for (final file in current.parent.list(followLinks: false)) {
    if (file is File &&
        file.path != current.path &&
        p.basename(file.path).startsWith('bundled-data-')) {
      await file.delete();
    }
  }
}
