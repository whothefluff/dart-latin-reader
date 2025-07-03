-- Diagnostic Query: Find forms in MorphologicalDetails that fail dictionaryRef resolution.
-- Associated logic in: enriched_resolver.dart
-- (For dev/maintenance. Not useful for production use.)

-- Form with no match at all in L&S
-- Will probably grow with the addition of future works
WITH Assimilated AS ( SELECT form,
                             item,
                             REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( dictionaryRef, 'd-p', 'pp' ), 'd-t', 'tt' ), 'd-s', 'ss' ), 'n-c', 'nc' ), 'n-r', 'rr' ), 'de_-', 'de' ), 'x-f', 'ff' ), 'x-s', 's' ), 'x-l', 'l' ), '_', '' ), '-', '' ) AS dictionaryRef
                        FROM MorphologicalDetails ),
     CompletelyUnmatchedForms AS ( SELECT Assimilated.form
                                        FROM Assimilated
                                        LEFT JOIN DictionaryEntries de
                                            ON Assimilated.dictionaryRef = de.lemma
                                               --if no match
                                               OR CONCAT( Assimilated.dictionaryRef, 1 ) = de.lemma --89 entries affected
                                               --if still no match
                                               OR REPLACE( Assimilated.dictionaryRef, 1, '' ) = de.lemma --4 entries affected
                                    GROUP BY Assimilated.form
                                    HAVING COUNT(de.lemma) = 0 ) -- forms with no successful joins (i.e., non-null lemma)
    -- Now, select the details for ONLY those forms identified above
    SELECT DISTINCT Assimilated.form,
                    Assimilated.dictionaryRef,
                    MorphologicalDetailInflections.partOfSpeech
        FROM Assimilated
        -- We only want details for the forms we found in our CTE
        INNER JOIN CompletelyUnmatchedForms cuf
            ON Assimilated.form = cuf.form
        INNER JOIN MorphologicalDetailInflections
            ON Assimilated.form = MorphologicalDetailInflections.form
               AND Assimilated.item = MorphologicalDetailInflections.item
        ORDER BY Assimilated.form, Assimilated.dictionaryRef;