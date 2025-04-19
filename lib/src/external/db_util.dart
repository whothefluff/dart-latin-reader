import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/dictionary/db_util.dart'
    as dict_util;
import 'package:latin_reader/src/component/library/db_util.dart' as libr_util;
import 'package:latin_reader/src/component/morph_analysis/db_util.dart'
    as morp_util;
import 'package:latin_reader/src/external/data_version.drift.dart';
import 'package:latin_reader/src/external/database.dart';
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
    ...libr_util.operations,
    ...dict_util.operations,
    ...morp_util.operations,
  ];
  await db.transaction(() async {
    await operations.fold(
        Future<void>.value(),
        (previousFuture, op) => previousFuture.then((_) async {
              log.info(() => 'populateDatabaseFromCsv() - deleting ${op.id}');
              await op.delete(db);
              log.info(() => 'populateDatabaseFromCsv() - inserting ${op.id}');
              await op.insert(db);
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
