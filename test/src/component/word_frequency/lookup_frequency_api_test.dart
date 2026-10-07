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

/// The lookup of [form] as a common word written without macrons, every letter certain
Lookup _common(String form) => Lookup(
  lookupForm: form,
  alsoLowercase: false,
  macronized: (form: form, uncertaintyBitMask: 0),
);

LookupCount _countOf(String form, int occurrences) => LookupCount(
  lookupForm: form,
  alsoLowercase: false,
  macronLookupForm: form,
  uncertaintyBitMask: 0,
  occurrences: occurrences,
);

/// Forms counted 5, 2, 2 and 1 times, each a lookup with one candidate lemma.
LookupFrequencies _formsOfTenUnits() => LookupFrequencies(
  counts: [_countOf('et', 5), _countOf('in', 2), _countOf('non', 2), _countOf('sed', 1)],
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
      expect(bands.bandOf(_common('et')), FrequencyBand.common);
      expect(bands.bandOf(_common('in')), isNull);
      expect(bands.bandOf(_common('sed')), FrequencyBand.uncommon);
    });

    test('common wins where the two bands overlap', () {
      final bands = _formsOfTenUnits().bandsFor(
        commonPercent: 100,
        uncommonPercent: 100,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('sed')), FrequencyBand.common);
    });

    test('a lookup with no counted candidate lemma is in neither band', () {
      final bands = _formsOfTenUnits().bandsFor(
        commonPercent: 50,
        uncommonPercent: 30,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('xyzzy')), isNull);
      expect(
        bands.bandOf(
          const Lookup(
            lookupForm: 'et',
            alsoLowercase: true,
            macronized: (form: 'et', uncertaintyBitMask: 0),
          ),
        ),
        isNull,
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
      expect(both.bandOf(_common('in')), FrequencyBand.common);
      expect(uncommonOnly.bandOf(_common('in')), FrequencyBand.uncommon);
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
      final edit = _common('edit');

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

      expect(
        bands.bandOf(
          const Lookup.of(
            'Venere',
            ProperNounState.either,
            macronized: (form: 'Venere', uncertaintyBitMask: 0),
          ),
        ),
        FrequencyBand.common,
      );
      expect(
        bands.bandOf(
          const Lookup.of(
            'Venere',
            ProperNounState.proper,
            macronized: (form: 'Venere', uncertaintyBitMask: 0),
          ),
        ),
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

      expect(bands.bandOf(_common('amat')), FrequencyBand.common);
      expect(
        bands.bandOf(
          const Lookup.of(
            'Xanthus',
            ProperNounState.proper,
            macronized: (form: 'Xanthus', uncertaintyBitMask: 0),
          ),
        ),
        isNull,
      );
    });

    test('a lemma whose analyses all make a certain short vowel long is not a candidate', () async {
      // est is sum1 (est) or edo1 (ēst), and its e is certainly short, so only edit counts for edo1
      await corpus.addWord(fables, 'est', times: 4);
      await corpus.addWord(fables, 'edit');
      await corpus.addAnalysis('est', 'sum1', macronizedForm: 'est');
      await corpus.addAnalysis('est', 'edo1', macronizedForm: 'ēst');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'est',
        'edit',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 20,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('edit')), FrequencyBand.uncommon);
    });

    test('an uncertain vowel rules no lemma out', () async {
      // as above, but the e of est may be long, so edo1 counts est too
      await corpus.addWord(fables, 'est', times: 4, uncertaintyBitMask: 1);
      await corpus.addWord(fables, 'edit');
      await corpus.addAnalysis('est', 'sum1', macronizedForm: 'est');
      await corpus.addAnalysis('est', 'edo1', macronizedForm: 'ēst');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'est',
        'edit',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 20,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('edit')), FrequencyBand.common);
    });

    test('a lemma stays a candidate while one of its spellings fits the text', () async {
      // venio is spelled venit and vēnit, veneo only vēnit: the certain short e rules out veneo
      await corpus.addWord(fables, 'venit', times: 4);
      await corpus.addWord(fables, 'veneunt', macronizedWord: 'vēneunt');
      await corpus.addAnalysis('venit', 'venio', macronizedForm: 'venit');
      await corpus.addAnalysis('venit', 'venio', macronizedForm: 'vēnit');
      await corpus.addAnalysis('venit', 'veneo', macronizedForm: 'vēnit');
      await corpus.addAnalysis('veneunt', 'veneo');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'venit',
        'veneunt',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 20,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('venit')), FrequencyBand.common);
      expect(
        bands.bandOf(
          const Lookup.of(
            'veneunt',
            ProperNounState.common,
            macronized: (form: 'vēneunt', uncertaintyBitMask: 0),
          ),
        ),
        FrequencyBand.uncommon,
      );
    });

    test('a lemma stays a candidate while one of its analyses has no spelling', () async {
      // edo1's first analysis of est is spelled ēst, its second has no inflections to go by
      await corpus.addWord(fables, 'est', times: 4);
      await corpus.addWord(fables, 'edit');
      await corpus.addAnalysis('est', 'sum1', macronizedForm: 'est');
      await corpus.addAnalysis('est', 'edo1', macronizedForm: 'ēst');
      await corpus.addAnalysis('est', 'edo1');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'est',
        'edit',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 20,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('edit')), FrequencyBand.common);
    });

    test('a long vowel in the text rules out no lemma whose analyses leave it unmarked', () async {
      // the noun serpens doesn't mark the long e of serpēns, the participle (serpo) does
      await corpus.addWord(fables, 'serpens', macronizedWord: 'serpēns');
      await corpus.addWord(fables, 'serpentem', times: 3);
      await corpus.addAnalysis('serpens', 'serpens', macronizedForm: 'serpens');
      await corpus.addAnalysis('serpens', 'serpo', macronizedForm: 'serpēns');
      await corpus.addAnalysis('serpentem', 'serpens');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'serpens',
        'serpentem',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 25,
        markCommon: true,
        markUncommon: true,
      );

      expect(
        bands.bandOf(
          const Lookup.of(
            'serpens',
            ProperNounState.common,
            macronized: (form: 'serpēns', uncertaintyBitMask: 0),
          ),
        ),
        FrequencyBand.common,
      );
    });

    test('a word whose every candidate would be ruled out keeps them all', () async {
      await corpus.addWord(fables, 'est');
      await corpus.addWord(fables, 'sunt', times: 3);
      await corpus.addAnalysis('est', 'sum1', macronizedForm: 'ēst');
      await corpus.addAnalysis('est', 'edo1', macronizedForm: 'ēst');
      await corpus.addAnalysis('sunt', 'sum1');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'est',
        'sunt',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 25,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('est')), FrequencyBand.common);
    });

    test('only macrons are compared, not the letters that carry them', () async {
      // iam1 is spelled jam and iam2 jām: the certain short a rules out iam2, the j doesn't
      await corpus.addWord(fables, 'iam');
      await corpus.addWord(fables, 'ianum', times: 3);
      await corpus.addAnalysis('iam', 'iam1', macronizedForm: 'jam');
      await corpus.addAnalysis('iam', 'iam2', macronizedForm: 'jām');
      await corpus.addAnalysis('ianum', 'iam2');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'iam',
        'ianum',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 25,
        markCommon: true,
        markUncommon: true,
      );

      expect(bands.bandOf(_common('iam')), FrequencyBand.uncommon);
    });

    test('an analysis spelled with a different number of letters rules nothing out', () async {
      // the analyses of estque spell only est, so ēst doesn't rule out edo1
      await corpus.addWord(fables, 'estque', times: 4, enclitic: 'que');
      await corpus.addWord(fables, 'edit');
      await corpus.addAnalysis('estque', 'sum1');
      await corpus.addAnalysis('estque', 'edo1', macronizedForm: 'ēst');
      await corpus.addAnalysis('edit', 'edo1');
      await corpus.populate();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'estque',
        'edit',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 40,
        uncommonPercent: 10,
        markCommon: true,
        markUncommon: false,
      );

      expect(bands.bandOf(_common('edit')), FrequencyBand.common);
    });

    test('an expansion rules out lemmas like a word, and the reader finds it', () async {
      // Lucius2 is spelled Lūcīus, and an expansion's macrons are certain: Lūcius has a short i
      await corpus.addWord(
        fables,
        'L.',
        times: 4,
        expansion: 'Lūcius',
        properNounState: ProperNounState.proper,
      );
      await corpus.addWord(fables, 'Lucii', properNounState: ProperNounState.proper);
      await corpus.addAnalysis('Lucius', 'Lucius1', macronizedForm: 'Lūcius');
      await corpus.addAnalysis('Lucius', 'Lucius2', macronizedForm: 'Lūcīus');
      await corpus.addAnalysis('Lucii', 'Lucius2');
      await corpus.populate();
      // the columns the reader builds its lookup from
      final abbreviation = await corpus.db
          .customSelect(
            'SELECT DISTINCT lookupForm, macronLookupForm, uncertaintyBitMask '
            "FROM WorkContents WHERE word = 'L.'",
          )
          .getSingle();

      final frequencies = await _readFrequencies(corpus.db, fables, FrequencyScope.work, [
        'Lucius',
        'Lucii',
      ]);
      final bands = frequencies.bandsFor(
        commonPercent: 50,
        uncommonPercent: 20,
        markCommon: true,
        markUncommon: true,
      );

      expect(
        bands.bandOf(
          Lookup.of(
            abbreviation.read<String>('lookupForm'),
            ProperNounState.proper,
            macronized: (
              form: abbreviation.read<String>('macronLookupForm'),
              uncertaintyBitMask: abbreviation.read<int>('uncertaintyBitMask'),
            ),
          ),
        ),
        FrequencyBand.common,
      );
      expect(
        bands.bandOf(
          const Lookup.of(
            'Lucii',
            ProperNounState.proper,
            macronized: (form: 'Lucii', uncertaintyBitMask: 0),
          ),
        ),
        FrequencyBand.uncommon,
      );
    });
  });
}
