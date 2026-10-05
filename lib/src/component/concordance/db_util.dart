import '../../external/database.dart';
import '../../external/db_oracle.dart';

// Type not important
// ignore: specify_nonobvious_property_types
final operations = [
  (
    id: 'ConcordanceDetails',
    delete: (AppDb db) async {
      await db.delete(db.concordanceDetails).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO ConcordanceDetails( form, item, dictionaryRef )
            SELECT DISTINCT Details.form,
                            Details.item,
                            Details.dictionaryRef
                FROM CountableWordCandidateAnalyses AS Candidate
                INNER JOIN MorphologicalDetails AS Details
                    ON Details.form = Candidate.form
                       AND Details.item = Candidate.item
      ''');
    },
  ),
  (
    id: 'ConcordanceDetailInflections',
    delete: (AppDb db) async {
      await db.delete(db.concordanceDetailInflections).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO ConcordanceDetailInflections( form, item, cnt, partOfSpeech, gramCase, number, gender, declension, person, verbForm, tense, voice )
            SELECT Infl.form,
                   Infl.item,
                   Infl.cnt,
                   Infl.partOfSpeech,
                   Infl.gramCase,
                   Infl.number,
                   Infl.gender,
                   Infl.declension,
                   Infl.person,
                   Infl.verbForm,
                   Infl.tense,
                   Infl.voice
                FROM ConcordanceDetails AS Details
                INNER JOIN MorphologicalDetailInflections AS Infl
                    ON Infl.form = Details.form
                       AND Infl.item = Details.item
      ''');
    },
  ),
  (
    id: 'ConcordanceCountableWordCandidateAnalyses',
    delete: (AppDb db) async {
      await db.delete(db.concordanceCountableWordCandidateAnalyses).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO ConcordanceCountableWordCandidateAnalyses( workId, idx, componentOrdinal, form, item )
            SELECT workId,
                   idx,
                   componentOrdinal,
                   form,
                   item
                FROM CountableWordCandidateAnalyses
      ''');
    },
  ),
];

const List<DbOracle> oracles = [];
