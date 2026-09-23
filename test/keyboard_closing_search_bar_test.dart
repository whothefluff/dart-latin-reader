import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/ui/widget/keyboard_closing_search_bar.dart';

/// Like the morphology page: the bar in the app bar, and a button that pushes another page
Widget _app({SearchController? searchController}) => MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Expanded(
            child: KeyboardClosingSearchBar(
              searchController: searchController,
              isFullScreen: true,
              suggestionsBuilder: (_, controller) => [
                ListTile(title: const Text('amo'), onTap: () => controller.closeView('amo')),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => Scaffold(appBar: AppBar())),
            ),
          ),
        ),
      ],
    ),
  ),
);

Future<void> _openView(WidgetTester tester) async {
  await tester.tap(find.byType(SearchBar));
  await tester.pumpAndSettle();
}

void main() {
  // flutter_test runs as Android with touch taps unless a variant says otherwise
  group('KeyboardClosingSearchBar', () {
    testWidgets('picking a suggestion closes the keyboard', (tester) async {
      await tester.pumpWidget(_app());
      await _openView(tester);
      expect(tester.testTextInput.isVisible, isTrue);

      await tester.tap(find.text('amo'));
      await tester.pumpAndSettle();

      expect(tester.testTextInput.isVisible, isFalse);
    });

    testWidgets('picking a suggestion closes the keyboard with a controller passed in', (
      tester,
    ) async {
      final controller = SearchController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(_app(searchController: controller));
      await _openView(tester);
      expect(tester.testTextInput.isVisible, isTrue);

      await tester.tap(find.text('amo'));
      await tester.pumpAndSettle();

      expect(tester.testTextInput.isVisible, isFalse);
      expect(controller.text, 'amo');
    });

    testWidgets('the back arrow closes the keyboard, also after visiting another page', (
      tester,
    ) async {
      await tester.pumpWidget(_app());
      await _openView(tester);
      expect(tester.testTextInput.isVisible, isTrue);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(tester.testTextInput.isVisible, isFalse);

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(tester.testTextInput.isVisible, isFalse);
    });

    testWidgets('Tab reaches the bar after its view closes', (tester) async {
      await tester.pumpWidget(_app());
      await _openView(tester);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      final focused = FocusManager.instance.primaryFocus?.context;
      expect(focused?.findAncestorWidgetOfExactType<KeyboardClosingSearchBar>(), isNotNull);
    }, variant: TargetPlatformVariant.desktop());
  });
}
