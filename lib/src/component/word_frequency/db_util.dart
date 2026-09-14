import '../../external/database.dart';

/// CTE for every frequency population statement.
/// Here as raw SQL (and not as a declared view) to keep behavior and DDL
/// isolated by feature branch
///
/// `CountUnits` holds one row per counted unit: anything that is consider
/// word-like + a separate unit for each detached enclitic.
/// It's basically what frequency ultimately counts.
///
/// `lookupForm` is the spelling used to find matches in `MorphologicalDetails`:
/// - Expansions use `baseNormForm`, such as `Marcus`.
/// - Words with an enclitic keep it attached for the lookup, such as `populusque`.
/// - Other words use `normForm`.
/// - Enclitics counted separately use their own spelling, such as `que`.
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
                                 WHEN 0 THEN CASE WHEN WorkContents.expansion IS NOT NULL
                                                  THEN WorkContents.baseNormForm
                                                  ELSE WorkContents.normForm
                                             END
                                 ELSE WorkContents.enclitic
                            END AS lookupForm,
                            CASE TokenComponents.ordinal
                                 WHEN 0 THEN WorkContents.properNounState
                                 ELSE 0 -- a detached enclitic is never a proper noun
                            END AS properNounState
                         FROM WorkContents
                         CROSS JOIN TokenComponents
                         WHERE ( TokenComponents.ordinal = 0
                                 AND ( WorkContents.tokenType = 1
                                       OR ( WorkContents.tokenType IN (2, 3) AND WorkContents.expansion IS NOT NULL ) ) )
                               OR ( TokenComponents.ordinal = 1
                                    AND WorkContents.tokenType = 1
                                    AND WorkContents.enclitic IS NOT NULL )
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
      // For properNounState = 2, look up both lookupForm and its lowercase form
      // to include proper-noun and common-word analyses.
      // Other states use lookupForm alone.
      await db.customStatement('''
        INSERT INTO ResolvedFreqMorphForms( workId, form, macronForm, morphForm, morphItem, dictionaryRef )
            $_countUnits
                SELECT DISTINCT u.workId,
                                u.form,
                                u.macronForm,
                                md.form,
                                md.item,
                                md.dictionaryRef
                    FROM CountUnits AS u
                    INNER JOIN MorphologicalDetails AS md
                        ON md.form = u.lookupForm
                           OR ( u.properNounState = 2 AND md.form = LOWER( u.lookupForm ) )
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
                 UnitLemmas AS ( SELECT DISTINCT u.workId,
                                                 u.sourceIdx,
                                                 u.componentOrdinal,
                                                 u.form,
                                                 u.macronForm,
                                                 md.dictionaryRef
                                     FROM CountUnits AS u
                                     INNER JOIN MorphologicalDetails AS md
                                         ON md.form = u.lookupForm
                                            OR ( u.properNounState = 2 AND md.form = LOWER( u.lookupForm ) ) ),
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
      await db.customStatement('''
        INSERT INTO ScopedFreqTotals( workId, totalForms, totalMacronForms, totalLemmas, totalTokens,
                                      noCandidateTokens, singleCandidateTokens, multipleCandidateTokens )
            $_countUnits,
                 Missing AS ( SELECT u.workId,
                                     COUNT( * ) AS noCandidateTokens
                                  FROM CountUnits AS u
                                  WHERE NOT EXISTS ( SELECT 1
                                                         FROM MorphologicalDetails AS md
                                                         WHERE md.form = u.lookupForm
                                                               OR ( u.properNounState = 2
                                                                    AND md.form = LOWER( u.lookupForm ) ) )
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
];
