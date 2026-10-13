import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_orthography.dart';
import 'package:latin_reader/src/component/settings/reader_settings_api.dart';
import 'package:latin_reader/src/component/word_frequency/lookup_frequency_api.dart';

/// Set explicitly so the tests don't depend on the defaults
const _uOnlyAndCapitalJ = ReaderSettings(
  showMacrons: true,
  fontFamily: null,
  fontSize: 20.0,
  lineHeight: 1.5,
  letterSpacing: 0.0,
  wordSpacing: 0.0,
  markCommonWords: false,
  commonWordsPercent: 25,
  markUncommonWords: true,
  uncommonWordsPercent: 5,
  frequencyScope: FrequencyScope.work,
  semivowelOrthographyChoice: SemivowelOrthographyChoice.manual,
  uvLowercase: SemivowelForm.vocalic,
  uvCapitals: null,
  ijLowercase: SemivowelForm.vocalicConsonantal,
  ijCapitals: SemivowelForm.consonantal,
);

const _vAndJOnlyEdition = SemivowelOrthography(
  uvLowercase: SemivowelForm.consonantal,
  uvCapitals: SemivowelForm.consonantal,
  ijLowercase: SemivowelForm.consonantal,
  ijCapitals: SemivowelForm.consonantal,
);

void main() {
  group('ReaderSettings.semivowelOrthographyFor', () {
    test("the original edition is the edition's orthography", () {
      final edition = _uOnlyAndCapitalJ.copyWith(
        semivowelOrthographyChoice: SemivowelOrthographyChoice.edition,
      );

      expect(edition.semivowelOrthographyFor(_vAndJOnlyEdition), _vAndJOnlyEdition);
    });

    test('u and v, i and j ignores the edition and the manual choices', () {
      final allVocalicConsonantal = _uOnlyAndCapitalJ.copyWith(
        semivowelOrthographyChoice: SemivowelOrthographyChoice.allVocalicConsonantal,
      );

      expect(
        allVocalicConsonantal.semivowelOrthographyFor(_vAndJOnlyEdition),
        SemivowelOrthography.allVocalicConsonantal,
      );
    });

    test('manual is the manual choices, with unset capitals like the lowercase', () {
      expect(
        _uOnlyAndCapitalJ.semivowelOrthographyFor(_vAndJOnlyEdition),
        const SemivowelOrthography(
          uvLowercase: SemivowelForm.vocalic,
          uvCapitals: SemivowelForm.vocalic,
          ijLowercase: SemivowelForm.vocalicConsonantal,
          ijCapitals: SemivowelForm.consonantal,
        ),
      );
    });
  });
}
