import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';
import 'package:latin_reader/src/ui/page/concordance/common.dart';
import 'package:latin_reader/src/ui/widget/lemma_text.dart';

String _described(ConcordanceCriterion criterion) =>
    describePhrase(ConcordanceQuery(slots: [criterion]));

/// Returns Dardania's choice under [entryRef].
LemmaChoice _dardania(String entryRef) =>
    LemmaChoice(entryRef: entryRef, dictionaryRefs: [entryRef], sublemma: 'Dardania');

void main() {
  test('a grammar word reads part of speech, declension, then the rest as grammars do', () {
    final query = ConcordanceQuery(
      slots: [
        GrammarCriterion(
          GrammarFilter(const {
            GrammarFeature.number: 'plural',
            GrammarFeature.gramCase: 'accusative',
            GrammarFeature.declension: '3rd',
            GrammarFeature.partOfSpeech: 'noun',
          }),
        ),
      ],
    );
    expect(describePhrase(query), 'noun, 3rd declension, accusative, plural (grammar)');
  });

  test('two sublemmas spelled alike are described apart, each with its entry', () {
    final adjective = GrammarFilter(const {GrammarFeature.partOfSpeech: 'adjective'});

    expect(
      _described(LemmaCriterion(_dardania('Dardanus1'))),
      isNot(_described(LemmaCriterion(_dardania('Dardani')))),
    );
    expect(
      _described(LemmaCriterion(_dardania('Dardanus1'))),
      contains(lemmaLabel('Dardanus1', 'Dardania')),
    );
    expect(
      _described(GrammarCriterion(adjective, lemma: _dardania('Dardani'))),
      contains(lemmaLabel('Dardani', 'Dardania')),
    );
  });

  test("an entry's own lemma is described by its entry alone", () {
    final sum = LemmaChoice(entryRef: 'sum1', dictionaryRefs: const ['sum1'], sublemma: '');

    expect(_described(LemmaCriterion(sum)), startsWith(entryRefText('sum1')));
  });

  test("a sublemma shows none of its entry's details, and the entry's own lemma does", () {
    LemmaChoice ofCicero(String sublemma) => LemmaChoice(
      entryRef: 'Cicero',
      dictionaryRefs: const ['Cicero'],
      sublemma: sublemma,
      partOfSpeech: 'noun',
      inflection: 'ōnis, m.',
    );

    expect(lemmaDetails(ofCicero('')), allOf(contains('noun'), contains('ōnis, m.')));
    expect(lemmaDetails(ofCicero('Ciceronianus')), isEmpty);
  });

  test('declensions are listed in order, with 1st & 2nd after 1st', () {
    expect(
      grammarOrder(['5th', '1st & 2nd', '3rd', '2nd', '1st', '4th']),
      ['1st', '1st & 2nd', '2nd', '3rd', '4th', '5th'],
    );
  });
}
