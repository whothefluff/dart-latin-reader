import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/settings/frequency_settings_api.dart';
import 'package:latin_reader/src/ui/page/settings/frequency_settings_page.dart';

class _InMemoryView extends FrequencyViewSettingsNotifier {
  //
  @override
  Future<FrequencySettings> build() async => const FrequencySettings();

  @override
  Future<void> updateSettings(FrequencySettings newSettings) async {
    state = AsyncData(newSettings);
  }

  //
}

// keep ProviderScope directly inside pumpWidget for riverpod_lint
Future<ProviderContainer> _pumpPage(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [frequencyViewSettingsNotifierProvider.overrideWith(_InMemoryView.new)],
      child: const MaterialApp(home: FrequencySettingsPage()),
    ),
  );
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(
    tester.element(find.byType(FrequencySettingsPage)),
    listen: false,
  );
}

Finder _chip(String label) => find.widgetWithText(ChoiceChip, label);

bool _selected(WidgetTester tester, String label) =>
    tester.widget<ChoiceChip>(_chip(label)).selected;

void main() {
  group('Lemma Coverage on Small Screens', () {
    testWidgets('starts on any candidate', (tester) async {
      await _pumpPage(tester);

      expect(_selected(tester, 'Any Candidate'), isTrue);
      expect(_selected(tester, 'Certain'), isFalse);
    });

    testWidgets('choosing Certain saves it and selects it', (tester) async {
      final container = await _pumpPage(tester);

      await tester.ensureVisible(_chip('Certain'));
      await tester.tap(_chip('Certain'));
      await tester.pumpAndSettle();

      expect(
        container.read(frequencyViewSettingsNotifierProvider).value?.narrowLemmaCoverage,
        NarrowLemmaCoverage.certain,
      );
      expect(_selected(tester, 'Certain'), isTrue);
      expect(_selected(tester, 'Any Candidate'), isFalse);
    });

    testWidgets('choosing it leaves the other settings alone', (tester) async {
      final container = await _pumpPage(tester);

      await tester.ensureVisible(_chip('Certain'));
      await tester.tap(_chip('Certain'));
      await tester.pumpAndSettle();

      expect(
        container.read(frequencyViewSettingsNotifierProvider).value,
        const FrequencySettings(narrowLemmaCoverage: NarrowLemmaCoverage.certain),
      );
    });
  });
}
