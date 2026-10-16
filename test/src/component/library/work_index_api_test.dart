import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_orthography.dart';
import 'package:latin_reader/src/component/library/subdivision_type.dart';
import 'package:latin_reader/src/component/library/work_index_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

WorkIndexEntry _entry(SubdivisionType typ, {String? title, String? numeralWordIndexes}) =>
    WorkIndexEntry.fromSql(
      workId: 'fables',
      node: 'book',
      parent: null,
      depth: 0,
      typ: typ,
      cnt: 0,
      fromIndex: 0,
      toIndex: 3,
      title: title,
      numeralWordIndexes: numeralWordIndexes,
      startReference: '1',
      endReference: '1.1',
    );

Future<WorkIndex> _index(AppDb db, String work) {
  final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
  addTearDown(container.dispose);
  return container.listen(workIndexProvider(work).future, (_, _) {}).read();
}

const _uAndIOnly = SemivowelOrthography(
  uvLowercase: SemivowelForm.vocalic,
  uvCapitals: SemivowelForm.vocalic,
  ijLowercase: SemivowelForm.vocalic,
  ijCapitals: SemivowelForm.vocalic,
);

const _vAndJOnly = SemivowelOrthography(
  uvLowercase: SemivowelForm.consonantal,
  uvCapitals: SemivowelForm.consonantal,
  ijLowercase: SemivowelForm.consonantal,
  ijCapitals: SemivowelForm.consonantal,
);

void main() {
  group('WorkIndexEntry.labelSpelledWith', () {
    test('a title is written with the spelling, and its numerals keep their letters', () {
      expect(
        _entry(
          SubdivisionType.book,
          title: 'Liber VI: Vir et juvenis',
          numeralWordIndexes: '1',
        ).labelSpelledWith(_uAndIOnly),
        'Liber VI: Uir et iuuenis',
      );
    });

    test('without numerals, every word is written with the spelling', () {
      expect(
        _entry(SubdivisionType.book, title: 'VI victus Juno').labelSpelledWith(_uAndIOnly),
        'UI uictus Iuno',
      );
    });

    test('without a title, the type is the label, and it is not written with the spelling', () {
      expect(_entry(SubdivisionType.prologue).labelSpelledWith(_vAndJOnly), 'Prologue');
    });
  });

  group('workIndexProvider', () {
    test('a numeral keeps its letters, unlike a word spelled the same', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'DE', '1', 1, 0, 0, 'DĒ', 0, TRUE ),
                   ( ?, 1, 'VI', '1', 1, 0, 1, 'VĪ', 0, TRUE ),
                   ( ?, 2, ':', '1', 4, 0, NULL, ':', 0, TRUE ),
                   ( ?, 3, 'LIBER', '1', 1, 0, 2, 'LIBER', 0, TRUE ),
                   ( ?, 4, 'VI', '1', 3, 0, 3, 'VI', 0, TRUE ),
                   ( ?, 5, 'Vis', '1.1', 1, 1, 0, 'Vīs', 0, FALSE )
        ''',
        List.filled(6, duties),
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c1', 'BOOK', 0, '', NULL, 0, 5 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'TITL', 0, 'DE VI: LIBER VI',
                     '00000000-0000-0000-0000-0000000000c1', 0, 4 )
        ''',
        [duties, duties],
      );

      expect(
        (await _index(db, duties)).roots.single.labelSpelledWith(_uAndIOnly),
        'DE UI: LIBER VI',
      );
    });

    test('a work without books lists its poems, untitled ones too', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'ECLOGA', '8', 1, 0, 0, 'ECLOGA', 0, TRUE ),
                   ( ?, 1, 'Damon', '8', 1, 1, 0, 'Damon', 0, TRUE ),
                   ( ?, 2, 'Nascere', '8.17', 1, 2, 0, 'Nascere', 0, FALSE ),
                   ( ?, 3, 'Incipe', '8.21', 1, 3, 0, 'Incipe', 0, FALSE ),
                   ( ?, 4, 'Pastorum', '9.1', 1, 4, 0, 'Pastorum', 0, FALSE )
        ''',
        List.filled(5, duties),
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c1', 'POEM', 0, 'ECLOGA', NULL, 0, 3 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'TITL', 0, 'ECLOGA',
                     '00000000-0000-0000-0000-0000000000c1', 0, 0 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c3', 'SPCH', 0, 'Damon',
                     '00000000-0000-0000-0000-0000000000c1', 1, 3 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c4', 'TITL', 0, 'Damon',
                     '00000000-0000-0000-0000-0000000000c3', 1, 1 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c5', 'VERS', 0, 'Nascere',
                     '00000000-0000-0000-0000-0000000000c3', 2, 2 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c6', 'LGRP', 0, '',
                     '00000000-0000-0000-0000-0000000000c3', 3, 3 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c7', 'VERS', 0, 'Incipe',
                     '00000000-0000-0000-0000-0000000000c6', 3, 3 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c8', 'POEM', 1, '', NULL, 4, 4 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c9', 'VERS', 0, 'Pastorum',
                     '00000000-0000-0000-0000-0000000000c8', 4, 4 )
        ''',
        List.filled(9, duties),
      );
      final index = await _index(db, duties);

      expect(
        index.entries.map((entry) => (entry.typ, entry.parent, entry.title, entry.referenceLabel)),
        [
          (SubdivisionType.poem, null, 'ECLOGA', '8 – 8.21'),
          (SubdivisionType.poem, null, null, '9.1'),
        ],
      );
    });

    test('a book comes before the poem it holds, even when they have the same tokens', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'Arma', '1.1.1', 1, 0, 0, 'Arma', 0, FALSE ),
                   ( ?, 1, 'Musa', '2.1.1', 1, 1, 0, 'Musa', 0, FALSE )
        ''',
        [duties, duties],
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c4', 'BOOK', 0, '', NULL, 0, 0 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c3', 'POEM', 0, '',
                     '00000000-0000-0000-0000-0000000000c4', 0, 0 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'BOOK', 1, '', NULL, 1, 1 ),
                   ( ?, '00000000-0000-0000-0000-0000000000c1', 'POEM', 0, '',
                     '00000000-0000-0000-0000-0000000000c2', 1, 1 )
        ''',
        List.filled(4, duties),
      );
      final index = await _index(db, duties);

      expect(index.entries.map((entry) => (entry.typ, entry.parent, entry.referenceLabel)), [
        (SubdivisionType.book, null, '1.1.1'),
        (SubdivisionType.poem, '00000000-0000-0000-0000-0000000000c4', '1.1.1'),
        (SubdivisionType.book, null, '2.1.1'),
        (SubdivisionType.poem, '00000000-0000-0000-0000-0000000000c2', '2.1.1'),
      ]);
    });
  });
}
