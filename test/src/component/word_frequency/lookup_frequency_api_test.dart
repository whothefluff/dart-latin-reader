import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/catalog_api.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';
import 'package:latin_reader/src/component/word_frequency/lookup_frequency_api.dart';
import 'package:latin_reader/src/component/word_frequency/text_coverage_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'frequency_corpus.dart';

const _anonymous = '00000000-0000-0000-0000-00000000000a';

/// Fables and letters by one author, and a work with none.
LibraryCatalog _catalog() => LibraryCatalog(
  authors: UnmodifiableListView([
    CatalogAuthor(
      id: 'phaedrus',
      name: 'Phaedrus',
      works: UnmodifiableListView(const [
        CatalogWork(id: fables, name: 'Fables'),
        CatalogWork(id: letters, name: 'Letters'),
      ]),
    ),
  ]),
  anonymousWorks: UnmodifiableListView(const [CatalogWork(id: _anonymous, name: 'Anonymous')]),
);

/// Forms counted 5, 2, 2 and 1 times, each a lookup with one candidate lemma.
LookupFrequencies _formsOfTenUnits() => LookupFrequencies(
  counts: const [
    LookupCount(lookupForm: 'et', alsoLowercase: false, occurrences: 5),
    LookupCount(lookupForm: 'in', alsoLowercase: false, occurrences: 2),
    LookupCount(lookupForm: 'non', alsoLowercase: false, occurrences: 2),
    LookupCount(lookupForm: 'sed', alsoLowercase: false, occurrences: 1),
  ],
  coverage: TextCoverage(
    steps: const [
      TextCoverageStep(minOccurrences: 5, coveredUnits: 5),
      TextCoverageStep(minOccurrences: 2, coveredUnits: 9),
      TextCoverageStep(minOccurrences: 1, coveredUnits: 10),
    ],
    totalUnits: 10,
  ),
);

Future<LookupFrequencies> _readFrequencies(
  AppDb db,
  String workId,
  FrequencyScope scope,
  List<String> lookupForms,
) {
  final container = ProviderContainer(
    overrides: [
      dbProvider.overrideWith((_) => db),
      libraryCatalogProvider.overrideWith((_) => _catalog()),
    ],
  );
  addTearDown(container.dispose);
  return container
      .listen(lookupFrequenciesProvider(workId, scope, LookupForms(lookupForms)).future, (_, _) {})
      .read();
}

