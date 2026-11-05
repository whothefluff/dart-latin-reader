import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/component/settings/frequency_filter_settings_api.dart';
import 'package:latin_reader/src/component/settings/frequency_settings_api.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/ui/page/word_frequency/word_frequency_page.dart';
import 'package:latin_reader/src/ui/widget/lemma_text.dart';

import '../../../component/word_frequency/frequency_corpus.dart';

class _InMemoryFilters extends FrequencyFilterSettingsNotifier {
  _InMemoryFilters(
    this._settings,
  );

  final FrequencyFilterSettings _settings;

  @override
  Future<FrequencyFilterSettings> build() async => _settings;
  //
}

class _InMemoryView extends FrequencyViewSettingsNotifier {
  _InMemoryView(
    this._settings,
  );

  final FrequencySettings _settings;

  @override
  Future<FrequencySettings> build() async => _settings;
  //
}

// Keep ProviderScope directly inside pumpWidget for riverpod_lint.
Future<void> _pumpPage(
  WidgetTester tester,
  AppDb db,
  FrequencyFilterSettings filters, {
  required FrequencySettings view,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        dbProvider.overrideWith((_) => db),
        frequencyFilterSettingsNotifierProvider.overrideWith(() => _InMemoryFilters(filters)),
        frequencyViewSettingsNotifierProvider.overrideWith(() => _InMemoryView(view)),
      ],
      child: const MaterialApp(home: WordFrequencyPage()),
    ),
  );
  await tester.pumpAndSettle();
}

/// Stands in for a page that the frequency page opens, to tell where it went
class _Opened extends StatelessWidget {
  const _Opened(this.state);

  final GoRouterState state;

  @override
  Widget build(context) => const Scaffold();
  //
}

