import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_spelling.dart';

SemivowelSpelling _spelling({
  SemivowelLetters uvLowercase = SemivowelLetters.both,
  SemivowelLetters? uvCapitals,
  SemivowelLetters ijLowercase = SemivowelLetters.both,
  SemivowelLetters? ijCapitals,
}) => SemivowelSpelling(
  uvLowercase: uvLowercase,
  uvCapitals: uvCapitals ?? uvLowercase,
  ijLowercase: ijLowercase,
  ijCapitals: ijCapitals ?? ijLowercase,
);

void main() {
  group('SemivowelSpelling.respell', () {
    test('the stored letters are kept', () {
      expect(SemivowelSpelling.stored.respell('Juppiter vīvus jam'), 'Juppiter vīvus jam');
    });

    test('one letter is written for both sounds, in lowercase and in capitals', () {
      final uOnly = _spelling(uvLowercase: SemivowelLetters.vowelLetterOnly);
      final iOnly = _spelling(ijLowercase: SemivowelLetters.vowelLetterOnly);
      final vOnly = _spelling(uvLowercase: SemivowelLetters.semivowelLetterOnly);
      final jOnly = _spelling(ijLowercase: SemivowelLetters.semivowelLetterOnly);

      expect(uOnly.respell('Vir vīvus Ut'), 'Uir uīuus Ut');
      expect(iOnly.respell('Juppiter jam īra'), 'Iuppiter iam īra');
      expect(vOnly.respell('Ut uir'), 'Vt vir');
      expect(jOnly.respell('Iam in'), 'Jam jn');
    });

    test('capitals follow their own choice', () {
      final capitalV = _spelling(
        uvLowercase: SemivowelLetters.vowelLetterOnly,
        uvCapitals: SemivowelLetters.semivowelLetterOnly,
      );
      final capitalJ = _spelling(ijCapitals: SemivowelLetters.semivowelLetterOnly);

      expect(capitalV.respell('Ut vir Vir'), 'Vt uir Vir');
      expect(capitalJ.respell('Iam iam'), 'Jam iam');
    });

    test('a long vowel written with a semivowel letter takes a combining macron', () {
      final vAndJOnly = _spelling(
        uvLowercase: SemivowelLetters.semivowelLetterOnly,
        ijLowercase: SemivowelLetters.semivowelLetterOnly,
      );

      expect(vAndJOnly.respell('ūtī Ūnī Īlia'), 'v̄tj̄ V̄nj̄ J̄lja');
      expect(vAndJOnly.respellEach('ūt'), ['v̄', 't']);
    });
  });

  group('SemivowelLettersConverter', () {
    test('each value is stored as its letters', () {
      const converter = SemivowelLettersConverter('U', 'V');

      expect(SemivowelLetters.values.map(converter.toSql), ['UV', 'U', 'V']);
      expect(['UV', 'U', 'V'].map(converter.fromSql), SemivowelLetters.values);
    });

    test('other letters are refused', () {
      expect(() => const SemivowelLettersConverter('i', 'j').fromSql('ji'), throwsStateError);
    });
  });
}
