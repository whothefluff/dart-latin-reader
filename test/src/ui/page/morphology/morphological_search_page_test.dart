import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/dictionary/lewis_and_short_basic_info_api.dart';
import 'package:latin_reader/src/component/morph_analysis/enriched_morph_search_api.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_search_api.dart';
import 'package:latin_reader/src/ui/page/morphology/morphological_search_page.dart';
import 'package:latin_reader/src/ui/widget/lemma_text.dart';

EnrichedResult _result(
  String form, {
  int item = 0,
  String macronizedForm = 'amō',
  String dictionaryRef = 'amo',
  String sublemma = '',
  required String partOfSpeech,
  String? additional,
}) => EnrichedResult(
  base: Result(
    form: form,
    macronizedForm: macronizedForm,
    partOfSpeech: partOfSpeech,
    dictionaryRef: dictionaryRef,
    sublemma: sublemma,
    additional: additional,
    item: item,
    cnt: 0,
  ),
  lns: LnsBasicInfoEntry(key: dictionaryRef),
);

/// Three analyses: `amo` and `amoque` show the same reading, the third a different one
final _amo = EnrichedResults([
  _result('amo', partOfSpeech: 'verb'),
  _result('amoque', partOfSpeech: 'verb'),
  _result('amo', item: 1, partOfSpeech: 'noun', additional: '2nd declension'),
]);

/// Latinis as two nouns under Latium, one of the entry's own lemma and one of its sublemma Latini.
final _latinis = EnrichedResults([
  _result('Latinis', macronizedForm: 'Latīnīs', dictionaryRef: 'Latium', partOfSpeech: 'noun'),
  _result(
    'Latinis',
    item: 1,
    macronizedForm: 'Latīnīs',
    dictionaryRef: 'Latium',
    sublemma: 'Latini',
    partOfSpeech: 'noun',
  ),
]);

/// Shows the page in a router, to check where picking a reading goes. Searching `amo` returns
/// what [amo] returns, and searching `Latinis` returns [_latinis]
Future<GoRouter> _pumpPage(
  WidgetTester tester, {
  required FutureOr<EnrichedResults> Function() amo,
}) async {
  final router = GoRouter(
    initialLocation: '/morph-search',
    routes: [
      GoRoute(
        path: '/morph-search',
        builder: (_, _) => const MorphologicalSearchPage(keys: null),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        enrichedMorphologicalSearchProvider('').overrideWith((_) => EnrichedResults(const [])),
        enrichedMorphologicalSearchProvider('amo').overrideWith((_) => amo()),
        enrichedMorphologicalSearchProvider('Latinis').overrideWith((_) => _latinis),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

Future<void> _search(WidgetTester tester, String text) async {
  await tester.tap(find.byType(SearchBar));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).last, text);
  await tester.pumpAndSettle();
}

AnalysisKeys? _openedKeys(GoRouter router) =>
    switch (router.routerDelegate.currentConfiguration.uri.queryParameters['keys']) {
      final keys? => AnalysisKeys.fromJson(keys),
      null => null,
    };

void main() {
  group('MorphologicalSearchPage', () {
    testWidgets('an empty search suggests nothing', (tester) async {
      await _pumpPage(tester, amo: () => _amo);
      await tester.tap(find.byType(SearchBar));
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('suggests each distinct reading once', (tester) async {
      await _pumpPage(tester, amo: () => _amo);
      await _search(tester, 'amo');

      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('the text is searched without surrounding spaces', (tester) async {
      await _pumpPage(tester, amo: () => _amo);
      await _search(tester, '  amo ');

      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('picking a reading opens every analysis behind it', (tester) async {
      final router = await _pumpPage(tester, amo: () => _amo);
      await _search(tester, 'amo');

      await tester.tap(find.widgetWithText(ListTile, 'verb'));
      await tester.pumpAndSettle();

      expect(
        _openedKeys(router),
        AnalysisKeys(const [
          AnalysisKey(form: 'amo', item: 0, cnt: 0),
          AnalysisKey(form: 'amoque', item: 0, cnt: 0),
        ]),
      );
    });

    testWidgets('picking the other reading opens only its analysis', (tester) async {
      final router = await _pumpPage(tester, amo: () => _amo);
      await _search(tester, 'amo');

      await tester.tap(find.widgetWithText(ListTile, 'noun • 2nd declension'));
      await tester.pumpAndSettle();

      expect(_openedKeys(router), AnalysisKeys(const [AnalysisKey(form: 'amo', item: 1, cnt: 0)]));
    });

    testWidgets('two lemmas with one form and part of speech are two suggestions', (tester) async {
      final router = await _pumpPage(tester, amo: () => _amo);
      await _search(tester, 'Latinis');

      expect(find.byType(ListTile), findsNWidgets(2));

      await tester.tap(find.textContaining(lemmaLabel('Latium', 'Latini')));
      await tester.pumpAndSettle();

      expect(
        _openedKeys(router),
        AnalysisKeys(const [AnalysisKey(form: 'Latinis', item: 1, cnt: 0)]),
      );
    });

    testWidgets('results that arrive after the text changed are not shown', (tester) async {
      final pending = Completer<EnrichedResults>();
      await _pumpPage(tester, amo: () => pending.future);
      await tester.tap(find.byType(SearchBar));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'amo');
      await tester.pump();
      await tester.enterText(find.byType(TextField).last, '');
      await tester.pump();

      pending.complete(_amo);
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('a failed search shows its error, and retrying shows the results', (tester) async {
      var searches = 0;
      await _pumpPage(
        tester,
        amo: () {
          searches++;
          return searches == 1 ? throw Exception('no database') : _amo;
        },
      );
      await _search(tester, 'amo');

      expect(find.byType(ListTile), findsNothing);

      await tester.tap(find.widgetWithText(TextButton, 'Retry'));
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(2));
    });
  });
}
