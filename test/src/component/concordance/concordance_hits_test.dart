import 'package:collection/collection.dart';
import 'package:drift/drift.dart' show Variable;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/concordance/concordance_api.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

/// Frequency and the concordance must agree on what a word is: a concordance
/// search for a counted form finds every occurrence frequency counted, and
/// nothing else but the same spelling written with an enclitic (seque)
///
/// Runs on the bundled CSVs, so it takes as long as a population
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDb db;
  late ConcordanceRepository repository;
  late List<String> workIds;

  setUpAll(() async {
    db = AppDb(
      executor: NativeDatabase.memory(setup: util.setupRegExp),
      populateFromCsv: true,
    );
    repository = ConcordanceRepository(db.concordanceDrift);
    final catalog = await db.libraryDrift.getLibraryCatalog().get();
    workIds = catalog.map((row) => row.workId).toSet().toList();
  });

  tearDownAll(() async => db.close());

  /// Hits identified by their work and the tokens of their words
  Future<List<(String, List<int>)>> hits(
    ConcordanceQuery query, {
    int offset = 0,
    int limit = 1 << 30,
  }) async {
    final page = await repository.getHits(query, workIds, offset, limit);
    return page.hits.map((hit) => (hit.workId, hit.slotIndices.toList())).toList();
  }

  /// The word a hit is sorted by, found apart from the query: the next word after its last one or
  /// the one before its first, in its sentence and on its side of a title's end. Null for text
  /// order, or when there's no such word
  Future<String?> sortWord(ConcordanceSort sort, (String, List<int>) hit) async {
    final (workId, slots) = hit;
    final (idx, step) = switch (sort) {
      ConcordanceSort.textOrder => (slots.first, 0),
      ConcordanceSort.followingWord => (slots.last, 1),
      ConcordanceSort.precedingWord => (slots.first, -1),
    };
    final rows = await db
        .customSelect(
          '''
          SELECT LOWER( Neighbour.normForm ) AS word
              FROM WorkContents AS Word
              INNER JOIN WorkContents AS Neighbour
                  ON Neighbour.workId = Word.workId
                     AND Neighbour.sentenceIdx = Word.sentenceIdx
                     AND Neighbour.isTitle = Word.isTitle
                     AND Neighbour.wordIdx = Word.wordIdx + ?
              WHERE Word.workId = ?
                    AND Word.idx = ?''',
          variables: [Variable.withInt(step), Variable.withString(workId), Variable.withInt(idx)],
        )
        .get();
    return step == 0 ? null : rows.firstOrNull?.read<String>('word');
  }

  Future<int> total(ConcordanceCriterion criterion, {bool matchMacrons = false}) async {
    final query = ConcordanceQuery(slots: [criterion], matchMacrons: matchMacrons);
    return (await repository.getHits(query, workIds, 0, 1)).total;
  }

  /// Rows of (form, frequency's count, tokens written that way with an enclitic)
  Future<List<(String, int, int)>> counted(String formColumn, String lookupColumn) async {
    final rows = await db.customSelect('''
      SELECT Counted.$formColumn AS form,
             SUM( Counted.occurrences ) AS occurrences,
             ( SELECT COUNT( * )
                   FROM WorkContents
                   WHERE WorkContents.enclitic IS NOT NULL
                         AND WorkContents.$lookupColumn = Counted.$formColumn ) AS written
          FROM ScopedFormFreq AS Counted
          GROUP BY Counted.$formColumn''').get();
    return rows
        .map(
          (row) => (
            row.read<String>('form'),
            row.read<int>('occurrences'),
            row.read<int>('written'),
          ),
        )
        .toList();
  }

  test('a form has the hits frequency counts, plus its spelling with an enclitic', () async {
    final forms = await counted('form', 'lookupForm');
    final mismatches = await Future.wait(
      forms.map((form) async {
        final (text, occurrences, written) = form;
        final found = await total(FormCriterion(text, exactCase: true));
        final expected = occurrences + written;
        return found == expected ? null : '$text: $found, expected $expected';
      }),
    );
    expect(mismatches.nonNulls, isEmpty);
  }, timeout: Timeout.none);

  test('a macronized form has the hits frequency counts with macrons on', () async {
    final forms = await counted('macronForm', 'macronLookupForm');
    final mismatches = await Future.wait(
      forms.map((form) async {
        final (text, occurrences, written) = form;
        final found = await total(FormCriterion(text, exactCase: true), matchMacrons: true);
        final expected = occurrences + written;
        return found == expected ? null : '$text: $found, expected $expected';
      }),
    );
    expect(mismatches.nonNulls, isEmpty);
  }, timeout: Timeout.none);

  test("a lemma has as many hits as frequency's possible occurrences", () async {
    final lemmas = await db.customSelect('''
      SELECT dictionaryRef, SUM( possibleOccurrences ) AS occurrences
          FROM ScopedLemmaFreq
          GROUP BY dictionaryRef''').get();
    final mismatches = await Future.wait(
      lemmas.map((row) async {
        final ref = row.read<String>('dictionaryRef');
        final occurrences = row.read<int>('occurrences');
        final found = await total(LemmaCriterion(LemmaChoice(label: ref, dictionaryRefs: [ref])));
        return found == occurrences ? null : '$ref: $found, expected $occurrences';
      }),
    );
    expect(mismatches.nonNulls, isEmpty);
  }, timeout: Timeout.none);

  test('pages hold every hit exactly once, in every sort', () async {
    final query = ConcordanceQuery(
      slots: [
        const FormCriterion('et'),
        GrammarCriterion(GrammarFilter(const {GrammarFeature.gramCase: 'accusative'})),
      ],
      distances: const [3],
    );
    const pageSize = 37;
    final mismatches = await Future.wait(
      ConcordanceSort.values.map((sort) async {
        final sorted = query.withSort(sort);
        final all = await hits(sorted);
        final pages = await Future.wait(
          Iterable.generate(
            (all.length / pageSize).ceil(),
            (page) => hits(sorted, offset: page * pageSize, limit: pageSize),
          ),
        );
        // The order is total, so the pages read one after another are the whole list
        final paged = pages.expand((page) => page).toList();
        return all.isNotEmpty && '$paged' == '$all' ? null : '${sort.name}: ${all.length} hits';
      }),
    );
    expect(mismatches.nonNulls, isEmpty);
  }, timeout: Timeout.none);

  test('hits come in the order of their sort word, then of work and position', () async {
    final phrases = [
      ConcordanceQuery(slots: const [FormCriterion('et')]),
      ConcordanceQuery(
        slots: [
          const FormCriterion('et'),
          GrammarCriterion(GrammarFilter(const {GrammarFeature.gramCase: 'accusative'})),
        ],
        distances: const [3],
      ),
    ];
    final queries = phrases.expand((phrase) => ConcordanceSort.values.map(phrase.withSort));
    final disorders = await Future.wait(
      queries.map((query) async {
        final found = await hits(query);
        final words = await Future.wait(found.map((hit) => sortWord(query.sort, hit)));
        final keys = found
            .mapIndexed(
              (i, hit) => _SortKey(
                word: words[i],
                work: workIds.indexOf(hit.$1),
                slots: hit.$2,
              ),
            )
            .toList();
        final disorder = keys.indexed
            .skip(1)
            .firstWhereOrNull(
              (entry) => keys[entry.$1 - 1].compareTo(entry.$2) > 0,
            );
        // Without any word to sort by, text order would pass for every sort
        final vacuous = query.sort != ConcordanceSort.textOrder && words.nonNulls.isEmpty;
        final name = '${query.sort.name}, ${query.slots.length} words';
        return switch ((found.isEmpty || vacuous, disorder)) {
          (true, _) => '$name: nothing to sort',
          (false, (final i, final key)?) => '$name: hit $i, $key, after ${keys[i - 1]}',
          (false, null) => null,
        };
      }),
    );
    expect(disorders.nonNulls, isEmpty);
  }, timeout: Timeout.none);

  test('a macron typed as a combining mark reads as the letter with the macron', () async {
    final typed = await total(const FormCriterion('lupo\u0304'), matchMacrons: true);
    final composed = await total(const FormCriterion('lupō'), matchMacrons: true);
    expect(typed, composed);
  }, timeout: Timeout.none);

  // Passes trivially once every title ends its sentence in the pipeline
  test('a phrase never runs from a title into the text after it', () async {
    final crossings = await db.customSelect('''
      SELECT Title.workId, Title.idx, Title.lookupForm AS first, Text.lookupForm AS second
          FROM WorkContents AS Title
          INNER JOIN WorkContents AS Text
              ON Text.workId = Title.workId
                 AND Text.sentenceIdx = Title.sentenceIdx
                 AND Text.wordIdx = Title.wordIdx + 1
          WHERE Title.isTitle
                AND NOT Text.isTitle
                AND Title.lookupForm IS NOT NULL
                AND Text.lookupForm IS NOT NULL''').get();
    final crossed = await Future.wait(
      crossings.map((row) async {
        final workId = row.read<String>('workId');
        final idx = row.read<int>('idx');
        final found = await hits(
          ConcordanceQuery(
            slots: [
              FormCriterion(row.read<String>('first'), exactCase: true),
              FormCriterion(row.read<String>('second'), exactCase: true),
            ],
          ),
        );
        return found.any((hit) => hit.$1 == workId && hit.$2.first == idx) ? '$workId: $idx' : null;
      }),
    );
    expect(crossed.nonNulls, isEmpty);
  }, timeout: Timeout.none);

  test('titles only keeps the hits in titles, and titles excluded the rest', () async {
    final titleRows = await db
        .customSelect('SELECT workId, idx FROM WorkContents WHERE isTitle')
        .get();
    final titleTokens = titleRows
        .map((row) => (row.read<String>('workId'), row.read<int>('idx')))
        .toSet();
    final forms = await db
        .customSelect(
          'SELECT DISTINCT lookupForm AS form FROM WorkContents '
          'WHERE isTitle AND lookupForm IS NOT NULL',
        )
        .get();
    final mismatches = await Future.wait(
      forms.map((row) async {
        final form = FormCriterion(row.read<String>('form'), exactCase: true);
        Future<List<(String, List<int>)>> find(ConcordanceTitles titles) =>
            hits(ConcordanceQuery(slots: [form], titles: titles));
        bool inTitle((String, List<int>) hit) => titleTokens.contains((hit.$1, hit.$2.first));
        final all = await find(ConcordanceTitles.included);
        final only = await find(ConcordanceTitles.only);
        final excluded = await find(ConcordanceTitles.excluded);
        final ok =
            all.length == only.length + excluded.length &&
            only.every(inTitle) &&
            !excluded.any(inTitle);
        return ok
            ? null
            : '${form.text}: ${all.length}, only ${only.length}, excluded ${excluded.length}';
      }),
    );
    expect(forms, isNotEmpty);
    expect(mismatches.nonNulls, isEmpty);
  }, timeout: Timeout.none);
}

/// Where the query puts a hit: by its sort word (none goes last), then by work and by its words'
/// tokens (first, last, then second and third, as ORDER BY has them)
class _SortKey implements Comparable<_SortKey> {
  _SortKey({
    required this.word,
    required this.work,
    required List<int> slots,
  }) : tokens = [slots.first, slots.last, ...slots.skip(1)];

  final String? word;

  /// Position in the searched works
  final int work;

  final List<int> tokens;

  // Dart compares by UTF-16 units and SQLite by UTF-8 bytes: the same order for these letters
  @override
  int compareTo(_SortKey other) => [
    (word == null ? 1 : 0).compareTo(other.word == null ? 1 : 0),
    (word ?? '').compareTo(other.word ?? ''),
    work.compareTo(other.work),
    ...IterableZip([tokens, other.tokens]).map((pair) => pair[0].compareTo(pair[1])),
  ].firstWhere((order) => order != 0, orElse: () => 0);

  @override
  String toString() => '_SortKey{word: $word, work: $work, tokens: $tokens}';
  //
}
