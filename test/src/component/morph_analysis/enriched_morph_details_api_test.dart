import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/morph_analysis/enriched_morph_details_api.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

class _EmptyDb extends AppDb {
  _EmptyDb() : super(executor: NativeDatabase.memory(setup: util.setupRegExp));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

/// Roma, whose lemma has an L&S entry, and Romani, whose lemma Romanus has none
Future<AppDb> _romaAndRomani() async {
  final db = _EmptyDb();
  addTearDown(db.close);
  await db.customStatement(
    "INSERT INTO MorphologicalDetails VALUES ( 'Roma', 0, 'Roma' ), ( 'Romani', 0, 'Romanus' )",
  );
  await db.customStatement(
    '''
    INSERT INTO MorphologicalDetailInflections( form, item, cnt, partOfSpeech, stem, suffix )
        VALUES ( 'Roma', 0, 0, 'noun', 'Rōm', 'a' ),
               ( 'Romani', 0, 0, 'adjective', 'Rōmān', 'ī' )
    ''',
  );
  await db.customStatement(
    '''
    INSERT INTO Dictionaries( id, name, language, publisher, publicationDate )
        VALUES ( '00000000-0000-0000-0000-000000000001', 'Lewis & Short', 'EN', 'Harper and Brothers',
                 '1879-07-01 00:00:00.000Z' )
    ''',
  );
  await db.customStatement(
    '''
    INSERT INTO DictionaryEntries( dictionary, lemma, partOfSpeech, inflection, idx )
        VALUES ( '00000000-0000-0000-0000-000000000001', 'Roma', 'noun', 'ae', 0 )
    ''',
  );
  await db.customStatement(
    "INSERT INTO LnsRefResolutions VALUES ( 'Roma', 'Roma' ), ( 'Romanus', NULL )",
  );
  return db;
}

void main() {
  group('enrichedMorphologicalAnalysesProvider', () {
    test('an analysis whose lemma has no L&S entry is kept without one', () async {
      final db = await _romaAndRomani();
      final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
      addTearDown(container.dispose);
      final keys = AnalysisKeys(const [
        AnalysisKey(form: 'Roma', item: 0, cnt: 0),
        AnalysisKey(form: 'Romani', item: 0, cnt: 0),
      ]);
      final analyses = await container
          .listen(enrichedMorphologicalAnalysesProvider(keys).future, (_, _) {})
          .read();
      expect(
        analyses.map((analysis) => (analysis.form, analysis.lnsLemma)),
        unorderedEquals([('Roma', 'Roma'), ('Romani', null)]),
      );
    });
  });
}
