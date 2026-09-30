import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/settings/reader_settings_api.dart';
import 'package:latin_reader/src/component/word_frequency/lookup_frequency_api.dart';
import 'package:latin_reader/src/ui/page/settings/library_settings_page.dart';

class _InMemoryReader extends ReaderSettingsNotifier {
  _InMemoryReader(
    this._initial,
  );

  final ReaderSettings _initial;

  @override
  Future<ReaderSettings> build() async => _initial;

  @override
  Future<void> updateSettings(ReaderSettings newSettings) async {
    state = AsyncData(newSettings);
  }

  //
}

/// Set explicitly so the tests don't depend on the defaults
const _marking = ReaderSettings(
  frequencyScope: FrequencyScope.work,
);

// keep ProviderScope directly inside pumpWidget for riverpod_lint
Future<ProviderContainer> _pumpPage(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [readerSettingsNotifierProvider.overrideWith(() => _InMemoryReader(_marking))],
      child: const MaterialApp(home: LibrarySettingsPage()),
    ),
  );
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(
    tester.element(find.byType(LibrarySettingsPage)),
    listen: false,
  );
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  // tap() hits the laid-out position, and the scroll is only laid out on the next frame
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('Word Frequency', () {
    testWidgets('marking common words saves only that', (tester) async {
      final container = await _pumpPage(tester);

      await _tap(tester, find.text('Mark Common Words'));

      expect(
        container.read(readerSettingsNotifierProvider).value,
        _marking.copyWith(markCommonWords: true),
      );
    });

    testWidgets('choosing the author saves only the scope', (tester) async {
      final container = await _pumpPage(tester);

      await _tap(tester, find.widgetWithText(ChoiceChip, 'Its Author'));

      expect(
        container.read(readerSettingsNotifierProvider).value,
        _marking.copyWith(frequencyScope: FrequencyScope.author),
      );
    });
  });
}
