import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';
import 'package:latin_reader/src/ui/router/config.dart';

void main() {
  test('reader and concordance URLs keep positions and every criterion', () {
    final reader = Uri.parse(
      const ReaderRoute('work', startingPoint: 42, highlights: [43, 45]).location,
    );
    expect(reader.path, '/library/reader/work');
    expect(reader.queryParameters['starting-point'], '42');
    expect(reader.queryParametersAll['highlights'], ['43', '45']);
    final query = ConcordanceQuery(
      slots: [
        const FormCriterion('rosā', exactCase: true, exactLetters: true),
        LemmaCriterion(
          LemmaChoice(entryRef: 'sum1', dictionaryRefs: const ['sum1', 'esum'], sublemma: ''),
        ),
        GrammarCriterion(
          GrammarFilter(const {
            GrammarFeature.partOfSpeech: 'adjective',
            GrammarFeature.declension: '1st & 2nd',
          }),
          lemma: LemmaChoice(
            entryRef: 'Dardanus1',
            dictionaryRefs: const ['Dardanus1'],
            sublemma: 'Dardanius',
          ),
        ),
      ],
      distances: const [null, 3],
      matchMacrons: true,
    );
    final hits = Uri.parse(ConcordanceHitsRoute(search: query.toJson(), offset: 50).location);
    final read = ConcordanceQuery.fromJson(hits.queryParameters['search']!);
    expect(read, query);
    expect(
      read.slots.last,
      isA<GrammarCriterion>().having((grammar) => grammar.lemma?.sublemma, 'sublemma', 'Dardanius'),
    );
    expect(hits.queryParameters['offset'], '50');
  });
}
