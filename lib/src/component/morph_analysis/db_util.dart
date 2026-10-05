import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../external/database.dart';
import '../../external/db_oracle.dart';
import '../../external/file_util.dart';
import '../../external/value_util.dart';
import 'morph_analysis.drift.dart';

const _path = 'assets/preprocessed_data/';

// Type not important
// ignore: specify_nonobvious_property_types
final operations = [
  (
    id: 'MorphologicalDetails',
    delete: (AppDb db) async {
      await db.delete(db.morphologicalDetails).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${_path}morphological_details.csv');
      final rows = const CsvParser.withAutoDetectedSettings().convert(csvData);
      await db.batch((b) {
        //ignore these entries, which won't have inflections anyway
        bool dictRefIsSet(List<dynamic> x) => x[2].toString().isNotEmpty;
        return b.insertAll(
          db.morphologicalDetails,
          rows
              .skip(1)
              .where(dictRefIsSet)
              .map(
                (row) => MorphologicalDetailsCompanion(
                  form: Value(row[0].toString()),
                  item: Value(row[1] as int),
                  dictionaryRef: Value(row[2].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        );
      });
    },
  ),
  (
    id: 'MorphologicalDetailInflections',
    delete: (AppDb db) async {
      await db.delete(db.morphologicalDetailInflections).go();
    },
    insert: (AppDb db) async {
      final csvData = await rootBundle.loadString('${_path}morphological_detail_inflections.csv');
      final rows = const CsvParser.withAutoDetectedSettings().convert(csvData);
      await db.batch(
        (b) => b.insertAll(
          db.morphologicalDetailInflections,
          rows
              .skip(1)
              .map(
                (row) => MorphologicalDetailInflectionsCompanion(
                  form: Value(row[0].toString()),
                  item: Value(row[1] as int),
                  cnt: Value(row[2] as int),
                  partOfSpeech: Value(row[3].toString()),
                  stem: Value(row[4].toString()),
                  suffix: stringValue(row[5].toString()),
                  segmentsInfo: stringValue(row[6].toString()),
                  gender: stringValue(row[7].toString()),
                  number: stringValue(row[8].toString()),
                  declension: stringValue(row[9].toString()),
                  gramCase: stringValue(row[10].toString()),
                  verbForm: stringValue(row[11].toString()),
                  tense: stringValue(row[12].toString()),
                  voice: stringValue(row[13].toString()),
                  person: stringValue(row[14].toString()),
                ),
              ),
          mode: InsertMode.insertOrRollback,
        ),
      );
    },
  ),
  (
    //this operation could probably be placed on a neater place (sometime)
    id: 'SearchableMorphDetInflections',
    delete: (AppDb db) async {
      await db.delete(db.searchableMorphDetInflections).go();
    },
    insert: (AppDb db) async {
      await db.morphAnalysisDrift.fillSearchableMorphDetInflections();
      await db.customInsert('''
        INSERT INTO SearchableMorphDetInflections( SearchableMorphDetInflections )
          VALUES('optimize')
        ''');
    },
  ),
  (
    id: 'CountableWordCandidateAnalyses',
    delete: (AppDb db) async {
      await db.delete(db.countableWordCandidateAnalyses).go();
    },
    insert: (AppDb db) async {
      // A lemma stops being a candidate where the text has a vowel certainly short and every
      // spelling of the lemma's analyses has it long
      await db.customStatement('''
        INSERT INTO CountableWordCandidateAnalyses( workId, idx, componentOrdinal, form, item )
            WITH TokenComponents( ordinal ) AS ( VALUES (0), (1) ),
                 CountableWords AS (
                     SELECT WorkContents.workId,
                            WorkContents.idx,
                            TokenComponents.ordinal AS componentOrdinal,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.lookupForm
                                 ELSE WorkContents.enclitic
                            END AS lookupForm,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.properNounState
                                 ELSE 0 -- a detached enclitic is never a proper noun
                            END AS properNounState,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.macronLookupForm
                                 ELSE WorkContents.enclitic
                            END AS macronLookupForm,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.uncertaintyBitMask
                                 ELSE 0
                            END AS uncertaintyBitMask
                         FROM WorkContents
                         CROSS JOIN TokenComponents
                         WHERE ( TokenComponents.ordinal = 0
                                 AND WorkContents.lookupForm IS NOT NULL )
                               OR ( TokenComponents.ordinal = 1
                                    AND WorkContents.enclitic IS NOT NULL ) -- only ever on tokenType 1
                 ),
                 WordAnalyses AS (
                     SELECT Word.workId,
                            Word.idx,
                            Word.componentOrdinal,
                            Word.macronLookupForm,
                            Word.uncertaintyBitMask,
                            Details.form AS morphForm,
                            Details.item AS morphItem,
                            Details.dictionaryRef
                         FROM CountableWords AS Word
                         INNER JOIN MorphologicalDetails AS Details
                             ON Details.form = Word.lookupForm
                                OR ( Word.properNounState = 2 -- a name or a common word
                                     AND Details.form = LOWER( Word.lookupForm ) )
                 ),
                 Letters( position ) AS (
                     SELECT 1
                     UNION ALL
                     SELECT position + 1
                         FROM Letters
                         WHERE position < ( SELECT MAX( LENGTH( macronLookupForm ) )
                                                FROM CountableWords )
                 ),
                 Spellings AS (
                     SELECT a.workId,
                            a.idx,
                            a.componentOrdinal,
                            a.dictionaryRef,
                            Infl.form IS NOT NULL -- no inflections, nothing to contradict
                            AND LENGTH( Infl.macronizedForm )
                                = LENGTH( a.macronLookupForm ) -- else letters don't line up
                            AND EXISTS (
                                SELECT 1
                                    FROM Letters
                                    WHERE Letters.position <= LENGTH( a.macronLookupForm )
                                          AND ( a.uncertaintyBitMask >> ( Letters.position - 1 ) )
                                              & 1 = 0 -- certain
                                          AND INSTR( 'aeiouyAEIOUY',
                                                     SUBSTR( a.macronLookupForm,
                                                             Letters.position,
                                                             1 ) ) > 0 -- short in the text
                                          AND INSTR( 'āēīōūȳĀĒĪŌŪȲ',
                                                     SUBSTR( Infl.macronizedForm,
                                                             Letters.position,
                                                             1 ) ) > 0 ) -- long in the analysis
                                AS contradictsText
                         FROM WordAnalyses AS a
                         LEFT OUTER JOIN MorphologicalDetailInflections AS Infl
                             ON Infl.form = a.morphForm
                                AND Infl.item = a.morphItem
                 ),
                 RuledOutLemmas AS (
                     SELECT workId,
                            idx,
                            componentOrdinal,
                            dictionaryRef
                         FROM Spellings
                         GROUP BY workId, idx, componentOrdinal, dictionaryRef
                         HAVING MIN( contradictsText ) = 1
                 ),
                 WordsWithEveryLemmaRuledOut AS (
                     SELECT a.workId,
                            a.idx,
                            a.componentOrdinal
                         FROM WordAnalyses AS a
                         LEFT JOIN RuledOutLemmas AS r
                             ON r.workId = a.workId
                                AND r.idx = a.idx
                                AND r.componentOrdinal = a.componentOrdinal
                                AND r.dictionaryRef = a.dictionaryRef
                         GROUP BY a.workId, a.idx, a.componentOrdinal
                         HAVING COUNT( r.dictionaryRef ) = COUNT( * )
                 )
                SELECT a.workId,
                       a.idx,
                       a.componentOrdinal,
                       a.morphForm,
                       a.morphItem
                    FROM WordAnalyses AS a
                    WHERE NOT EXISTS ( SELECT 1
                                           FROM RuledOutLemmas AS r
                                           WHERE r.workId = a.workId
                                                 AND r.idx = a.idx
                                                 AND r.componentOrdinal = a.componentOrdinal
                                                 AND r.dictionaryRef = a.dictionaryRef )
                          OR EXISTS ( SELECT 1 -- a word never loses every lemma
                                          FROM WordsWithEveryLemmaRuledOut AS w
                                          WHERE w.workId = a.workId
                                                AND w.idx = a.idx
                                                AND w.componentOrdinal = a.componentOrdinal )
      ''');
    },
  ),
];

Expression<T> replace<T extends Object>(Expression<T> val, Expression<T> sub, Expression<T> wit) =>
    FunctionCallExpression<T>('REPLACE', [val, sub, wit]);

Expression<T> concat<T extends Object>(List<Expression<Object>> args) =>
    FunctionCallExpression<T>('CONCAT', args);

const List<DbOracle> oracles = [];
