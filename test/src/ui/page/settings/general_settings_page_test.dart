import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/settings/general_settings_api.dart';
import 'package:latin_reader/src/ui/page/settings/general_settings_page.dart';

class _InMemoryGeneral extends GeneralSettingsNotifier {
  _InMemoryGeneral(
    this._initial,
  );

  final GeneralSettings _initial;

  @override
  Future<GeneralSettings> build() async => _initial;

  @override
  Future<void> updateSettings(GeneralSettings newSettings) async {
    state = AsyncData(newSettings);
  }

  //
}

/// Set explicitly so the tests don't depend on the defaults
const _tealInTheDark = GeneralSettings(
  themeMode: ThemeMode.dark,
  accentColor: Color(0xFF009688),
);

// keep ProviderScope directly inside pumpWidget for riverpod_lint
Future<ProviderContainer> _pumpPage(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        generalSettingsNotifierProvider.overrideWith(() => _InMemoryGeneral(_tealInTheDark)),
      ],
      child: const MaterialApp(home: GeneralSettingsPage()),
    ),
  );
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(
    tester.element(find.byType(GeneralSettingsPage)),
    listen: false,
  );
}

Finder _selectedSwatches() => find.byWidgetPredicate(
  (widget) => widget is Semantics && (widget.properties.selected ?? false),
);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  // tap() hits the laid-out position, and the scroll is only laid out on the next frame
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('Accent color', () {
    testWidgets('a saved preset color shows that preset as selected', (tester) async {
      await _pumpPage(tester);

      expect(_selectedSwatches(), findsOneWidget);
      expect(
        find.descendant(of: find.byTooltip('Teal'), matching: _selectedSwatches()),
        findsOneWidget,
      );
    });

    testWidgets('choosing a preset saves only its color', (tester) async {
      final container = await _pumpPage(tester);

      await _tap(tester, find.byTooltip('Pink'));

      expect(
        container.read(generalSettingsNotifierProvider).value,
        _tealInTheDark.copyWith(accentColor: const Color(0xFFE91E63)),
      );
    });

    testWidgets('choosing the baseline saves no color', (tester) async {
      final container = await _pumpPage(tester);

      await _tap(tester, find.byTooltip('Baseline'));

      expect(
        container.read(generalSettingsNotifierProvider).value,
        _tealInTheDark.copyWith(accentColor: null),
      );
    });
  });
}
