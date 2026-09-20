import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Exports the database after all validation checks pass', () async {
    final originalLogLevel = Logger.root.level;
    Logger.root.level = Level.FINE;
    final subscription = Logger.root.onRecord.listen(_writeLogRecord);
    try {
      await _exportDatabase();
    } finally {
      Logger.root.level = originalLogLevel;
      await subscription.cancel();
    }
  }, timeout: Timeout.none);
}

void _writeLogRecord(LogRecord record) {
  stdout.writeln('${record.level.name}: ${record.message}');
  if (record.error != null) {
    stdout.writeln(record.error);
  }
  if (record.stackTrace != null) {
    stdout.writeln(record.stackTrace);
  }
}

/// Builds in a temporary directory and exports only a closed, validated database.
Future<void> _exportDatabase() async {
  final dataVersion = await util.getDataVersion();
  expect(dataVersion, greaterThan(0), reason: 'data_version.txt must contain a positive integer.');
  final directory = await Directory.systemTemp.createTemp('latin_reader_database_');
  try {
    final file = File(p.join(directory.path, 'data.db'));
    final schemaVersion = await _populateDatabase(file);
    _validateDatabase(file, schemaVersion, dataVersion);
    final output = File(p.join('build', 'generated_database', 'data.db'));
    await output.parent.create(recursive: true);
    await file.copy(output.path);
    stdout.writeln('Database written to ${output.path}');
  } finally {
    await directory.delete(recursive: true);
  }
}

Future<int> _populateDatabase(File file) async {
  final db = AppDb(
    executor: NativeDatabase(file, setup: util.setupRegExp),
    populateFromCsv: true,
  );
  try {
    // Opening the connection runs the existing schema creation and CSV population.
    await db.customSelect('SELECT 1').getSingle();
  } finally {
    await db.close();
  }
  return db.schemaVersion;
}

void _validateDatabase(File file, int schemaVersion, int dataVersion) {
  final db = sqlite3.open(file.path, mode: OpenMode.readOnly);
  try {
    util.setupRegExp(db);
    expect(
      db.select('PRAGMA user_version').single['user_version'],
      schemaVersion,
      reason: 'The exported schema version must match AppDb.schemaVersion.',
    );
    expect(
      db.select('SELECT MAX(idx) AS version FROM DataVersion').single['version'],
      dataVersion,
      reason: 'The exported data version must match data_version.txt.',
    );
    expect(
      db.select('PRAGMA integrity_check').map((row) => row.values.single).toList(),
      ['ok'],
      reason: 'SQLite integrity_check must report no errors.',
    );
    expect(
      db.select('PRAGMA foreign_key_check'),
      isEmpty,
      reason: 'The exported database must not contain broken foreign keys.',
    );
    const tables = [
      'Authors',
      'Works',
      'WorkContents',
      'DictionaryEntries',
      'DictEntrySenses',
      'MorphologicalDetails',
      'ScopedFormFreq',
      'ScopedFreqTotals',
    ];
    for (final table in tables) {
      final count = db.select('SELECT COUNT(*) AS count FROM "$table"').single['count'] as int;
      expect(count, greaterThan(0), reason: '$table must contain data.');
      stdout.writeln('$table: $count rows');
    }
  } finally {
    db.dispose();
  }
}
