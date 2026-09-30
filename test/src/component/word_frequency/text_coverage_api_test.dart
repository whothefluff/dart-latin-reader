import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';
import 'package:latin_reader/src/component/word_frequency/resolved_freq_morph_form_api.dart'
    show WorkIds;
import 'package:latin_reader/src/component/word_frequency/text_coverage_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'frequency_corpus.dart';

/// Forms occurring 5, 2, 2 and 1 times.
TextCoverage _formsOfTenUnits() => TextCoverage(
  steps: const [
    TextCoverageStep(minOccurrences: 5, coveredUnits: 5),
    TextCoverageStep(minOccurrences: 2, coveredUnits: 9),
    TextCoverageStep(minOccurrences: 1, coveredUnits: 10),
  ],
  totalUnits: 10,
);

/// Two of the twelve units have no candidate lemma.
TextCoverage _lemmasOfTwelveUnits() => TextCoverage(
  steps: const [
    TextCoverageStep(minOccurrences: 6, coveredUnits: 6),
    TextCoverageStep(minOccurrences: 1, coveredUnits: 10),
  ],
  totalUnits: 12,
);

Future<TextCoverage> _readCoverage(
  AppDb db,
  List<String> works,
  CoverageBasis basis,
) {
  final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
  addTearDown(container.dispose);
  return container.listen(textCoverageProvider(WorkIds(works), basis).future, (_, _) {}).read();
}

