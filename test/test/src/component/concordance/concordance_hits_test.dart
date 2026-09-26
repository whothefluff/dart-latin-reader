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

  test('pages hold every hit exactly once', () async {
    final query = ConcordanceQuery(
      slots: [
        const FormCriterion('et'),
        GrammarCriterion(GrammarFilter(const {GrammarFeature.gramCase: 'accusative'})),
      ],
      distances: const [3],
      sort: ConcordanceSort.followingWord,
    );
    final all = await hits(query);
    const pageSize = 37;
    final pages = await Future.wait(
      Iterable.generate(
        (all.length / pageSize).ceil(),
        (page) => hits(query, offset: page * pageSize, limit: pageSize),
      ),
    );
    final paged = pages.expand((page) => page).map((hit) => '$hit').toList();
    expect(all, isNotEmpty);
    expect(paged.length, all.length);
    expect(paged.toSet(), all.map((hit) => '$hit').toSet());
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

  test('titles only and titles excluded add up to all the hits', () async {
    final forms = await db
        .customSelect(
          'SELECT DISTINCT lookupForm AS form FROM WorkContents '
          'WHERE isTitle AND lookupForm IS NOT NULL',
        )
        .get();
    final mismatches = await Future.wait(
      forms.map((row) async {
        final form = FormCriterion(row.read<String>('form'), exactCase: true);
        Future<int> count(ConcordanceTitles titles) async =>
            (await hits(ConcordanceQuery(slots: [form], titles: titles))).length;
        final all = await count(ConcordanceTitles.included);
        final only = await count(ConcordanceTitles.only);
        final excluded = await count(ConcordanceTitles.excluded);
        return all == only + excluded ? null : '${form.text}: $all, not $only + $excluded';
      }),
    );
    expect(forms, isNotEmpty);
    expect(mismatches.nonNulls, isEmpty);
  }, timeout: Timeout.none);
}
