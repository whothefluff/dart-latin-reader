import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';
import 'package:latin_reader/src/component/word_frequency/db_util.dart' as frequency;
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_oracle.dart';

import 'frequency_corpus.dart';

Future<int> _violationCount(AppDb db, DbOracle oracle) async {
  final row = await db
      .customSelect('SELECT COUNT( * ) AS violations FROM ( ${oracle.sql} )')
      .getSingle();
  return row.read<int>('violations');
}

DbOracle _oracle(String id) => frequency.oracles.singleWhere((o) => o.id == id);

void main() {
  late FrequencyCorpus corpus;

  setUp(() async {
    corpus = FrequencyCorpus();
    await corpus.addWork(fables);
    await corpus.addWork(letters);
    await corpus.addWord(fables, 'est', times: 3);
    await corpus.addWord(fables, 'amat', times: 2);
    await corpus.addWord(fables, 'Xanthus', properNounState: ProperNounState.proper);
    await corpus.addWord(fables, 'Venere', properNounState: ProperNounState.either);
    await corpus.addWord(fables, 'Venere', properNounState: ProperNounState.proper);
    await corpus.addWord(fables, 'populusque', enclitic: 'que');
    await corpus.addWord(letters, 'est', macronizedWord: 'ēst');
    await corpus.addAnalysis('est', 'sum1');
    await corpus.addAnalysis('est', 'edo1');
    await corpus.addAnalysis('amat', 'amo1');
    await corpus.addAnalysis('Venere', 'Venus1');
    await corpus.addAnalysis('venere', 'venio');
    await corpus.addAnalysis('populusque', 'populus1');
    await corpus.addAnalysis('que', 'que');
    await corpus.populate();
  });

  tearDown(() => corpus.close());

  test('a populated corpus passes every frequency integrity check', () async {
    final violations = {
      for (final oracle in frequency.oracles) oracle.id: await _violationCount(corpus.db, oracle),
    };

    expect(violations.values, everyElement(0), reason: '$violations');
  });

  test('the lookup check catches lookups that no longer match the totals', () async {
    await corpus.db.customStatement("DELETE FROM ScopedLookupLemmas WHERE lookupForm = 'amat'");

    final violations = await _violationCount(corpus.db, _oracle('ScopedLookupFreq_MatchesTotals'));

    expect(violations, 1);
  });

  test('the lookup check catches a work whose lookups are missing', () async {
    await corpus.db.customStatement('DELETE FROM ScopedLookupFreq WHERE workId = ?', [letters]);

    final violations = await _violationCount(corpus.db, _oracle('ScopedLookupFreq_MatchesTotals'));

    expect(violations, 1);
  });
}
