import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';

void main() {
  test('a form is one word: blanks around it are fine, blanks inside make a phrase', () {
    for (final word in [' puellam ', 'M.', 'XII', 'rosā', 'populusque']) {
      expect(FormCriterion(word).isComplete, isTrue, reason: word);
    }
    for (final phrase in ['puellam videt', 'puellam\tvidet', 'puellam videt']) {
      expect(FormCriterion(phrase).isPhrase, isTrue, reason: phrase);
      expect(FormCriterion(phrase).isComplete, isFalse, reason: phrase);
    }
    expect(const FormCriterion(' ').isPhrase, isFalse);
    expect(const FormCriterion(' ').isComplete, isFalse);
  });

  test("an entry's own lemma and its sublemma are two lemmas", () {
    LemmaChoice ofBonus(String sublemma) =>
        LemmaChoice(entryRef: 'bonus', dictionaryRefs: const ['bonus'], sublemma: sublemma);

    expect(ofBonus('bonae'), ofBonus('bonae'));
    expect(ofBonus('bonae'), isNot(ofBonus('')));
  });
}
