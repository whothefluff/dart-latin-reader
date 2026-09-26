// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/morph_analysis/morph_analysis.drift.dart'
    as i1;
import 'package:latin_reader/src/component/concordance/concordance.drift.dart'
    as i2;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart'
    as i3;
import 'package:latin_reader/src/component/library/library.drift.dart' as i4;
import 'package:latin_reader/src/component/word_frequency/word_frequency.drift.dart'
    as i5;
import 'package:latin_reader/src/external/data_version.drift.dart' as i6;
import 'package:drift/internal/modular.dart' as i7;
import 'package:sqlite3/common.dart' as i8;

abstract class $AppDb extends i0.GeneratedDatabase {
  $AppDb(i0.QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final i1.MorphologicalDetails morphologicalDetails =
      i1.MorphologicalDetails(this);
  late final i1.MorphologicalDetailInflections morphologicalDetailInflections =
      i1.MorphologicalDetailInflections(this);
  late final i2.ConcordanceAnalyses concordanceAnalyses =
      i2.ConcordanceAnalyses(this);
  late final i3.LnsRefResolutions lnsRefResolutions = i3.LnsRefResolutions(
    this,
  );
  late final i3.Dictionaries dictionaries = i3.Dictionaries(this);
  late final i3.DictionaryEntries dictionaryEntries = i3.DictionaryEntries(
    this,
  );
  late final i3.DictionaryResolvedLnsRefs dictionaryResolvedLnsRefs =
      i3.DictionaryResolvedLnsRefs(this);
  late final i2.ConcordanceLemmas concordanceLemmas = i2.ConcordanceLemmas(
    this,
  );
  late final i2.ConcordanceGrammarValues concordanceGrammarValues =
      i2.ConcordanceGrammarValues(this);
  late final i4.Works works = i4.Works(this);
  late final i4.WorkContents workContents = i4.WorkContents(this);
  late final i5.ScopedFormFreq scopedFormFreq = i5.ScopedFormFreq(this);
  late final i5.ResolvedFreqMorphForms resolvedFreqMorphForms =
      i5.ResolvedFreqMorphForms(this);
  late final i5.ScopedFormLemmaFreq scopedFormLemmaFreq =
      i5.ScopedFormLemmaFreq(this);
  late final i5.ScopedLemmaFreq scopedLemmaFreq = i5.ScopedLemmaFreq(this);
  late final i5.ScopedFreqTotals scopedFreqTotals = i5.ScopedFreqTotals(this);
  late final i1.SearchableMorphDetInflections searchableMorphDetInflections =
      i1.SearchableMorphDetInflections(this);
  late final i1.MorphologyPeek morphologyPeek = i1.MorphologyPeek(this);
  late final i1.MorphologyAnalyses morphologyAnalyses = i1.MorphologyAnalyses(
    this,
  );
  late final i3.DictionaryAlphabets dictionaryAlphabets =
      i3.DictionaryAlphabets(this);
  late final i3.DictEntrySenses dictEntrySenses = i3.DictEntrySenses(this);
  late final i3.DictEntrySenseQuotes dictEntrySenseQuotes =
      i3.DictEntrySenseQuotes(this);
  late final i3.DictionaryDictionaries dictionaryDictionaries =
      i3.DictionaryDictionaries(this);
  late final i3.DictionaryLewisAndShortDictionary
  dictionaryLewisAndShortDictionary = i3.DictionaryLewisAndShortDictionary(
    this,
  );
  late final i3.DictionaryDictionaryEntries dictionaryDictionaryEntries =
      i3.DictionaryDictionaryEntries(this);
  late final i4.Authors authors = i4.Authors(this);
  late final i4.AuthorAbbreviations authorAbbreviations =
      i4.AuthorAbbreviations(this);
  late final i4.WorkAbbreviations workAbbreviations = i4.WorkAbbreviations(
    this,
  );
  late final i4.WorkContentSubdivisions workContentSubdivisions =
      i4.WorkContentSubdivisions(this);
  late final i4.WorkContentSupplementary workContentSupplementary =
      i4.WorkContentSupplementary(this);
  late final i4.UnambiguousMacronizations unambiguousMacronizations =
      i4.UnambiguousMacronizations(this);
  late final i4.WorkMacronizations workMacronizations = i4.WorkMacronizations(
    this,
  );
  late final i4.AuthorsAndWorks authorsAndWorks = i4.AuthorsAndWorks(this);
  late final i4.LibraryStagingResolvedMacronizations
  libraryStagingResolvedMacronizations =
      i4.LibraryStagingResolvedMacronizations(this);
  late final i4.LibraryWorkContentSubdivisionsHierarchy
  libraryWorkContentSubdivisionsHierarchy =
      i4.LibraryWorkContentSubdivisionsHierarchy(this);
  late final i4.LibraryAuthors libraryAuthors = i4.LibraryAuthors(this);
  late final i4.LibraryAuthorDetails libraryAuthorDetails =
      i4.LibraryAuthorDetails(this);
  late final i4.LibraryWorkDetails libraryWorkDetails = i4.LibraryWorkDetails(
    this,
  );
  late final i4.LibraryWorkContents libraryWorkContents =
      i4.LibraryWorkContents(this);
  late final i4.LibraryReadingStarts libraryReadingStarts =
      i4.LibraryReadingStarts(this);
  late final i4.LibraryWorkIndexes libraryWorkIndexes = i4.LibraryWorkIndexes(
    this,
  );
  late final i4.LibraryCatalog libraryCatalog = i4.LibraryCatalog(this);
  late final i6.DataVersion dataVersion = i6.DataVersion(this);
  late final i6.LatestDataVersion latestDataVersion = i6.LatestDataVersion(
    this,
  );
  i4.LibraryDrift get libraryDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i4.LibraryDrift>(i4.LibraryDrift.new);
  i3.DictionaryDrift get dictionaryDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i3.DictionaryDrift>(i3.DictionaryDrift.new);
  i1.MorphAnalysisDrift get morphAnalysisDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i1.MorphAnalysisDrift>(i1.MorphAnalysisDrift.new);
  i5.WordFrequencyDrift get wordFrequencyDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i5.WordFrequencyDrift>(i5.WordFrequencyDrift.new);
  i2.ConcordanceDrift get concordanceDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i2.ConcordanceDrift>(i2.ConcordanceDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    morphologicalDetails,
    morphologicalDetailInflections,
    concordanceAnalyses,
    lnsRefResolutions,
    dictionaries,
    dictionaryEntries,
    dictionaryResolvedLnsRefs,
    concordanceLemmas,
    concordanceGrammarValues,
    works,
    workContents,
    scopedFormFreq,
    resolvedFreqMorphForms,
    i5.resolvedFreqMorphFormsLemma,
    scopedFormLemmaFreq,
    i5.scopedFormLemmaFreqMacronForm,
    scopedLemmaFreq,
    scopedFreqTotals,
    i1.morphologicalDetailsDictRef,
    searchableMorphDetInflections,
    morphologyPeek,
    morphologyAnalyses,
    dictionaryAlphabets,
    dictEntrySenses,
    dictEntrySenseQuotes,
    dictionaryDictionaries,
    dictionaryLewisAndShortDictionary,
    dictionaryDictionaryEntries,
    authors,
    authorAbbreviations,
    workAbbreviations,
    i4.workContentsLookupForm,
    i4.workContentsEncliticHost,
    i4.workContentsEnclitic,
    i4.workContentsWordPosition,
    workContentSubdivisions,
    i4.workContentSubdivisionsParent,
    i4.workContentSubdivisionsTitle,
    workContentSupplementary,
    unambiguousMacronizations,
    workMacronizations,
    authorsAndWorks,
    libraryStagingResolvedMacronizations,
    libraryWorkContentSubdivisionsHierarchy,
    libraryAuthors,
    libraryAuthorDetails,
    libraryWorkDetails,
    libraryWorkContents,
    libraryReadingStarts,
    libraryWorkIndexes,
    libraryCatalog,
    dataVersion,
    latestDataVersion,
  ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $AppDbManager {
  final $AppDb _db;
  $AppDbManager(this._db);
  i1.$MorphologicalDetailsTableManager get morphologicalDetails =>
      i1.$MorphologicalDetailsTableManager(_db, _db.morphologicalDetails);
  i1.$MorphologicalDetailInflectionsTableManager
  get morphologicalDetailInflections =>
      i1.$MorphologicalDetailInflectionsTableManager(
        _db,
        _db.morphologicalDetailInflections,
      );
  i3.$LnsRefResolutionsTableManager get lnsRefResolutions =>
      i3.$LnsRefResolutionsTableManager(_db, _db.lnsRefResolutions);
  i3.$DictionariesTableManager get dictionaries =>
      i3.$DictionariesTableManager(_db, _db.dictionaries);
  i3.$DictionaryEntriesTableManager get dictionaryEntries =>
      i3.$DictionaryEntriesTableManager(_db, _db.dictionaryEntries);
  i4.$WorksTableManager get works => i4.$WorksTableManager(_db, _db.works);
  i4.$WorkContentsTableManager get workContents =>
      i4.$WorkContentsTableManager(_db, _db.workContents);
  i5.$ScopedFormFreqTableManager get scopedFormFreq =>
      i5.$ScopedFormFreqTableManager(_db, _db.scopedFormFreq);
  i5.$ResolvedFreqMorphFormsTableManager get resolvedFreqMorphForms =>
      i5.$ResolvedFreqMorphFormsTableManager(_db, _db.resolvedFreqMorphForms);
  i5.$ScopedFormLemmaFreqTableManager get scopedFormLemmaFreq =>
      i5.$ScopedFormLemmaFreqTableManager(_db, _db.scopedFormLemmaFreq);
  i5.$ScopedLemmaFreqTableManager get scopedLemmaFreq =>
      i5.$ScopedLemmaFreqTableManager(_db, _db.scopedLemmaFreq);
  i5.$ScopedFreqTotalsTableManager get scopedFreqTotals =>
      i5.$ScopedFreqTotalsTableManager(_db, _db.scopedFreqTotals);
  i1.$SearchableMorphDetInflectionsTableManager
  get searchableMorphDetInflections =>
      i1.$SearchableMorphDetInflectionsTableManager(
        _db,
        _db.searchableMorphDetInflections,
      );
  i3.$DictionaryAlphabetsTableManager get dictionaryAlphabets =>
      i3.$DictionaryAlphabetsTableManager(_db, _db.dictionaryAlphabets);
  i3.$DictEntrySensesTableManager get dictEntrySenses =>
      i3.$DictEntrySensesTableManager(_db, _db.dictEntrySenses);
  i3.$DictEntrySenseQuotesTableManager get dictEntrySenseQuotes =>
      i3.$DictEntrySenseQuotesTableManager(_db, _db.dictEntrySenseQuotes);
  i4.$AuthorsTableManager get authors =>
      i4.$AuthorsTableManager(_db, _db.authors);
  i4.$AuthorAbbreviationsTableManager get authorAbbreviations =>
      i4.$AuthorAbbreviationsTableManager(_db, _db.authorAbbreviations);
  i4.$WorkAbbreviationsTableManager get workAbbreviations =>
      i4.$WorkAbbreviationsTableManager(_db, _db.workAbbreviations);
  i4.$WorkContentSubdivisionsTableManager get workContentSubdivisions =>
      i4.$WorkContentSubdivisionsTableManager(_db, _db.workContentSubdivisions);
  i4.$WorkContentSupplementaryTableManager get workContentSupplementary => i4
      .$WorkContentSupplementaryTableManager(_db, _db.workContentSupplementary);
  i4.$UnambiguousMacronizationsTableManager get unambiguousMacronizations =>
      i4.$UnambiguousMacronizationsTableManager(
        _db,
        _db.unambiguousMacronizations,
      );
  i4.$WorkMacronizationsTableManager get workMacronizations =>
      i4.$WorkMacronizationsTableManager(_db, _db.workMacronizations);
  i4.$AuthorsAndWorksTableManager get authorsAndWorks =>
      i4.$AuthorsAndWorksTableManager(_db, _db.authorsAndWorks);
  i6.$DataVersionTableManager get dataVersion =>
      i6.$DataVersionTableManager(_db, _db.dataVersion);
}

extension DefineFunctions on i8.CommonDatabase {
  void defineFunctions({required int Function(String, String) regexp}) {
    createFunction(
      functionName: 'regexp',
      argumentCount: const i8.AllowedArgumentCount(2),
      function: (args) {
        final arg0 = args[0] as String;
        final arg1 = args[1] as String;
        return regexp(arg0, arg1);
      },
    );
  }
}
