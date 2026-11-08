import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_orthography.dart';
import 'package:latin_reader/src/component/library/subdivision_type.dart';
import 'package:latin_reader/src/component/library/work_index_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

WorkIndexEntry _entry(
  SubdivisionType typ, {
  int cnt = 0,
  String editionLabel = '1',
  String? title,
  String? numeralWordIndexes,
}) => WorkIndexEntry.fromSql(
  workId: 'fables',
  node: 'book',
  parent: null,
  depth: 0,
  typ: typ,
  cnt: cnt,
  fromIndex: 0,
  toIndex: 3,
  editionLabel: editionLabel,
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

  group('WorkIndexEntry.typeLabel', () {
    test('a poem is labelled with its TEI n', () {
      expect(_entry(SubdivisionType.poem, editionLabel: '14a').typeLabel, 'Poem 14a');
    });

    test('a book is labelled with its TEI n when that is a number, and counted when it is not', () {
      expect(_entry(SubdivisionType.book, editionLabel: '4').typeLabel, 'Book 4');
      expect(_entry(SubdivisionType.book, cnt: 5, editionLabel: 'appendix').typeLabel, 'Book 6');
    });

    test('a chapter is labelled with its TEI n', () {
      expect(_entry(SubdivisionType.chapter, editionLabel: '55').typeLabel, 'Chapter 55');
    });

    test('an act or a scene is labelled with its TEI n, or counted when that is no number', () {
      expect(_entry(SubdivisionType.act, editionLabel: '2').typeLabel, 'Act 2');
      expect(_entry(SubdivisionType.scene, editionLabel: '3').typeLabel, 'Scene 3');
      expect(_entry(SubdivisionType.scene, editionLabel: 'pr').typeLabel, 'Scene 1');
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
                                             toIndex, editionLabel )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c1', 'BOOK', 0, '', NULL, 0, 5, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'TITL', 0, 'DE VI: LIBER VI',
                     '00000000-0000-0000-0000-0000000000c1', 0, 4, NULL )
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
                                             toIndex, editionLabel )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c1', 'POEM', 0, 'ECLOGA', NULL, 0, 3, '8' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'TITL', 0, 'ECLOGA',
                     '00000000-0000-0000-0000-0000000000c1', 0, 0, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c3', 'SPCH', 0, 'Damon',
                     '00000000-0000-0000-0000-0000000000c1', 1, 3, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c4', 'TITL', 0, 'Damon',
                     '00000000-0000-0000-0000-0000000000c3', 1, 1, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c5', 'VERS', 0, 'Nascere',
                     '00000000-0000-0000-0000-0000000000c3', 2, 2, '17' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c6', 'LGRP', 0, '',
                     '00000000-0000-0000-0000-0000000000c3', 3, 3, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c7', 'VERS', 0, 'Incipe',
                     '00000000-0000-0000-0000-0000000000c6', 3, 3, '21' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c8', 'POEM', 1, '', NULL, 4, 4, '9' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c9', 'VERS', 0, 'Pastorum',
                     '00000000-0000-0000-0000-0000000000c8', 4, 4, '1' )
        ''',
        List.filled(9, duties),
      );
      final index = await _index(db, duties);

      expect(
        index.entries.map(
          (entry) =>
              (entry.typ, entry.parent, entry.labelSpelledWith(_uAndIOnly), entry.referenceLabel),
        ),
        [
          (SubdivisionType.poem, null, 'ECLOGA', '8 – 8.21'),
          (SubdivisionType.poem, null, 'Poem 9', '9.1'),
        ],
      );
    });

    test('a work of books of chapters lists its books and chapters, not their sections', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'COMMENTARIUS', '1', 1, 0, 0, 'COMMENTARIUS', 0, TRUE ),
                   ( ?, 1, 'Gallia', '1.1.1', 1, 1, 0, 'Gallia', 0, FALSE ),
                   ( ?, 2, 'Hi', '1.1.2', 1, 2, 0, 'Hi', 0, FALSE ),
                   ( ?, 3, 'Apud', '1.2.1', 1, 3, 0, 'Apud', 0, FALSE )
        ''',
        List.filled(4, duties),
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex, editionLabel )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c1', 'BOOK', 0, 'COMMENTARIUS', NULL, 0,
                     3, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'TITL', 0, 'COMMENTARIUS',
                     '00000000-0000-0000-0000-0000000000c1', 0, 0, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c3', 'CHAP', 0, '',
                     '00000000-0000-0000-0000-0000000000c1', 1, 2, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c4', 'SECT', 0, '',
                     '00000000-0000-0000-0000-0000000000c3', 1, 1, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c5', 'SECT', 1, '',
                     '00000000-0000-0000-0000-0000000000c3', 2, 2, '2' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c6', 'CHAP', 1, '',
                     '00000000-0000-0000-0000-0000000000c1', 3, 3, '2' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c7', 'SECT', 0, '',
                     '00000000-0000-0000-0000-0000000000c6', 3, 3, '1' )
        ''',
        List.filled(7, duties),
      );
      final index = await _index(db, duties);

      expect(
        index.entries.map(
          (entry) => (entry.typ, entry.labelSpelledWith(_uAndIOnly), entry.referenceLabel),
        ),
        [
          (SubdivisionType.book, 'COMMENTARIUS', '1 – 1.2.1'),
          (SubdivisionType.chapter, 'Chapter 1', '1.1.1 – 1.1.2'),
          (SubdivisionType.chapter, 'Chapter 2', '1.2.1'),
        ],
      );
    });

    test('a play lists its acts and scenes, and a prologue', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'Mercurius', '1', 1, 0, 0, 'Mercurius', 0, TRUE ),
                   ( ?, 1, 'Ut', '1', 1, 1, 0, 'Ut', 0, FALSE ),
                   ( ?, 2, 'Sosia', '153', 1, 2, 0, 'Sosia', 0, TRUE ),
                   ( ?, 3, 'Qui', '153', 1, 3, 0, 'Qui', 0, FALSE )
        ''',
        List.filled(4, duties),
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex, editionLabel )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c1', 'PROL', 0, '', NULL, 0, 1,
                     'prologue' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'SCEN', 0, '',
                     '00000000-0000-0000-0000-0000000000c1', 0, 1, 'pr' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c3', 'SPCH', 0, 'Mercurius',
                     '00000000-0000-0000-0000-0000000000c2', 0, 1, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c4', 'TITL', 0, 'Mercurius',
                     '00000000-0000-0000-0000-0000000000c3', 0, 0, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c5', 'VERS', 0, 'Ut',
                     '00000000-0000-0000-0000-0000000000c3', 1, 1, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c6', 'ACT', 0, '', NULL, 2, 3, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c7', 'SCEN', 0, '',
                     '00000000-0000-0000-0000-0000000000c6', 2, 3, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c8', 'SPCH', 0, 'Sosia',
                     '00000000-0000-0000-0000-0000000000c7', 2, 3, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c9', 'TITL', 0, 'Sosia',
                     '00000000-0000-0000-0000-0000000000c8', 2, 2, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000ca', 'VERS', 0, 'Qui',
                     '00000000-0000-0000-0000-0000000000c8', 3, 3, '153' )
        ''',
        List.filled(10, duties),
      );
      final index = await _index(db, duties);

      expect(
        index.entries.map(
          (entry) => (entry.typ, entry.labelSpelledWith(_uAndIOnly), entry.referenceLabel),
        ),
        [
          (SubdivisionType.prologue, 'Prologue', '1'),
          (SubdivisionType.scene, 'Scene 1', '1'),
          (SubdivisionType.act, 'Act 1', '153'),
          (SubdivisionType.scene, 'Scene 1', '153'),
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
                                             toIndex, editionLabel )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c4', 'BOOK', 0, '', NULL, 0, 0, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c3', 'POEM', 0, '',
                     '00000000-0000-0000-0000-0000000000c4', 0, 0, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'BOOK', 1, '', NULL, 1, 1, '2' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c1', 'POEM', 0, '',
                     '00000000-0000-0000-0000-0000000000c2', 1, 1, '1' )
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
