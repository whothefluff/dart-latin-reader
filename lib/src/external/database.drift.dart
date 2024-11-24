// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart'
    as i1;
import 'package:latin_reader/src/external/analysis.drift.dart' as i2;
import 'package:latin_reader/src/external/library.drift.dart' as i3;
import 'package:latin_reader/src/external/data_version.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

abstract class $AppDb extends i0.GeneratedDatabase {
  $AppDb(i0.QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final i1.Dictionaries dictionaries = i1.Dictionaries(this);
  late final i1.DictionaryEntries dictionaryEntries =
      i1.DictionaryEntries(this);
  late final i1.DictEntrySenses dictEntrySenses = i1.DictEntrySenses(this);
  late final i1.DicEntrySenseQuotes dicEntrySenseQuotes =
      i1.DicEntrySenseQuotes(this);
  late final i1.BrowserDictionaries browserDictionaries =
      i1.BrowserDictionaries(this);
  late final i2.MorphologicalDetails morphologicalDetails =
      i2.MorphologicalDetails(this);
  late final i2.MorphologicalDetailInflections morphologicalDetailInflections =
      i2.MorphologicalDetailInflections(this);
  late final i3.Authors authors = i3.Authors(this);
  late final i3.AuthorAbbreviations authorAbbreviations =
      i3.AuthorAbbreviations(this);
  late final i3.Works works = i3.Works(this);
  late final i3.WorkAbbreviations workAbbreviations =
      i3.WorkAbbreviations(this);
  late final i3.WorkContents workContents = i3.WorkContents(this);
  late final i3.WorkContentSubdivisions workContentSubdivisions =
      i3.WorkContentSubdivisions(this);
  late final i3.WorkContentSupplementary workContentSupplementary =
      i3.WorkContentSupplementary(this);
  late final i3.Macronizations macronizations = i3.Macronizations(this);
  late final i3.WorkMacronizations workMacronizations =
      i3.WorkMacronizations(this);
  late final i3.UserProvidedMacronizations userProvidedMacronizations =
      i3.UserProvidedMacronizations(this);
  late final i3.AuthorsAndWorks authorsAndWorks = i3.AuthorsAndWorks(this);
  late final i3.WorkContentSubdivisionsHierarchy
      workContentSubdivisionsHierarchy =
      i3.WorkContentSubdivisionsHierarchy(this);
  late final i3.LibraryAuthors libraryAuthors = i3.LibraryAuthors(this);
  late final i3.LibraryAuthorDetails libraryAuthorDetails =
      i3.LibraryAuthorDetails(this);
  late final i3.LibraryWorkDetails libraryWorkDetails =
      i3.LibraryWorkDetails(this);
  late final i3.LibraryWorkContents libraryWorkContents =
      i3.LibraryWorkContents(this);
  late final i3.LibraryWorkIndexes libraryWorkIndexes =
      i3.LibraryWorkIndexes(this);
  late final i4.DataVersion dataVersion = i4.DataVersion(this);
  late final i4.LatestDataVersion latestDataVersion =
      i4.LatestDataVersion(this);
  i3.LibraryDrift get libraryDrift => i5.ReadDatabaseContainer(this)
      .accessor<i3.LibraryDrift>(i3.LibraryDrift.new);
  i1.DictionaryDrift get dictionaryDrift => i5.ReadDatabaseContainer(this)
      .accessor<i1.DictionaryDrift>(i1.DictionaryDrift.new);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
        dictionaries,
        dictionaryEntries,
        dictEntrySenses,
        dicEntrySenseQuotes,
        browserDictionaries,
        morphologicalDetails,
        morphologicalDetailInflections,
        authors,
        authorAbbreviations,
        works,
        workAbbreviations,
        workContents,
        workContentSubdivisions,
        workContentSupplementary,
        macronizations,
        workMacronizations,
        userProvidedMacronizations,
        authorsAndWorks,
        workContentSubdivisionsHierarchy,
        libraryAuthors,
        libraryAuthorDetails,
        libraryWorkDetails,
        libraryWorkContents,
        libraryWorkIndexes,
        dataVersion,
        latestDataVersion
      ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $AppDbManager {
  final $AppDb _db;
  $AppDbManager(this._db);
  i1.$DictionariesTableManager get dictionaries =>
      i1.$DictionariesTableManager(_db, _db.dictionaries);
  i1.$DictionaryEntriesTableManager get dictionaryEntries =>
      i1.$DictionaryEntriesTableManager(_db, _db.dictionaryEntries);
  i1.$DictEntrySensesTableManager get dictEntrySenses =>
      i1.$DictEntrySensesTableManager(_db, _db.dictEntrySenses);
  i1.$DicEntrySenseQuotesTableManager get dicEntrySenseQuotes =>
      i1.$DicEntrySenseQuotesTableManager(_db, _db.dicEntrySenseQuotes);
  i2.$MorphologicalDetailsTableManager get morphologicalDetails =>
      i2.$MorphologicalDetailsTableManager(_db, _db.morphologicalDetails);
  i2.$MorphologicalDetailInflectionsTableManager
      get morphologicalDetailInflections =>
          i2.$MorphologicalDetailInflectionsTableManager(
              _db, _db.morphologicalDetailInflections);
  i3.$AuthorsTableManager get authors =>
      i3.$AuthorsTableManager(_db, _db.authors);
  i3.$AuthorAbbreviationsTableManager get authorAbbreviations =>
      i3.$AuthorAbbreviationsTableManager(_db, _db.authorAbbreviations);
  i3.$WorksTableManager get works => i3.$WorksTableManager(_db, _db.works);
  i3.$WorkAbbreviationsTableManager get workAbbreviations =>
      i3.$WorkAbbreviationsTableManager(_db, _db.workAbbreviations);
  i3.$WorkContentsTableManager get workContents =>
      i3.$WorkContentsTableManager(_db, _db.workContents);
  i3.$WorkContentSubdivisionsTableManager get workContentSubdivisions =>
      i3.$WorkContentSubdivisionsTableManager(_db, _db.workContentSubdivisions);
  i3.$WorkContentSupplementaryTableManager get workContentSupplementary => i3
      .$WorkContentSupplementaryTableManager(_db, _db.workContentSupplementary);
  i3.$MacronizationsTableManager get macronizations =>
      i3.$MacronizationsTableManager(_db, _db.macronizations);
  i3.$WorkMacronizationsTableManager get workMacronizations =>
      i3.$WorkMacronizationsTableManager(_db, _db.workMacronizations);
  i3.$UserProvidedMacronizationsTableManager get userProvidedMacronizations =>
      i3.$UserProvidedMacronizationsTableManager(
          _db, _db.userProvidedMacronizations);
  i3.$AuthorsAndWorksTableManager get authorsAndWorks =>
      i3.$AuthorsAndWorksTableManager(_db, _db.authorsAndWorks);
  i4.$DataVersionTableManager get dataVersion =>
      i4.$DataVersionTableManager(_db, _db.dataVersion);
}
