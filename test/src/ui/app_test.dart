import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;
import 'package:latin_reader/src/external/provider_failure_logger.dart';
import 'package:latin_reader/src/external/settings.dart';
import 'package:latin_reader/src/ui/app.dart';
import 'package:latin_reader/src/ui/page/concordance/concordance_page.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionaries_page.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entries_page.dart';
import 'package:latin_reader/src/ui/page/dictionary/dictionary_entry_page.dart';
import 'package:latin_reader/src/ui/page/library/text_page.dart';
import 'package:latin_reader/src/ui/page/library/works_page.dart';
import 'package:latin_reader/src/ui/page/morphology/common.dart';
import 'package:latin_reader/src/ui/page/morphology/morphological_data_page.dart';
import 'package:latin_reader/src/ui/page/morphology/morphological_search_page.dart';
import 'package:latin_reader/src/ui/page/word_frequency/word_frequency_page.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

/// The CSV files of the two-work fixture.
class _TwoWorksCsvFiles implements util.CsvSource {
  const _TwoWorksCsvFiles();

  @override
  Future<String> loadString(String fileName) =>
      File(p.join('test', 'fixtures', 'two_works_by_one_author', fileName)).readAsString();
  //
}

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
  Future<ReaderSettings> build() async => _withoutMacronsOrMarks;
  //
}

class _SavedDictionary extends DictionarySettingsNotifier {
  //
  @override
  Future<DictionarySettings> build() async => _openingFirstSense;
  //
}

class _SavedFrequencyView extends FrequencyViewSettingsNotifier {
  _SavedFrequencyView(
    this._settings,
  );

  final FrequencySettings _settings;

  @override
  Future<FrequencySettings> build() async => _settings;
  //
}

