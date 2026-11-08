import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/subdivision_type.dart';
import 'package:latin_reader/src/component/library/work_contents_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

const _firstPoem = '00000000-0000-0000-0000-0000000000c1';
const _secondPoem = '00000000-0000-0000-0000-0000000000c7';
const _firstChapter = '00000000-0000-0000-0000-0000000000d1';
const _secondChapter = '00000000-0000-0000-0000-0000000000d4';
const _prologueScene = '00000000-0000-0000-0000-0000000000e2';
const _firstScene = '00000000-0000-0000-0000-0000000000e6';

Future<WorkContentsSegments> _contents(AppDb db, String work, int fromIndex, int toIndex) {
  final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
  addTearDown(container.dispose);
  return container.listen(workContentsProvider(work, fromIndex, toIndex).future, (_, _) {}).read();
}

void main() {
  group('workContentsProvider', () {
    test('each token belongs to the poem that holds it, whatever line group holds it', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'ECLOGA', '8', 1, 0, 0, 'ECLOGA', 0, TRUE ),
                   ( ?, 1, 'Pastorum', '8.1', 1, 1, 0, 'Pastorum', 0, FALSE ),
                   ( ?, 2, 'Tu', '8.6', 1, 2, 0, 'Tu', 0, FALSE ),
                   ( ?, 3, 'Formosum', '9.1', 1, 3, 0, 'Formosum', 0, FALSE )
        ''',
        List.filled(4, duties),
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex, editionLabel )
            VALUES ( ?, '$_firstPoem', 'POEM', 0, 'ECLOGA', NULL, 0, 2, '8' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'TITL', 0, 'ECLOGA', '$_firstPoem',
                     0, 0, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c3', 'LGRP', 0, '', '$_firstPoem', 1, 1,
                     NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c4', 'VERS', 0, 'Pastorum',
                     '00000000-0000-0000-0000-0000000000c3', 1, 1, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c5', 'LGRP', 1, '', '$_firstPoem', 2, 2,
                     NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000c6', 'VERS', 0, 'Tu',
                     '00000000-0000-0000-0000-0000000000c5', 2, 2, '6' ),
                   ( ?, '$_secondPoem', 'POEM', 1, '', NULL, 3, 3, '9' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c8', 'VERS', 0, 'Formosum', '$_secondPoem',
                     3, 3, '1' )
        ''',
        List.filled(8, duties),
      );
      final contents = await _contents(db, duties, 0, 3);

      expect(
        contents.map((segment) => (segment.idx, segment.typ, segment.piece)),
        [
          (0, SubdivisionType.poem, _firstPoem),
          (1, SubdivisionType.verse, _firstPoem),
          (2, SubdivisionType.verse, _firstPoem),
          (3, SubdivisionType.verse, _secondPoem),
        ],
      );
    });

    test('each token keeps the ictus that its edition prints', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, ictusBitMask,
                                  isTitle )
            VALUES ( ?, 0, 'Levis', '1', 1, 0, 0, 'Levis', 0, 2, FALSE ),
                   ( ?, 1, 'est', '1', 1, 0, 1, 'est', 0, 0, FALSE )
        ''',
        [duties, duties],
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex, editionLabel )
            VALUES ( ?, '$_firstPoem', 'POEM', 0, '', NULL, 0, 1, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000c2', 'VERS', 0, 'Lévis est',
                     '$_firstPoem', 0, 1, '1' )
        ''',
        [duties, duties],
      );
      final contents = await _contents(db, duties, 0, 1);

      expect(
        contents.map((segment) => (segment.idx, segment.word, segment.ictusBitMask)),
        [
          (0, 'Levis', 2),
          (1, 'est', 0),
        ],
      );
    });

    test("a book's title belongs to no poem", () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'LIBER', '1', 1, 0, 0, 'LIBER', 0, TRUE ),
                   ( ?, 1, 'Ranae', '1.1.1', 1, 1, 0, 'Ranae', 0, FALSE )
        ''',
        [duties, duties],
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex, editionLabel )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000c9', 'BOOK', 0, 'LIBER', NULL, 0, 1,
                     '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000ca', 'TITL', 0, 'LIBER',
                     '00000000-0000-0000-0000-0000000000c9', 0, 0, NULL ),
                   ( ?, '$_firstPoem', 'POEM', 0, '', '00000000-0000-0000-0000-0000000000c9', 1, 1,
                     '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000cb', 'VERS', 0, 'Ranae',
                     '$_firstPoem', 1, 1, '1' )
        ''',
        List.filled(4, duties),
      );
      final contents = await _contents(db, duties, 0, 1);

      expect(
        contents.map((segment) => (segment.idx, segment.typ, segment.piece)),
        [
          (0, SubdivisionType.book, null),
          (1, SubdivisionType.verse, _firstPoem),
        ],
      );
    });

    test('each token belongs to the chapter that holds it, whatever section holds it', () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx,
                                  wordIdx, macronizedWord, uncertaintyBitMask, isTitle )
            VALUES ( ?, 0, 'Gallia', '1.1.1', 1, 0, 0, 'Gallia', 0, FALSE ),
                   ( ?, 1, 'Hi', '1.1.2', 1, 1, 0, 'Hi', 0, FALSE ),
                   ( ?, 2, 'Apud', '1.2.1', 1, 2, 0, 'Apud', 0, FALSE )
        ''',
        List.filled(3, duties),
      );
      await db.customStatement(
        '''
        INSERT INTO WorkContentSubdivisions( workId, node, typ, cnt, name, parent, fromIndex,
                                             toIndex, editionLabel )
            VALUES ( ?, '00000000-0000-0000-0000-0000000000d0', 'BOOK', 0, '', NULL, 0, 2, '1' ),
                   ( ?, '$_firstChapter', 'CHAP', 0, '', '00000000-0000-0000-0000-0000000000d0',
                     0, 1, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000d2', 'SECT', 0, '', '$_firstChapter',
                     0, 0, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000d3', 'SECT', 1, '', '$_firstChapter',
                     1, 1, '2' ),
                   ( ?, '$_secondChapter', 'CHAP', 1, '', '00000000-0000-0000-0000-0000000000d0',
                     2, 2, '2' ),
                   ( ?, '00000000-0000-0000-0000-0000000000d5', 'SECT', 0, '', '$_secondChapter',
                     2, 2, '1' )
        ''',
        List.filled(6, duties),
      );
      final contents = await _contents(db, duties, 0, 2);

      expect(
        contents.map((segment) => (segment.idx, segment.typ, segment.piece)),
        [
          (0, SubdivisionType.section, _firstChapter),
          (1, SubdivisionType.section, _firstChapter),
          (2, SubdivisionType.section, _secondChapter),
        ],
      );
    });

    test('each token belongs to the scene that holds it, also in a prologue', () async {
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
            VALUES ( ?, '00000000-0000-0000-0000-0000000000e1', 'PROL', 0, '', NULL, 0, 1,
                     'prologue' ),
                   ( ?, '$_prologueScene', 'SCEN', 0, '', '00000000-0000-0000-0000-0000000000e1',
                     0, 1, 'pr' ),
                   ( ?, '00000000-0000-0000-0000-0000000000e3', 'SPCH', 0, 'Mercurius',
                     '$_prologueScene', 0, 1, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000e4', 'VERS', 0, 'Ut',
                     '00000000-0000-0000-0000-0000000000e3', 1, 1, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000e5', 'ACT', 0, '', NULL, 2, 3, '1' ),
                   ( ?, '$_firstScene', 'SCEN', 0, '', '00000000-0000-0000-0000-0000000000e5', 2,
                     3, '1' ),
                   ( ?, '00000000-0000-0000-0000-0000000000e7', 'SPCH', 0, 'Sosia', '$_firstScene',
                     2, 3, NULL ),
                   ( ?, '00000000-0000-0000-0000-0000000000e8', 'VERS', 0, 'Qui',
                     '00000000-0000-0000-0000-0000000000e7', 3, 3, '153' )
        ''',
        List.filled(8, duties),
      );
      final contents = await _contents(db, duties, 0, 3);

      expect(
        contents.map((segment) => (segment.idx, segment.typ, segment.piece)),
        [
          (0, SubdivisionType.speech, _prologueScene),
          (1, SubdivisionType.verse, _prologueScene),
          (2, SubdivisionType.speech, _firstScene),
          (3, SubdivisionType.verse, _firstScene),
        ],
      );
    });
  });
}
