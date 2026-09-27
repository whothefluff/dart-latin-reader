import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';
import 'package:latin_reader/src/ui/page/concordance/common.dart';

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

  test('declensions are listed in order, with 1st & 2nd after 1st', () {
    expect(
      grammarOrder(['5th', '1st & 2nd', '3rd', '2nd', '1st', '4th']),
      ['1st', '1st & 2nd', '2nd', '3rd', '4th', '5th'],
    );
  });
}
