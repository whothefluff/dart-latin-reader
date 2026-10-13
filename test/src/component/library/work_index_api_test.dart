import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_orthography.dart';
import 'package:latin_reader/src/component/library/subdivision_type.dart';
import 'package:latin_reader/src/component/library/work_index_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

WorkIndexEntry _title(String label, {String? numeralWordIndexes}) => WorkIndexEntry.fromSql(
  workId: 'fables',
  node: 'title',
  parent: 'book',
  depth: 1,
  typ: SubdivisionType.title,
  cnt: 0,
  fromIndex: 0,
  toIndex: 3,
  label: label,
  numeralWordIndexes: numeralWordIndexes,
  startReference: '1',
  endReference: '1',
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

void main() {
  group('WorkIndexEntry.labelSpelledWith', () {
    test('a title is written with the spelling, and its numerals keep their letters', () {
      expect(
        _title('Liber VI: Vir et juvenis', numeralWordIndexes: '1').labelSpelledWith(_uAndIOnly),
        'Liber VI: Uir et iuuenis',
      );
    });

    test('without numerals, every word is written with the spelling', () {
      expect(_title('VI victus Juno').labelSpelledWith(_uAndIOnly), 'UI uictus Iuno');
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
  });
}