void main() {
  group('FrequencyScope', () {
    test('the work alone', () {
      expect(FrequencyScope.work.workIdsFor(letters, _catalog()), [letters]);
    });

    test('every work of its author', () {
      expect(FrequencyScope.author.workIdsFor(fables, _catalog()), [letters, fables]);
    });

    test('a work with no author has no other works to add', () {
      expect(FrequencyScope.author.workIdsFor(_anonymous, _catalog()), [_anonymous]);
    });

    test('every work in the library', () {
      expect(FrequencyScope.library.workIdsFor(fables, _catalog()), [_anonymous, letters, fables]);
    });
  });

  group('FrequencyBands', () {
    test('common words are the most frequent, uncommon the rarest', () {
      final bands = _formsOfTenUnits().bandsFor(
        commonPercent: 50,
        uncommonPercent: 10,
        markCommon: true,
        markUncommon: true,
      );
      Lookup form(String lookupForm) => Lookup(lookupForm: lookupForm, alsoLowercase: false);

      expect(bands.bandOf(form('et')), FrequencyBand.common);
      expect(bands.bandOf(form('in')), isNull);
      expect(bands.bandOf(form('sed')), FrequencyBand.uncommon);
    });

    test('common wins where the two bands overlap', () {
      final bands = _formsOfTenUnits().bandsFor(
        commonPercent: 100,
        uncommonPercent: 100,
        markCommon: true,
        markUncommon: true,
      );

      expect(
        bands.bandOf(const Lookup(lookupForm: 'sed', alsoLowercase: false)),
        FrequencyBand.common,
      );
    });

    test('a lookup with no counted candidate lemma is in neither band', () {
      final bands = _formsOfTenUnits().bandsFor(
        commonPercent: 50,
        uncommonPercent: 30,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(const Lookup(lookupForm: 'xyzzy', alsoLowercase: false)), isNull);
      expect(bands.bandOf(const Lookup(lookupForm: 'et', alsoLowercase: true)), isNull);
    });

    test('only a name that may be a common word is looked up in lowercase too', () {
      expect(
        [ProperNounState.either, ProperNounState.proper, ProperNounState.common, null].map(
          (state) => Lookup.of('Venere', state).alsoLowercase,
        ),
        [true, false, false, false],
      );
    });

    test('a band left out takes no words from the other', () {
      // at 60% and 30%, in and non fall in both bands, and common wins
      final both = _formsOfTenUnits().bandsFor(
        commonPercent: 60,
        uncommonPercent: 30,
        markCommon: true,
        markUncommon: true,
      );
      final uncommonOnly = _formsOfTenUnits().bandsFor(
        commonPercent: 60,
        uncommonPercent: 30,
        markCommon: false,
        markUncommon: true,
      );
      const inForm = Lookup(lookupForm: 'in', alsoLowercase: false);

      expect(both.bandOf(inForm), FrequencyBand.common);
      expect(uncommonOnly.bandOf(inForm), FrequencyBand.uncommon);
    });
  });

  group('lookupFrequenciesProvider', () {
    late FrequencyCorpus corpus;

    setUp(() async {
      corpus = FrequencyCorpus();
      await corpus.addWork(fables);
      await corpus.addWork(letters);
    });

    tearDown(() => corpus.close());

    test('a word counts as its most frequent candidate lemma in the works of the scope', () async {
      // Fables: est may be sum1 or edo1, edit is edo1. Letters: sunt is sum1.
      // In the fables alone edo1 (3) beats sum1 (1); with the letters sum1 (5) beats it
      await corpus.addWord(fables, 'est');
      await corpus.addWord(fables, 'edit', times: 2);
      await corpus.addWord(letters, 'sunt', times: 4);
      await corpus.addAnalysis('est', 'sum1');
      await corpus.addAnalysis('est', 'edo1');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.addAnalysis('sunt', 'sum1');
      await corpus.populate();
      const edit = Lookup(lookupForm: 'edit', alsoLowercase: false);

      final work = await _readFrequencies(corpus.db, fables, FrequencyScope.work, ['est', 'edit']);
      final author = await _readFrequencies(
        corpus.db,
        fables,
        FrequencyScope.author,
        ['est', 'edit'],
      );

      // edit (3) is as frequent as anything in the fables, and the rarest with the letters
      expect(
        work
            .bandsFor(
              commonPercent: 50,
              uncommonPercent: 20,
              markCommon: true,
              markUncommon: true,
            )
            .bandOf(edit),
        FrequencyBand.common,
      );
      expect(
        author
            .bandsFor(
              commonPercent: 50,
              uncommonPercent: 20,
              markCommon: true,
              markUncommon: true,
            )
            .bandOf(edit),
        FrequencyBand.uncommon,
      );
    });

    test('a word read as either a name or a common word has the candidates of both', () async {
      // Venere (either) is Venus1 or venio (4, with venit); Venere (a name) only Venus1 (2)
      await corpus.addWord(fables, 'venit', times: 3);
      await corpus.addWord(fables, 'Venere', properNounState: ProperNounState.either);
      await corpus.addWord(fables, 'Venere', properNounState: ProperNounState.proper);
      await corpus.addAnalysis('venit', 'venio');
      await corpus.addAnalysis('Venere', 'Venus1');
      await corpus.addAnalysis('venere', 'venio');
      await corpus.populate();

      final frequencies = await _readFrequencies(
        corpus.db,
        fables,
        FrequencyScope.work,
        ['venit', 'Venere'],
      );
      final bands = frequencies.bandsFor(
        commonPercent: 80,
        uncommonPercent: 20,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(const Lookup.of('Venere', ProperNounState.either)), FrequencyBand.common);
      expect(
        bands.bandOf(const Lookup.of('Venere', ProperNounState.proper)),
        FrequencyBand.uncommon,
      );
    });

    test('a word without candidate lemmas is in neither band', () async {
      await corpus.addWord(fables, 'amat', times: 2);
      await corpus.addWord(fables, 'Xanthus', properNounState: ProperNounState.proper);
      await corpus.addAnalysis('amat', 'amo1');
      await corpus.populate();

      final frequencies = await _readFrequencies(
        corpus.db,
        fables,
        FrequencyScope.work,
        ['amat', 'Xanthus'],
      );
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 30,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(const Lookup.of('amat', ProperNounState.common)), FrequencyBand.common);
      expect(bands.bandOf(const Lookup.of('Xanthus', ProperNounState.proper)), isNull);
    });
  });
}
