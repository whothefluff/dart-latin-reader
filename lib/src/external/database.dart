import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:latin_reader/src/external/database_util.dart' as util;

part 'database.g.dart';

@DriftDatabase(
  include: {'library.drift'},
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
    if (shouldPopulate) {
      await util.populateDatabaseFromCsv(this);
      await util.updateDatabaseVersion(this);
    }
  }
//
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final packageInfo = await PackageInfo.fromPlatform();
    final folderPath = p.join(dbFolder.path, packageInfo.appName);
    final filePath = p.join(folderPath, 'library.db');
    final file = File(filePath);
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    return NativeDatabase.createInBackground(file);
  });
}
