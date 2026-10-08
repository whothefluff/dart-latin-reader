import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/dictionary/dictionary_entries_api.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entries_page.dart';
import 'package:latin_reader/src/ui/widget/lemma_text.dart';

Entry _entry(String lemma) =>
    Entry(dictionary: 'ls', lemma: lemma, inflection: null, partOfSpeech: null, numberOfSenses: 1);

/// Dictionary entries with `sum1` and `sum2` at indices 40 and 41.
final List<Entry> _entries = List.generate(
  60,
  (index) => _entry(switch (index) {
    40 => 'sum1',
    41 => 'sum2',
    _ => 'entry$index',
  }),
);

DictionaryEntries _allEntries() => DictionaryEntries(_entries);

/// Search results for each query, in result order.
final Map<String, List<Entry>> _found = {
  '': [],
  'sum': [_entry('sum2'), _entry('sum1')],
  'entry': [_entry('entry0'), _entry('entry59')],
  'missing': [_entry('missing')],
};

final _dark = ThemeData(brightness: Brightness.dark);

final _compact = ThemeData(visualDensity: VisualDensity.compact);

final Matcher _highlighted = isNot(Colors.transparent);

/// A minimal definition page that records the route's lemma.
class _Definition extends StatelessWidget {
  const _Definition(this.lemma);

  final String lemma;

  @override
  Widget build(context) => Scaffold(appBar: AppBar());
}

/// A search override returning [found] for [text].
Override _searching(String text, List<Entry> found) =>
    dictionaryEntriesSearchProvider('ls', text).overrideWith((_) => DictionaryEntries(found));

/// Shows the dictionary page and returns its theme notifier.
Future<ValueNotifier<ThemeData>> _pumpPage(
  WidgetTester tester, {
  FutureOr<DictionaryEntries> Function() entries = _allEntries,
}) async {
  final router = GoRouter(
    initialLocation: '/dictionaries/ls',
    routes: [
      GoRoute(
        path: '/dictionaries/:dictionaryId',
        builder: (_, _) => const DictionaryEntriesPage('ls'),
        routes: [
          GoRoute(
            path: 'entries/:lemma',
            builder: (_, state) => _Definition(state.pathParameters['lemma']!),
          ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);
  final theme = ValueNotifier(ThemeData());
  addTearDown(theme.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        dictionaryEntriesProvider('ls').overrideWith((_) => entries()),
        ..._found.entries.map((found) => _searching(found.key, found.value)),
      ],
      child: ValueListenableBuilder(
        valueListenable: theme,
        builder: (_, themeData, _) => MaterialApp.router(routerConfig: router, theme: themeData),
      ),
    ),
  );
  await tester.pump();
  return theme;
}

Future<void> _search(WidgetTester tester, String text) async {
  await tester.tap(find.byType(SearchBar));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).last, text);
  await tester.pumpAndSettle();
}

/// Row text, including the trailing space for the empty inflection.
String _title(String lemma) => '${lemmaText(lemma)} ';

Finder _row(String lemma) => find.descendant(
  of: find.byType(ListView),
  matching: find.widgetWithText(ListTile, _title(lemma)),
);

Finder _result(String lemma) => find.descendant(
  of: find.byType(CustomScrollView),
  matching: find.widgetWithText(ListTile, _title(lemma)),
);

Finder _browseButton(String lemma) =>
    find.descendant(of: _result(lemma), matching: find.byType(IconButton));

ScrollPosition _position(WidgetTester tester) {
  final list = find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable));
  return tester.state<ScrollableState>(list).position;
}

/// Vertical offset of [lemma]'s row from the top of the list.
double _rowTop(WidgetTester tester, String lemma) =>
    tester.getTopLeft(_row(lemma)).dy - tester.getTopLeft(find.byType(ListView)).dy;

/// The gap below [lemma]'s row, measured to the list's bottom edge.
double _spaceBelow(WidgetTester tester, String lemma) =>
    tester.getBottomLeft(find.byType(ListView)).dy - tester.getBottomLeft(_row(lemma)).dy;

