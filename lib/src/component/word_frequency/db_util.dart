import '../../external/database.dart';
import '../../external/db_oracle.dart';

/// CTEs for every frequency population statement.
/// Here as raw SQL (and not as a declared view) to keep behavior and DDL
/// isolated by feature branch
///
/// `CountUnits` holds one row per counted unit: anything that is consider
/// word-like + a separate unit for each detached enclitic.
/// It's basically what frequency ultimately counts.
/// `CandidateAnalyses` holds each unit's candidate analyses.
///
/// `lookupForm` is the spelling used to find matches in `MorphologicalDetails`:
/// - For the word itself, `WorkContents.lookupForm`: expansions by what they
///   stand for (`Marcus`), words with an enclitic as written (`populusque`).
///   It's NULL for tokens that aren't counted words, which is what excludes them.
/// - Enclitics counted separately use their own spelling, such as `que`.
///
/// `macronLookupForm` is the same spelling with its macrons, and
/// `uncertaintyBitMask` says which of its letters are uncertain:
/// the token's own mask, and 0 for an enclitic.
///
/// The body is indented for the use site, not for this declaration(we make it
/// so that `WITH` lands at column 12 and CTE names align at col 17
const _countUnits = '''WITH TokenComponents( ordinal ) AS ( VALUES (0), (1) ),
                 CountUnits AS (
                     SELECT WorkContents.workId,
                            WorkContents.idx AS sourceIdx,
                            TokenComponents.ordinal AS componentOrdinal,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.baseNormForm
                                 ELSE WorkContents.enclitic
                            END AS form,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.macronBaseNormForm
                                 ELSE WorkContents.enclitic
                            END AS macronForm,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.lookupForm
                                 ELSE WorkContents.enclitic
                            END AS lookupForm,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.properNounState
                                 ELSE 0 -- a detached enclitic is never a proper noun
                            END AS properNounState,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.macronLookupForm
                                 ELSE WorkContents.enclitic
                            END AS macronLookupForm,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.uncertaintyBitMask
                                 ELSE 0
                            END AS uncertaintyBitMask
                         FROM WorkContents
                         CROSS JOIN TokenComponents
                         WHERE ( TokenComponents.ordinal = 0
                                 AND WorkContents.lookupForm IS NOT NULL )
                               OR ( TokenComponents.ordinal = 1
                                    AND WorkContents.enclitic IS NOT NULL ) -- only ever on tokenType 1
                 ),
                 CandidateAnalyses AS (
                     SELECT Unit.*,
                            Details.form AS morphForm,
                            Details.item AS morphItem,
                            Details.dictionaryRef
                         FROM CountUnits AS Unit
                         INNER JOIN CountableWordCandidateAnalyses AS Candidate
                             ON Candidate.workId = Unit.workId
                                AND Candidate.idx = Unit.sourceIdx
                                AND Candidate.componentOrdinal = Unit.componentOrdinal
                         INNER JOIN MorphologicalDetails AS Details
                             ON Details.form = Candidate.form
                                AND Details.item = Candidate.item
                 )''';

