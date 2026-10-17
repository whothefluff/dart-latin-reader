import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;
import 'package:path/path.dart' as p;

const _carminaPrima = 'Carmina Prima';
const _carminaAltera = 'Carmina Altera';
const _fictorId = '00000000-0000-4000-8000-000000000011';

/// The producer's aggregate of two works by one author, populated by the app's importer.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fixtureDirectory = Directory('test/fixtures/two_works_by_one_author');
  final fixture = _FixtureCsvSource(fixtureDirectory);
  late AppDb db;

  setUpAll(() async {
    db = AppDb(
      executor: NativeDatabase.memory(setup: util.setupRegExp),
      populateFromCsv: true,
      csvSource: fixture,
    );
    // Opening the database runs every population step and integrity check
    await db.customSelect('SELECT 1').get();
  });

  tearDownAll(() async => db.close());

  /// Returns the values of each row that [sql] selects, in the order of its columns.
  Future<List<List<Object?>>> rows(String sql) async =>
      (await db.customSelect(sql).get()).map((row) => row.data.values.toList()).toList();

  test('reads every CSV file in the fixture, and no other file', () {
    final csvFileNames = fixtureDirectory
        .listSync()
        .map((entry) => p.basename(entry.path))
        .where((name) => name.endsWith('.csv'));

    expect(fixture.servedFileNames, unorderedEquals(csvFileNames));
  });

  test('fills each table with the stated number of rows', () async {
    final tables = await rows('''
      SELECT name
          FROM sqlite_master AS Tables
          WHERE type = 'table'
                AND SUBSTR( name, 1, 7 ) <> 'sqlite_'
                AND NOT EXISTS ( SELECT 1 -- FTS5's shadow tables
                                     FROM sqlite_master AS Search
                                     WHERE Search.sql LIKE 'CREATE VIRTUAL TABLE%'
                                           AND SUBSTR( Tables.name, 1, LENGTH( Search.name ) + 1 )
                                               = Search.name || '_' )''');
    final rowCounts = Map.fromEntries(
      await Future.wait(
        tables.map((table) async {
          final count = await rows('SELECT COUNT( * ) FROM "${table.single}"');
          return MapEntry(table.single, count.single.single);
        }),
      ),
    );

    expect(
      rowCounts,
      {
        'Authors': 1,
        'AuthorAbbreviations': 1,
        'Works': 2,
        'WorkAbbreviations': 0,
        'WorkContents': 24,
        'WorkContentSubdivisions': 11,
        'WorkContentSupplementary': 0,
        'UnambiguousMacronizations': 10,
        'WorkMacronizations': 4,
        'AuthorsAndWorks': 2,
        'MorphologicalDetails': 13,
        'MorphologicalDetailInflections': 40,
        'SearchableMorphDetInflections': 40,
        'CountableWordCandidateAnalyses': 21,
        'Dictionaries': 1,
        'DictionaryEntries': 17,
        'DictEntrySenses': 0,
        'DictEntrySenseQuotes': 0,
        'DictionaryAlphabets': 6,
        'SearchableDictionaryEntries': 17,
        'LnsRefResolutions': 12,
        'ScopedFormFreq': 15,
        'ResolvedFreqMorphForms': 17,
        'ScopedFormLemmaFreq': 17,
        'ScopedLemmaFreq': 14,
        'ScopedFreqTotals': 2,
        'ScopedLookupFreq': 15,
        'ScopedLookupLemmas': 17,
        'ConcordanceDetails': 11,
        'ConcordanceDetailInflections': 38,
        'ConcordanceCountableWordCandidateAnalyses': 21,
        'ConcordanceSpellingsWithSemivowels': 2,
        'DataVersion': 1,
      },
    );
  });

  test('imports the author of both works once', () async {
    expect(
      await rows('SELECT id, name, about, image FROM Authors'),
      [
        [_fictorId, 'Fictor', 'An invented poet.', utf8.encode('fixture')],
      ],
    );
    expect(
      await rows('SELECT authorId, id, val FROM AuthorAbbreviations'),
      [
        [_fictorId, 0, 'Fict.'],
      ],
    );
    expect(
      await rows('''
        SELECT AuthorsAndWorks.authorId, Works.name
            FROM AuthorsAndWorks
            INNER JOIN Works
                ON Works.id = AuthorsAndWorks.workId
            ORDER BY Works.id'''),
      [
        [_fictorId, _carminaPrima],
        [_fictorId, _carminaAltera],
      ],
    );
  });

  test('imports both works and their subdivisions', () async {
    expect(
      await rows('''
        SELECT name, about, uvLowercase, uvCapitals, ijLowercase, ijCapitals
            FROM Works
            ORDER BY id'''),
      [
        [_carminaPrima, 'The first invented work.', 'uv', 'UV', 'i', 'I'],
        [_carminaAltera, 'The second invented work.', 'uv', 'UV', 'i', 'I'],
      ],
    );
    expect(
      await rows('''
        SELECT Works.name AS work, Division.typ, Division.cnt, Division.name,
               Parent.typ AS parentTyp, Division.fromIndex, Division.toIndex, Division.editionLabel
            FROM WorkContentSubdivisions AS Division
            INNER JOIN Works
                ON Works.id = Division.workId
            LEFT JOIN WorkContentSubdivisions AS Parent
                ON Parent.workId = Division.workId
                   AND Parent.node = Division.parent
            ORDER BY Division.workId, Division.node'''),
      [
        [_carminaPrima, 'POEM', 0, 'Ad amicum', null, 0, 10, '1'],
        [_carminaPrima, 'TITL', 0, 'Ad amicum', 'POEM', 0, 1, null],
        [_carminaPrima, 'VERS', 0, 'Levis et Roma est.', 'POEM', 2, 6, '1'],
        [_carminaPrima, 'VERS', 1, 'et levis aura.', 'POEM', 7, 10, '2'],
        [_carminaAltera, 'BOOK', 0, '', null, 0, 12, '1'],
        [_carminaAltera, 'POEM', 0, 'De speculo', 'BOOK', 0, 9, '10'],
        [_carminaAltera, 'TITL', 0, 'De speculo', 'POEM', 0, 1, null],
        [_carminaAltera, 'VERS', 0, 'levis speculum et Roma.', 'POEM', 2, 6, '1'],
        [_carminaAltera, 'VERS', 1, 'est levis.', 'POEM', 7, 9, '2'],
        [_carminaAltera, 'POEM', 1, '', 'BOOK', 10, 12, '10a'],
        [_carminaAltera, 'VERS', 0, 'Roma est.', 'POEM', 10, 12, '1'],
      ],
    );
  });

  test('imports every token of both works', () async {
    expect(
      await rows('''
        SELECT Works.name AS work, Token.idx, Token.word, Token.sourceReference,
               Token.properNounState, Token.tokenType, Token.sentenceIdx, Token.wordIdx,
               Token.enclitic, Token.expansion
            FROM WorkContents AS Token
            INNER JOIN Works
                ON Works.id = Token.workId
            ORDER BY Token.workId, Token.idx'''),
      [
        [_carminaPrima, 0, 'Ad', '1', 0, 1, 0, 0, null, null],
        [_carminaPrima, 1, 'amicum', '1', 0, 1, 0, 1, null, null],
        [_carminaPrima, 2, 'Levis', '1.1', 0, 1, 1, 0, null, null],
        [_carminaPrima, 3, 'et', '1.1', 0, 1, 1, 1, null, null],
        [_carminaPrima, 4, 'Roma', '1.1', 1, 1, 1, 2, null, null],
        [_carminaPrima, 5, 'est', '1.1', 0, 1, 1, 3, null, null],
        [_carminaPrima, 6, '.', '1.1', null, 4, 1, null, null, null],
        [_carminaPrima, 7, 'et', '1.2', 0, 1, 2, 0, null, null],
        [_carminaPrima, 8, 'levis', '1.2', 0, 1, 2, 1, null, null],
        [_carminaPrima, 9, 'aura', '1.2', 0, 1, 2, 2, null, null],
        [_carminaPrima, 10, '.', '1.2', null, 4, 2, null, null, null],
        [_carminaAltera, 0, 'De', '1.10', 0, 1, 0, 0, null, null],
        [_carminaAltera, 1, 'speculo', '1.10', 0, 1, 0, 1, null, null],
        [_carminaAltera, 2, 'levis', '1.10.1', 0, 1, 1, 0, null, null],
        [_carminaAltera, 3, 'speculum', '1.10.1', 0, 1, 1, 1, null, null],
        [_carminaAltera, 4, 'et', '1.10.1', 0, 1, 1, 2, null, null],
        [_carminaAltera, 5, 'Roma', '1.10.1', 1, 1, 1, 3, null, null],
        [_carminaAltera, 6, '.', '1.10.1', null, 4, 1, null, null, null],
        [_carminaAltera, 7, 'est', '1.10.2', 0, 1, 2, 0, null, null],
        [_carminaAltera, 8, 'levis', '1.10.2', 0, 1, 2, 1, null, null],
        [_carminaAltera, 9, '.', '1.10.2', null, 4, 2, null, null, null],
        [_carminaAltera, 10, 'Roma', '1.10a.1', 1, 1, 3, 0, null, null],
        [_carminaAltera, 11, 'est', '1.10a.1', 0, 1, 3, 1, null, null],
        [_carminaAltera, 12, '.', '1.10a.1', null, 4, 3, null, null, null],
      ],
    );
  });

  test('marks the tokens of each title', () async {
    expect(
      await rows('''
        SELECT Works.name AS work, Token.idx
            FROM WorkContents AS Token
            INNER JOIN Works
                ON Works.id = Token.workId
            WHERE Token.isTitle
            ORDER BY Token.workId, Token.idx'''),
      [
        [_carminaPrima, 0],
        [_carminaPrima, 1],
        [_carminaAltera, 0],
        [_carminaAltera, 1],
      ],
    );
  });

  test('gives each token the macronization that the producer intends', () async {
    expect(
      await rows('''
        SELECT Works.name AS work, Token.idx, Token.word, Token.macronizedWord,
               Token.uncertaintyBitMask
            FROM WorkContents AS Token
            INNER JOIN Works
                ON Works.id = Token.workId
            ORDER BY Token.workId, Token.idx'''),
      [
        [_carminaPrima, 0, 'Ad', 'Ad', 0],
        [_carminaPrima, 1, 'amicum', 'amīcum', 0],
        [_carminaPrima, 2, 'Levis', 'Levis', 0],
        [_carminaPrima, 3, 'et', 'et', 0],
        [_carminaPrima, 4, 'Roma', 'Rōma', 0],
        [_carminaPrima, 5, 'est', 'est', 0],
        [_carminaPrima, 6, '.', '.', 0],
        [_carminaPrima, 7, 'et', 'et', 0],
        [_carminaPrima, 8, 'levis', 'levis', 0],
        [_carminaPrima, 9, 'aura', 'aura', 0],
        [_carminaPrima, 10, '.', '.', 0],
        [_carminaAltera, 0, 'De', 'Dē', 0],
        [_carminaAltera, 1, 'speculo', 'speculō', 0],
        [_carminaAltera, 2, 'levis', 'lēvis', 0],
        [_carminaAltera, 3, 'speculum', 'speculum', 0],
        [_carminaAltera, 4, 'et', 'et', 0],
        [_carminaAltera, 5, 'Roma', 'Rōma', 0],
        [_carminaAltera, 6, '.', '.', 0],
        [_carminaAltera, 7, 'est', 'est', 0],
        [_carminaAltera, 8, 'levis', 'levis', 2],
        [_carminaAltera, 9, '.', '.', 0],
        [_carminaAltera, 10, 'Roma', 'Rōma', 0],
        [_carminaAltera, 11, 'est', 'est', 0],
        [_carminaAltera, 12, '.', '.', 0],
      ],
    );
  });

  test('imports the analyses that have a lemma, with their inflections', () async {
    expect(
      await rows('''
        SELECT Details.form, Details.item, Details.dictionaryRef,
               COUNT( Inflections.cnt ) AS inflections
            FROM MorphologicalDetails AS Details
            LEFT JOIN MorphologicalDetailInflections AS Inflections
                ON Inflections.form = Details.form
                   AND Inflections.item = Details.item
            GROUP BY Details.form, Details.item
            ORDER BY Details.form, Details.item'''),
      [
        ['Roma', 0, 'Roma', 3],
        ['ad', 0, 'ad', 1],
        ['aura', 0, 'aura', 3],
        ['aura', 1, 'auro', 1],
        ['aura', 2, 'aurum', 3],
        ['de', 0, 'de', 2],
        ['est', 0, 'edo1', 1],
        ['est', 1, 'sum1', 1],
        ['et', 0, 'et', 1],
        ['levis', 0, 'levis1', 9],
        ['levis', 1, 'levis2', 9],
        ['speculo', 0, 'speculum', 2],
        ['speculum', 0, 'speculum', 4],
      ],
    );
  });

  test('imports the Lewis & Short entries', () async {
    expect(
      await rows('SELECT id, name, language, publisher, publicationDate FROM Dictionaries'),
      [
        [
          'c26efadb-83e9-4183-9327-01542e489e14',
          'Lewis & Short',
          'EN',
          'Harper and Brothers',
          '1879-07-01 00:00:00.000Z',
        ],
      ],
    );
    expect(
      await rows('SELECT lemma, partOfSpeech, inflection, idx FROM DictionaryEntries ORDER BY idx'),
      [
        ['ad', 'preposition', null, 667],
        ['aura', 'noun', 'ae', 4536],
        ['auro', 'verb', 'āre', 4584],
        ['aurum', 'noun', 'i', 4592],
        ['de1', 'adverb', 'indeclinable', 12376],
        ['de2', 'preposition', null, 12377],
        ['edo1', 'verb', 'ēdi, ēsum, 3', 15176],
        ['edo2', 'verb', 'dĭdi, dĭtum, 3', 15177],
        ['edo3', 'noun', 'ōnis', 15178],
        ['et', null, null, 16299],
        ['levis1', 'adjective', 'e', 26442],
        ['levis2', 'adjective', 'e', 26443],
        ['Roma', 'adjective', 'ae', 41885],
        ['speculum', 'noun', 'i', 45002],
        ['sum1', 'verb', 'fŭi, esse', 46579],
        ['sum2', null, null, 46580],
        ['sum3', null, null, 46581],
      ],
    );
  });

  test("resolves each analysis's lemma to a Lewis & Short entry", () async {
    expect(
      await rows('SELECT dictionaryRef, lnsLemma FROM LnsRefResolutions ORDER BY dictionaryRef'),
      [
        ['Roma', 'Roma'],
        ['ad', 'ad'],
        ['aura', 'aura'],
        ['auro', 'auro'],
        ['aurum', 'aurum'],
        ['de', 'de1'],
        ['edo1', 'edo1'],
        ['et', 'et'],
        ['levis1', 'levis1'],
        ['levis2', 'levis2'],
        ['speculum', 'speculum'],
        ['sum1', 'sum1'],
      ],
    );
  });

  test('gives each counted word the lemmas that its certain macrons leave', () async {
    expect(
      await rows('''
        SELECT Works.name AS work, Candidate.idx, Token.macronizedWord, Token.uncertaintyBitMask,
               Details.dictionaryRef
            FROM CountableWordCandidateAnalyses AS Candidate
            INNER JOIN Works
                ON Works.id = Candidate.workId
            INNER JOIN WorkContents AS Token
                ON Token.workId = Candidate.workId
                   AND Token.idx = Candidate.idx
            INNER JOIN MorphologicalDetails AS Details
                ON Details.form = Candidate.form
                   AND Details.item = Candidate.item
            ORDER BY Candidate.workId, Candidate.idx, Details.dictionaryRef'''),
      [
        [_carminaPrima, 0, 'Ad', 0, 'ad'],
        [_carminaPrima, 2, 'Levis', 0, 'levis1'],
        [_carminaPrima, 3, 'et', 0, 'et'],
        [_carminaPrima, 4, 'Rōma', 0, 'Roma'],
        [_carminaPrima, 5, 'est', 0, 'sum1'],
        [_carminaPrima, 7, 'et', 0, 'et'],
        [_carminaPrima, 8, 'levis', 0, 'levis1'],
        [_carminaPrima, 9, 'aura', 0, 'aura'],
        [_carminaPrima, 9, 'aura', 0, 'aurum'],
        [_carminaAltera, 0, 'Dē', 0, 'de'],
        [_carminaAltera, 1, 'speculō', 0, 'speculum'],
        [_carminaAltera, 2, 'lēvis', 0, 'levis1'],
        [_carminaAltera, 2, 'lēvis', 0, 'levis2'],
        [_carminaAltera, 3, 'speculum', 0, 'speculum'],
        [_carminaAltera, 4, 'et', 0, 'et'],
        [_carminaAltera, 5, 'Rōma', 0, 'Roma'],
        [_carminaAltera, 7, 'est', 0, 'sum1'],
        [_carminaAltera, 8, 'levis', 2, 'levis1'],
        [_carminaAltera, 8, 'levis', 2, 'levis2'],
        [_carminaAltera, 10, 'Rōma', 0, 'Roma'],
        [_carminaAltera, 11, 'est', 0, 'sum1'],
      ],
    );
  });

  test("counts each work's tokens by how many candidate lemmas they have", () async {
    expect(
      await rows('''
        SELECT Works.name AS work, Totals.totalForms, Totals.totalMacronForms, Totals.totalLemmas,
               Totals.totalTokens, Totals.noCandidateTokens, Totals.singleCandidateTokens,
               Totals.multipleCandidateTokens
            FROM ScopedFreqTotals AS Totals
            INNER JOIN Works
                ON Works.id = Totals.workId
            ORDER BY Totals.workId'''),
      [
        [_carminaPrima, 7, 7, 7, 9, 1, 7, 1],
        [_carminaAltera, 7, 8, 7, 10, 0, 8, 2],
      ],
    );
  });
}

/// CSV files in a directory, and the names of the files that population asked for.
class _FixtureCsvSource implements util.CsvSource {
  _FixtureCsvSource(this._directory);

  final Directory _directory;
  final Set<String> servedFileNames = {};

  @override
  Future<String> loadString(String fileName) {
    servedFileNames.add(fileName);
    return File(p.join(_directory.path, fileName)).readAsString();
  }

  //
}
