import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/dictionary/db_util.dart' as dict_util;
import 'package:latin_reader/src/component/dictionary/dictionary_entries_api.dart';
import 'package:latin_reader/src/component/settings/general_settings_api.dart';
import 'package:latin_reader/src/core/semivowel_search.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

const _lewisAndShort = '00000000-0000-0000-0000-00000000000a';
const _other = '00000000-0000-0000-0000-00000000000b';

class _InMemoryGeneral extends GeneralSettingsNotifier {
  _InMemoryGeneral(
    this._initial,
  );

  final GeneralSettings _initial;

  @override
  Future<GeneralSettings> build() async => _initial;

  //
}

/// Settings with explicit values, so the tests don't depend on the defaults
GeneralSettings _searching(SemivowelSearchRules rules) =>
    GeneralSettings(themeMode: ThemeMode.system, accentColor: null, semivowelSearchRules: rules);

const _neither = SemivowelSearchRules(iFindsJ: false, uFindsV: false);
const _iOnly = SemivowelSearchRules(iFindsJ: true, uFindsV: false);
const _both = SemivowelSearchRules(iFindsJ: true, uFindsV: true);

class _EmptyDb extends AppDb {
  _EmptyDb() : super(executor: NativeDatabase.memory(setup: util.setupRegExp));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

/// Creates both dictionaries with [lemmas] in that order, and fills the search table with the
/// app's population step
Future<AppDb> _dictionariesWith(
  Map<String, List<String>> lemmas, {
  Map<String, int> senses = const {},
}) async {
  final db = _EmptyDb();
  addTearDown(db.close);
  await db.customStatement('INSERT INTO Dictionaries VALUES (?, ?, ?, ?, ?), (?, ?, ?, ?, ?)', [
    _lewisAndShort,
    'Lewis & Short',
    'EN',
    '',
    '1879-07-01',
    _other,
    'Other',
    'EN',
    '',
    '1900-01-01',
  ]);
  await Future.wait(
    lemmas.entries.expand(
      (dict) => dict.value.indexed.map(
        (entry) => db.customStatement(
          'INSERT INTO DictionaryEntries( dictionary, lemma, idx ) VALUES ( ?, ?, ? )',
          [dict.key, entry.$2, entry.$1],
        ),
      ),
    ),
  );
  await Future.wait(
    senses.entries.expand(
      (lemma) => List.generate(
        lemma.value,
        (i) => db.customStatement(
          '''
          INSERT INTO DictEntrySenses( dictionary, lemma, lvl, prettyLevel, content )
              VALUES ( ?, ?, ?, '', '' )
          ''',
          [_lewisAndShort, lemma.key, (i + 1).toString().padLeft(3, '0')],
        ),
      ),
    ),
  );
  await dict_util.operations
      .singleWhere((operation) => operation.id == 'SearchableDictionaryEntries')
      .insert(db);
  return db;
}

Future<DictionaryEntries> _found(
  AppDb db,
  String text, {
  String dictionary = _lewisAndShort,
  SemivowelSearchRules rules = _neither,
}) {
  final container = ProviderContainer(
    overrides: [
      dbProvider.overrideWith((_) => db),
      generalSettingsNotifierProvider.overrideWith(() => _InMemoryGeneral(_searching(rules))),
    ],
  );
  addTearDown(container.dispose);
  return container
      .listen(dictionaryEntriesSearchProvider(dictionary, text).future, (_, _) {})
      .read();
}

Future<List<String>> _lemmasFound(
  AppDb db,
  String text, {
  String dictionary = _lewisAndShort,
  SemivowelSearchRules search = _neither,
}) async {
  final entries = await _found(db, text, dictionary: dictionary, rules: search);
  return entries.map((entry) => entry.lemma).toList();
}

void main() {
  group('dictionaryEntriesSearchProvider', () {
    test('finds headwords containing the text, with their number of senses', () async {
      final db = await _dictionariesWith(
        {
          _lewisAndShort: ['amo', 'amor', 'clamo', 'rosa'],
        },
        senses: {'amo': 2},
      );

      final entries = await _found(db, 'amo');

      expect(entries.map((entry) => entry.lemma), unorderedEquals(['amo', 'amor', 'clamo']));
      expect(entries.singleWhere((entry) => entry.lemma == 'amo').numberOfSenses, 2);
    });

    test('an exact search ignores homograph numbers', () async {
      final db = await _dictionariesWith({
        _lewisAndShort: ['sum1', 'sum2', 'summa'],
      });

      expect(await _lemmasFound(db, '"sum"'), unorderedEquals(['sum1', 'sum2']));
    });

    test('text with spaces or punctuation is found inside a headword', () async {
      final db = await _dictionariesWith({
        _lewisAndShort: ['Graecia', 'Magna Graecia', 'ha!', 'hahae'],
      });

      expect(await _lemmasFound(db, 'magna gr'), ['Magna Graecia']);
      expect(await _lemmasFound(db, 'ha!'), ['ha!']);
    });

    test('headwords are found with their own j and v', () async {
      final db = await _dictionariesWith({
        _lewisAndShort: ['jam', 'iambus', 'servus'],
      });

      expect(await _lemmasFound(db, '"jam"'), ['jam']);
      expect(await _lemmasFound(db, '"iam"'), isEmpty);
      expect(await _lemmasFound(db, 'seruus'), isEmpty);
    });

    test('a typed i or u also finds j or v as the settings say, and not the reverse', () async {
      final db = await _dictionariesWith({
        _lewisAndShort: ['jam', 'injuria', 'iambus', 'servus'],
      });

      expect(await _lemmasFound(db, '"iam"', search: _both), ['jam']);
      expect(await _lemmasFound(db, 'iniur', search: _both), ['injuria']);
      expect(await _lemmasFound(db, 'seruus', search: _both), ['servus']);
      expect(await _lemmasFound(db, 'seruus', search: _iOnly), isEmpty);
      expect(await _lemmasFound(db, 'jamb', search: _both), isEmpty);
    });

    test('what the headwords match as typed is listed once, first', () async {
      final db = await _dictionariesWith({
        _lewisAndShort: ['iam', 'jam'],
      });

      expect(await _lemmasFound(db, '"iam"', search: _both), ['iam', 'jam']);
    });

    test('typed macrons are ignored', () async {
      final db = await _dictionariesWith({
        _lewisAndShort: ['amo', 'rosa'],
      });

      expect(await _lemmasFound(db, 'rosā'), ['rosa']);
    });

    test('only the dictionary asked for is searched', () async {
      final db = await _dictionariesWith({
        _lewisAndShort: ['amo'],
        _other: ['amo', 'amor'],
      });

      expect(await _lemmasFound(db, 'amo'), ['amo']);
      expect(
        await _lemmasFound(db, 'amo', dictionary: _other),
        unorderedEquals(['amo', 'amor']),
      );
    });
  });
}