/// Shows the page in a router, with stand-ins for the pages that a row opens
Future<void> _pumpRoutedPage(
  WidgetTester tester,
  AppDb db,
  FrequencyFilterSettings filters, {
  required FrequencySettings view,
}) async {
  final router = GoRouter(
    initialLocation: '/word-frequency',
    routes: [
      GoRoute(path: '/word-frequency', builder: (_, _) => const WordFrequencyPage()),
      GoRoute(
        path: '/dictionaries/:dictionaryId/entries/:entryKey',
        builder: (_, state) => _Opened(state),
      ),
      GoRoute(path: '/morph-detail/:keys', builder: (_, state) => _Opened(state)),
      GoRoute(path: '/concordance/hits', builder: (_, state) => _Opened(state)),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        dbProvider.overrideWith((_) => db),
        frequencyFilterSettingsNotifierProvider.overrideWith(() => _InMemoryFilters(filters)),
        frequencyViewSettingsNotifierProvider.overrideWith(() => _InMemoryView(view)),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

/// Returns the route of the page that the frequency page opened.
GoRouterState _opened(WidgetTester tester) => tester.widget<_Opened>(find.byType(_Opened)).state;

void _usePhone(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(1080, 2340)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

Finder _row(String label) => find.ancestor(of: find.text(label), matching: find.byType(Row)).first;

Finder _cell(Finder row, String text) => find.descendant(of: row, matching: find.text(text));

/// A single text with both of sum¹'s coverages, certain first.
Finder get _bothCoveragesOfSum => find.textContaining(RegExp(r'33\.3%.*83\.3%'));

/// Set explicitly so the tests don't depend on the defaults
const _byForm = FrequencyFilterSettings(
  pageSize: 50,
  ascending: false,
  groupByLemma: false,
  showMacrons: true,
);

/// Set explicitly so the tests don't depend on the defaults
const _byLemma = FrequencyFilterSettings(
  pageSize: 50,
  ascending: false,
  groupByLemma: true,
  showMacrons: true,
);

/// Set explicitly so the tests don't depend on the defaults
const _anyCandidateView = FrequencySettings(
  showSummary: true,
  formTapAction: FormTapAction.ask,
  narrowLemmaCoverage: NarrowLemmaCoverage.anyCandidate,
);

void main() {
  late FrequencyCorpus corpus;

  setUp(() async {
    corpus = FrequencyCorpus();
    await corpus.addWork(fables);
  });

  tearDown(() => corpus.close());

  group('by form', () {
    setUp(() async {
      await corpus.addWord(fables, 'et', times: 2);
      await corpus.addWord(fables, 'in');
      await corpus.populate();
    });

    testWidgets('there is no CERT., since each unit has exactly one form', (tester) async {
      await _pumpPage(tester, corpus.db, _byForm, view: _anyCandidateView);

      expect(find.text('CERT.'), findsNothing);
    });

    testWidgets('each row shows its coverage, rounded down', (tester) async {
      await _pumpPage(tester, corpus.db, _byForm, view: _anyCandidateView);

      expect(_cell(_row('et'), '66.6%'), findsOneWidget);
      expect(_cell(_row('in'), '100.0%'), findsOneWidget);
    });

    testWidgets('reversing the order leaves each row its coverage', (tester) async {
      await _pumpPage(
        tester,
        corpus.db,
        _byForm.copyWith(ascending: true),
        view: _anyCandidateView,
      );

      expect(_cell(_row('in'), '100.0%'), findsOneWidget);
      expect(_cell(_row('et'), '66.6%'), findsOneWidget);
    });
  });

  group('by lemma', () {
    // At sum1's threshold, est is possibly covered; only sunt is certainly covered.
    setUp(() async {
      await corpus.addWord(fables, 'est', times: 3);
      await corpus.addWord(fables, 'sunt', times: 2);
      await corpus.addWord(fables, 'edit');
      await corpus.addAnalysis('est', 'sum1');
      await corpus.addAnalysis('est', 'edo1');
      await corpus.addAnalysis('sunt', 'sum1');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.populate();
    });

    group('with room for both', () {
      testWidgets('a lemma adds only the units no more frequent lemma covers', (tester) async {
        await _pumpPage(tester, corpus.db, _byLemma, view: _anyCandidateView);

        expect(_cell(_row('sum¹'), '83.3%'), findsOneWidget);
        expect(_cell(_row('edo¹'), '100.0%'), findsNWidgets(2));
      });

      testWidgets('certain coverage waits for every candidate lemma', (tester) async {
        await _pumpPage(tester, corpus.db, _byLemma, view: _anyCandidateView);

        expect(_cell(_row('sum¹'), '33.3%'), findsOneWidget);
      });

      testWidgets('a long press shows nothing the columns do not', (tester) async {
        await _pumpPage(tester, corpus.db, _byLemma, view: _anyCandidateView);

        await tester.longPress(_row('sum¹'));
        await tester.pumpAndSettle();

        expect(_bothCoveragesOfSum, findsNothing);
      });
    });

    group('on a phone', () {
      testWidgets('any-candidate coverage is shown alone', (tester) async {
        _usePhone(tester);

        await _pumpPage(tester, corpus.db, _byLemma, view: _anyCandidateView);

        expect(find.text('COVER.'), findsOneWidget);
        expect(find.text('CERT.'), findsNothing);
        expect(_cell(_row('sum¹'), '83.3%'), findsOneWidget);
        expect(find.text('33.3%'), findsNothing);
      });

      testWidgets('the setting shows certain coverage instead', (tester) async {
        _usePhone(tester);

        await _pumpPage(
          tester,
          corpus.db,
          _byLemma,
          view: _anyCandidateView.copyWith(narrowLemmaCoverage: NarrowLemmaCoverage.certain),
        );

        expect(find.text('CERT.'), findsOneWidget);
        expect(find.text('COVER.'), findsNothing);
        expect(_cell(_row('sum¹'), '33.3%'), findsOneWidget);
        expect(find.text('83.3%'), findsNothing);
      });

      for (final shown in NarrowLemmaCoverage.values) {
        testWidgets('a long press on a row shows both (${shown.name} in the column)', (
          tester,
        ) async {
          _usePhone(tester);
          await _pumpPage(
            tester,
            corpus.db,
            _byLemma,
            view: _anyCandidateView.copyWith(narrowLemmaCoverage: shown),
          );

          await tester.longPress(_row('sum¹'));
          await tester.pumpAndSettle();

          expect(_bothCoveragesOfSum, findsOneWidget);
        });
      }
    });
  });

  group('rows with sublemmas', () {
    // bonīs may be bonus or its sublemma bonae, Cybeleia only Cybele's sublemma Cybeleius
    setUp(() async {
      await corpus.addWord(fables, 'bonis', times: 2, macronizedWord: 'bonīs');
      await corpus.addWord(fables, 'Cybeleia', properNounState: ProperNounState.proper);
      await corpus.addAnalysis('bonis', 'bonus', macronizedForm: 'bonīs');
      await corpus.addAnalysis('bonis', 'bonus', sublemma: 'bonae', macronizedForm: 'bonīs');
      await corpus.addAnalysis('Cybeleia', 'Cybele', sublemma: 'Cybeleius');
      await corpus.addLnsEntry('bonus', 'bonus');
      await corpus.addLnsEntry('Cybele', 'Cybele');
      await corpus.populate();
    });

    testWidgets('by lemma, a sublemma opens its entry in the dictionary', (tester) async {
      await _pumpRoutedPage(
        tester,
        corpus.db,
        _byLemma,
        view: _anyCandidateView.copyWith(formTapAction: FormTapAction.openDictionary),
      );

      await tester.tap(find.text(lemmaLabel('Cybele', 'Cybeleius')));
      await tester.pumpAndSettle();

      expect(_opened(tester).pathParameters['entryKey'], 'Cybele');
    });

    testWidgets('by lemma, a sublemma searches the concordance for itself', (
      tester,
    ) async {
      await _pumpRoutedPage(
        tester,
        corpus.db,
        _byLemma,
        view: _anyCandidateView.copyWith(formTapAction: FormTapAction.openConcordance),
      );

      await tester.tap(find.text(lemmaLabel('bonus', 'bonae')));
      await tester.pumpAndSettle();

      final query = ConcordanceQuery.fromJson(_opened(tester).uri.queryParameters['search']!);
      expect(
        query.slots.single,
        isA<LemmaCriterion>()
            .having((criterion) => criterion.lemma.dictionaryRefs, 'dictionaryRefs', ['bonus'])
            .having((criterion) => criterion.lemma.sublemma, 'sublemma', 'bonae'),
      );
    });

    for (final showMacrons in [true, false]) {
      testWidgets(
        "by form, morphology offers the form's lemmas and opens the chosen one's analyses "
        '(macrons: $showMacrons)',
        (tester) async {
          await _pumpRoutedPage(
            tester,
            corpus.db,
            _byForm.copyWith(showMacrons: showMacrons),
            view: _anyCandidateView.copyWith(formTapAction: FormTapAction.openMorphology),
          );

          await tester.tap(find.text(showMacrons ? 'bonīs' : 'bonis'));
          await tester.pumpAndSettle();

          expect(find.widgetWithText(ListTile, lemmaLabel('bonus', '')), findsOneWidget);

          await tester.tap(find.widgetWithText(ListTile, lemmaLabel('bonus', 'bonae')));
          await tester.pumpAndSettle();

          expect(
            AnalysisKeys.fromJson(_opened(tester).pathParameters['keys']!),
            AnalysisKeys(const [AnalysisKey(form: 'bonis', item: 1, cnt: 0)]),
          );
        },
      );
    }

    testWidgets('by form, the dictionary opens the one entry of both lemmas, with no choice', (
      tester,
    ) async {
      await _pumpRoutedPage(
        tester,
        corpus.db,
        _byForm,
        view: _anyCandidateView.copyWith(formTapAction: FormTapAction.openDictionary),
      );

      await tester.tap(find.text('bonīs'));
      await tester.pumpAndSettle();

      expect(_opened(tester).pathParameters['entryKey'], 'bonus');
    });
  });
}
