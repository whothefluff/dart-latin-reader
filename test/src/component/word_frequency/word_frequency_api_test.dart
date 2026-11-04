import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/word_frequency/lemma.dart';
import 'package:latin_reader/src/component/word_frequency/resolved_freq_morph_form_api.dart'
    show WorkIds;
import 'package:latin_reader/src/component/word_frequency/text_coverage_api.dart'
    show CoverageBasis;
import 'package:latin_reader/src/component/word_frequency/word_frequency_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'frequency_corpus.dart';

/// Reads the report of the fables, by lemma or by form, most frequent first unless [ascending].
Future<FrequencyReport> _readReport(
  AppDb db, {
  required bool groupByLemma,
  bool ascending = false,
  bool showMacrons = false,
}) => GetFrequencyReportUseCase(
  WordFrequencyRepository(db.wordFrequencyDrift),
  FrequencyFilter(
    workIds: WorkIds(const [fables]),
    pageSize: 50,
    offset: 0,
    ascending: ascending,
    groupByLemma: groupByLemma,
    showMacrons: showMacrons,
  ),
).invoke();

/// Returns each row's lemma, possible occurrences and single-candidate occurrences.
Iterable<(Lemma, int, int)> _countsByLemma(FrequencyReport report) => report.rows
    .cast<LemmaFrequencyRow>()
    .map((row) => (row.lemma, row.possibleOccurrences, row.singleCandidateOccurrences));

void main() {
  group('FrequencyFilter coverage bases', () {
    const cases = [
      (groupByLemma: false, showMacrons: false, basis: CoverageBasis.form, certain: null),
      (groupByLemma: false, showMacrons: true, basis: CoverageBasis.macronForm, certain: null),
      (
        groupByLemma: true,
        showMacrons: false,
        basis: CoverageBasis.anyCandidateLemma,
        certain: CoverageBasis.allCandidateLemmas,
      ),
      (
        groupByLemma: true,
        showMacrons: true,
        basis: CoverageBasis.anyCandidateLemma,
        certain: CoverageBasis.allCandidateLemmas,
      ),
    ];

    for (final (:groupByLemma, :showMacrons, :basis, :certain) in cases) {
      test('by lemma: $groupByLemma, macrons: $showMacrons -> ${basis.name}, '
          'certain: ${certain?.name}', () {
        final filter = FrequencyFilter(
          workIds: WorkIds(const []),
          pageSize: 50,
          offset: 0,
          ascending: false,
          groupByLemma: groupByLemma,
          showMacrons: showMacrons,
        );

        expect(filter.coverageBasis, basis);
        expect(filter.certainCoverageBasis, certain);
      });
    }
  });

  group('frequencyReport', () {
    late FrequencyCorpus corpus;

    setUp(() async {
      corpus = FrequencyCorpus();
      await corpus.addWork(fables);
    });

    tearDown(() => corpus.close());

    group('of bonis, which may be bonus or its sublemma bonae, and bonos', () {
      setUp(() async {
        await corpus.addWord(fables, 'bonis', times: 2);
        await corpus.addWord(fables, 'bonos');
        await corpus.addAnalysis('bonis', 'bonus');
        await corpus.addAnalysis('bonis', 'bonus', sublemma: 'bonae');
        await corpus.addAnalysis('bonos', 'bonus');
        await corpus.populate();
      });

      test('by lemma, each lemma is a row with its own counts, and one of the totals', () async {
        final report = await _readReport(corpus.db, groupByLemma: true);
        final rarestFirst = await _readReport(corpus.db, groupByLemma: true, ascending: true);
        final rows = [
          ((dictionaryRef: 'bonus', sublemma: ''), 3, 1),
          ((dictionaryRef: 'bonus', sublemma: 'bonae'), 2, 0),
        ];

        expect(_countsByLemma(report), rows);
        expect(_countsByLemma(rarestFirst), rows.reversed);
        expect(report.totalLemmas, 2);
      });

      for (final (ascending, showMacrons) in [
        (false, false),
        (true, false),
        (false, true),
        (true, true),
      ]) {
        test('by form, a form has each lemma that it may be '
            '(ascending: $ascending, macrons: $showMacrons)', () async {
          final report = await _readReport(
            corpus.db,
            groupByLemma: false,
            ascending: ascending,
            showMacrons: showMacrons,
          );
          final bonis = report.rows.cast<FormFrequencyRow>().singleWhere(
            (row) => row.displayForm == 'bonis',
          );

          expect(
            bonis.possibleLemmas,
            unorderedEquals([
              (dictionaryRef: 'bonus', sublemma: ''),
              (dictionaryRef: 'bonus', sublemma: 'bonae'),
            ]),
          );
        });
      }
    });

    test('two analyses of one lemma count once, as the only candidate of their form', () async {
      await corpus.addWord(fables, 'bonis');
      await corpus.addAnalysis('bonis', 'bonus', sublemma: 'bonae');
      await corpus.addAnalysis('bonis', 'bonus', sublemma: 'bonae');
      await corpus.populate();

      final report = await _readReport(corpus.db, groupByLemma: true);

      expect(_countsByLemma(report), [((dictionaryRef: 'bonus', sublemma: 'bonae'), 1, 1)]);
    });
  });
}
