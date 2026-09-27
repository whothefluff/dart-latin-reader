import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/concordance/concordance_api.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';
import 'package:latin_reader/src/component/concordance/grammar_values_api.dart' as grammar;
import 'package:latin_reader/src/component/concordance/lemma_choices_api.dart' as lemmas;
import 'package:latin_reader/src/component/library/catalog_api.dart' as catalog;
import 'package:latin_reader/src/component/word_frequency/library_selection_api.dart';

import 'concordance_fixture.dart';

LemmaCriterion _lemma(String reference) =>
    LemmaCriterion(LemmaChoice(label: reference, dictionaryRefs: [reference]));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FixtureDb db;
  late ConcordanceRepository repository;

  setUp(() async {
    db = FixtureDb();
    repository = ConcordanceRepository(db.concordanceDrift);
    await seedCatalog(db);
  });

  tearDown(() async => db.close());

  /// The first token of each hit
  Future<List<int>> starts(
    List<ConcordanceCriterion> slots, {
    bool macrons = false,
    List<int?> distances = const [],
  }) async => (await repository.getHits(
    ConcordanceQuery(slots: slots, matchMacrons: macrons, distances: distances),
    [work],
    0,
    100,
  )).hits.map((hit) => hit.firstIdx).toList();

  test('with macrons on, a vowel typed without one only matches a vowel without one', () async {
    await token(db, 0, 'rosa');
    await token(db, 1, 'rosa', macron: 'rosā');
    expect(await starts([const FormCriterion('rosa')]), [0, 1]);
    expect(await starts([const FormCriterion('rosa')], macrons: true), [0]);
    expect(await starts([const FormCriterion('rosā')], macrons: true), [1]);
    expect(await starts([const FormCriterion('rosā')], macrons: true), [1]);
  });

  test('capitals beyond ASCII follow the exact case option', () async {
    await token(db, 0, 'Apis', macron: 'Āpis', proper: 1);
    await token(db, 1, 'apis', macron: 'āpis');
    expect(await starts([const FormCriterion('ĀPIS')], macrons: true), [0, 1]);
    expect(await starts([const FormCriterion('ĀPIS', exactCase: true)], macrons: true), [0]);
  });

  test('a host, its enclitic and an expansion all find their own token', () async {
    await token(db, 0, 'populusque', enclitic: 'que');
    await token(db, 1, 'M.', type: 2, proper: 1, expansion: 'Mārcus');
    await token(db, 2, 'XII', type: 3);
    expect(await starts([const FormCriterion('populus')]), [0]);
    expect(await starts([const FormCriterion('que')]), [0]);
    expect(await starts([const FormCriterion('populusque')]), [0]);
    expect(await starts([const FormCriterion('Mārcus')], macrons: true), [1]);
    expect(await starts([const FormCriterion('xii')]), isEmpty);
    // one token can't be two words of the phrase
    expect(await starts([const FormCriterion('populus'), const FormCriterion('que')]), isEmpty);
  });

  test('distance counts words: punctuation and gaps in idx add none', () async {
    await token(db, 10, 'puellam', position: 0);
    await token(db, 11, ',', type: 4);
    await token(db, 15, 'pulchram', position: 1);
    await token(db, 18, 'videt', position: 2);
    await token(db, 20, 'puellam', position: 3);
    await token(db, 21, 'pulchram', sentence: 1, position: 4);
    expect(
      await starts(const [
        FormCriterion('puellam'),
        FormCriterion('pulchram'),
        FormCriterion('videt'),
      ]),
      [10],
    );
    expect(await starts(const [FormCriterion('puellam'), FormCriterion('videt')]), isEmpty);
    expect(
      await starts(const [FormCriterion('puellam'), FormCriterion('videt')], distances: const [2]),
      [10],
    );
    expect(await starts(const [FormCriterion('puellam'), FormCriterion('pulchram')]), [10]);
  });

  test('a repeated criterion finds every ordered pair of tokens', () async {
    for (var idx = 0; idx < 3; idx++) {
      await token(db, idx, 'et');
    }
    final page = await repository.getHits(
      ConcordanceQuery(
        slots: const [FormCriterion('et'), FormCriterion('et')],
        distances: const [2],
      ),
      [work],
      0,
      100,
    );
    expect(page.hits.map((hit) => hit.slotIndices), [
      [0, 1],
      [0, 2],
      [1, 2],
    ]);
  });

  test('a lemma found by one of its dictionaryRefs keeps all of them', () async {
    await token(db, 0, 'rosam');
    await token(db, 1, 'rosas');
    await analysis(db, 'rosam', 'rosa');
    await analysis(db, 'rosam', 'flos-rosa', item: 1);
    await analysis(db, 'rosas', 'rosa');
    await resolution(db, 'rosa', 'rosa1');
    await resolution(db, 'flos-rosa', 'rosa1');
    final choices = await lemmas.SearchLemmaChoicesUseCase(
      lemmas.ConcordanceRepository(db.concordanceDrift),
      'flos-',
    ).invoke();
    expect(choices.single.label, 'rosa1');
    expect(choices.single.dictionaryRefs, unorderedEquals(['rosa', 'flos-rosa']));
    expect(await starts([LemmaCriterion(choices.single)]), [0, 1]);
  });

  test("a lemma matches each token's own analyses, not frequency's pooled ones", () async {
    await token(db, 0, 'populus');
    await token(db, 1, 'populusque', enclitic: 'que');
    await analysis(db, 'populus', 'tree');
    await analysis(db, 'populusque', 'people');
    await analysis(db, 'que', 'que', pos: 'conjunction');
    expect(await starts([_lemma('people')]), [1]);
    expect(await starts([_lemma('tree')]), [0]);
    expect(await starts([_lemma('que')]), [1]);
  });

  test('a name that may be a common word has the analyses of both', () async {
    await token(db, 0, 'Venere', proper: 2);
    await token(db, 1, 'Venere', proper: 1);
    await token(db, 2, 'venere');
    await analysis(db, 'Venere', 'Venus');
    await analysis(db, 'venere', 'venio', pos: 'verb');
    expect(await starts([_lemma('Venus')]), [0, 1]);
    expect(await starts([_lemma('venio')]), [0, 2]);
  });

  test('every feature of a grammar criterion, and its lemma, hold in one analysis', () async {
    await token(db, 0, 'idem');
    await analysis(db, 'idem', 'idem', pos: 'pronoun', gender: 'masculine', gramCase: 'nominative');
    await analysis(
      db,
      'idem',
      'idem',
      count: 1,
      pos: 'pronoun',
      gender: 'neuter',
      gramCase: 'accusative',
    );
    expect(
      await starts([
        GrammarCriterion(
          GrammarFilter(const {
            GrammarFeature.gender: 'masculine',
            GrammarFeature.gramCase: 'accusative',
          }),
        ),
      ]),
      isEmpty,
    );
    final accusative = GrammarFilter(const {GrammarFeature.gramCase: 'accusative'});
    expect(await starts([GrammarCriterion(accusative, lemma: _lemma('idem').lemma)]), [0]);
    await analysis(db, 'idem', 'other', item: 1, gramCase: 'nominative');
    expect(await starts([GrammarCriterion(accusative, lemma: _lemma('other').lemma)]), isEmpty);
  });

  test('forms, lemmas and grammar combine in one phrase', () async {
    await token(db, 0, 'puellam');
    await token(db, 1, 'pulchram');
    await token(db, 2, 'videt');
    await analysis(db, 'puellam', 'puella');
    await analysis(db, 'videt', 'video', pos: 'verb', verbForm: 'indicative', person: '3rd');
    expect(
      await starts([
        _lemma('puella'),
        const FormCriterion('pulchram'),
        GrammarCriterion(
          GrammarFilter(const {
            GrammarFeature.partOfSpeech: 'verb',
            GrammarFeature.person: '3rd',
          }),
        ),
      ]),
      [0],
    );
  });

  test('a combined gender matches each of its genders, as offered per part of speech', () async {
    await token(db, 0, 'felix');
    await analysis(db, 'felix', 'felix', pos: 'adjective', gender: 'masculine/feminine/neuter');
    await analysis(db, 'videt', 'video', pos: 'verb', verbForm: 'indicative');
    expect(
      await starts([
        GrammarCriterion(
          GrammarFilter(const {
            GrammarFeature.partOfSpeech: 'adjective',
            GrammarFeature.gender: 'feminine',
          }),
        ),
      ]),
      [0],
    );
    final values = await grammar.ConcordanceRepository(db.concordanceDrift).getGrammarValues();
    expect(
      values.valuesOf(GrammarFeature.gender, partOfSpeech: 'adjective'),
      unorderedEquals(['feminine', 'masculine', 'neuter']),
    );
    expect(values.valuesOf(GrammarFeature.gender, partOfSpeech: 'verb'), isEmpty);
  });

  test('a declension holds in one analysis with the rest, and 1st & 2nd is not 1st', () async {
    await token(db, 0, 'reges');
    await token(db, 1, 'dominos');
    await token(db, 2, 'bonos');
    await token(db, 3, 'nos');
    await token(db, 4, 'mixta');
    await analysis(db, 'reges', 'rex', gramCase: 'accusative', declension: '3rd');
    await analysis(db, 'dominos', 'dominus', gramCase: 'accusative', declension: '2nd');
    await analysis(db, 'bonos', 'bonus', pos: 'adjective', declension: '1st & 2nd');
    await analysis(db, 'nos', 'ego', pos: 'pronoun', gramCase: 'accusative');
    await analysis(db, 'mixta', 'mixtum', gramCase: 'nominative', declension: '3rd');
    await analysis(db, 'mixta', 'mixtum', count: 1, gramCase: 'accusative', declension: '2nd');
    Future<List<int>> declined(
      String declension, {
      Map<GrammarFeature, String> others = const {},
      String? lemma,
    }) => starts([
      GrammarCriterion(
        GrammarFilter({GrammarFeature.declension: declension, ...others}),
        lemma: lemma == null ? null : _lemma(lemma).lemma,
      ),
    ]);
    expect(await declined('3rd', others: const {GrammarFeature.gramCase: 'accusative'}), [0]);
    expect(await declined('3rd', others: const {GrammarFeature.partOfSpeech: 'noun'}), [0, 4]);
    expect(await declined('2nd'), [1, 4]);
    expect(await declined('1st & 2nd'), [2]);
    expect(await declined('1st'), isEmpty);
    expect(await declined('3rd', others: const {GrammarFeature.partOfSpeech: 'pronoun'}), isEmpty);
    expect(await declined('3rd', lemma: 'rex'), [0]);
    expect(await declined('3rd', lemma: 'dominus'), isEmpty);
    // without a declension, analyses that have none still match
    expect(
      await starts([
        GrammarCriterion(GrammarFilter(const {GrammarFeature.gramCase: 'accusative'})),
      ]),
      [0, 1, 3, 4],
    );
    final values = await grammar.ConcordanceRepository(db.concordanceDrift).getGrammarValues();
    expect(
      values.valuesOf(GrammarFeature.declension, partOfSpeech: 'noun'),
      unorderedEquals(['2nd', '3rd']),
    );
    expect(values.valuesOf(GrammarFeature.declension, partOfSpeech: 'adjective'), {'1st & 2nd'});
    expect(values.valuesOf(GrammarFeature.declension, partOfSpeech: 'pronoun'), isEmpty);
  });

  test('macrons filter before the count and the pages', () async {
    for (var idx = 0; idx < 8; idx++) {
      await token(db, idx, 'rosa', macron: idx.isEven ? 'rosā' : 'rosa');
    }
    final query = ConcordanceQuery(slots: const [FormCriterion('rosā')], matchMacrons: true);
    final first = await repository.getHits(query, [work], 0, 2);
    final second = await repository.getHits(query, [work], 2, 2);
    expect(first.hits.map((hit) => hit.firstIdx), [0, 2]);
    expect(first.total, 4);
    expect(first.hasNextPage, isTrue);
    expect(second.hits.map((hit) => hit.firstIdx), [4, 6]);
    expect(second.total, 4);
    expect(second.hasNextPage, isFalse);
  });

  test('a selected work without an author is searched, and only it', () async {
    await token(db, 0, 'rosa');
    await token(db, 4, 'rosa', workId: otherWork);
    final library = await catalog.LibraryRepository(db.libraryDrift).getCatalog();
    final selected = ConcordanceQuery(
      slots: const [FormCriterion('rosa')],
      selection: LibrarySelection(const {
        null: {otherWork},
      }),
    );
    final page = await GetConcordanceHitsUseCase(repository, selected, library, 0, 100).invoke();
    expect(page.hits.single.workId, otherWork);
    expect(page.hits.single.firstIdx, 4);
    expect(page.hits.single.reference, '1.1');
  });

  test('typed text is literal: no SQL, no LIKE wildcards', () async {
    await token(db, 0, 'rosa');
    expect(await starts([const FormCriterion("rosa' OR '1'='1")]), isEmpty);
    expect(await starts([const FormCriterion('%')]), isEmpty);
    expect(await starts([const FormCriterion('_')]), isEmpty);
  });
}