void main() {
  group('TextCoverage', () {
    for (final (atLeast, units) in [(5, 5), (2, 9), (1, 10)]) {
      test('the items counted at least $atLeast times make up $units units', () {
        expect(_formsOfTenUnits().unitsCovered(atLeast: atLeast), units);
      });
    }

    for (final (atLeast, units) in [(4, 5), (3, 5)]) {
      test('a count between steps ($atLeast) covers what the next higher count does', () {
        expect(_formsOfTenUnits().unitsCovered(atLeast: atLeast), units);
      });
    }

    test('a count above the most frequent item covers nothing', () {
      expect(_formsOfTenUnits().unitsCovered(atLeast: 6), 0);
    });

    test('a count of zero covers every item', () {
      expect(_formsOfTenUnits().unitsCovered(atLeast: 0), 10);
    });

    test('the share is of every unit, covered or not', () {
      final coverage = _lemmasOfTwelveUnits();

      expect(coverage.share(atLeast: 6), 6 / 12);
      expect(coverage.share(atLeast: 1), 10 / 12);
    });

    test('no units make a share of 0 rather than a division by zero', () {
      final coverage = TextCoverage(steps: const [], totalUnits: 0);

      expect(coverage.unitsCovered(atLeast: 1), 0);
      expect(coverage.share(atLeast: 1), 0);
    });

    test('the order the steps come in changes nothing', () {
      final shuffled = TextCoverage(
        steps: const [
          TextCoverageStep(minOccurrences: 2, coveredUnits: 9),
          TextCoverageStep(minOccurrences: 1, coveredUnits: 10),
          TextCoverageStep(minOccurrences: 5, coveredUnits: 5),
        ],
        totalUnits: 10,
      );

      expect(shuffled, _formsOfTenUnits());
      expect(shuffled.unitsCovered(atLeast: 3), 5);
    });

    for (final (share, cutoff) in [(0.5, 5), (0.51, 2), (0.9, 2), (0.91, 1), (1.0, 1)]) {
      test('covering $share of the units takes the items counted $cutoff times or more', () {
        expect(_formsOfTenUnits().cutoffFor(share), cutoff);
      });
    }

    // For these percentages, k / 100 * 100 rounds above k.
    for (final k in [7, 14, 28, 55, 56]) {
      test('a share reached exactly is enough ($k of 100 units)', () {
        // One form counted k times, and 100 - k forms counted once
        final coverage = TextCoverage(
          steps: [
            TextCoverageStep(minOccurrences: k, coveredUnits: k),
            const TextCoverageStep(minOccurrences: 1, coveredUnits: 100),
          ],
          totalUnits: 100,
        );

        expect(coverage.cutoffFor(k / 100), k);
      });
    }

    test('the cutoff for the share at a count is that count', () {
      // One form counted each of 1 to 60 times: 1,830 units, 60 steps
      final coverage = TextCoverage(
        steps: List.generate(
          60,
          (i) => TextCoverageStep(
            minOccurrences: i + 1,
            coveredUnits: List.generate(60 - i, (j) => i + 1 + j).sum,
          ),
        ),
        totalUnits: 1830,
      );
      final counts = List.generate(60, (i) => i + 1);

      expect(counts.map((n) => coverage.cutoffFor(coverage.share(atLeast: n))), counts);
    });

    test('a share beyond what every item covers has no cutoff', () {
      final coverage = _lemmasOfTwelveUnits();

      expect(coverage.cutoffFor(0.8), 1);
      expect(coverage.cutoffFor(0.9), isNull);
    });

    test('a share outside 0 to 1 is a mistake', () {
      expect(() => _formsOfTenUnits().cutoffFor(1.5), throwsA(isA<AssertionError>()));
    });

    for (final (share, cutoff) in [(0.1, 1), (0.11, 2), (0.5, 2), (0.51, 5), (1.0, 5)]) {
      test('the rarest items making up $share of the units are counted $cutoff times or less', () {
        expect(_formsOfTenUnits().rareCutoffFor(share), cutoff);
      });
    }

    for (final k in [7, 14, 28, 55, 56]) {
      test('a rare share reached exactly is enough ($k of 100 units)', () {
        // k forms counted once, and one form counted 100 - k times
        final coverage = TextCoverage(
          steps: [
            TextCoverageStep(minOccurrences: 100 - k, coveredUnits: 100 - k),
            const TextCoverageStep(minOccurrences: 1, coveredUnits: 100),
          ],
          totalUnits: 100,
        );

        expect(coverage.rareCutoffFor(k / 100), 1);
      });
    }

    test('units with no candidate lemma are never among the rarest', () {
      final coverage = _lemmasOfTwelveUnits();

      expect(coverage.rareCutoffFor(0.3), 1);
      expect(coverage.rareCutoffFor(0.8), 6);
      expect(coverage.rareCutoffFor(0.9), isNull);
    });

    test('a rare share outside 0 to 1 is a mistake', () {
      expect(() => _formsOfTenUnits().rareCutoffFor(-0.1), throwsA(isA<AssertionError>()));
    });
  });

  group('textCoverageProvider', () {
    late FrequencyCorpus corpus;

    setUp(() async {
      corpus = FrequencyCorpus();
      await corpus.addWork(fables);
    });

    tearDown(() => corpus.close());

    test('forms counted equally often are covered together', () async {
      await corpus.addWord(fables, 'et', times: 3);
      await corpus.addWord(fables, 'in', times: 2);
      await corpus.addWord(fables, 'non', times: 2);
      await corpus.addWord(fables, 'sed');
      await corpus.populate();

      final coverage = await _readCoverage(corpus.db, [fables], CoverageBasis.form);

      expect(coverage.totalUnits, 8);
      expect(coverage.unitsCovered(atLeast: 3), 3);
      expect(coverage.unitsCovered(atLeast: 2), 7);
      expect(coverage.unitsCovered(atLeast: 1), 8);
    });

    test('macronized forms are counted apart, plain forms together', () async {
      await corpus.addWord(fables, 'est', times: 2);
      await corpus.addWord(fables, 'est', macronizedWord: 'ēst');
      await corpus.populate();

      final plain = await _readCoverage(corpus.db, [fables], CoverageBasis.form);
      final macronized = await _readCoverage(corpus.db, [fables], CoverageBasis.macronForm);

      expect(plain.unitsCovered(atLeast: 3), 3);
      expect(macronized.unitsCovered(atLeast: 3), 0);
      expect(macronized.unitsCovered(atLeast: 2), 2);
      expect(macronized.unitsCovered(atLeast: 1), 3);
    });

    test('a unit counts once, under its most frequent candidate lemma', () async {
      await corpus.addWord(fables, 'est', times: 3);
      await corpus.addWord(fables, 'sunt', times: 2);
      await corpus.addWord(fables, 'edit');
      await corpus.addAnalysis('est', 'sum1');
      await corpus.addAnalysis('est', 'edo1');
      await corpus.addAnalysis('sunt', 'sum1');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.populate();

      final coverage = await _readCoverage(corpus.db, [fables], CoverageBasis.anyCandidateLemma);

      expect(coverage.totalUnits, 6);
      // sum1 covers est and sunt; edo1 adds only edit.
      expect(coverage.unitsCovered(atLeast: 5), 5);
      expect(coverage.unitsCovered(atLeast: 4), 6);
    });

    test('a unit is certainly covered only once all its candidate lemmas are', () async {
      await corpus.addWord(fables, 'est', times: 3);
      await corpus.addWord(fables, 'sunt', times: 2);
      await corpus.addWord(fables, 'edit');
      await corpus.addAnalysis('est', 'sum1');
      await corpus.addAnalysis('est', 'edo1');
      await corpus.addAnalysis('sunt', 'sum1');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.populate();

      final coverage = await _readCoverage(corpus.db, [fables], CoverageBasis.allCandidateLemmas);

      expect(coverage.totalUnits, 6);
      // est is covered only when edo1 joins sum1 at the 4+ threshold.
      expect(coverage.unitsCovered(atLeast: 5), 2);
      expect(coverage.unitsCovered(atLeast: 4), 6);
    });

    test('certain coverage never exceeds any-candidate coverage', () async {
      await corpus.addWord(fables, 'est', times: 4);
      await corpus.addWord(fables, 'sunt', times: 3);
      await corpus.addWord(fables, 'edit', times: 2);
      await corpus.addWord(fables, 'amat', times: 2);
      await corpus.addWord(fables, 'Xanthus');
      await corpus.addWord(fables, 'Venere', properNounState: ProperNounState.either);
      await corpus.addWord(fables, 'venit', times: 3);
      await corpus.addAnalysis('est', 'sum1');
      await corpus.addAnalysis('est', 'edo1');
      await corpus.addAnalysis('sunt', 'sum1');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.addAnalysis('amat', 'amo1');
      await corpus.addAnalysis('Venere', 'Venus1');
      await corpus.addAnalysis('venere', 'venio');
      await corpus.addAnalysis('venit', 'venio');
      await corpus.populate();

      final any = await _readCoverage(corpus.db, [fables], CoverageBasis.anyCandidateLemma);
      final certain = await _readCoverage(corpus.db, [fables], CoverageBasis.allCandidateLemmas);
      final counts = List.generate(9, (i) => i);

      expect(
        counts.map((n) => certain.unitsCovered(atLeast: n) <= any.unitsCovered(atLeast: n)),
        everyElement(isTrue),
      );
      expect(certain, isNot(any), reason: 'the corpus must tell the two apart');
    });

    test('units with no candidate lemma are never covered by lemmas', () async {
      await corpus.addWord(fables, 'amat', times: 2);
      await corpus.addWord(fables, 'Xanthus', properNounState: ProperNounState.proper);
      await corpus.addAnalysis('amat', 'amo1');
      await corpus.populate();

      final lemmas = await _readCoverage(corpus.db, [fables], CoverageBasis.anyCandidateLemma);
      final certain = await _readCoverage(corpus.db, [fables], CoverageBasis.allCandidateLemmas);
      final forms = await _readCoverage(corpus.db, [fables], CoverageBasis.form);

      expect(lemmas.totalUnits, 3);
      expect(lemmas.unitsCovered(atLeast: 1), 2);
      expect(lemmas.cutoffFor(1), isNull);
      expect(certain.unitsCovered(atLeast: 1), 2);
      expect(forms.unitsCovered(atLeast: 1), 3);
    });

    test('a word read as either a name or a common word has the candidates of both', () async {
      // Both Venere tokens share a display form; only the one read as either also matches venio.
      await corpus.addWord(fables, 'venit', times: 3);
      await corpus.addWord(fables, 'Venere', properNounState: ProperNounState.either);
      await corpus.addWord(fables, 'Venere', properNounState: ProperNounState.proper);
      await corpus.addAnalysis('venit', 'venio');
      await corpus.addAnalysis('Venere', 'Venus1');
      await corpus.addAnalysis('venere', 'venio');
      await corpus.populate();

      final coverage = await _readCoverage(corpus.db, [fables], CoverageBasis.anyCandidateLemma);

      expect(coverage.unitsCovered(atLeast: 4), 4);
      expect(coverage.unitsCovered(atLeast: 2), 5);
    });

    test('a detached enclitic is a unit of its own', () async {
      // The host is looked up as populusque; que is counted separately.
      await corpus.addWord(fables, 'populusque', enclitic: 'que');
      await corpus.addAnalysis('populusque', 'populus1');
      await corpus.addAnalysis('que', 'que');
      await corpus.populate();

      final forms = await _readCoverage(corpus.db, [fables], CoverageBasis.form);
      final lemmas = await _readCoverage(corpus.db, [fables], CoverageBasis.anyCandidateLemma);

      expect(forms.totalUnits, 2);
      expect(forms.unitsCovered(atLeast: 1), 2);
      expect(lemmas.unitsCovered(atLeast: 1), 2);
    });

    test('the most frequent candidate depends on the works selected', () async {
      await corpus.addWork(letters);
      await corpus.addWord(fables, 'est');
      await corpus.addWord(fables, 'edit', times: 2);
      await corpus.addWord(letters, 'sunt', times: 4);
      await corpus.addAnalysis('est', 'sum1');
      await corpus.addAnalysis('est', 'edo1');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.addAnalysis('sunt', 'sum1');
      await corpus.populate();

      final fablesOnly = await _readCoverage(corpus.db, [fables], CoverageBasis.anyCandidateLemma);
      final both = await _readCoverage(
        corpus.db,
        [fables, letters],
        CoverageBasis.anyCandidateLemma,
      );

      // est counts under edo1 in fables, but under sum1 when letters are included.
      expect(fablesOnly.totalUnits, 3);
      expect(fablesOnly.unitsCovered(atLeast: 3), 3);
      expect(both.totalUnits, 7);
      expect(both.unitsCovered(atLeast: 5), 5);
      expect(both.unitsCovered(atLeast: 3), 7);
    });

    test('works with no counted words cover nothing', () async {
      await corpus.populate();

      final coverage = await _readCoverage(corpus.db, [fables], CoverageBasis.anyCandidateLemma);

      expect(coverage.totalUnits, 0);
      expect(coverage.share(atLeast: 1), 0);
    });
  });
}
