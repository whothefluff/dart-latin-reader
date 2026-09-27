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
        const FormCriterion('rosā'),
        LemmaCriterion(LemmaChoice(label: 'sum1', dictionaryRefs: const ['sum1', 'esum'])),
        GrammarCriterion(
          GrammarFilter(const {
            GrammarFeature.partOfSpeech: 'adjective',
            GrammarFeature.declension: '1st & 2nd',
          }),
        ),
      ],
      distances: const [null, 3],
      matchMacrons: true,
    );
    final hits = Uri.parse(ConcordanceHitsRoute(search: query.toJson(), offset: 50).location);
    expect(ConcordanceQuery.fromJson(hits.queryParameters['search']!), query);
    expect(hits.queryParameters['offset'], '50');
  });
}
