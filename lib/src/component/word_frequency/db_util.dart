import '../../external/database.dart';

// technically we have a dependency here on other schemas, but it's a reasonably pragmatic choice

// Type not important
// ignore: specify_nonobvious_property_types
final operations = [
  (
    id: 'WorkFormCounts',
    delete: (AppDb db) async {
      await db.delete(db.workFormCounts).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO WorkFormCounts( workId, form, macronForm, cnt )
            SELECT workId, 
                   baseNormForm, 
                   macronBaseNormForm, 
                   COUNT(*)
                FROM WorkContents
                WHERE tokenType = 1
                   OR ( tokenType IN (2, 3) 
                      AND expansion IS NOT NULL )
                GROUP BY workId, baseNormForm, macronBaseNormForm
      ''');
      await db.customStatement('''
        INSERT INTO WorkFormCounts( workId, form, macronForm, cnt )
            SELECT workId, 
                   enclitic, 
                   enclitic, 
                   COUNT(*)
                FROM WorkContents
                WHERE enclitic IS NOT NULL
                GROUP BY workId, enclitic
            ON CONFLICT( workId, form, macronForm )
                DO UPDATE SET cnt = cnt + excluded.cnt
      ''');
    },
  ),
  (
    id: 'WorkLemmaCounts',
    delete: (AppDb db) async {
      await db.delete(db.workLemmaCounts).go();
    },
    insert: (AppDb db) async {
      await db.customStatement('''
        INSERT INTO WorkLemmaCounts( workId, dictionaryRef, cnt )
            SELECT w_f_c.workId, 
                   m_d.dictionaryRef, 
                   SUM( w_f_c.cnt )
                FROM WorkFormCounts AS w_f_c
                INNER JOIN MorphologicalDetails AS m_d
                    ON m_d.form = w_f_c.form AND m_d.item = 0
                GROUP BY w_f_c.workId, m_d.dictionaryRef
      ''');
    },
  ),
];
