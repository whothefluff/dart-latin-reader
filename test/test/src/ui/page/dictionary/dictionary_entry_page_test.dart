import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/dictionary/dictionary_entry_senses_api.dart';
import 'package:latin_reader/src/component/settings/dictionary_settings_api.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entry_page.dart';

/// Too long for one line of the test screen
final String _long = 'long ' * 40;

/// A saved setting, without the platform storage behind it
class _SavedSettings extends DictionarySettingsNotifier {
  _SavedSettings(this._settings);

  final DictionarySettings _settings;

  @override
  Future<DictionarySettings> build() async => _settings;
  //
}

// riverpod_lint only takes a scope passed straight to pumpWidget (or runApp) as the root one
Future<void> _pumpPage(
  WidgetTester tester,
  List<String> prettyLevels, {
  Set<String> long = const {},
  bool openFirstSense = false,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        dictionaryEntrySensesProvider('ls', 'amo').overrideWith(
          (_) => DictionaryEntrySenses(
            prettyLevels.map(
              (level) => EntrySense(
                prettyLevel: level,
                content: long.contains(level) ? _long : 'sense $level',
                quotes: const [],
              ),
            ),
          ),
        ),
        dictionarySettingsNotifierProvider.overrideWith(
          () => _SavedSettings(DictionarySettings(openFirstSense: openFirstSense)),
        ),
      ],
      child: const MaterialApp(home: DictionaryEntryPage('ls', 'amo')),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _senseText(String prettyLevel) => find.text('$prettyLevel. sense $prettyLevel');

List<bool> _expanded(WidgetTester tester) =>
    tester.widgetList<ExpandIcon>(find.byType(ExpandIcon)).map((icon) => icon.isExpanded).toList();

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

    testWidgets('makes collapsible only the senses that hide something, the rest selectable', (
      tester,
    ) async {
      await _pumpPage(tester, ['1', '1.1', '2', '3'], long: {'3'});

      expect(_expanded(tester), [false, false]);
      expect(
        find.ancestor(of: _senseText('2'), matching: find.byType(SelectionArea)),
        findsOneWidget,
      );
    });

    testWidgets('opens and closes a sense by tapping its header', (tester) async {
      await _pumpPage(tester, ['1', '1.1', '2', '2.1']);
      expect(_senseText('1.1'), findsNothing);

      await tester.tap(_senseText('1'));
      await tester.pumpAndSettle();
      expect(_expanded(tester), [true, false]);
      expect(_senseText('1.1'), findsOneWidget);

      await tester.tap(_senseText('1'));
      await tester.pumpAndSettle();
      expect(_expanded(tester), [false, false]);
      expect(_senseText('1.1'), findsNothing);
    });

    testWidgets('closes the open sense when another one opens', (tester) async {
      await _pumpPage(tester, ['1', '1.1', '2', '2.1']);

      await tester.tap(_senseText('1'));
      await tester.pumpAndSettle();
      await tester.tap(_senseText('2'));
      await tester.pumpAndSettle();

      expect(_expanded(tester), [false, true]);
    });

    testWidgets('copies a sense by long-pressing or right-clicking its header', (tester) async {
      final copied = <Object?>[];
      final messenger = tester.binding.defaultBinaryMessenger
        ..setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'Clipboard.setData') {
            copied.add((call.arguments as Map<Object?, Object?>)['text']);
          }
          return null;
        });
      addTearDown(() => messenger.setMockMethodCallHandler(SystemChannels.platform, null));
      await _pumpPage(tester, ['1', '1.1', '2', '2.1']);

      await tester.longPress(_senseText('1'));
      await tester.tap(
        _senseText('2'),
        buttons: kSecondaryMouseButton,
        kind: PointerDeviceKind.mouse,
      );
      await tester.pumpAndSettle();

      expect(copied, ['sense 1', 'sense 2']);
      expect(_expanded(tester), [false, false]);
      expect(find.text('Sense copied'), findsWidgets);
    });

    testWidgets('opens the first sense when set to', (tester) async {
      // The setting loads after the senses here, as on the first entry after launch
      await _pumpPage(tester, ['1', '1.1', '2', '2.1'], openFirstSense: true);

      expect(_expanded(tester), [true, false]);
      expect(_senseText('1.1'), findsOneWidget);
    });

    testWidgets('opens no sense when set to but the first one has nothing to open', (
      tester,
    ) async {
      await _pumpPage(tester, ['1', '2', '2.1'], openFirstSense: true);

      expect(_expanded(tester), [false]);
    });
  });
}
