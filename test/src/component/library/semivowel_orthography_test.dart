import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_orthography.dart';

SemivowelOrthography _orthography({
  SemivowelForm uvLowercase = SemivowelForm.vocalicConsonantal,
  SemivowelForm? uvCapitals,
  SemivowelForm ijLowercase = SemivowelForm.vocalicConsonantal,
  SemivowelForm? ijCapitals,
}) => SemivowelOrthography(
  uvLowercase: uvLowercase,
  uvCapitals: uvCapitals ?? uvLowercase,
  ijLowercase: ijLowercase,
  ijCapitals: ijCapitals ?? ijLowercase,
);

void main() {
  group('SemivowelOrthography.respell', () {
    test('the stored letters are kept', () {
      expect(
        SemivowelOrthography.allVocalicConsonantal.respell('Juppiter vīvus jam'),
        'Juppiter vīvus jam',
      );
    });

    test('one letter is written for both sounds, in lowercase and in capitals', () {
      final uOnly = _orthography(uvLowercase: SemivowelForm.vocalic);
      final iOnly = _orthography(ijLowercase: SemivowelForm.vocalic);
      final vOnly = _orthography(uvLowercase: SemivowelForm.consonantal);
      final jOnly = _orthography(ijLowercase: SemivowelForm.consonantal);

      expect(uOnly.respell('Vir vīvus Ut'), 'Uir uīuus Ut');
      expect(iOnly.respell('Juppiter jam īra'), 'Iuppiter iam īra');
      expect(vOnly.respell('Ut uir'), 'Vt vir');
      expect(jOnly.respell('Iam in'), 'Jam jn');
    });

    test('capitals follow their own choice', () {
      final capitalV = _orthography(
        uvLowercase: SemivowelForm.vocalic,
        uvCapitals: SemivowelForm.consonantal,
      );
      final capitalJ = _orthography(ijCapitals: SemivowelForm.consonantal);

      expect(capitalV.respell('Ut vir Vir'), 'Vt uir Vir');
      expect(capitalJ.respell('Iam iam'), 'Jam iam');
    });

    test('a long vowel written with a semivowel letter takes a combining macron', () {
      final vAndJOnly = _orthography(
        uvLowercase: SemivowelForm.consonantal,
        ijLowercase: SemivowelForm.consonantal,
      );

      expect(vAndJOnly.respell('ūtī Ūnī Īlia'), 'v̄tj̄ V̄nj̄ J̄lja');
      expect(vAndJOnly.respellEach('ūt'), ['v̄', 't']);
    });
  });

  group('SemivowelsConverter', () {
    test('each value is stored as its letters', () {
      const converter = SemivowelsConverter('U', 'V');

      expect(SemivowelForm.values.map(converter.toSql), ['UV', 'U', 'V']);
      expect(['UV', 'U', 'V'].map(converter.fromSql), SemivowelForm.values);
    });

    test('other letters are refused', () {
      expect(() => const SemivowelsConverter('i', 'j').fromSql('ji'), throwsStateError);
    });
  });
}