// Type not important
// ignore: specify_nonobvious_property_types
final operations = [
  (
    id: 'ScopedFormFreq',
    delete: (AppDb db) async {
      await db.delete(db.scopedFormFreq).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO ScopedFormFreq( workId, form, macronForm, occurrences )
            $_countUnits
                SELECT workId,
                       form,
                       macronForm,
                       COUNT( * )
                    FROM CountUnits
                    GROUP BY workId, form, macronForm
      ''');
    },
  ),
  (
    id: 'ResolvedFreqMorphForms',
    delete: (AppDb db) async {
      await db.delete(db.resolvedFreqMorphForms).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO ResolvedFreqMorphForms( workId, form, macronForm, morphForm, morphItem, dictionaryRef )
            $_countUnits
                SELECT DISTINCT workId,
                                form,
                                macronForm,
                                morphForm,
                                morphItem,
                                dictionaryRef
                    FROM CandidateAnalyses
      ''');
    },
  ),
  (
    id: 'ScopedFormLemmaFreq',
    delete: (AppDb db) async {
      await db.delete(db.scopedFormLemmaFreq).go();
    },
    insert: (AppDb db) async {
      // UnitLemmas keeps one row per counted unit and candidate lemma.
      // Several analyses pointing to the same lemma therefore count once.
      // candidateCount = 1 means the stored analyses offer only one candidate lemma.
      await db.customStatement('''
        INSERT INTO ScopedFormLemmaFreq( workId, form, macronForm, dictionaryRef,
                                         possibleOccurrences, singleCandidateOccurrences )
            $_countUnits,
                 UnitLemmas AS ( SELECT DISTINCT workId,
                                                 sourceIdx,
                                                 componentOrdinal,
                                                 form,
                                                 macronForm,
                                                 dictionaryRef
                                     FROM CandidateAnalyses ),
                 Counted AS ( SELECT UnitLemmas.*,
                                     COUNT( * ) OVER ( PARTITION BY workId, sourceIdx, componentOrdinal ) AS candidateCount
                                  FROM UnitLemmas )
                SELECT workId,
                       form,
                       macronForm,
                       dictionaryRef,
                       COUNT( * ),
                       SUM( CASE WHEN candidateCount = 1 THEN 1 ELSE 0 END )
                    FROM Counted
                    GROUP BY workId, form, macronForm, dictionaryRef
      ''');
    },
  ),
  (
    id: 'ScopedLemmaFreq',
    delete: (AppDb db) async {
      await db.delete(db.scopedLemmaFreq).go();
    },
    insert: (AppDb db) async {
      // Add each lemma's counts across its forms within a work.
      // Each counted unit has one form and one macronized form, so it contributes
      // at most once to a given lemma's total.
      await db.customStatement('''
        INSERT INTO ScopedLemmaFreq( workId, dictionaryRef, possibleOccurrences, singleCandidateOccurrences )
            SELECT workId,
                   dictionaryRef,
                   SUM( possibleOccurrences ),
                   SUM( singleCandidateOccurrences )
                FROM ScopedFormLemmaFreq
                GROUP BY workId, dictionaryRef
      ''');
    },
  ),
  (
    id: 'ScopedFreqTotals',
    delete: (AppDb db) async {
      await db.delete(db.scopedFreqTotals).go();
    },
    insert: (AppDb db) async {
      // Sum singleCandidateOccurrences to count units with exactly one candidate.
      // Each of those units contributes to only one lemma.
      // Subtract units with zero or one candidate from totalTokens to get
      // multipleCandidateTokens.
      // Narrowing never removes all of a unit's candidates, so a unit without any has no analyses.
      await db.customStatement('''
        INSERT INTO ScopedFreqTotals( workId, totalForms, totalMacronForms, totalLemmas, totalTokens,
                                      noCandidateTokens, singleCandidateTokens, multipleCandidateTokens )
            $_countUnits,
                 Missing AS ( SELECT u.workId,
                                     COUNT( * ) AS noCandidateTokens
                                  FROM CountUnits AS u
                                  WHERE NOT EXISTS ( SELECT 1
                                                        FROM CountableWordCandidateAnalyses AS Candidate
                                                        WHERE Candidate.workId = u.workId
                                                              AND Candidate.idx = u.sourceIdx
                                                              AND Candidate.componentOrdinal = u.componentOrdinal )
                                  GROUP BY u.workId ),
                 PerWork AS ( SELECT workId,
                                     COUNT( DISTINCT form ) AS totalForms,
                                     COUNT( DISTINCT macronForm ) AS totalMacronForms,
                                     SUM( occurrences ) AS totalTokens
                                  FROM ScopedFormFreq
                                  GROUP BY workId ),
                 LemmaTotals AS ( SELECT workId,
                                         COUNT( * ) AS totalLemmas,
                                         SUM( singleCandidateOccurrences ) AS singleCandidateTokens
                                      FROM ScopedLemmaFreq
                                      GROUP BY workId )
                SELECT p.workId,
                       p.totalForms,
                       p.totalMacronForms,
                       COALESCE( l.totalLemmas, 0 ),
                       p.totalTokens,
                       COALESCE( m.noCandidateTokens, 0 ),
                       COALESCE( l.singleCandidateTokens, 0 ),
                       p.totalTokens - COALESCE( m.noCandidateTokens, 0 ) - COALESCE( l.singleCandidateTokens, 0 )
                    FROM PerWork AS p
                    LEFT JOIN Missing AS m
                        ON m.workId = p.workId
                    LEFT JOIN LemmaTotals AS l
                        ON l.workId = p.workId
      ''');
    },
  ),
  (
    id: 'ScopedLookupFreq',
    delete: (AppDb db) async {
      await db.delete(db.scopedLookupFreq).go();
    },
    insert: (AppDb db) async {
      //`IS 2` maps an unknown proper-noun state to false
      await db.customStatement('''
        INSERT INTO ScopedLookupFreq( workId, lookupForm, alsoLowercase, macronLookupForm,
                                      uncertaintyBitMask, occurrences )
            $_countUnits
                SELECT workId,
                       lookupForm,
                       properNounState IS 2,
                       macronLookupForm,
                       uncertaintyBitMask,
                       COUNT( * )
                    FROM CountUnits
                    GROUP BY workId,
                             lookupForm,
                             properNounState IS 2,
                             macronLookupForm,
                             uncertaintyBitMask
      ''');
    },
  ),
  (
    id: 'ScopedLookupLemmas',
    delete: (AppDb db) async {
      await db.delete(db.scopedLookupLemmas).go();
    },
    insert: (AppDb db) async {
      // several analyses can point to the same lemma
      await db.customStatement('''
        INSERT INTO ScopedLookupLemmas( workId, lookupForm, alsoLowercase, macronLookupForm,
                                        uncertaintyBitMask, dictionaryRef )
            $_countUnits
                SELECT DISTINCT workId,
                                lookupForm,
                                properNounState IS 2,
                                macronLookupForm,
                                uncertaintyBitMask,
                                dictionaryRef
                    FROM CandidateAnalyses
      ''');
    },
  ),
];

