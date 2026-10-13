import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/core/semivowel_search.dart';

void main() {
  group('SemivowelSearch.allows', () {
    test('a typed i finds a stored j only when the setting is on, in either case', () {
      const iFindsJ = SemivowelSearchRules(iFindsJ: true, uFindsV: false);
      const neither = SemivowelSearchRules(iFindsJ: false, uFindsV: false);

      expect(iFindsJ.allows('iam', 'jam'), isTrue);
      expect(iFindsJ.allows('Iam', 'Jam'), isTrue);
      expect(neither.allows('iam', 'jam'), isFalse);
      expect(iFindsJ.allows('Iam', 'jam'), isFalse);
    });

    test('a typed u finds a stored v only when the setting is on', () {
      const uFindsV = SemivowelSearchRules(iFindsJ: false, uFindsV: true);

      expect(uFindsV.allows('seruus', 'servus'), isTrue);
      expect(uFindsV.allows('iuuenis', 'juvenis'), isFalse);
    });

    test('a typed j or v never finds a stored i or u', () {
      const both = SemivowelSearchRules(iFindsJ: true, uFindsV: true);

      expect(both.allows('jam', 'iam'), isFalse);
      expect(both.allows('vir', 'uir'), isFalse);
      expect(both.allows('iam', 'jams'), isFalse);
    });
  });

  group('toVowelLetters', () {
    test('j is written as i and v as u, in either case', () {
      expect(toVowelLetters('Juvenis vīvit'), 'Iuuenis uīuit');
    });
  });
}
