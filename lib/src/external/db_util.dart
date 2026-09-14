import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqlite3/sqlite3.dart';

import '../../logger.dart';
import '../component/dictionary/db_util.dart' as dict_util;
import '../component/library/db_util.dart' as libr_util;
import '../component/morph_analysis/db_util.dart' as morp_util;
import '../component/word_frequency/db_util.dart' as freq_util;
import 'data_version.drift.dart';
import 'database.dart';
import 'db_oracle.dart';

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
    deterministic: true,
    // Necessary for using it in table definition's checks
    directOnly: false,
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
    ...morp_util.operations,
    ...dict_util.operations,
    ...freq_util.operations,
  ];
  await db.transaction(() async {
    // Two passes, one transaction.
    // Foreign keys are enforced immediately so every dependent table has to be
    // emptied before the table it points at
    await operations.reversed.fold(
      Future<void>.value(),
      (previousFuture, op) => previousFuture.then((_) async {
        log.fine(() => 'deleting ${op.id}');
        await op.delete(db);
      }),
    );
    await operations.fold(
      Future<void>.value(),
      (previousFuture, op) => previousFuture.then((_) async {
        log.fine(() => 'inserting ${op.id}');
        await op.insert(db);
      }),
    );
    // Better plans:
    await db.customStatement('ANALYZE;');
    // Rollback on invariant violation
    log.info(() => 'Running integrity checks');
    await _runOracles(db);
    log.info(() => 'Integrity checks passed');
  });
}

typedef _Result = ({DbOracle oracle, int violations, String sample});

Future<void> _runOracles(AppDb db) async {
  const oracles = <DbOracle>[
    ...libr_util.oracles,
    ...dict_util.oracles,
    ...morp_util.oracles,
    ...freq_util.oracles,
  ];
  final checks = await oracles.fold(
    Future<List<_Result>>.value(const []),
    (previous, oracle) async => [...await previous, await _check(db, oracle)],
  );
  final violated = checks.where((check) => check.violations > 0).toList()..forEach(_report);
  final errors = violated
      .where((check) => check.oracle.severity == DbOracleSeverity.error)
      .map(_message)
      .toList();
  if (errors.isNotEmpty) {
    throw DbIntegrityError(errors);
  }
}

Future<_Result> _check(AppDb db, DbOracle oracle) async {
  const sampleSize = 5;
  assert(
    !oracle.sql.trimRight().endsWith(';') && !oracle.sql.contains(oracleViolationsColumn),
    '${oracle.id}: trailing ; or reserved column name',
  );
  final rows = await db
      .customSelect(
        'SELECT COUNT( * ) OVER ( ) AS $oracleViolationsColumn, * '
        'FROM ( ${oracle.sql} ) '
        'LIMIT $sampleSize',
      )
      .get();
  final sample = rows.map((row) => Map.of(row.data)..remove(oracleViolationsColumn)).join('\n');
  final violations = rows.isEmpty ? 0 : rows.first.read<int>(oracleViolationsColumn);
  return (oracle: oracle, violations: violations, sample: sample);
}

String _message(_Result check) => '${check.oracle.id}: ${check.violations} rows\n${check.sample}';

void _report(_Result check) => log.log(
  check.oracle.severity.level,
  () => _message(check),
);

Future<void> updateDatabaseVersion(AppDb db) async {
  log.fine(() => 'updating data version');
  final assetVersion = await getDataVersion();
  await db
      .into(db.dataVersion)
      .insertOnConflictUpdate(DataVersionCompanion(idx: Value(assetVersion)));
}
