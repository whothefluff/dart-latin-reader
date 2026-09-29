import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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

/// An in-memory corpus populated by the production frequency statements.
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
    int properNounState = 0,
    String? enclitic,
  }) => Future.wait(
    List.generate(times, (_) => _nextIdx.update(workId, (i) => i + 1, ifAbsent: () => 0)).map(
      (idx) => db.customStatement(
        '''
        INSERT INTO WorkContents( workId, idx, word, sourceReference, properNounState, tokenType,
                                  sentenceIdx, wordIdx, enclitic, expansion, macronizedWord,
                                  uncertaintyBitMask )
            VALUES ( ?, ?, ?, '1', ?, 1, 0, ?, ?, NULL, ?, 0 )
        ''',
        [workId, idx, word, properNounState, idx, enclitic, macronizedWord ?? word],
      ),
    ),
  );

  Future<void> addAnalysis(String form, String dictionaryRef) => db.customStatement(
    '''
    INSERT INTO MorphologicalDetails( form, item, dictionaryRef )
        SELECT ?, COUNT( * ), ? FROM MorphologicalDetails WHERE form = ?
    ''',
    [form, dictionaryRef, form],
  );

  Future<void> populate() => db.transaction(
    () => frequency.operations.fold(
      Future<void>.value(),
      (previous, operation) => previous.then((_) => operation.insert(db)),
    ),
  );

  Future<void> close() => db.close();
  //
}
