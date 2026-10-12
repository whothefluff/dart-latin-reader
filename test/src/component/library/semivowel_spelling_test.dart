import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/semivowel_spelling.dart';

void main() {
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
