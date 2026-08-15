// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/word_frequency/word_frequency.drift.dart'
    as i1;
import 'package:latin_reader/src/component/morph_analysis/morph_analysis.drift.dart'
    as i2;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart'
    as i3;
import 'package:latin_reader/src/component/library/library.drift.dart' as i4;
import 'package:latin_reader/src/external/data_version.drift.dart' as i5;
import 'package:drift/internal/modular.dart' as i6;
import 'package:sqlite3/common.dart' as i7;

abstract class $AppDb extends i0.GeneratedDatabase {
  $AppDb(i0.QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final i1.WorkFormCounts workFormCounts = i1.WorkFormCounts(this);
  late final i1.WorkLemmaCounts workLemmaCounts = i1.WorkLemmaCounts(this);
  late final i2.MorphologicalDetails morphologicalDetails =
      i2.MorphologicalDetails(this);
  late final i2.MorphologicalDetailInflections morphologicalDetailInflections =
      i2.MorphologicalDetailInflections(this);
  late final i2.SearchableMorphDetInflections searchableMorphDetInflections =
      i2.SearchableMorphDetInflections(this);
  late final i2.MorphologyPeek morphologyPeek = i2.MorphologyPeek(this);
  late final i2.MorphologyAnalyses morphologyAnalyses = i2.MorphologyAnalyses(
    this,
  );
  late final i3.Dictionaries dictionaries = i3.Dictionaries(this);
  late final i3.DictionaryEntries dictionaryEntries = i3.DictionaryEntries(
    this,
  );
  late final i3.DictionaryAlphabets dictionaryAlphabets =
      i3.DictionaryAlphabets(this);
  late final i3.DictEntrySenses dictEntrySenses = i3.DictEntrySenses(this);
  late final i3.DictEntrySenseQuotes dictEntrySenseQuotes =
      i3.DictEntrySenseQuotes(this);
  late final i3.DictionaryDictionaries dictionaryDictionaries =
      i3.DictionaryDictionaries(this);
  late final i3.DictionaryDictionaryEntries dictionaryDictionaryEntries =
      i3.DictionaryDictionaryEntries(this);
  late final i4.Authors authors = i4.Authors(this);
  late final i4.AuthorAbbreviations authorAbbreviations =
      i4.AuthorAbbreviations(this);
  late final i4.Works works = i4.Works(this);
  late final i4.WorkAbbreviations workAbbreviations = i4.WorkAbbreviations(
    this,
  );
  late final i4.WorkContents workContents = i4.WorkContents(this);
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
  late final i4.LibraryWorkIndexes libraryWorkIndexes = i4.LibraryWorkIndexes(
    this,
  );
  late final i5.DataVersion dataVersion = i5.DataVersion(this);
  late final i5.LatestDataVersion latestDataVersion = i5.LatestDataVersion(
    this,
  );
  i4.LibraryDrift get libraryDrift => i6.ReadDatabaseContainer(
    this,
  ).accessor<i4.LibraryDrift>(i4.LibraryDrift.new);
  i3.DictionaryDrift get dictionaryDrift => i6.ReadDatabaseContainer(
    this,
  ).accessor<i3.DictionaryDrift>(i3.DictionaryDrift.new);
  i2.MorphAnalysisDrift get morphAnalysisDrift => i6.ReadDatabaseContainer(
    this,
  ).accessor<i2.MorphAnalysisDrift>(i2.MorphAnalysisDrift.new);
  i1.WordFrequencyDrift get wordFrequencyDrift => i6.ReadDatabaseContainer(
    this,
  ).accessor<i1.WordFrequencyDrift>(i1.WordFrequencyDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    workFormCounts,
    workLemmaCounts,
    morphologicalDetails,
    morphologicalDetailInflections,
    searchableMorphDetInflections,
    morphologyPeek,
    morphologyAnalyses,
    dictionaries,
    dictionaryEntries,
    dictionaryAlphabets,
    dictEntrySenses,
    dictEntrySenseQuotes,
    dictionaryDictionaries,
    dictionaryDictionaryEntries,
    authors,
    authorAbbreviations,
    works,
    workAbbreviations,
    workContents,
    i4.workContentsBaseNormForm,
    i4.workContentsWordPosition,
    workContentSubdivisions,
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
    libraryWorkIndexes,
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
  i1.$WorkFormCountsTableManager get workFormCounts =>
      i1.$WorkFormCountsTableManager(_db, _db.workFormCounts);
  i1.$WorkLemmaCountsTableManager get workLemmaCounts =>
      i1.$WorkLemmaCountsTableManager(_db, _db.workLemmaCounts);
  i2.$MorphologicalDetailsTableManager get morphologicalDetails =>
      i2.$MorphologicalDetailsTableManager(_db, _db.morphologicalDetails);
  i2.$MorphologicalDetailInflectionsTableManager
  get morphologicalDetailInflections =>
      i2.$MorphologicalDetailInflectionsTableManager(
        _db,
        _db.morphologicalDetailInflections,
      );
  i2.$SearchableMorphDetInflectionsTableManager
  get searchableMorphDetInflections =>
      i2.$SearchableMorphDetInflectionsTableManager(
        _db,
        _db.searchableMorphDetInflections,
      );
  i3.$DictionariesTableManager get dictionaries =>
      i3.$DictionariesTableManager(_db, _db.dictionaries);
  i3.$DictionaryEntriesTableManager get dictionaryEntries =>
      i3.$DictionaryEntriesTableManager(_db, _db.dictionaryEntries);
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
  i4.$WorksTableManager get works => i4.$WorksTableManager(_db, _db.works);
  i4.$WorkAbbreviationsTableManager get workAbbreviations =>
      i4.$WorkAbbreviationsTableManager(_db, _db.workAbbreviations);
  i4.$WorkContentsTableManager get workContents =>
      i4.$WorkContentsTableManager(_db, _db.workContents);
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
  i5.$DataVersionTableManager get dataVersion =>
      i5.$DataVersionTableManager(_db, _db.dataVersion);
}

extension DefineFunctions on i7.CommonDatabase {
  void defineFunctions({required int Function(String, String) regexp}) {
    createFunction(
      functionName: 'regexp',
      argumentCount: const i7.AllowedArgumentCount(2),
      function: (args) {
        final arg0 = args[0] as String;
        final arg1 = args[1] as String;
        return regexp(arg0, arg1);
      },
    );
  }
}
