import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:sqlite3/sqlite3.dart' show SqliteException;

import 'library_fixture.dart';

const _book = '00000000-0000-0000-0000-0000000000c1';
const _poem = '00000000-0000-0000-0000-0000000000c2';
const _lineGroup = '00000000-0000-0000-0000-0000000000c3';
const _speech = '00000000-0000-0000-0000-0000000000c4';
const _verse = '00000000-0000-0000-0000-0000000000c5';
const _title = '00000000-0000-0000-0000-0000000000c6';

final Matcher _checkFailure = throwsA(
  isA<SqliteException>().having(
    (error) => error.message,
    'message',
    contains('CHECK constraint failed'),
  ),
);

/// Adds a subdivision of the two tokens of [fables].
Future<void> _addSubdivision(
  AppDb db, {
  required String node,
  required String typ,
  String? parent,
  String name = '',
  String? editionLabel,
}) => db.customStatement(
  '''
  INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex, toIndex,
                                       editionLabel )
      VALUES ( ?, ?, ?, 0, ?, ?, 0, 1, ? )
  ''',
  [fables, node, typ, name, parent, editionLabel],
);

void main() {
  late AppDb db;

  setUp(() async {
    db = await smallLibrary();
    await db.customStatement(
      '''
      INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx, wordIdx,
                                macronizedWord, uncertaintyBitMask )
          VALUES ( ?, 0, 'Damon', '8', 1, 0, 0, 'Damon', 0 ),
                 ( ?, 1, 'Nascere', '8.17', 1, 1, 0, 'Nascere', 0 )
      ''',
      [fables, fables],
    );
  });

  group('WorkContentSubdivisions', () {
    test('a work without books has its poems as roots, with line groups and speeches', () async {
      await _addSubdivision(db, node: _poem, typ: 'POEM', editionLabel: '8');
      await _addSubdivision(db, node: _lineGroup, typ: 'LGRP', parent: _poem);
      await _addSubdivision(db, node: _speech, typ: 'SPCH', parent: _poem, name: 'Damon');

      final rows = await db
          .customSelect('SELECT typ, parent FROM WorkContentSubdivisions ORDER BY node')
          .get();
      expect(rows.map((row) => row.data.values.toList()), [
        ['POEM', null],
        ['LGRP', _poem],
        ['SPCH', _poem],
      ]);
    });

    test('a verse is never a root', () async {
      await expectLater(
        _addSubdivision(db, node: _verse, typ: 'VERS', editionLabel: '17'),
        _checkFailure,
      );
    });

    test('a book is always a root', () async {
      await _addSubdivision(db, node: _book, typ: 'BOOK', editionLabel: '1');

      await expectLater(
        _addSubdivision(db, node: _poem, typ: 'BOOK', parent: _book, editionLabel: '2'),
        _checkFailure,
      );
    });

    test('a poem has its TEI n as its edition label', () async {
      await expectLater(_addSubdivision(db, node: _poem, typ: 'POEM'), _checkFailure);
    });

    test('a title has no edition label', () async {
      await _addSubdivision(db, node: _poem, typ: 'POEM', editionLabel: '8');

      await expectLater(
        _addSubdivision(
          db,
          node: _title,
          typ: 'TITL',
          parent: _poem,
          name: 'Damon',
          editionLabel: '1',
        ),
        _checkFailure,
      );
    });
  });
}
