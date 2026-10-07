// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/concordance/concordance.drift.dart'
    as i1;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart'
    as i2;
import 'package:latin_reader/src/component/library/library.drift.dart' as i3;
import 'package:latin_reader/src/component/word_frequency/word_frequency.drift.dart'
    as i4;
import 'package:latin_reader/src/component/morph_analysis/morph_analysis.drift.dart'
    as i5;
import 'package:latin_reader/src/external/data_version.drift.dart' as i6;
import 'package:drift/internal/modular.dart' as i7;
import 'package:sqlite3/common.dart' as i8;

abstract class $AppDb extends i0.GeneratedDatabase {
  $AppDb(i0.QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final i1.ConcordanceDetails concordanceDetails = i1.ConcordanceDetails(
    this,
  );
  late final i1.ConcordanceDetailInflections concordanceDetailInflections =
      i1.ConcordanceDetailInflections(this);
  late final i1.ConcordanceCountableWordCandidateAnalyses
  concordanceCountableWordCandidateAnalyses =
      i1.ConcordanceCountableWordCandidateAnalyses(this);
  late final i1.ConcordanceAnalysesWithOptionalInflections
  concordanceAnalysesWithOptionalInflections =
      i1.ConcordanceAnalysesWithOptionalInflections(this);
  late final i2.LnsRefResolutions lnsRefResolutions = i2.LnsRefResolutions(
    this,
  );
  late final i2.Dictionaries dictionaries = i2.Dictionaries(this);
  late final i2.DictionaryEntries dictionaryEntries = i2.DictionaryEntries(
    this,
  );
  late final i2.DictionaryResolvedLnsRefs dictionaryResolvedLnsRefs =
      i2.DictionaryResolvedLnsRefs(this);
  late final i1.ConcordanceLemmas concordanceLemmas = i1.ConcordanceLemmas(
    this,
  );
  late final i1.ConcordanceGrammarValues concordanceGrammarValues =
      i1.ConcordanceGrammarValues(this);
  late final i3.Works works = i3.Works(this);
  late final i3.WorkContents workContents = i3.WorkContents(this);
  late final i4.ScopedFormFreq scopedFormFreq = i4.ScopedFormFreq(this);
  late final i4.ResolvedFreqMorphForms resolvedFreqMorphForms =
      i4.ResolvedFreqMorphForms(this);
  late final i4.ScopedFormLemmaFreq scopedFormLemmaFreq =
      i4.ScopedFormLemmaFreq(this);
  late final i4.ScopedLemmaFreq scopedLemmaFreq = i4.ScopedLemmaFreq(this);
  late final i4.ScopedFreqTotals scopedFreqTotals = i4.ScopedFreqTotals(this);
  late final i4.ScopedLookupFreq scopedLookupFreq = i4.ScopedLookupFreq(this);
  late final i4.ScopedLookupLemmas scopedLookupLemmas = i4.ScopedLookupLemmas(
    this,
  );
  late final i5.MorphologicalDetails morphologicalDetails =
      i5.MorphologicalDetails(this);
  late final i5.MorphologicalDetailInflections morphologicalDetailInflections =
      i5.MorphologicalDetailInflections(this);
  late final i5.CountableWordCandidateAnalyses countableWordCandidateAnalyses =
      i5.CountableWordCandidateAnalyses(this);
  late final i5.SearchableMorphDetInflections searchableMorphDetInflections =
      i5.SearchableMorphDetInflections(this);
  late final i5.MorphologyPeek morphologyPeek = i5.MorphologyPeek(this);
  late final i5.MorphologyLookupFormCandidateInflections
  morphologyLookupFormCandidateInflections =
      i5.MorphologyLookupFormCandidateInflections(this);
  late final i5.MorphologyAnalyses morphologyAnalyses = i5.MorphologyAnalyses(
    this,
  );
  late final i2.DictionaryAlphabets dictionaryAlphabets =
      i2.DictionaryAlphabets(this);
  late final i2.DictEntrySenses dictEntrySenses = i2.DictEntrySenses(this);
  late final i2.DictEntrySenseQuotes dictEntrySenseQuotes =
      i2.DictEntrySenseQuotes(this);
  late final i2.DictionaryDictionaries dictionaryDictionaries =
      i2.DictionaryDictionaries(this);
  late final i2.DictionaryLewisAndShortDictionary
  dictionaryLewisAndShortDictionary = i2.DictionaryLewisAndShortDictionary(
    this,
  );
  late final i2.DictionaryDictionaryEntries dictionaryDictionaryEntries =
      i2.DictionaryDictionaryEntries(this);
  late final i2.SearchableDictionaryEntries searchableDictionaryEntries =
      i2.SearchableDictionaryEntries(this);
  late final i3.Authors authors = i3.Authors(this);
  late final i3.AuthorAbbreviations authorAbbreviations =
      i3.AuthorAbbreviations(this);
  late final i3.WorkAbbreviations workAbbreviations = i3.WorkAbbreviations(
    this,
  );
  late final i3.WorkContentSubdivisions workContentSubdivisions =
      i3.WorkContentSubdivisions(this);
  late final i3.WorkContentSupplementary workContentSupplementary =
      i3.WorkContentSupplementary(this);
  late final i3.UnambiguousMacronizations unambiguousMacronizations =
      i3.UnambiguousMacronizations(this);
  late final i3.WorkMacronizations workMacronizations = i3.WorkMacronizations(
    this,
  );
  late final i3.AuthorsAndWorks authorsAndWorks = i3.AuthorsAndWorks(this);
  late final i3.LibraryStagingResolvedMacronizations
  libraryStagingResolvedMacronizations =
      i3.LibraryStagingResolvedMacronizations(this);
  late final i3.LibraryWorkContentSubdivisionsHierarchy
  libraryWorkContentSubdivisionsHierarchy =
      i3.LibraryWorkContentSubdivisionsHierarchy(this);
  late final i3.LibraryAuthors libraryAuthors = i3.LibraryAuthors(this);
  late final i3.LibraryAuthorDetails libraryAuthorDetails =
      i3.LibraryAuthorDetails(this);
  late final i3.LibraryWorkDetails libraryWorkDetails = i3.LibraryWorkDetails(
    this,
  );
  late final i3.LibraryWorkContents libraryWorkContents =
      i3.LibraryWorkContents(this);
  late final i3.LibraryReadingStarts libraryReadingStarts =
      i3.LibraryReadingStarts(this);
  late final i3.LibraryWorkIndexes libraryWorkIndexes = i3.LibraryWorkIndexes(
    this,
  );
  late final i3.LibraryCatalog libraryCatalog = i3.LibraryCatalog(this);
  late final i6.DataVersion dataVersion = i6.DataVersion(this);
  late final i6.LatestDataVersion latestDataVersion = i6.LatestDataVersion(
    this,
  );
  i3.LibraryDrift get libraryDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i3.LibraryDrift>(i3.LibraryDrift.new);
  i2.DictionaryDrift get dictionaryDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i2.DictionaryDrift>(i2.DictionaryDrift.new);
  i5.MorphAnalysisDrift get morphAnalysisDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i5.MorphAnalysisDrift>(i5.MorphAnalysisDrift.new);
  i4.WordFrequencyDrift get wordFrequencyDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i4.WordFrequencyDrift>(i4.WordFrequencyDrift.new);
  i1.ConcordanceDrift get concordanceDrift => i7.ReadDatabaseContainer(
    this,
  ).accessor<i1.ConcordanceDrift>(i1.ConcordanceDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    concordanceDetails,
    i1.concordanceDetailsDictRef,
    concordanceDetailInflections,
    concordanceCountableWordCandidateAnalyses,
    i1.concordanceCountableWordCandidateAnalysesAnalysis,
    concordanceAnalysesWithOptionalInflections,
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
    i4.resolvedFreqMorphFormsLemma,
    scopedFormLemmaFreq,
    i4.scopedFormLemmaFreqMacronForm,
    scopedLemmaFreq,
    scopedFreqTotals,
    scopedLookupFreq,
    scopedLookupLemmas,
    morphologicalDetails,
    morphologicalDetailInflections,
    countableWordCandidateAnalyses,
    searchableMorphDetInflections,
    morphologyPeek,
    morphologyLookupFormCandidateInflections,
    morphologyAnalyses,
    dictionaryAlphabets,
    dictEntrySenses,
    dictEntrySenseQuotes,
    dictionaryDictionaries,
    dictionaryLewisAndShortDictionary,
    dictionaryDictionaryEntries,
    searchableDictionaryEntries,
    authors,
    authorAbbreviations,
    workAbbreviations,
    i3.workContentsLookupForm,
    i3.workContentsEncliticHost,
    i3.workContentsEnclitic,
    i3.workContentsWordPosition,
    workContentSubdivisions,
    i3.workContentSubdivisionsParent,
    i3.workContentSubdivisionsTitle,
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
  i1.$ConcordanceDetailsTableManager get concordanceDetails =>
      i1.$ConcordanceDetailsTableManager(_db, _db.concordanceDetails);
  i1.$ConcordanceDetailInflectionsTableManager
  get concordanceDetailInflections =>
      i1.$ConcordanceDetailInflectionsTableManager(
        _db,
        _db.concordanceDetailInflections,
      );
  i1.$ConcordanceCountableWordCandidateAnalysesTableManager
  get concordanceCountableWordCandidateAnalyses =>
      i1.$ConcordanceCountableWordCandidateAnalysesTableManager(
        _db,
        _db.concordanceCountableWordCandidateAnalyses,
      );
  i2.$LnsRefResolutionsTableManager get lnsRefResolutions =>
      i2.$LnsRefResolutionsTableManager(_db, _db.lnsRefResolutions);
  i2.$DictionariesTableManager get dictionaries =>
      i2.$DictionariesTableManager(_db, _db.dictionaries);
  i2.$DictionaryEntriesTableManager get dictionaryEntries =>
      i2.$DictionaryEntriesTableManager(_db, _db.dictionaryEntries);
  i3.$WorksTableManager get works => i3.$WorksTableManager(_db, _db.works);
  i3.$WorkContentsTableManager get workContents =>
      i3.$WorkContentsTableManager(_db, _db.workContents);
  i4.$ScopedFormFreqTableManager get scopedFormFreq =>
      i4.$ScopedFormFreqTableManager(_db, _db.scopedFormFreq);
  i4.$ResolvedFreqMorphFormsTableManager get resolvedFreqMorphForms =>
      i4.$ResolvedFreqMorphFormsTableManager(_db, _db.resolvedFreqMorphForms);
  i4.$ScopedFormLemmaFreqTableManager get scopedFormLemmaFreq =>
      i4.$ScopedFormLemmaFreqTableManager(_db, _db.scopedFormLemmaFreq);
  i4.$ScopedLemmaFreqTableManager get scopedLemmaFreq =>
      i4.$ScopedLemmaFreqTableManager(_db, _db.scopedLemmaFreq);
  i4.$ScopedFreqTotalsTableManager get scopedFreqTotals =>
      i4.$ScopedFreqTotalsTableManager(_db, _db.scopedFreqTotals);
  i4.$ScopedLookupFreqTableManager get scopedLookupFreq =>
      i4.$ScopedLookupFreqTableManager(_db, _db.scopedLookupFreq);
  i4.$ScopedLookupLemmasTableManager get scopedLookupLemmas =>
      i4.$ScopedLookupLemmasTableManager(_db, _db.scopedLookupLemmas);
  i5.$MorphologicalDetailsTableManager get morphologicalDetails =>
      i5.$MorphologicalDetailsTableManager(_db, _db.morphologicalDetails);
  i5.$MorphologicalDetailInflectionsTableManager
  get morphologicalDetailInflections =>
      i5.$MorphologicalDetailInflectionsTableManager(
        _db,
        _db.morphologicalDetailInflections,
      );
  i5.$CountableWordCandidateAnalysesTableManager
  get countableWordCandidateAnalyses =>
      i5.$CountableWordCandidateAnalysesTableManager(
        _db,
        _db.countableWordCandidateAnalyses,
      );
  i5.$SearchableMorphDetInflectionsTableManager
  get searchableMorphDetInflections =>
      i5.$SearchableMorphDetInflectionsTableManager(
        _db,
        _db.searchableMorphDetInflections,
      );
  i2.$DictionaryAlphabetsTableManager get dictionaryAlphabets =>
      i2.$DictionaryAlphabetsTableManager(_db, _db.dictionaryAlphabets);
  i2.$DictEntrySensesTableManager get dictEntrySenses =>
      i2.$DictEntrySensesTableManager(_db, _db.dictEntrySenses);
  i2.$DictEntrySenseQuotesTableManager get dictEntrySenseQuotes =>
      i2.$DictEntrySenseQuotesTableManager(_db, _db.dictEntrySenseQuotes);
  i2.$SearchableDictionaryEntriesTableManager get searchableDictionaryEntries =>
      i2.$SearchableDictionaryEntriesTableManager(
        _db,
        _db.searchableDictionaryEntries,
      );
  i3.$AuthorsTableManager get authors =>
      i3.$AuthorsTableManager(_db, _db.authors);
  i3.$AuthorAbbreviationsTableManager get authorAbbreviations =>
      i3.$AuthorAbbreviationsTableManager(_db, _db.authorAbbreviations);
  i3.$WorkAbbreviationsTableManager get workAbbreviations =>
      i3.$WorkAbbreviationsTableManager(_db, _db.workAbbreviations);
  i3.$WorkContentSubdivisionsTableManager get workContentSubdivisions =>
      i3.$WorkContentSubdivisionsTableManager(_db, _db.workContentSubdivisions);
  i3.$WorkContentSupplementaryTableManager get workContentSupplementary => i3
      .$WorkContentSupplementaryTableManager(_db, _db.workContentSupplementary);
  i3.$UnambiguousMacronizationsTableManager get unambiguousMacronizations =>
      i3.$UnambiguousMacronizationsTableManager(
        _db,
        _db.unambiguousMacronizations,
      );
  i3.$WorkMacronizationsTableManager get workMacronizations =>
      i3.$WorkMacronizationsTableManager(_db, _db.workMacronizations);
  i3.$AuthorsAndWorksTableManager get authorsAndWorks =>
      i3.$AuthorsAndWorksTableManager(_db, _db.authorsAndWorks);
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
