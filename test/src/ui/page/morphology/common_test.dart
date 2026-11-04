import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/dictionary/dictionaries_api.dart';
import 'package:latin_reader/src/component/dictionary/lewis_and_short_api.dart';
import 'package:latin_reader/src/component/dictionary/lewis_and_short_basic_info_api.dart';
import 'package:latin_reader/src/component/morph_analysis/enriched_morph_details_api.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/ui/page/morphology/common.dart';

final _romani = AnalysisKeys(const [AnalysisKey(form: 'Romani', item: 0, cnt: 0)]);

/// Returns an analysis of [form] under Cicero with [sublemma] ('' for the entry's own lemma),
/// whose L&S entry has the inflection that [_entrysInflection] finds.
EnrichedAnalysis _ofCicero(
  String form, {
  required String sublemma,
  required String partOfSpeech,
}) => EnrichedAnalysis(
  base: Analysis(
    form: form,
    item: 0,
    cnt: 0,
    macronizedForm: form,
    dictionaryRef: 'Cicero',
    sublemma: sublemma,
    partOfSpeech: partOfSpeech,
    stem: form,
  ),
  lns: const LnsBasicInfoEntry(lemma: 'Cicero', inflection: 'ōnis, m.', partOfSpeech: 'noun'),
);

final EnrichedAnalysis _ciceronis = _ofCicero(
  'Ciceronis',
  sublemma: '',
  partOfSpeech: 'noun',
);
final EnrichedAnalysis _ciceroniani = _ofCicero(
  'Ciceroniani',
  sublemma: 'Ciceronianus',
  partOfSpeech: 'adjective',
);
final Finder _entrysInflection = find.textContaining('ōnis, m.');

/// Stands in for the dictionary entry that the card opens
class _OpenedEntry extends StatelessWidget {
  const _OpenedEntry(this.lemma);

  final String lemma;

  @override
  Widget build(context) => const Scaffold();
  //
}

/// Shows the card of [analysis] in a router, to check where its dictionary link goes
Future<void> _pumpCard(WidgetTester tester, EnrichedAnalysis analysis) async {
  final keys = AnalysisKeys([
    AnalysisKey(form: analysis.form, item: analysis.item, cnt: analysis.cnt),
  ]);
  final router = GoRouter(
    initialLocation: '/morph-detail',
    routes: [
      GoRoute(
        path: '/morph-detail',
        builder: (_, _) => Scaffold(body: MorphologicalDataView(keys: keys)),
      ),
      GoRoute(
        path: '/dictionaries/:dictionaryId/entries/:lemma',
        builder: (_, state) => _OpenedEntry(state.pathParameters['lemma']!),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        enrichedMorphologicalAnalysesProvider(keys).overrideWith(
          (_) => EnrichedAnalyses([analysis]),
        ),
        lewisAndShortDictionaryProvider.overrideWith(
          (_) => Dictionary(
            id: '00000000-0000-0000-0000-00000000000d',
            name: 'Lewis & Short',
            language: 'Latin',
            publisher: '',
            publicationDate: DateTime(1879),
            numberOfEntries: 1,
          ),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

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
                    sublemma: '',
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

    testWidgets("an entry's own lemma shows the entry's L&S inflection", (tester) async {
      await _pumpCard(tester, _ciceronis);

      expect(_entrysInflection, findsOneWidget);
    });

    testWidgets("a sublemma shows none of its entry's inflection", (tester) async {
      await _pumpCard(tester, _ciceroniani);

      expect(_entrysInflection, findsNothing);
    });

    testWidgets('a sublemma opens its entry in the dictionary', (tester) async {
      await _pumpCard(tester, _ciceroniani);

      await tester.tap(find.text('View in Dictionary'));
      await tester.pumpAndSettle();

      expect(tester.widget<_OpenedEntry>(find.byType(_OpenedEntry)).lemma, 'Cicero');
    });
  });
}
