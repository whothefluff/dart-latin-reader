import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:sqlite3/sqlite3.dart' show SqliteException;

import 'library_fixture.dart';

const _book = '00000000-0000-0000-0000-0000000000c1';
const _poem = '00000000-0000-0000-0000-0000000000c2';
const _lineGroup = '00000000-0000-0000-0000-0000000000c3';
const _speech = '00000000-0000-0000-0000-0000000000c4';
const _verse = '00000000-0000-0000-0000-0000000000c5';

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
}) => db.customStatement(
  '''
  INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex, toIndex )
      VALUES ( ?, ?, ?, 0, ?, ?, 0, 1 )
  ''',
  [fables, node, typ, name, parent],
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
      await _addSubdivision(db, node: _poem, typ: 'POEM');
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
      await expectLater(_addSubdivision(db, node: _verse, typ: 'VERS'), _checkFailure);
    });

    test('a book is always a root', () async {
      await _addSubdivision(db, node: _book, typ: 'BOOK');

      await expectLater(
        _addSubdivision(db, node: _poem, typ: 'BOOK', parent: _book),
        _checkFailure,
      );
    });
  });
}
