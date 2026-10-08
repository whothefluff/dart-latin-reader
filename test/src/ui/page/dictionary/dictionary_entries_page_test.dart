import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/dictionary/dictionary_entries_api.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entries_page.dart';

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
  });
}