class _SavedFrequencyFilters extends FrequencyFilterSettingsNotifier {
  //
  @override
  Future<FrequencyFilterSettings> build() async => _byForm;
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

/// Shows each word as the fixture spells it.
const _withoutMacronsOrMarks = ReaderSettings(
  showMacrons: false,
  fontFamily: null,
  fontSize: 20.0,
  lineHeight: 1.5,
  letterSpacing: 0.0,
  wordSpacing: 0.0,
  markCommonWords: false,
  commonWordsPercent: 25,
  markUncommonWords: false,
  uncommonWordsPercent: 5,
  frequencyScope: FrequencyScope.library,
  semivowelOrthographyChoice: SemivowelOrthographyChoice.manual,
  uvLowercase: SemivowelForm.vocalicConsonantal,
  uvCapitals: null,
  ijLowercase: SemivowelForm.vocalicConsonantal,
  ijCapitals: null,
);

const _openingFirstSense = DictionarySettings(openFirstSense: true);

const _openingTheDictionary = FrequencySettings(
  showSummary: true,
  formTapAction: FormTapAction.openDictionary,
  narrowLemmaCoverage: NarrowLemmaCoverage.anyCandidate,
);

const _openingMorphology = FrequencySettings(
  showSummary: true,
  formTapAction: FormTapAction.openMorphology,
  narrowLemmaCoverage: NarrowLemmaCoverage.anyCandidate,
);

const _byForm = FrequencyFilterSettings(
  pageSize: 50,
  ascending: false,
  groupByLemma: false,
  showMacrons: false,
);

const _pagesOf25 = ConcordanceSettings(pageSize: 25);

/// A word in a verse of Carmina Altera, with one analysis and a Lewis & Short entry.
const _speculum = 'speculum';

/// A form of Carmina Altera with one analysis. Its lemma, speculum, is spelled otherwise, so a
/// frequency row by form shows it once.
const _speculo = 'speculo';

/// The two works of the fixture, imported as the app imports its CSV files.
late final AppDb _twoWorks;

/// The severe log records of the running test.
final _severeLogs = <LogRecord>[];

/// Moves through the app's tabs and pages, on the two works of the fixture.
///
/// A test fails on any severe log record: one for each failed provider, and one for each
/// navigation that ends on the router's error page.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    _twoWorks = AppDb(
      executor: NativeDatabase.memory(setup: util.setupRegExp),
      populateFromCsv: true,
      csvSource: const _TwoWorksCsvFiles(),
    );
    // Opening the database imports the CSV files
    await _twoWorks.customSelect('SELECT 1').get();
  });
  tearDownAll(() async => _twoWorks.close());
  setUp(() {
    _severeLogs.clear();
    addTearDown(
      log.onRecord.where((record) => record.level >= Level.SEVERE).listen(_severeLogs.add).cancel,
    );
  });

  group('a tab', () {
    testWidgets('keeps its pages while another tab is open', (tester) async {
      await _launch(tester);
      await _openTab(tester, Icons.translate);
      await _openTheFirstEntry(tester);

      await _openTab(tester, Icons.auto_stories);
      await _openTab(tester, Icons.translate);

      expect(find.byType(DictionaryEntryPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(DictionaryEntriesPage), findsOneWidget);
    });

    testWidgets('goes back to its first page when it is opened again', (tester) async {
      await _launch(tester);
      await _openTab(tester, Icons.translate);
      await _openTheFirstEntry(tester);

      await _openTab(tester, Icons.translate);

      expect(find.byType(DictionariesPage), findsOneWidget);
    });
  });

  group('pages stay in the tab that opened them', () {
    testWidgets('the reader and the pages that it opens, in the library', (tester) async {
      await _launch(tester);
      await _read(tester, 'Carmina Altera');
      await _lookUp(tester, _speculum);
      await _openTheEntry(tester);

      await _openTab(tester, Icons.translate);
      expect(find.byType(DictionariesPage), findsOneWidget);
      await _openTab(tester, Icons.edit_note);
      expect(find.byType(MorphologicalSearchPage), findsOneWidget);
      await _openTab(tester, Icons.auto_stories);
      expect(find.byType(DictionaryEntryPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(MorphologicalDataPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(TextPage), findsOneWidget);
    });

    testWidgets('an entry, in the frequency report', (tester) async {
      await _launch(tester);
      await _openTab(tester, Icons.bar_chart);
      await tester.tap(find.text(_speculo));
      await _settle(tester);

      await _openTab(tester, Icons.translate);
      expect(find.byType(DictionariesPage), findsOneWidget);
      await _openTab(tester, Icons.bar_chart);
      expect(find.byType(DictionaryEntryPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(WordFrequencyPage), findsOneWidget);
    });

    testWidgets("a form's morphology and its entry, in the frequency report", (tester) async {
      await _launch(tester, frequencyView: _openingMorphology);
      await _openTab(tester, Icons.bar_chart);
      await tester.tap(find.text(_speculo));
      await _settle(tester);
      await _openTheEntry(tester);

      await _openTab(tester, Icons.edit_note);
      expect(find.byType(MorphologicalSearchPage), findsOneWidget);
      await _openTab(tester, Icons.translate);
      expect(find.byType(DictionariesPage), findsOneWidget);
      await _openTab(tester, Icons.bar_chart);
      expect(find.byType(DictionaryEntryPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(MorphologicalDataPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(WordFrequencyPage), findsOneWidget);
    });

    testWidgets('an entry, in morphology', (tester) async {
      await _launch(tester);
      await _openTab(tester, Icons.edit_note);
      await _searchMorphology(tester, _speculo);
      await _openTheEntry(tester);

      await _openTab(tester, Icons.translate);
      expect(find.byType(DictionariesPage), findsOneWidget);
      await _openTab(tester, Icons.edit_note);
      expect(find.byType(DictionaryEntryPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(MorphologicalDataView), findsOneWidget);
    });

    testWidgets('the reader at a hit and the pages that it opens, in the concordance', (
      tester,
    ) async {
      await _launch(tester);
      await _openTab(tester, Icons.manage_search);
      await _readTheFirstHitOf(tester, _speculum);
      await _lookUp(tester, _speculum);
      await _openTheEntry(tester);

      await _openTab(tester, Icons.translate);
      expect(find.byType(DictionariesPage), findsOneWidget);
      await _openTab(tester, Icons.edit_note);
      expect(find.byType(MorphologicalSearchPage), findsOneWidget);
      await _openTab(tester, Icons.auto_stories);
      expect(find.byType(WorksPage), findsOneWidget);
      await _openTab(tester, Icons.manage_search);
      expect(find.byType(DictionaryEntryPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(MorphologicalDataPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(TextPage), findsOneWidget);
      await _goBack(tester);
      expect(find.byType(ConcordanceHitsPage), findsOneWidget);
    });
  });
}

/// Launches the app on the two works, as `main` does, with the settings above and
/// [frequencyView].
Future<void> _launch(
  WidgetTester tester, {
  FrequencySettings frequencyView = _openingTheDictionary,
}) async {
  tester.view
    ..physicalSize = const Size(1280, 1600)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  // keep ProviderScope directly inside pumpWidget for riverpod_lint
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(_InMemorySettings()),
        generalSettingsNotifierProvider.overrideWith(_SavedGeneral.new),
        librarySettingsNotifierProvider.overrideWith(_SavedLibrary.new),
        readerSettingsNotifierProvider.overrideWith(_SavedReader.new),
        dictionarySettingsNotifierProvider.overrideWith(_SavedDictionary.new),
        frequencyViewSettingsNotifierProvider.overrideWith(
          () => _SavedFrequencyView(frequencyView),
        ),
        frequencyFilterSettingsNotifierProvider.overrideWith(_SavedFrequencyFilters.new),
        concordanceSettingsNotifierProvider.overrideWith(_SavedConcordance.new),
        dbProvider.overrideWith((_) => _twoWorks),
      ],
      observers: const [ProviderFailureLogger()],
      child: const App(),
    ),
  );
  await _settle(tester);
}

/// Pumps frames until nothing is left to draw, then expects no severe log records.
Future<void> _settle(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(_severeLogs.map(_describe), isEmpty, reason: 'Severe log records');
}

/// Returns [record]'s message, error and stack trace.
String _describe(LogRecord record) => '${record.message}\n${record.error}\n${record.stackTrace}';

/// Opens the tab with [icon] from the navigation rail.
Future<void> _openTab(WidgetTester tester, IconData icon) async {
  await tester.tap(_inTheRail(icon));
  await _settle(tester);
}

/// Finds the destination with [icon] in the navigation rail, the app's or the reader menu's.
Finder _inTheRail(IconData icon) =>
    find.descendant(of: find.byType(NavigationRail), matching: find.byIcon(icon)).hitTestable();

/// Presses the system back button.
Future<void> _goBack(WidgetTester tester) async {
  const navigation = SystemChannels.navigation;
  await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    navigation.name,
    navigation.codec.encodeMethodCall(const MethodCall('popRoute')),
    null,
  );
  await _settle(tester);
}

/// Opens [work] in the reader, from the works list.
Future<void> _read(WidgetTester tester, String work) async {
  await tester.tap(find.text(work));
  await _settle(tester);
  await tester.tap(find.widgetWithText(FilledButton, 'Read'));
  await _settle(tester);
}

/// Opens the morphology of [word] from the reader's text menu.
Future<void> _lookUp(WidgetTester tester, String word) async {
  await tester.longPressAt(_centerOf(tester, word));
  await tester.pumpAndSettle(kDoubleTapTimeout);
  await tester.tap(find.text('Morph'));
  await _settle(tester);
}

/// Returns the center of the first [word] on the reader's page.
Offset _centerOf(WidgetTester tester, String word) {
  final text = tester.state<EditableTextState>(find.byType(EditableText));
  final start = text.textEditingValue.text.indexOf(word);
  final boxes = text.renderEditable.getBoxesForSelection(
    TextSelection(baseOffset: start, extentOffset: start + word.length),
  );
  return text.renderEditable.localToGlobal(boxes.first.toRect().center);
}

/// Opens the Lewis & Short entry of the morphology on screen.
Future<void> _openTheEntry(WidgetTester tester) async {
  await tester.tap(find.text('View in Dictionary'));
  await _settle(tester);
}

/// Opens the first entry of the first dictionary.
Future<void> _openTheFirstEntry(WidgetTester tester) async {
  await tester.tap(_firstTileIn(DictionariesPage));
  await _settle(tester);
  await tester.tap(_firstTileIn(ScrollableEntries));
  await _settle(tester);
}

/// Finds the first list tile inside [list] that a tap reaches.
Finder _firstTileIn(Type list) =>
    find.descendant(of: find.byType(list), matching: find.byType(ListTile)).hitTestable().first;

/// Searches morphology for [form], and opens the analyses that it finds.
Future<void> _searchMorphology(WidgetTester tester, String form) async {
  await tester.tap(find.byType(SearchBar));
  await _settle(tester);
  await tester.enterText(find.byType(TextField).last, form);
  await _settle(tester);
  await tester.tap(find.byType(ListTile).hitTestable());
  await _settle(tester);
}

/// Searches the concordance for [form], and opens the reader at the first hit.
Future<void> _readTheFirstHitOf(WidgetTester tester, String form) async {
  await tester.enterText(find.widgetWithText(TextField, 'Word form'), form);
  await _settle(tester);
  await tester.tap(find.text('Search'));
  await _settle(tester);
  await tester.tap(
    find.descendant(of: find.byType(ListView), matching: find.byType(InkWell)).first,
  );
  await _settle(tester);
}
