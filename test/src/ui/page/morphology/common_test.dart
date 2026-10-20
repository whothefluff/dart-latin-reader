import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/morph_analysis/enriched_morph_details_api.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/ui/page/morphology/common.dart';

final _romani = AnalysisKeys(const [AnalysisKey(form: 'Romani', item: 0, cnt: 0)]);

void main() {
  group('MorphologicalDataView', () {
    testWidgets('a lemma without an L&S entry shows that the dictionary has none', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            enrichedMorphologicalAnalysesProvider(_romani).overrideWith(
              (_) => EnrichedAnalyses(const [
                EnrichedAnalysis(
                  base: Analysis(
                    form: 'Romani',
                    item: 0,
                    cnt: 0,
                    macronizedForm: 'Rōmānī',
                    dictionaryRef: 'Romanus',
                    partOfSpeech: 'adjective',
                    stem: 'Rōmān',
                    suffix: 'ī',
                  ),
                  lns: null,
                ),
              ]),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(body: MorphologicalDataView(keys: _romani)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('View in Dictionary'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
