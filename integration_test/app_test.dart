import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:latin_reader/app_config.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/library/semivowel_orthography.dart';
import 'package:latin_reader/src/component/settings/concordance_settings_api.dart';
import 'package:latin_reader/src/component/settings/dictionary_settings_api.dart';
import 'package:latin_reader/src/component/settings/frequency_filter_settings_api.dart';
import 'package:latin_reader/src/component/settings/frequency_settings_api.dart';
import 'package:latin_reader/src/component/settings/general_settings_api.dart';
import 'package:latin_reader/src/component/settings/library_settings_api.dart';
import 'package:latin_reader/src/component/settings/reader_settings_api.dart';
import 'package:latin_reader/src/component/word_frequency/lookup_frequency_api.dart';
import 'package:latin_reader/src/core/semivowel_search.dart';
import 'package:latin_reader/src/external/provider_failure_logger.dart';
import 'package:latin_reader/src/external/settings.dart';
import 'package:latin_reader/src/ui/app.dart';
import 'package:latin_reader/src/ui/page/concordance/concordance_page.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionaries_page.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entries_page.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entry_page.dart';
import 'package:latin_reader/src/ui/page/library/text_page.dart';
import 'package:latin_reader/src/ui/page/library/work_details_page.dart';
import 'package:latin_reader/src/ui/page/library/works_page.dart';
import 'package:latin_reader/src/ui/page/morphology/morphological_search_page.dart';
import 'package:latin_reader/src/ui/page/word_frequency/word_frequency_page.dart';
import 'package:logging/logging.dart';

/// Storage kept in memory, so the tests never change the device's settings.
class _InMemorySettings implements SettingsRepository {
  //
  final Map<String, Pref> _values = {};

  @override
  Future<T?> get<T extends Pref>(String key, T typeHint) async => _values[key] as T?;

  @override
  Future<void> set(String key, Pref? value) async {
    if (value == null) {
      _values.remove(key);
    } else {
      _values[key] = value;
    }
  }

  @override
  Future<void> clearAll() async => _values.clear();
  //
}

// Saved settings, without the platform storage behind them

class _SavedGeneral extends GeneralSettingsNotifier {
  //
  @override
  Future<GeneralSettings> build() async => _lightBaseline;
  //
}

class _SavedLibrary extends LibrarySettingsNotifier {
  //
  @override
  Future<LibrarySettings> build() async => _listingWorks;
  //
}

class _SavedReader extends ReaderSettingsNotifier {
  //
  @override
  Future<ReaderSettings> build() async => _markingCommonAndUncommon;
  //
}

class _SavedDictionary extends DictionarySettingsNotifier {
  //
  @override
  Future<DictionarySettings> build() async => _openingFirstSense;
  //
}

class _SavedFrequencyView extends FrequencyViewSettingsNotifier {
  //
  @override
  Future<FrequencySettings> build() async => _anyCandidateView;
  //
}

class _SavedFrequencyFilters extends FrequencyFilterSettingsNotifier {
  //
  @override
  Future<FrequencyFilterSettings> build() async => _byLemma;
  //
}

class _SavedConcordance extends ConcordanceSettingsNotifier {
  //
  @override
  Future<ConcordanceSettings> build() async => _pagesOf25;
  //
}

// Set explicitly so the tests don't depend on the defaults

const _lightBaseline = GeneralSettings(
  themeMode: ThemeMode.light,
  accentColor: null,
  semivowelSearchRules: SemivowelSearchRules(iFindsJ: true, uFindsV: true),
);

const _listingWorks = LibrarySettings(view: LibraryView.works);

const _markingCommonAndUncommon = ReaderSettings(
  showMacrons: true,
  fontFamily: null,
  fontSize: 20.0,
  lineHeight: 1.5,
  letterSpacing: 0.0,
  wordSpacing: 0.0,
  markCommonWords: true,
  commonWordsPercent: 25,
  markUncommonWords: true,
  uncommonWordsPercent: 5,
  frequencyScope: FrequencyScope.library,
  semivowelOrthographyChoice: SemivowelOrthographyChoice.manual,
  uvLowercase: SemivowelForm.vocalicConsonantal,
  uvCapitals: null,
  ijLowercase: SemivowelForm.vocalicConsonantal,
  ijCapitals: null,
);

const _openingFirstSense = DictionarySettings(openFirstSense: true);

const _anyCandidateView = FrequencySettings(
  showSummary: true,
  formTapAction: FormTapAction.ask,
  narrowLemmaCoverage: NarrowLemmaCoverage.anyCandidate,
);

