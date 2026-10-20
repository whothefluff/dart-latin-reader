import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';

import 'frequency_corpus.dart';

/// Tests that the reader looks a word up by its proper-noun state alone.
void main() {
  final (common, proper, either) = (
    ProperNounState.common,
    ProperNounState.proper,
    ProperNounState.either,
  );
  late FrequencyCorpus corpus;

  setUp(() async {
    corpus = FrequencyCorpus();
    await corpus.addWork(fables);
  });

  tearDown(() => corpus.close());

  group('analyses without inflections', () {
    setUp(() async {
      await corpus.addWord(fables, 'tartareo', properNounState: proper);
      await corpus.addAnalysis('Tartareo', 'Tartareus');
      await corpus.addWord(fables, 'roma', properNounState: common);
      await corpus.addAnalysis('Roma', 'Roma');
      await corpus.addWord(fables, 'Religio', properNounState: either);
      await corpus.addWord(fables, 'religio', properNounState: common);
      await corpus.addAnalysis('religio', 'religio');
      await corpus.addWord(fables, 'Eutyche', properNounState: proper);
      await corpus.addWord(fables, 'Venantum', properNounState: either);
      await corpus.addWord(fables, 'buvile', properNounState: common);
      await corpus.populate();
    });

    test(
      'a common word is looked up lowercase, a proper word capitalized and an either word in both cases, so the proper tartareo finds Tartareo and the common roma does not find Roma',
      () async {
        final rows = await corpus.db.customSelect('''
        SELECT WorkContents.word, Details.dictionaryRef
            FROM WorkContents
            LEFT JOIN CountableWordCandidateAnalyses AS Candidates
                ON Candidates.workId = WorkContents.workId AND Candidates.idx = WorkContents.idx
            LEFT JOIN MorphologicalDetails AS Details
                ON Details.form = Candidates.form AND Details.item = Candidates.item''').get();
        final lemmas = <String, Set<String>>{};
        for (final row in rows) {
          final lemmasOfWord = lemmas.putIfAbsent(row.read<String>('word'), () => {});
          final dictionaryRef = row.readNullable<String>('dictionaryRef');
          if (dictionaryRef != null) {
            lemmasOfWord.add(dictionaryRef);
          }
        }

        expect(lemmas, {
          'tartareo': {'Tartareus'},
          'roma': <String>{},
          'Religio': {'religio'},
          'religio': {'religio'},
          'Eutyche': <String>{},
          'Venantum': <String>{},
          'buvile': <String>{},
        });
      },
    );

    test(
      'frequency lists proper and either words capitalized and common words lowercase, and counts their candidate lemmas',
      () async {
        final forms = await corpus.db.customSelect('''
        SELECT form, occurrences
            FROM ScopedFormFreq''').get();
        final lemmas = await corpus.db.customSelect('''
        SELECT dictionaryRef, possibleOccurrences, singleCandidateOccurrences
            FROM ScopedLemmaFreq
            ORDER BY dictionaryRef''').get();

        expect(
          {for (final row in forms) row.read<String>('form'): row.read<int>('occurrences')},
          {
            'Tartareo': 1,
            'roma': 1,
            'Religio': 1,
            'religio': 1,
            'Eutyche': 1,
            'Venantum': 1,
            'buvile': 1,
          },
        );
        expect(
          [
            for (final row in lemmas)
              (
                row.read<String>('dictionaryRef'),
                row.read<int>('possibleOccurrences'),
                row.read<int>('singleCandidateOccurrences'),
              ),
          ],
          [('Tartareus', 1, 1), ('religio', 2, 2)],
        );
      },
    );
  });

  test(
    'an either word gets the readings of both cases, each once: Venere at the start of a verse, with both e uncertain, is Venus or venio, and venere inside a sentence only venio',
    () async {
      await corpus.addWord(fables, 'Venere', uncertaintyBitMask: 10, properNounState: either);
      await corpus.addWord(fables, 'venere', macronizedWord: 'vēnēre', properNounState: common);
      await corpus.addAnalysis('Venere', 'Venus', macronizedForm: 'Venere');
      await corpus.addAnalysis('venere', 'venio', macronizedForm: 'vēnēre');
      await corpus.addWord(fables, 'tartareo', macronizedWord: 'tartareō', properNounState: proper);
      await corpus.addAnalysis('Tartareo', 'Tartareus', macronizedForm: 'Tartareō');
      await corpus.populate();

      final rows = await corpus.db.customSelect('''
      SELECT WorkContents.word, Candidates.form, Candidates.item, Details.dictionaryRef
          FROM WorkContents
          INNER JOIN CountableWordCandidateAnalyses AS Candidates
              ON Candidates.workId = WorkContents.workId AND Candidates.idx = WorkContents.idx
          INNER JOIN MorphologicalDetails AS Details
              ON Details.form = Candidates.form AND Details.item = Candidates.item
          ORDER BY WorkContents.idx, Candidates.form, Candidates.item''').get();

      expect(
        [
          for (final row in rows)
            (
              row.read<String>('word'),
              row.read<String>('form'),
              row.read<int>('item'),
              row.read<String>('dictionaryRef'),
            ),
        ],
        [
          ('Venere', 'Venere', 0, 'Venus'),
          ('Venere', 'venere', 0, 'venio'),
          ('venere', 'venere', 0, 'venio'),
          ('tartareo', 'Tartareo', 0, 'Tartareus'),
        ],
      );
    },
  );
}
