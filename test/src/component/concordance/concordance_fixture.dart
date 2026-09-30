import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:latin_reader/src/component/library/proper_noun_state.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

const work = '00000000-0000-0000-0000-000000000001';
const otherWork = '00000000-0000-0000-0000-000000000002';
const dictionary = '00000000-0000-0000-0000-000000000003';

/// The app's schema, empty: each test inserts the rows it needs
class FixtureDb extends AppDb {
  FixtureDb() : super(executor: NativeDatabase.memory(setup: util.setupRegExp));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

Future<void> seedCatalog(AppDb db) async {
  await db.customStatement('INSERT INTO Works VALUES (?, ?, ?), (?, ?, ?)', [
    work,
    'Fables',
    '',
    otherWork,
    'Other work',
    '',
  ]);
  await db.customStatement('INSERT INTO Dictionaries VALUES (?, ?, ?, ?, ?)', [
    dictionary,
    'Lewis & Short',
    'Latin',
    '',
    '1879-01-01',
  ]);
}

/// A token of [workId]. Its word position is [idx] unless [position] says
/// otherwise, and punctuation (type 4 and up) has none
Future<void> token(
  AppDb db,
  int idx,
  String word, {
  String workId = work,
  String? macron,
  int sentence = 0,
  int? position,
  int type = 1,
  ProperNounState proper = ProperNounState.common,
  String? enclitic,
  String? expansion,
}) => db.customStatement(
  '''
  INSERT INTO WorkContents(workId, idx, word, sourceReference, properNounState,
    tokenType, sentenceIdx, wordIdx, enclitic, expansion, macronizedWord, uncertaintyBitMask)
  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)
''',
  [
    workId,
    idx,
    word,
    '1.${sentence + 1}',
    if (type >= 4) null else proper.code,
    type,
    sentence,
    if (type >= 4) null else position ?? idx,
    enclitic,
    expansion,
    macron ?? word,
  ],
);

/// Analysis [item] of [form] as [reference], with inflection [count]
Future<void> analysis(
  AppDb db,
  String form,
  String reference, {
  int item = 0,
  int count = 0,
  String pos = 'noun',
  String? gender,
  String? number,
  String? declension,
  String? gramCase,
  String? verbForm,
  String? person,
}) async {
  await db.customStatement('INSERT OR IGNORE INTO MorphologicalDetails VALUES (?, ?, ?)', [
    form,
    item,
    reference,
  ]);
  await db.customStatement(
    '''
    INSERT INTO MorphologicalDetailInflections(form, item, cnt, partOfSpeech, stem,
      gender, number, declension, gramCase, verbForm, person)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''',
    [form, item, count, pos, form, gender, number, declension, gramCase, verbForm, person],
  );
}

/// [reference] resolves to the L&S entry [lemma]
Future<void> resolution(AppDb db, String reference, String lemma) async {
  await db.customStatement('INSERT INTO LnsRefResolutions VALUES (?, ?)', [reference, lemma]);
  await db.customStatement(
    '''
    INSERT OR IGNORE INTO DictionaryEntries(dictionary, lemma, idx)
    SELECT ?, ?, COUNT(*) FROM DictionaryEntries
  ''',
    [dictionary, lemma],
  );
}
