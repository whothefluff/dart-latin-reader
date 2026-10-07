import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

const _fables = 'fables';
const _letters = 'letters';

class _EmptyDb extends AppDb {
  _EmptyDb() : super(executor: NativeDatabase.memory(setup: util.setupRegExp));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

/// tres, a numeral, and nequam, which Morpheus tags as irregular
Future<AppDb> _numeralAndIrregular() async {
  final db = _EmptyDb();
  addTearDown(db.close);
  await db.customStatement(
    "INSERT INTO MorphologicalDetails VALUES ( 'tres', 0, 'tres' ), ( 'nequam', 0, 'nequam' )",
  );
  await db.customStatement(
    '''
    INSERT INTO MorphologicalDetailInflections( form, item, cnt, partOfSpeech, stem )
        VALUES ( 'tres', 0, 0, 'numeral', 'trēs' ),
               ( 'nequam', 0, 0, 'irregular', 'nēquam' )
    ''',
  );
  return db;
}

/// Venere, as Venus and as venio, each under its own form
Future<AppDb> _venereTwice() async {
  final db = _EmptyDb();
  addTearDown(db.close);
  await db.customStatement(
    "INSERT INTO MorphologicalDetails VALUES ( 'Venere', 0, 'Venus' ), ( 'venere', 0, 'venio' )",
  );
  await db.customStatement(
    '''
    INSERT INTO MorphologicalDetailInflections( form, item, cnt, partOfSpeech, stem )
        VALUES ( 'Venere', 0, 0, 'noun', 'Vener' ),
               ( 'venere', 0, 0, 'verb', 'vēn' )
    ''',
  );
  return db;
}

/// A database with Magnoque and its enclitic at index 5 in [_fables],
/// plus magno at index 6 in [_fables] and index 5 in [_letters].
Future<AppDb> _magnoque() async {
  final db = _EmptyDb();
  addTearDown(db.close);
  await db.customStatement(
    '''
    INSERT INTO MorphologicalDetails VALUES ( 'Magnoque', 0, 'magnus' ),
                                            ( 'que', 0, 'que' ),
                                            ( 'magno', 0, 'magnus' )
    ''',
  );
  await db.customStatement(
    '''
    INSERT INTO MorphologicalDetailInflections( form, item, cnt, partOfSpeech, stem )
        VALUES ( 'Magnoque', 0, 0, 'adjective', 'magn' ),
               ( 'Magnoque', 0, 1, 'adjective', 'magn' ),
               ( 'que', 0, 0, 'conjunction', 'que' ),
               ( 'magno', 0, 0, 'adjective', 'magn' )
    ''',
  );
  await db.customStatement(
    '''
    INSERT INTO CountableWordCandidateAnalyses( workId, idx, componentOrdinal, form, item )
        VALUES ( ?, 5, 0, 'Magnoque', 0 ),
               ( ?, 5, 1, 'que', 0 ),
               ( ?, 6, 0, 'magno', 0 ),
               ( ?, 5, 0, 'magno', 0 )
    ''',
    [_fables, _fables, _fables, _letters],
  );
  return db;
}

void main() {
  group('morphologicalAnalysesProvider', () {
    test('numerals and irregular words have analyses like any other part of speech', () async {
      final db = await _numeralAndIrregular();
      final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
      addTearDown(container.dispose);
      final keys = AnalysisKeys(const [
        AnalysisKey(form: 'tres', item: 0, cnt: 0),
        AnalysisKey(form: 'nequam', item: 0, cnt: 0),
      ]);
      final analyses = await container
          .listen(morphologicalAnalysesProvider(keys).future, (_, _) {})
          .read();
      expect(
        analyses.map((analysis) => (analysis.form, analysis.partOfSpeech)),
        unorderedEquals([('tres', 'numeral'), ('nequam', 'irregular')]),
      );
    });
  });

  group('morphologicalAnalysisKeysProvider', () {
    test('finds the analyses stored under the form exactly as written', () async {
      final db = await _venereTwice();
      final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
      addTearDown(container.dispose);
      final keys = await container
          .listen(morphologicalAnalysisKeysProvider('Venere').future, (_, _) {})
          .read();
      expect(keys, AnalysisKeys(const [AnalysisKey(form: 'Venere', item: 0, cnt: 0)]));
    });
  });

  group('lookupFormCandidateAnalysisKeysProvider', () {
    test("finds every inflection of the lookup form's candidates, not the enclitic's", () async {
      final db = await _magnoque();
      final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
      addTearDown(container.dispose);
      final keys = await container
          .listen(lookupFormCandidateAnalysisKeysProvider(_fables, 5).future, (_, _) {})
          .read();
      expect(
        keys,
        AnalysisKeys(const [
          AnalysisKey(form: 'Magnoque', item: 0, cnt: 0),
          AnalysisKey(form: 'Magnoque', item: 0, cnt: 1),
        ]),
      );
    });
  });
}
