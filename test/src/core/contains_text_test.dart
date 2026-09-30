import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/core/contains_text.dart';

void main() {
  group('containsText', () {
    test('finds the trimmed text anywhere in any of the values, whatever the case', () {
      expect(containsText(['Phaedrus', 'Phaedr.'], ' AEDR. '), isTrue);
      expect(containsText(['Phaedrus', 'Phaedr.'], 'cic'), isFalse);
    });

    test('macrons are ignored on both sides', () {
      expect(containsText(['Lupus et agnus'], 'āgnus'), isTrue);
      expect(containsText(['Lūpus et agnus'], 'LUPUS'), isTrue);
    });

    test('wildcards and quotes are plain characters', () {
      expect(containsText(['Phaedrus'], 'ph*'), isFalse);
      expect(containsText(['Phaedrus'], '"phaedrus"'), isFalse);
    });
  });
}
