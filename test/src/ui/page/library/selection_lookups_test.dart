import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';
import 'package:latin_reader/src/component/library/subdivision_type.dart';
import 'package:latin_reader/src/component/library/work_contents_api.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:latin_reader/src/ui/page/library/selection_lookups.dart';

WorkContentsSegment _segment(
  int idx,
  String word, {
  String line = 'line 2',
  String? baseNormForm,
  ProperNounState? state,
}) => WorkContentsSegment(
  workId: 'fables',
  parent: null,
  node: line,
  idx: idx,
  word: word,
  macronizedWord: word,
  uncertaintyBitMask: 0,
  typ: SubdivisionType.verse,
  depth: 1,
  lookupForm: word,
  macronLookupForm: word,
  baseNormForm: baseNormForm ?? word.toLowerCase(),
  properNounState: state,
  sourceReference: '1',
);

/// Displays an empty page and returns its [BuildContext].
Future<BuildContext> _pumpPage(WidgetTester tester) async {
  late BuildContext pageContext;
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              pageContext = context;
              return const SizedBox.expand();
            },
          ),
        ),
      ),
    ),
  );
  return pageContext;
}

void main() {
  group('LookupMenuButton', () {
    testWidgets('the chosen entry runs once the selection toolbar is gone', (tester) async {
      final pageContext = await _pumpPage(tester);
      final opened = <String>[];
      final toolbar = ContextMenuController();
      addTearDown(toolbar.remove);
      toolbar.show(
        context: pageContext,
        contextMenuBuilder: (_) => AdaptiveTextSelectionToolbar.buttonItems(
          anchors: const TextSelectionToolbarAnchors(primaryAnchor: Offset(200, 200)),
          buttonItems: [
            LookupMenuButton(
              label: 'Wiktionary',
              anchor: const Offset(200, 200),
              pageContext: pageContext,
              choices: [
                (label: 'Venere', open: () async => opened.add('Venere')),
                (label: 'venere', open: () async => opened.add('venere')),
              ],
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Wiktionary ›'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('venere'));
      await tester.pumpAndSettle();

      expect(opened, ['venere']);
    });
  });

  group('lookUpThenOpen', () {
    testWidgets('opens what the lookup found', (tester) async {
      final pageContext = await _pumpPage(tester);
      final opened = <String>[];

      await lookUpThenOpen(
        pageContext,
        lookUp: () async => 'amo',
        open: (found) async => opened.add(found),
      );
      await tester.pumpAndSettle();

      expect(opened, ['amo']);
      expect(find.byType(SnackBar), findsNothing);
    });

    testWidgets('a retry runs again the cached provider that made the lookup fail', (tester) async {
      var dependencyRuns = 0;
      final dependency = FutureProvider.autoDispose<String>((ref) async {
        ref.keepAlive();
        dependencyRuns++;
        return dependencyRuns == 1 ? throw Exception('database is locked') : 'amo';
      });
      final lookup = FutureProvider.autoDispose<String>((ref) async {
        ref.keepAlive();
        return ref.watch(dependency.future);
      });
      final pageContext = await _pumpPage(tester);
      final container = ProviderScope.containerOf(pageContext, listen: false);
      final opened = <String>[];

      await lookUpThenOpen(
        pageContext,
        lookUp: () => container.readRetryingFailures(lookup),
        open: (found) async => opened.add(found),
      );
      await tester.pumpAndSettle();

      expect(opened, isEmpty);
      await tester.tap(find.byType(SnackBarAction));
      await tester.pumpAndSettle();

      expect(opened, ['amo']);
    });
  });

  group('isMacronizedAs', () {
    test('every vowel must have the same quantity, marked in the text or not', () {
      expect(isMacronizedAs('venīre', form: 'venire', macronizedForm: 'venīre'), isTrue);
      expect(isMacronizedAs('venīre', form: 'venire', macronizedForm: 'vēnīre'), isFalse);
      expect(isMacronizedAs('vēnit', form: 'venit', macronizedForm: 'venit'), isFalse);
    });

    test('an enclitic Morpheus leaves out of its spelling is taken from the form', () {
      expect(isMacronizedAs('longēque', form: 'longeque', macronizedForm: 'longē'), isTrue);
    });

    test('case does not matter, macronized letters included', () {
      expect(isMacronizedAs('Ēsca', form: 'esca', macronizedForm: 'ēsca'), isTrue);
    });

    test('j counts as i, in the text or in the analysis', () {
      expect(isMacronizedAs('Iūnō', form: 'Iuno', macronizedForm: 'Jūnō'), isTrue);
      expect(isMacronizedAs('Jūnō', form: 'Juno', macronizedForm: 'Iūnō'), isTrue);
    });
  });

  group('wiktionaryPagesOf', () {
    test('a word with a proper-noun state is looked up as the state says', () {
      final lupus = _segment(1, 'Lupus', baseNormForm: 'lupus', state: ProperNounState.common);
      expect(wiktionaryPagesOf(lupus, [lupus]), {'lupus'});
    });

    test('a capitalized word with no state is looked up capitalized', () {
      final line = [_segment(1, 'dixi'), _segment(2, ','), _segment(3, 'Eutyche')];
      expect(wiktionaryPagesOf(line.last, line), {'Eutyche'});
    });

    test('and in lowercase too where any word would be capitalized', () {
      final lineStart = [_segment(1, 'sunt', line: 'line 1'), _segment(2, 'Venantum')];
      final afterColon = [
        _segment(1, 'dixit'),
        _segment(2, ':'),
        _segment(3, '"'),
        _segment(4, 'Philete'),
      ];
      final afterDash = [_segment(1, 'ait'), _segment(2, '—'), _segment(3, 'Philete')];
      final afterCapital = [_segment(1, 'Marce'), _segment(2, 'Philete')];
      expect(wiktionaryPagesOf(lineStart.last, lineStart), {'Venantum', 'venantum'});
      expect(wiktionaryPagesOf(afterColon.last, afterColon), {'Philete', 'philete'});
      expect(wiktionaryPagesOf(afterDash.last, afterDash), {'Philete', 'philete'});
      expect(wiktionaryPagesOf(afterCapital.last, afterCapital), {'Philete', 'philete'});
    });

    test('a capitalized word only counts right before it', () {
      final line = [_segment(1, 'Marce'), _segment(2, ','), _segment(3, 'Philete')];
      expect(wiktionaryPagesOf(line.last, line), {'Philete'});
    });

    test('a lowercase word with no state is looked up in lowercase', () {
      final line = [_segment(1, 'Et'), _segment(2, 'buvile')];
      expect(wiktionaryPagesOf(line.last, line), {'buvile'});
    });
  });
}
