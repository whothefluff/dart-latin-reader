import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/value_util.dart';

const path = 'assets/preprocessed_data/';

final operations = [
  (
    id: 'Dictionaries',
    delete: (AppDb db) async {
      await db.delete(db.dictionaries).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString(
        '${path}dictionaries.csv',
      );
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
            db.dictionaries,
            rows.skip(1).map((row) => DictionariesCompanion(
                  id: Value(row[0].toString()),
                  name: Value(row[1].toString()),
                  language: Value(row[2].toString()),
                  publisher: Value(row[3].toString()),
                  publicationDate: Value(row[4].toString()),
                )),
            mode: InsertMode.insertOrRollback),
      );
    }
  ),
  (
    id: 'DictionaryEntries',
    delete: (AppDb db) async {
      await db.delete(db.dictionaryEntries).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString(
        '${path}dictionary_entries.csv',
      );
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
            db.dictionaryEntries,
            rows.skip(1).map((row) => DictionaryEntriesCompanion(
                  dictionary: Value(row[0].toString()),
                  lemma: Value(row[1].toString()),
                  partOfSpeech: stringValue(row[2].toString()),
                  inflection: stringValue(row[3].toString()),
                  idx: Value(row[4] as int),
                )),
            mode: InsertMode.insertOrRollback),
      );
    }
  ),
  (
    id: 'DictEntrySenses',
    delete: (AppDb db) async {
      await db.delete(db.dictEntrySenses).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString(
        '${path}dict_entry_senses.csv',
      );
      final rows = const CsvToListConverter().convert(
        csvData,
        shouldParseNumbers: false,
      );
      await db.batch(
        (b) => b.insertAll(
            db.dictEntrySenses,
            rows.skip(1).map((row) => DictEntrySensesCompanion(
                  dictionary: Value(row[0].toString()),
                  lemma: Value(row[1].toString()),
                  lvl: Value(row[2].toString()),
                  prettyLevel: Value(row[3].toString()),
                  content: Value(row[4].toString()),
                )),
            mode: InsertMode.insertOrRollback),
      );
    },
  ),
  (
    id: 'DicEntrySenseQuotes',
    delete: (AppDb db) async {
      await db.delete(db.dictEntrySenseQuotes).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString(
        '${path}dict_entry_sense_quotes.csv',
      );
      final rows = const CsvToListConverter().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
            db.dictEntrySenseQuotes,
            rows.skip(1).map((row) => DictEntrySenseQuotesCompanion(
                  dictionary: Value(row[0].toString()),
                  lemma: Value(row[1].toString()),
                  lvl: Value(row[2].toString()),
                  seq: Value(row[3] as int),
                  content: Value(row[4].toString()),
                  translation: stringValue(row[5].toString()),
                )),
            mode: InsertMode.insertOrRollback),
      );
    },
  ),
  (
    id: 'DictionaryAlphabets',
    delete: (AppDb db) async {
      await db.delete(db.dictionaryAlphabets).go();
    },
    insert: (AppDb db) async {
      await db.dictionaryDrift.fillDictionaryAlphabets();
    },
  ),
];
