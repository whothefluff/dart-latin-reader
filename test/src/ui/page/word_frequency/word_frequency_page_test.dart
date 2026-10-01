import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/settings/frequency_filter_settings_api.dart';
import 'package:latin_reader/src/component/settings/frequency_settings_api.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/ui/page/word_frequency/word_frequency_page.dart';

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

void _usePhone(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(1080, 2340)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

Finder _row(String label) => find.ancestor(of: find.text(label), matching: find.byType(Row)).first;

Finder _cell(Finder row, String text) => find.descendant(of: row, matching: find.text(text));

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

    testWidgets('the coverage column is headed COVER.', (tester) async {
      await _pumpPage(tester, corpus.db, _byForm, view: _anyCandidateView);

      expect(find.text('COVER.'), findsOneWidget);
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
      testWidgets('COVER. and CERT. each have a column', (tester) async {
        await _pumpPage(tester, corpus.db, _byLemma, view: _anyCandidateView);

        expect(find.text('COVER.'), findsOneWidget);
        expect(find.text('CERT.'), findsOneWidget);
      });

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

        expect(find.textContaining('Any candidate'), findsNothing);
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

          expect(find.text('Certain: 33.3% · Any candidate: 83.3%'), findsOneWidget);
        });
      }
    });
  });
}
