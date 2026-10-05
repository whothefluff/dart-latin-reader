import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';
import 'package:latin_reader/src/component/morph_analysis/db_util.dart' as morphology;
import 'package:latin_reader/src/component/word_frequency/db_util.dart' as frequency;
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

const fables = '00000000-0000-0000-0000-00000000000f';
const letters = '00000000-0000-0000-0000-00000000000e';

class _EmptyDb extends AppDb {
  _EmptyDb() : super(executor: NativeDatabase.memory(setup: util.setupRegExp));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

/// An in-memory corpus populated by the production statements.
class FrequencyCorpus {
  FrequencyCorpus() : db = _EmptyDb();

  final AppDb db;
  final Map<String, int> _nextIdx = {};

  Future<void> addWork(String id, {String name = 'A work'}) =>
      db.customStatement('INSERT INTO Works( id, name, about ) VALUES ( ?, ?, ? )', [id, name, '']);

  Future<void> addWord(
    String workId,
    String word, {
    int times = 1,
    String? macronizedWord,
    int uncertaintyBitMask = 0,
    ProperNounState properNounState = ProperNounState.common,
    String? enclitic,
    String? expansion,
  }) => Future.wait(
    List.generate(times, (_) => _nextIdx.update(workId, (i) => i + 1, ifAbsent: () => 0)).map(
      (idx) => db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, properNounState, tokenType,
                                  sentenceIdx, wordIdx, enclitic, expansion, macronizedWord,
                                  uncertaintyBitMask )
            VALUES ( ?, ?, ?, '1', ?, ?, 0, ?, ?, ?, ?, ? )
        ''',
        [
          workId,
          idx,
          word,
          properNounState.code,
          // tokenType: a word, or an abbreviation when it has an expansion
          if (expansion == null) 1 else 2,
          idx,
          enclitic,
          expansion,
          macronizedWord ?? word,
          uncertaintyBitMask,
        ],
      ),
    ),
  );

  /// An analysis of [form] as [dictionaryRef], spelled [macronizedForm] when given
  Future<void> addAnalysis(String form, String dictionaryRef, {String? macronizedForm}) async {
    await db.customStatement(
      '''
      INSERT INTO MorphologicalDetails( form, item, dictionaryRef )
          SELECT ?, COUNT( * ), ? FROM MorphologicalDetails WHERE form = ?
      ''',
      [form, dictionaryRef, form],
    );
    if (macronizedForm != null) {
      await db.customStatement(
        '''
        INSERT INTO MorphologicalDetailInflections( form, item, cnt, partOfSpeech, stem )
            SELECT ?, MAX( item ), 0, 'noun', ? FROM MorphologicalDetails WHERE form = ?
        ''',
        [form, macronizedForm, form],
      );
    }
  }

  Future<void> populate() => db.transaction(
    () =>
        [
          morphology.operations.singleWhere(
            (operation) => operation.id == 'CountableWordCandidateAnalyses',
          ),
          ...frequency.operations,
        ].fold(
          Future<void>.value(),
          (previous, operation) => previous.then((_) => operation.insert(db)),
        ),
  );

  Future<void> close() => db.close();
  //
}
