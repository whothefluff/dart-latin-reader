import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../external/database.dart';
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
      final rows = const CsvToListConverter().convert(csvData);
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
      final rows = const CsvToListConverter().convert(csvData);
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
      final inflTab = db.morphologicalDetailInflections;
      final allInflections = db.selectOnly(inflTab)
        ..addColumns([
          inflTab.form,
          inflTab.item,
          inflTab.cnt,
          concat([_removeAllHyphens(inflTab.stem), inflTab.suffix]),
        ]);
      final searchTab = db.searchableMorphDetInflections;
      await db
          .into(searchTab)
          .insertFromSelect(
            allInflections,
            columns: {
              searchTab.form: inflTab.form,
              searchTab.item: inflTab.item,
              searchTab.cnt: inflTab.cnt,
              // TODO(whothefluff): consider adding nullable field "macronizedForm" to source tab to avoid calculation duplication for search tab and views
              searchTab.macronizedForm: concat([_removeAllHyphens(inflTab.stem), inflTab.suffix]),
            },
            mode: InsertMode.insertOrRollback,
          );
      await db.customInsert('''
        INSERT INTO SearchableMorphDetInflections( SearchableMorphDetInflections ) 
          VALUES('optimize')
        ''');
    },
  ),
];

Expression<String> _removeAllHyphens(Expression<String> columnExpression) =>
    replace<String>(columnExpression, const Constant('-'), const Constant(''));

Expression<T> replace<T extends Object>(Expression<T> val, Expression<T> sub, Expression<T> wit) =>
    FunctionCallExpression<T>('REPLACE', [val, sub, wit]);

Expression<T> concat<T extends Object>(List<Expression<Object>> args) =>
    FunctionCallExpression<T>('CONCAT', args);
