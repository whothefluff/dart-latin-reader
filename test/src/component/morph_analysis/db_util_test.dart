import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/morph_analysis/db_util.dart' as morphology;
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

/// CSV files written by the test, by name
class _CsvFiles implements util.CsvSource {
  const _CsvFiles(this._files);

  final Map<String, String> _files;

  @override
  Future<String> loadString(String fileName) async => _files[fileName]!;
  //
}

/// The app's schema, empty, to import `csvFiles` into
class _EmptyDb extends AppDb {
  _EmptyDb(
    util.CsvSource csvFiles,
  ) : super(
        executor: NativeDatabase.memory(setup: util.setupRegExp),
        csvSource: csvFiles,
      );

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

void main() {
  test("the import keeps each analysis's sublemma, '' for the entry's own lemma", () async {
    final db = _EmptyDb(
      const _CsvFiles({
        'morphological_details.csv':
            'form,item,dictionaryRef,sublemma\n'
            'Dardaniae,0,Dardanus1,Dardania\n'
            'Dardaniae,1,Dardani,Dardania\n'
            'Dardanum,0,Dardanus1,\n',
      }),
    );
    addTearDown(db.close);

    await morphology.operations
        .singleWhere((operation) => operation.id == 'MorphologicalDetails')
        .insert(db);

    final rows = await db.customSelect('''
      SELECT form, item, dictionaryRef, sublemma
          FROM MorphologicalDetails
          ORDER BY form, item''').get();
    expect(rows.map((row) => row.data.values.toList()), [
      ['Dardaniae', 0, 'Dardanus1', 'Dardania'],
      ['Dardaniae', 1, 'Dardani', 'Dardania'],
      ['Dardanum', 0, 'Dardanus1', ''],
    ]);
  });
}
