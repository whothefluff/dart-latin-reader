import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/subdivision_type.dart';
import 'package:latin_reader/src/component/library/work_contents_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

const _firstPoem = '00000000-0000-0000-0000-0000000000c1';
const _secondPoem = '00000000-0000-0000-0000-0000000000c7';

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
        contents.map((segment) => (segment.idx, segment.typ, segment.poem)),
        [
          (0, SubdivisionType.poem, _firstPoem),
          (1, SubdivisionType.verse, _firstPoem),
          (2, SubdivisionType.verse, _firstPoem),
          (3, SubdivisionType.verse, _secondPoem),
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
        contents.map((segment) => (segment.idx, segment.typ, segment.poem)),
        [
          (0, SubdivisionType.book, null),
          (1, SubdivisionType.verse, _firstPoem),
        ],
      );
    });
  });
}
