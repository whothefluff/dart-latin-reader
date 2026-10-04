import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/morph_analysis/db_util.dart' as morp_util;
import 'package:latin_reader/src/component/morph_analysis/morphological_search_api.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

class _EmptyDb extends AppDb {
  _EmptyDb() : super(executor: NativeDatabase.memory(setup: util.setupRegExp));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

/// rosa (nominative rosa and ablative rosā), rosae and rosarum (rosārum), searchable through the
/// app's population step
Future<AppDb> _roses() async {
  final db = _EmptyDb();
  addTearDown(db.close);
  await db.customStatement(
    "INSERT INTO MorphologicalDetails VALUES ( 'rosa', 0, 'rosa' ), ( 'rosae', 0, 'rosa' ), "
    "( 'rosarum', 0, 'rosa' )",
  );
  await db.customStatement(
    '''
    INSERT INTO MorphologicalDetailInflections( form, item, cnt, partOfSpeech, stem, suffix )
        VALUES ( 'rosa', 0, 0, 'noun', 'ros', 'a' ),
               ( 'rosa', 0, 1, 'noun', 'ros', 'ā' ),
               ( 'rosae', 0, 0, 'noun', 'ros', 'ae' ),
               ( 'rosarum', 0, 0, 'noun', 'ros', 'ārum' )
    ''',
  );
  await morp_util.operations
      .singleWhere((operation) => operation.id == 'SearchableMorphDetInflections')
      .insert(db);
  return db;
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
  await morp_util.operations
      .singleWhere((operation) => operation.id == 'SearchableMorphDetInflections')
      .insert(db);
  return db;
}

/// The analyses [text] finds, as form and count
Future<List<(String, int)>> _found(AppDb db, String text) async {
  final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
  addTearDown(container.dispose);
  final results = await container
      .listen(morphologicalSearchProvider(text).future, (_, _) {})
      .read();
  return results.map((result) => (result.form, result.cnt)).toList();
}

void main() {
  group('morphologicalSearchProvider', () {
    test('text with macrons is found anywhere in the macronized forms', () async {
      expect(
        await _found(await _roses(), 'rosā'),
        unorderedEquals([('rosa', 1), ('rosarum', 0)]),
      );
    });

    test('quoted text with macrons must match a macronized form exactly', () async {
      expect(await _found(await _roses(), '"rosā"'), [('rosa', 1)]);
    });

    test('text without macrons is found anywhere in the forms, with or without macrons', () async {
      expect(
        await _found(await _roses(), 'rosa'),
        unorderedEquals([('rosa', 0), ('rosa', 1), ('rosae', 0), ('rosarum', 0)]),
      );
    });

    test('quoted text without macrons must match a form exactly', () async {
      expect(await _found(await _roses(), '"rosa"'), unorderedEquals([('rosa', 0), ('rosa', 1)]));
    });

    test('empty text searches nothing', () async {
      expect(await _found(await _roses(), '  '), isEmpty);
    });

    test('numerals and irregular words are found like any other part of speech', () async {
      final db = await _numeralAndIrregular();
      expect(await _found(db, '"tres"'), [('tres', 0)]);
      expect(await _found(db, '"nequam"'), [('nequam', 0)]);
    });
  });
}
