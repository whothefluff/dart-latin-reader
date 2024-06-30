import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:latin_reader/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_details.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {'db_schema.drift'},
)
class AppDb extends _$AppDb {
  AppDb._() : super(_openConnection());

  static final AppDb _instance = AppDb._();
  static bool _isInitialized = false;

  factory AppDb() {
    if (!_isInitialized) {
      throw Exception('AppDb has not been initialized');
    }
    return _instance;
  }

  static Future<void> initialize() async {
    if (!_isInitialized) {
      log.info(() => 'AppDb - initializing singleton');
      await _instance._populateDb();
      _isInitialized = true;
    }
  }

  Future<LatestDataVersionData?> getLatestDataVersion() =>
      select(latestDataVersion).getSingleOrNull();

  @override
  int get schemaVersion => 1;

  Future<void> _populateDb() async {
    final shouldPopulate = await util.shouldPopulate(this);
    log.info(() => 'AppDb - shouldPopulate: $shouldPopulate');
    if (shouldPopulate) {
      await util.populateDatabaseFromCsv(this);
      await util.updateDatabaseVersion(this);
    }
  }
//
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    log.info(() => '_openConnection() - getting path');
    final dbFolder = await getApplicationDocumentsDirectory();
    final packageInfo = await PackageInfo.fromPlatform();
    final folderPath = p.join(dbFolder.path, packageInfo.appName);
    final filePath = p.join(folderPath, 'library.db');
    final file = File(filePath);
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    log.info(() => '_openConnection() - creating database from file');
    return NativeDatabase.createInBackground(file);
  });
}
