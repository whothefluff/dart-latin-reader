import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../external/database.dart';
import '../../external/db_oracle.dart';
import '../../external/file_util.dart';
import '../../external/value_util.dart';
import 'dictionary.drift.dart';

const path = 'assets/preprocessed_data/';

// Type not important
// ignore: specify_nonobvious_property_types
final operations = [
  (
    id: 'Dictionaries',
    delete: (AppDb db) async {
      await db.delete(db.dictionaries).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}dictionaries.csv');
      final rows = const CsvParser.withAutoDetectedSettings().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.dictionaries,
          rows
              .skip(1)
              .map(
                (row) => DictionariesCompanion(
                  id: Value(row[0].toString()),
                  name: Value(row[1].toString()),
                  language: Value(row[2].toString()),
                  publisher: Value(row[3].toString()),
                  publicationDate: Value(row[4].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'DictionaryEntries',
    delete: (AppDb db) async {
      await db.delete(db.dictionaryEntries).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}dictionary_entries.csv');
      final rows = const CsvParser.withAutoDetectedSettings().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.dictionaryEntries,
          rows
              .skip(1)
              .map(
                (row) => DictionaryEntriesCompanion(
                  dictionary: Value(row[0].toString()),
                  lemma: Value(row[1].toString()),
                  partOfSpeech: stringValue(row[2].toString()),
                  //at least for L&S, this field contains "," which is not good for .csv files
                  inflection: stringValue(row[3].toString().replaceAll(RegExp('"'), '')),
                  idx: Value(row[4] as int),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'DictEntrySenses',
    delete: (AppDb db) async {
      await db.delete(db.dictEntrySenses).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}dict_entry_senses.csv');
      final rows = const CsvParser.withAutoDetectedSettings().convert(
        csvData,
        shouldParseNumbers: false,
      );
      await db.batch(
        (b) => b.insertAll(
          db.dictEntrySenses,
          rows
              .skip(1)
              .map(
                (row) => DictEntrySensesCompanion(
                  dictionary: Value(row[0].toString()),
                  lemma: Value(row[1].toString()),
                  lvl: Value(row[2].toString()),
                  prettyLevel: Value(row[3].toString()),
                  content: Value(row[4].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    id: 'DicEntrySenseQuotes',
    delete: (AppDb db) async {
      await db.delete(db.dictEntrySenseQuotes).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${path}dict_entry_sense_quotes.csv');
      final rows = const CsvParser.withAutoDetectedSettings().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.dictEntrySenseQuotes,
          rows
              .skip(1)
              .map(
                (row) => DictEntrySenseQuotesCompanion(
                  dictionary: Value(row[0].toString()),
                  lemma: Value(row[1].toString()),
                  lvl: Value(row[2].toString()),
                  seq: Value(row[3] as int),
                  content: Value(row[4].toString()),
                  translation: stringValue(row[5].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
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
  (
    id: 'LnsRefResolutions',
    delete: (AppDb db) async {
      await db.delete(db.lnsRefResolutions).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO LnsRefResolutions( dictionaryRef, lnsLemma )
            WITH LnsDictId AS ( SELECT id 
                                    FROM Dictionaries
                                    WHERE name = 'Lewis & Short' -- literal 3 of 3
                                    LIMIT 1 ),
                 Refs AS ( SELECT DISTINCT dictionaryRef,
                                           --Many forms use a variety of spellings ('ad-tingo' -> 'attingo', 'con-mitto' -> 'committo')
                                           REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE(
                                           dictionaryRef,
                                           'b-m','mm'), 'd-p','pp'), 'd-t','tt'), 'd-s','ss'), 'n-c','nc'), 'n-m','mm'), 'n-r','rr'), 'x-f','ff'), 'x-su','su'), 'x-l','l'),
                                           '-',''), '_','') AS assimilated
                               FROM MorphologicalDetails ),
                 -- Step 0: Match before assimilations (protects pre-existing L&S from being mangled)
                 Step0_Verbatim AS ( SELECT dictionaryRef,
                                            assimilated,
                                            CASE WHEN dictionaryRef <> assimilated
                                                 THEN ( SELECT LnsEntries.lemma
                                                            FROM DictionaryEntries LnsEntries
                                                            WHERE LnsEntries.dictionary = ( SELECT id FROM LnsDictId )
                                                                  AND LnsEntries.lemma = Refs.dictionaryRef )
                                            END AS verbatimMatch
                                         FROM Refs ),
                 -- Step 1: Exact match of the assimilated form against L&S
                 Step1_Exact AS ( SELECT *,
                                         CASE WHEN verbatimMatch IS NULL
                                              THEN ( SELECT LnsEntries.lemma
                                                         FROM DictionaryEntries LnsEntries
                                                         WHERE LnsEntries.dictionary = ( SELECT id FROM LnsDictId )
                                                               AND LnsEntries.lemma = Verbatim.assimilated )
                                         END AS exactMatch
                                      FROM Step0_Verbatim Verbatim ),
                 -- Step 2: A few entries are only found by appending '1' ('princeps' not in L&S, but 'princeps1' is)
                 Step2_Suffix AS ( SELECT *,
                                          CASE WHEN verbatimMatch IS NULL
                                                    AND exactMatch IS NULL
                                                    AND assimilated NOT LIKE '%1'
                                               THEN ( SELECT LnsEntries.lemma
                                                          FROM DictionaryEntries LnsEntries
                                                          WHERE LnsEntries.dictionary = ( SELECT id FROM LnsDictId )
                                                                AND LnsEntries.lemma = Exact.assimilated || '1' )
                                          END AS suffixMatch
                                       FROM Step1_Exact Exact ),
                 -- Step 3: A small handful are only found by removing a trailing '1' ('equus1' not in L&S, but 'equus' is)
                 Step3_Normalize AS ( SELECT *,
                                             CASE WHEN verbatimMatch IS NULL
                                                       AND exactMatch IS NULL
                                                       AND suffixMatch IS NULL
                                                      AND assimilated LIKE '%1'
                                                  THEN ( SELECT LnsEntries.lemma
                                                             FROM DictionaryEntries LnsEntries
                                                             WHERE LnsEntries.dictionary = ( SELECT id FROM LnsDictId )
                                                                   AND LnsEntries.lemma = SUBSTR( Suffixed.assimilated, 1, LENGTH( Suffixed.assimilated ) - 1 ) )
                                             END AS normalizedMatch
                                          FROM Step2_Suffix Suffixed )
                -- Some forms must be handled in Morpheus directly (e.g. 'adultera' when L&S only has 'adulter'); these get lnsLemma = NULL
                SELECT dictionaryRef,
                       COALESCE( verbatimMatch, exactMatch, suffixMatch, normalizedMatch )
                    FROM Step3_Normalize;
      ''');
    },
  ),
];

const List<DbOracle> oracles = [];
