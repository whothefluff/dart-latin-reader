import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/dictionary/dictionary_entry_senses_api.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entry_page.dart';

EntrySense _sense(String prettyLevel) =>
    EntrySense(prettyLevel: prettyLevel, content: 'sense $prettyLevel', quotes: const []);

// riverpod_lint only takes a scope passed straight to pumpWidget (or runApp) as the root one
Future<void> _pumpPage(WidgetTester tester, List<String> prettyLevels) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        dictionaryEntrySensesProvider('ls', 'amo').overrideWith(
          (_) => DictionaryEntrySenses(prettyLevels.map(_sense)),
        ),
      ],
      child: const MaterialApp(home: DictionaryEntryPage('ls', 'amo')),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _senseText(String prettyLevel) => find.text('$prettyLevel. sense $prettyLevel');

void main() {
  group('DictionaryEntryPage', () {
    testWidgets('shows a lone top-level sense in full, with nothing to collapse', (tester) async {
      await _pumpPage(tester, ['1', '1.1', '1.2']);

      expect(find.byType(ExpandIcon), findsNothing);
      expect(tester.widget<Text>(_senseText('1')).maxLines, isNull);
      expect(_senseText('1.1'), findsOneWidget);
      expect(_senseText('1.2'), findsOneWidget);
    });

    testWidgets('makes a lone top-level sense selectable along with its subsenses', (
      tester,
    ) async {
      await _pumpPage(tester, ['1', '1.1']);

      final area = find.ancestor(of: _senseText('1'), matching: find.byType(SelectionArea));
      expect(area, findsOneWidget);
      expect(find.descendant(of: area, matching: _senseText('1.1')), findsOneWidget);
    });

    testWidgets('keeps several top-level senses as closed panels', (tester) async {
      await _pumpPage(tester, ['1', '1.1', '2']);

      final icons = tester.widgetList<ExpandIcon>(find.byType(ExpandIcon));
      expect(icons.map((icon) => icon.isExpanded), [false, false]);
    });
  });
}