Color? _rowColor(WidgetTester tester, String lemma) =>
    tester.widget<ListTile>(_row(lemma)).tileColor;

/// [lemma]'s row colors, sampled on the next frame and every 50 ms for [duration].
Future<List<Color?>> _rowColorsOver(WidgetTester tester, String lemma, Duration duration) async {
  const frame = Duration(milliseconds: 50);
  final colors = <Color?>[];
  await Future.forEach(
    [Duration.zero, ...List.filled(duration.inMilliseconds ~/ frame.inMilliseconds, frame)],
    (wait) async {
      await tester.pump(wait);
      colors.add(_rowColor(tester, lemma));
    },
  );
  return colors;
}

void main() {
  group('DictionaryEntriesPage', () {
    testWidgets('shows an empty dictionary as an empty list', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dictionaryEntriesProvider('ls').overrideWith((_) => DictionaryEntries(const [])),
          ],
          child: const MaterialApp(home: DictionaryEntriesPage('ls')),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(
        find.descendant(of: find.byType(ListView), matching: find.byType(ListTile)),
        findsNothing,
      );
    });

    testWidgets('picking a search result opens its entry, and Back shows the list at it', (
      tester,
    ) async {
      await _pumpPage(tester);
      await _search(tester, 'sum');

      await tester.tap(_result('sum1'));
      await tester.pumpAndSettle();
      expect(find.byType(_Definition, skipOffstage: false), findsOneWidget);
      expect(tester.widget<_Definition>(find.byType(_Definition)).lemma, 'sum1');

      // Let the initial hold expire behind the definition page
      await tester.pump(searchResultHighlight.hold);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(_Definition, skipOffstage: false), findsNothing);
      expect(_rowTop(tester, 'entry39'), 0);
      expect(_rowColor(tester, 'sum1'), _highlighted);
    });

    testWidgets('browsing from a search result scrolls the list to it without opening it', (
      tester,
    ) async {
      await _pumpPage(tester);
      await _search(tester, 'sum');

      await tester.tap(_browseButton('sum1'));
      await tester.pump(); // start the scroll animation
      await tester.pump(const Duration(milliseconds: 16));
      final partway = _position(tester).pixels;
      await tester.pumpAndSettle();

      expect(partway, allOf(greaterThan(0), lessThan(_position(tester).pixels)));
      expect(find.byType(CustomScrollView), findsNothing);
      expect(find.byType(_Definition, skipOffstage: false), findsNothing);
      expect(_rowTop(tester, 'entry39'), 0);
      expect(_rowColor(tester, 'sum1'), _highlighted);
    });

    testWidgets('browsing from a homograph goes to that homograph', (tester) async {
      await _pumpPage(tester);
      await _search(tester, 'sum');

      await tester.tap(_browseButton('sum2'));
      await tester.pumpAndSettle();

      expect(_rowTop(tester, 'sum1'), 0);
      expect(_rowColor(tester, 'sum1'), Colors.transparent);
      expect(_rowColor(tester, 'sum2'), _highlighted);
    });

    testWidgets(
      'browsing from the first or the last entry scrolls no further than the list',
      (
        tester,
      ) async {
        await _pumpPage(tester);
        await _search(tester, 'entry');

        await tester.tap(_browseButton('entry59'));
        await tester.pump(); // start the scroll animation
        await tester.pump(dictionaryScrollAnimation.duration);
        expect(_spaceBelow(tester, 'entry59'), 0);

        await tester.pumpAndSettle();
        await tester.tap(find.byType(SearchBar));
        await tester.pumpAndSettle();
        await tester.tap(_browseButton('entry0'));
        await tester.pump();
        await tester.pump(dictionaryScrollAnimation.duration);
        expect(_rowTop(tester, 'entry0'), 0);
      },
      // iOS can bounce back from overscroll, so check the endpoint before settling.
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );

    testWidgets('browsing before the dictionary has loaded scrolls to the result once it loads', (
      tester,
    ) async {
      final loading = Completer<DictionaryEntries>();
      await _pumpPage(tester, entries: () => loading.future);
      //the loading spinner keeps scheduling frames, so use timed pumps
      await tester.tap(find.byType(SearchBar));
      await tester.pump(); // start the search transition
      await tester.pump(const Duration(seconds: 1));
      await tester.enterText(find.byType(TextField).last, 'sum');
      await tester.pump();
      await tester.tap(_browseButton('sum1'));

      loading.complete(DictionaryEntries(_entries));
      await tester.pumpAndSettle();

      expect(_rowTop(tester, 'entry39'), 0);
      expect(_rowColor(tester, 'sum1'), _highlighted);
    });

    testWidgets('browsing while the dictionary failed to load scrolls to the result after Retry', (
      tester,
    ) async {
      var loads = 0;
      await _pumpPage(
        tester,
        entries: () {
          loads++;
          return loads == 1 ? throw Exception('database is locked') : DictionaryEntries(_entries);
        },
      );
      await _search(tester, 'sum');
      await tester.tap(_browseButton('sum1'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(TextButton, 'Retry'));
      await tester.pumpAndSettle();

      expect(_rowTop(tester, 'entry39'), 0);
      expect(_rowColor(tester, 'sum1'), _highlighted);
    });

    testWidgets('browsing from a result missing from the list leaves the list as it was', (
      tester,
    ) async {
      await _pumpPage(tester);
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pumpAndSettle();
      final scrolled = _position(tester).pixels;
      await _search(tester, 'missing');

      await tester.tap(_browseButton('missing'));
      await tester.pumpAndSettle();

      expect(_position(tester).pixels, scrolled);
      expect(
        tester
            .widgetList<ListTile>(
              find.descendant(of: find.byType(ListView), matching: find.byType(ListTile)),
            )
            .map((tile) => tile.tileColor),
        everyElement(Colors.transparent),
      );
    });

    testWidgets('scrolls to a search result once, not again when the rows are measured again', (
      tester,
    ) async {
      final theme = await _pumpPage(tester);
      await _search(tester, 'sum');
      await tester.tap(_browseButton('sum1'));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0, 1000));
      await tester.pumpAndSettle();
      final scrolled = _position(tester).pixels;

      theme.value = _compact;
      await tester.pumpAndSettle();

      expect(_position(tester).pixels, scrolled);
    });

    testWidgets('the highlight holds, then fades out', (tester) async {
      await _pumpPage(tester);
      await _search(tester, 'sum');
      await tester.tap(_browseButton('sum1'));
      await tester.pump(); // start the scroll animation
      await tester.pump(searchResultHighlight.hold - const Duration(milliseconds: 1));
      final highlight = _rowColor(tester, 'sum1');
      expect(highlight, _highlighted);

      await tester.pump(const Duration(milliseconds: 1)); // end the hold and start the fade
      expect(_rowColor(tester, 'sum1'), highlight);

      await tester.pump(searchResultHighlight.fade ~/ 2);
      expect(_rowColor(tester, 'sum1'), allOf(isNot(highlight), _highlighted));

      await tester.pump(searchResultHighlight.fade ~/ 2);
      expect(_rowColor(tester, 'sum1'), Colors.transparent);
    });

    testWidgets('a highlight that ran out stays off when its row is rebuilt or made again', (
      tester,
    ) async {
      final theme = await _pumpPage(tester);
      await _search(tester, 'sum');
      await tester.tap(_browseButton('sum1'));
      await tester.pump(searchResultHighlight.hold);
      await tester.pumpAndSettle();
      expect(_rowColor(tester, 'sum1'), Colors.transparent);
      final highlightLength = searchResultHighlight.hold + searchResultHighlight.fade;

      theme.value = _dark;
      expect(
        await _rowColorsOver(tester, 'sum1', highlightLength),
        everyElement(Colors.transparent),
      );

      final scrolled = _position(tester).pixels;
      _position(tester).jumpTo(0);
      await tester.pump();
      expect(find.text(_title('sum1'), skipOffstage: false), findsNothing);
      _position(tester).jumpTo(scrolled);
      expect(
        await _rowColorsOver(tester, 'sum1', highlightLength),
        everyElement(Colors.transparent),
      );
    });
  });
}