const _byLemma = FrequencyFilterSettings(
  pageSize: 50,
  ascending: false,
  groupByLemma: true,
  showMacrons: true,
);

const _pagesOf25 = ConcordanceSettings(pageSize: 25);

/// The longest a page may take to load, long enough for a first launch that fills the database
/// from the CSVs.
const _loadTimeout = Duration(minutes: 10);

/// The time between two frames while a page loads.
const _frameInterval = Duration(milliseconds: 100);

/// The severe log records of the running test.
final _severeLogs = <LogRecord>[];

/// Opens each tab of the app on the database that the build uses.
///
/// A test fails on any severe log record, which [ProviderFailureLogger] writes for every failed
/// provider, and on any framework or uncaught error, as every widget test does.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(AppConfig.instance.load);
  setUp(() {
    _severeLogs.clear();
    addTearDown(
      log.onRecord.where((record) => record.level >= Level.SEVERE).listen(_severeLogs.add).cancel,
    );
  });

  testWidgets('the first work opens at its first page', (tester) async {
    await _launch(tester);

    await tester.tap(_firstTileIn(WorksPage));
    await _load(tester, WorkDetailsPage);
    await tester.tap(find.widgetWithText(FilledButton, 'Read'));
    await _load(tester, TextPage);
  });

  testWidgets('the first entry of the first dictionary opens', (tester) async {
    await _launch(tester);

    await _openTab(tester, Icons.translate);
    await _load(tester, DictionariesPage);
    await tester.tap(_firstTileIn(DictionariesPage));
    await _load(tester, DictionaryEntriesPage);
    await tester.tap(_firstTileIn(ScrollableEntries));
    await _load(tester, DictionaryEntryPage);
  });

  testWidgets('the word frequency tab opens', (tester) async {
    await _launch(tester);

    await _openTab(tester, Icons.bar_chart);
    await _load(tester, WordFrequencyPage);
  });

  testWidgets('the morphology tab opens', (tester) async {
    await _launch(tester);

    await _openTab(tester, Icons.edit_note);
    await _load(tester, MorphologicalSearchPage);
  });

  testWidgets('the concordance tab opens', (tester) async {
    await _launch(tester);

    await _openTab(tester, Icons.manage_search);
    await _load(tester, ConcordancePage);
  });
}

/// Launches the app as `main` does, with the settings above.
Future<void> _launch(WidgetTester tester) async {
  // keep ProviderScope directly inside pumpWidget for riverpod_lint
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(_InMemorySettings()),
        generalSettingsNotifierProvider.overrideWith(_SavedGeneral.new),
        librarySettingsNotifierProvider.overrideWith(_SavedLibrary.new),
        readerSettingsNotifierProvider.overrideWith(_SavedReader.new),
        dictionarySettingsNotifierProvider.overrideWith(_SavedDictionary.new),
        frequencyViewSettingsNotifierProvider.overrideWith(_SavedFrequencyView.new),
        frequencyFilterSettingsNotifierProvider.overrideWith(_SavedFrequencyFilters.new),
        concordanceSettingsNotifierProvider.overrideWith(_SavedConcordance.new),
      ],
      observers: const [ProviderFailureLogger()],
      child: const App(),
    ),
  );
  await _load(tester, WorksPage);
}

/// Taps the navigation destination with [icon].
Future<void> _openTab(WidgetTester tester, IconData icon) =>
    tester.tap(find.byIcon(icon).hitTestable());

/// Finds the first list tile inside [list] that a tap reaches.
Finder _firstTileIn(Type list) =>
    find.descendant(of: find.byType(list), matching: find.byType(ListTile)).hitTestable().first;

/// Pumps frames until [page] has loaded, then expects no severe log records.
Future<void> _load(WidgetTester tester, Type page) async {
  final deadline = DateTime.now().add(_loadTimeout);
  while (!_isLoaded(tester, page) && DateTime.now().isBefore(deadline)) {
    await tester.pump(_frameInterval);
  }
  expect(_isLoaded(tester, page), isTrue, reason: 'The page is still loading after $_loadTimeout');
  expect(_severeLogs.map(_describe), isEmpty, reason: 'Severe log records while loading the page');
}

/// Whether [page] is shown, with no loading indicator and no frame waiting to be drawn.
bool _isLoaded(WidgetTester tester, Type page) =>
    tester.any(find.byType(page)) &&
    !tester.any(find.byType(CircularProgressIndicator)) &&
    !tester.binding.hasScheduledFrame;

/// Returns [record]'s message, error and stack trace.
String _describe(LogRecord record) => '${record.message}\n${record.error}\n${record.stackTrace}';