const List<DbOracle> oracles = [
  (
    id: 'ScopedLookupFreq_MatchesTotals',
    sql: '''
      SELECT t.workId,
             t.totalTokens,
             k.totalTokens AS lookupTotalTokens,
             t.noCandidateTokens,
             k.noCandidateTokens AS lookupNoCandidateTokens,
             t.singleCandidateTokens,
             k.singleCandidateTokens AS lookupSingleCandidateTokens
          FROM ScopedFreqTotals AS t
          LEFT JOIN ( SELECT l.workId,
                             SUM( l.occurrences ) AS totalTokens,
                             SUM( CASE WHEN c.candidates IS NULL THEN l.occurrences ELSE 0 END ) AS noCandidateTokens,
                             SUM( CASE WHEN c.candidates = 1 THEN l.occurrences ELSE 0 END ) AS singleCandidateTokens
                          FROM ScopedLookupFreq AS l
                          LEFT JOIN ( SELECT workId,
                                             lookupForm,
                                             alsoLowercase,
                                             macronLookupForm,
                                             uncertaintyBitMask,
                                             COUNT( * ) AS candidates
                                          FROM ScopedLookupLemmas
                                          GROUP BY workId,
                                                   lookupForm,
                                                   alsoLowercase,
                                                   macronLookupForm,
                                                   uncertaintyBitMask ) AS c
                              ON c.workId = l.workId
                                 AND c.lookupForm = l.lookupForm
                                 AND c.alsoLowercase = l.alsoLowercase
                                 AND c.macronLookupForm = l.macronLookupForm
                                 AND c.uncertaintyBitMask = l.uncertaintyBitMask
                          GROUP BY l.workId ) AS k
              ON k.workId = t.workId
          WHERE k.totalTokens IS NOT t.totalTokens
                OR k.noCandidateTokens IS NOT t.noCandidateTokens
                OR k.singleCandidateTokens IS NOT t.singleCandidateTokens''',
    severity: DbOracleSeverity.error,
  ),
];
