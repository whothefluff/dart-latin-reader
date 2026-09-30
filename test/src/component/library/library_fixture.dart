import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_util.dart' as util;

const phaedrus = '00000000-0000-0000-0000-0000000000a1';
const cicero = '00000000-0000-0000-0000-0000000000a2';
const fables = '00000000-0000-0000-0000-0000000000b1';
const duties = '00000000-0000-0000-0000-0000000000b2';
const anonymous = '00000000-0000-0000-0000-0000000000b3';

class _EmptyDb extends AppDb {
  _EmptyDb() : super(executor: NativeDatabase.memory(setup: util.setupRegExp));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) => m.createAll());
  //
}

/// Two authors with abbreviations, a work by one, a work by both with an abbreviation, and an
/// anonymous work
Future<AppDb> smallLibrary() async {
  final db = _EmptyDb();
  addTearDown(db.close);
  await db.customStatement(
    '''
    INSERT INTO Authors( id, name, about, image ) VALUES ( ?, 'Phaedrus', '', x'00' ),
                                                         ( ?, 'Cicero', '', x'00' )
    ''',
    [phaedrus, cicero],
  );
  await db.customStatement(
    '''
    INSERT INTO AuthorAbbreviations( authorId, id, val ) VALUES ( ?, 0, 'Phaedr.' ),
                                                                ( ?, 1, 'Phaed.' ),
                                                                ( ?, 0, 'Cic.' )
    ''',
    [phaedrus, phaedrus, cicero],
  );
  await db.customStatement(
    '''
    INSERT INTO Works( id, name, about ) VALUES ( ?, 'Fabulae Aesopiae', '' ),
                                                ( ?, 'De officiis', '' ),
                                                ( ?, 'Carmina', '' )
    ''',
    [fables, duties, anonymous],
  );
  await db.customStatement(
    "INSERT INTO WorkAbbreviations( workId, id, val ) VALUES ( ?, 0, 'Off.' )",
    [duties],
  );
  await db.customStatement(
    'INSERT INTO AuthorsAndWorks( authorId, workId ) VALUES ( ?, ? ), ( ?, ? ), ( ?, ? )',
    [phaedrus, fables, cicero, duties, phaedrus, duties],
  );
  return db;
}
