import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_orthography.dart';
import 'package:latin_reader/src/component/library/work_details_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

Future<WorkDetails> _details(AppDb db, String work) {
  final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
  addTearDown(container.dispose);
  return container.listen(workDetailsProvider(work).future, (_, _) {}).read();
}

void main() {
  group('workDetailsProvider', () {
    test("a work's semivowel orthography is its edition's", () async {
      final db = await smallLibrary();
      await db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, tokenType, sentenceIdx, wordIdx,
                                  macronizedWord, uncertaintyBitMask )
            VALUES ( ?, 0, 'Quamquam', '1.1', 1, 0, 0, 'Quamquam', 0 )
        ''',
        [fables],
      );

      expect(
        (await _details(db, fables)).editionSemivowelOrthography,
        const SemivowelOrthography(
          uvLowercase: SemivowelForm.vocalic,
          uvCapitals: SemivowelForm.consonantal,
          ijLowercase: SemivowelForm.vocalicConsonantal,
          ijCapitals: SemivowelForm.consonantal,
        ),
      );
    });
  });
}
