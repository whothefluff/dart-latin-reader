import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';

void main() {
  group('spellingsToLookUp', () {
    test('only a name that may be a common word is looked up in lowercase too', () {
      expect(
        [ProperNounState.either, ProperNounState.proper, ProperNounState.common, null].map(
          (state) => spellingsToLookUp('Venere', state).toList(),
        ),
        [
          ['Venere', 'venere'],
          ['Venere'],
          ['Venere'],
          ['Venere'],
        ],
      );
    });
  });
}
