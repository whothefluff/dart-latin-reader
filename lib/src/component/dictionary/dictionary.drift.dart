// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart'
    as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:latin_reader/src/component/dictionary/dictionaries_api.dart'
    as i3;
import 'package:latin_reader/src/component/dictionary/dictionary_entries_api.dart'
    as i4;
import 'package:latin_reader/src/component/dictionary/dictionary_entry_senses_api.dart'
    as i5;

typedef $DictionariesCreateCompanionBuilder =
    i1.DictionariesCompanion Function({
      required String id,
      required String name,
      required String language,
      required String publisher,
      required String publicationDate,
    });
typedef $DictionariesUpdateCompanionBuilder =
    i1.DictionariesCompanion Function({
      i0.Value<String> id,
      i0.Value<String> name,
      i0.Value<String> language,
      i0.Value<String> publisher,
      i0.Value<String> publicationDate,
    });

class $DictionariesFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Dictionaries> {
  $DictionariesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get publicationDate => $composableBuilder(
    column: $table.publicationDate,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $DictionariesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Dictionaries> {
  $DictionariesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get publicationDate => $composableBuilder(
    column: $table.publicationDate,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $DictionariesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Dictionaries> {
  $DictionariesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  i0.GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  i0.GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  i0.GeneratedColumn<String> get publicationDate => $composableBuilder(
    column: $table.publicationDate,
    builder: (column) => column,
  );
}

class $DictionariesTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.Dictionaries,
          i1.Dictionary,
          i1.$DictionariesFilterComposer,
          i1.$DictionariesOrderingComposer,
          i1.$DictionariesAnnotationComposer,
          $DictionariesCreateCompanionBuilder,
          $DictionariesUpdateCompanionBuilder,
          (
            i1.Dictionary,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.Dictionaries,
              i1.Dictionary
            >,
          ),
          i1.Dictionary,
          i0.PrefetchHooks Function()
        > {
  $DictionariesTableManager(i0.GeneratedDatabase db, i1.Dictionaries table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$DictionariesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$DictionariesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$DictionariesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> id = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<String> language = const i0.Value.absent(),
                i0.Value<String> publisher = const i0.Value.absent(),
                i0.Value<String> publicationDate = const i0.Value.absent(),
              }) => i1.DictionariesCompanion(
                id: id,
                name: name,
                language: language,
                publisher: publisher,
                publicationDate: publicationDate,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String language,
                required String publisher,
                required String publicationDate,
              }) => i1.DictionariesCompanion.insert(
                id: id,
                name: name,
                language: language,
                publisher: publisher,
                publicationDate: publicationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DictionariesProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.Dictionaries,
      i1.Dictionary,
      i1.$DictionariesFilterComposer,
      i1.$DictionariesOrderingComposer,
      i1.$DictionariesAnnotationComposer,
      $DictionariesCreateCompanionBuilder,
      $DictionariesUpdateCompanionBuilder,
      (
        i1.Dictionary,
        i0.BaseReferences<i0.GeneratedDatabase, i1.Dictionaries, i1.Dictionary>,
      ),
      i1.Dictionary,
      i0.PrefetchHooks Function()
    >;
typedef $DictionaryEntriesCreateCompanionBuilder =
    i1.DictionaryEntriesCompanion Function({
      required String dictionary,
      required String lemma,
      i0.Value<String?> partOfSpeech,
      i0.Value<String?> inflection,
      required int idx,
    });
typedef $DictionaryEntriesUpdateCompanionBuilder =
    i1.DictionaryEntriesCompanion Function({
      i0.Value<String> dictionary,
      i0.Value<String> lemma,
      i0.Value<String?> partOfSpeech,
      i0.Value<String?> inflection,
      i0.Value<int> idx,
    });

class $DictionaryEntriesFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictionaryEntries> {
  $DictionaryEntriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get inflection => $composableBuilder(
    column: $table.inflection,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $DictionaryEntriesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictionaryEntries> {
  $DictionaryEntriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get inflection => $composableBuilder(
    column: $table.inflection,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $DictionaryEntriesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictionaryEntries> {
  $DictionaryEntriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get lemma =>
      $composableBuilder(column: $table.lemma, builder: (column) => column);

  i0.GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get inflection => $composableBuilder(
    column: $table.inflection,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get idx =>
      $composableBuilder(column: $table.idx, builder: (column) => column);
}

class $DictionaryEntriesTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.DictionaryEntries,
          i1.DictionaryEntry,
          i1.$DictionaryEntriesFilterComposer,
          i1.$DictionaryEntriesOrderingComposer,
          i1.$DictionaryEntriesAnnotationComposer,
          $DictionaryEntriesCreateCompanionBuilder,
          $DictionaryEntriesUpdateCompanionBuilder,
          (
            i1.DictionaryEntry,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.DictionaryEntries,
              i1.DictionaryEntry
            >,
          ),
          i1.DictionaryEntry,
          i0.PrefetchHooks Function()
        > {
  $DictionaryEntriesTableManager(
    i0.GeneratedDatabase db,
    i1.DictionaryEntries table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$DictionaryEntriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$DictionaryEntriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$DictionaryEntriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> dictionary = const i0.Value.absent(),
                i0.Value<String> lemma = const i0.Value.absent(),
                i0.Value<String?> partOfSpeech = const i0.Value.absent(),
                i0.Value<String?> inflection = const i0.Value.absent(),
                i0.Value<int> idx = const i0.Value.absent(),
              }) => i1.DictionaryEntriesCompanion(
                dictionary: dictionary,
                lemma: lemma,
                partOfSpeech: partOfSpeech,
                inflection: inflection,
                idx: idx,
              ),
          createCompanionCallback:
              ({
                required String dictionary,
                required String lemma,
                i0.Value<String?> partOfSpeech = const i0.Value.absent(),
                i0.Value<String?> inflection = const i0.Value.absent(),
                required int idx,
              }) => i1.DictionaryEntriesCompanion.insert(
                dictionary: dictionary,
                lemma: lemma,
                partOfSpeech: partOfSpeech,
                inflection: inflection,
                idx: idx,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DictionaryEntriesProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.DictionaryEntries,
      i1.DictionaryEntry,
      i1.$DictionaryEntriesFilterComposer,
      i1.$DictionaryEntriesOrderingComposer,
      i1.$DictionaryEntriesAnnotationComposer,
      $DictionaryEntriesCreateCompanionBuilder,
      $DictionaryEntriesUpdateCompanionBuilder,
      (
        i1.DictionaryEntry,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.DictionaryEntries,
          i1.DictionaryEntry
        >,
      ),
      i1.DictionaryEntry,
      i0.PrefetchHooks Function()
    >;
typedef $DictionaryAlphabetsCreateCompanionBuilder =
    i1.DictionaryAlphabetsCompanion Function({
      required String dictionary,
      required String letter,
      required int firstEntryIndex,
    });
typedef $DictionaryAlphabetsUpdateCompanionBuilder =
    i1.DictionaryAlphabetsCompanion Function({
      i0.Value<String> dictionary,
      i0.Value<String> letter,
      i0.Value<int> firstEntryIndex,
    });

class $DictionaryAlphabetsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictionaryAlphabets> {
  $DictionaryAlphabetsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get letter => $composableBuilder(
    column: $table.letter,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get firstEntryIndex => $composableBuilder(
    column: $table.firstEntryIndex,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $DictionaryAlphabetsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictionaryAlphabets> {
  $DictionaryAlphabetsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get letter => $composableBuilder(
    column: $table.letter,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get firstEntryIndex => $composableBuilder(
    column: $table.firstEntryIndex,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $DictionaryAlphabetsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictionaryAlphabets> {
  $DictionaryAlphabetsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get letter =>
      $composableBuilder(column: $table.letter, builder: (column) => column);

  i0.GeneratedColumn<int> get firstEntryIndex => $composableBuilder(
    column: $table.firstEntryIndex,
    builder: (column) => column,
  );
}

class $DictionaryAlphabetsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.DictionaryAlphabets,
          i1.DictionaryAlphabet,
          i1.$DictionaryAlphabetsFilterComposer,
          i1.$DictionaryAlphabetsOrderingComposer,
          i1.$DictionaryAlphabetsAnnotationComposer,
          $DictionaryAlphabetsCreateCompanionBuilder,
          $DictionaryAlphabetsUpdateCompanionBuilder,
          (
            i1.DictionaryAlphabet,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.DictionaryAlphabets,
              i1.DictionaryAlphabet
            >,
          ),
          i1.DictionaryAlphabet,
          i0.PrefetchHooks Function()
        > {
  $DictionaryAlphabetsTableManager(
    i0.GeneratedDatabase db,
    i1.DictionaryAlphabets table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$DictionaryAlphabetsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$DictionaryAlphabetsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$DictionaryAlphabetsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> dictionary = const i0.Value.absent(),
                i0.Value<String> letter = const i0.Value.absent(),
                i0.Value<int> firstEntryIndex = const i0.Value.absent(),
              }) => i1.DictionaryAlphabetsCompanion(
                dictionary: dictionary,
                letter: letter,
                firstEntryIndex: firstEntryIndex,
              ),
          createCompanionCallback:
              ({
                required String dictionary,
                required String letter,
                required int firstEntryIndex,
              }) => i1.DictionaryAlphabetsCompanion.insert(
                dictionary: dictionary,
                letter: letter,
                firstEntryIndex: firstEntryIndex,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DictionaryAlphabetsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.DictionaryAlphabets,
      i1.DictionaryAlphabet,
      i1.$DictionaryAlphabetsFilterComposer,
      i1.$DictionaryAlphabetsOrderingComposer,
      i1.$DictionaryAlphabetsAnnotationComposer,
      $DictionaryAlphabetsCreateCompanionBuilder,
      $DictionaryAlphabetsUpdateCompanionBuilder,
      (
        i1.DictionaryAlphabet,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.DictionaryAlphabets,
          i1.DictionaryAlphabet
        >,
      ),
      i1.DictionaryAlphabet,
      i0.PrefetchHooks Function()
    >;
typedef $DictEntrySensesCreateCompanionBuilder =
    i1.DictEntrySensesCompanion Function({
      required String dictionary,
      required String lemma,
      required String lvl,
      required String prettyLevel,
      required String content,
    });
typedef $DictEntrySensesUpdateCompanionBuilder =
    i1.DictEntrySensesCompanion Function({
      i0.Value<String> dictionary,
      i0.Value<String> lemma,
      i0.Value<String> lvl,
      i0.Value<String> prettyLevel,
      i0.Value<String> content,
    });

class $DictEntrySensesFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictEntrySenses> {
  $DictEntrySensesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get lvl => $composableBuilder(
    column: $table.lvl,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get prettyLevel => $composableBuilder(
    column: $table.prettyLevel,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $DictEntrySensesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictEntrySenses> {
  $DictEntrySensesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get lvl => $composableBuilder(
    column: $table.lvl,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get prettyLevel => $composableBuilder(
    column: $table.prettyLevel,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $DictEntrySensesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictEntrySenses> {
  $DictEntrySensesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get lemma =>
      $composableBuilder(column: $table.lemma, builder: (column) => column);

  i0.GeneratedColumn<String> get lvl =>
      $composableBuilder(column: $table.lvl, builder: (column) => column);

  i0.GeneratedColumn<String> get prettyLevel => $composableBuilder(
    column: $table.prettyLevel,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $DictEntrySensesTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.DictEntrySenses,
          i1.DictEntrySense,
          i1.$DictEntrySensesFilterComposer,
          i1.$DictEntrySensesOrderingComposer,
          i1.$DictEntrySensesAnnotationComposer,
          $DictEntrySensesCreateCompanionBuilder,
          $DictEntrySensesUpdateCompanionBuilder,
          (
            i1.DictEntrySense,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.DictEntrySenses,
              i1.DictEntrySense
            >,
          ),
          i1.DictEntrySense,
          i0.PrefetchHooks Function()
        > {
  $DictEntrySensesTableManager(
    i0.GeneratedDatabase db,
    i1.DictEntrySenses table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$DictEntrySensesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$DictEntrySensesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$DictEntrySensesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> dictionary = const i0.Value.absent(),
                i0.Value<String> lemma = const i0.Value.absent(),
                i0.Value<String> lvl = const i0.Value.absent(),
                i0.Value<String> prettyLevel = const i0.Value.absent(),
                i0.Value<String> content = const i0.Value.absent(),
              }) => i1.DictEntrySensesCompanion(
                dictionary: dictionary,
                lemma: lemma,
                lvl: lvl,
                prettyLevel: prettyLevel,
                content: content,
              ),
          createCompanionCallback:
              ({
                required String dictionary,
                required String lemma,
                required String lvl,
                required String prettyLevel,
                required String content,
              }) => i1.DictEntrySensesCompanion.insert(
                dictionary: dictionary,
                lemma: lemma,
                lvl: lvl,
                prettyLevel: prettyLevel,
                content: content,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DictEntrySensesProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.DictEntrySenses,
      i1.DictEntrySense,
      i1.$DictEntrySensesFilterComposer,
      i1.$DictEntrySensesOrderingComposer,
      i1.$DictEntrySensesAnnotationComposer,
      $DictEntrySensesCreateCompanionBuilder,
      $DictEntrySensesUpdateCompanionBuilder,
      (
        i1.DictEntrySense,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.DictEntrySenses,
          i1.DictEntrySense
        >,
      ),
      i1.DictEntrySense,
      i0.PrefetchHooks Function()
    >;
typedef $DictEntrySenseQuotesCreateCompanionBuilder =
    i1.DictEntrySenseQuotesCompanion Function({
      required String dictionary,
      required String lemma,
      required String lvl,
      required int seq,
      required String content,
      i0.Value<String?> translation,
    });
typedef $DictEntrySenseQuotesUpdateCompanionBuilder =
    i1.DictEntrySenseQuotesCompanion Function({
      i0.Value<String> dictionary,
      i0.Value<String> lemma,
      i0.Value<String> lvl,
      i0.Value<int> seq,
      i0.Value<String> content,
      i0.Value<String?> translation,
    });

class $DictEntrySenseQuotesFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictEntrySenseQuotes> {
  $DictEntrySenseQuotesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get lvl => $composableBuilder(
    column: $table.lvl,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $DictEntrySenseQuotesOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictEntrySenseQuotes> {
  $DictEntrySenseQuotesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get lvl => $composableBuilder(
    column: $table.lvl,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $DictEntrySenseQuotesAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DictEntrySenseQuotes> {
  $DictEntrySenseQuotesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get dictionary => $composableBuilder(
    column: $table.dictionary,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get lemma =>
      $composableBuilder(column: $table.lemma, builder: (column) => column);

  i0.GeneratedColumn<String> get lvl =>
      $composableBuilder(column: $table.lvl, builder: (column) => column);

  i0.GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  i0.GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  i0.GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );
}

class $DictEntrySenseQuotesTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.DictEntrySenseQuotes,
          i1.DictEntrySenseQuote,
          i1.$DictEntrySenseQuotesFilterComposer,
          i1.$DictEntrySenseQuotesOrderingComposer,
          i1.$DictEntrySenseQuotesAnnotationComposer,
          $DictEntrySenseQuotesCreateCompanionBuilder,
          $DictEntrySenseQuotesUpdateCompanionBuilder,
          (
            i1.DictEntrySenseQuote,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.DictEntrySenseQuotes,
              i1.DictEntrySenseQuote
            >,
          ),
          i1.DictEntrySenseQuote,
          i0.PrefetchHooks Function()
        > {
  $DictEntrySenseQuotesTableManager(
    i0.GeneratedDatabase db,
    i1.DictEntrySenseQuotes table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$DictEntrySenseQuotesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$DictEntrySenseQuotesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => i1
              .$DictEntrySenseQuotesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> dictionary = const i0.Value.absent(),
                i0.Value<String> lemma = const i0.Value.absent(),
                i0.Value<String> lvl = const i0.Value.absent(),
                i0.Value<int> seq = const i0.Value.absent(),
                i0.Value<String> content = const i0.Value.absent(),
                i0.Value<String?> translation = const i0.Value.absent(),
              }) => i1.DictEntrySenseQuotesCompanion(
                dictionary: dictionary,
                lemma: lemma,
                lvl: lvl,
                seq: seq,
                content: content,
                translation: translation,
              ),
          createCompanionCallback:
              ({
                required String dictionary,
                required String lemma,
                required String lvl,
                required int seq,
                required String content,
                i0.Value<String?> translation = const i0.Value.absent(),
              }) => i1.DictEntrySenseQuotesCompanion.insert(
                dictionary: dictionary,
                lemma: lemma,
                lvl: lvl,
                seq: seq,
                content: content,
                translation: translation,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $DictEntrySenseQuotesProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.DictEntrySenseQuotes,
      i1.DictEntrySenseQuote,
      i1.$DictEntrySenseQuotesFilterComposer,
      i1.$DictEntrySenseQuotesOrderingComposer,
      i1.$DictEntrySenseQuotesAnnotationComposer,
      $DictEntrySenseQuotesCreateCompanionBuilder,
      $DictEntrySenseQuotesUpdateCompanionBuilder,
      (
        i1.DictEntrySenseQuote,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.DictEntrySenseQuotes,
          i1.DictEntrySenseQuote
        >,
      ),
      i1.DictEntrySenseQuote,
      i0.PrefetchHooks Function()
    >;

class Dictionaries extends i0.Table
    with i0.TableInfo<Dictionaries, i1.Dictionary> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Dictionaries(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (id LIKE \'________-____-____-____-____________\')',
  );
  static const i0.VerificationMeta _nameMeta = const i0.VerificationMeta(
    'name',
  );
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _languageMeta = const i0.VerificationMeta(
    'language',
  );
  late final i0.GeneratedColumn<String> language = i0.GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _publisherMeta = const i0.VerificationMeta(
    'publisher',
  );
  late final i0.GeneratedColumn<String> publisher = i0.GeneratedColumn<String>(
    'publisher',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _publicationDateMeta =
      const i0.VerificationMeta('publicationDate');
  late final i0.GeneratedColumn<String> publicationDate =
      i0.GeneratedColumn<String>(
        'publicationDate',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    name,
    language,
    publisher,
    publicationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Dictionaries';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.Dictionary> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    } else if (isInserting) {
      context.missing(_publisherMeta);
    }
    if (data.containsKey('publicationDate')) {
      context.handle(
        _publicationDateMeta,
        publicationDate.isAcceptableOrUnknown(
          data['publicationDate']!,
          _publicationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publicationDateMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Dictionary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Dictionary(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      language: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      publisher: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      )!,
      publicationDate: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}publicationDate'],
      )!,
    );
  }

  @override
  Dictionaries createAlias(String alias) {
    return Dictionaries(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class Dictionary extends i0.DataClass implements i0.Insertable<i1.Dictionary> {
  final String id;
  final String name;
  final String language;
  final String publisher;
  final String publicationDate;
  const Dictionary({
    required this.id,
    required this.name,
    required this.language,
    required this.publisher,
    required this.publicationDate,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['name'] = i0.Variable<String>(name);
    map['language'] = i0.Variable<String>(language);
    map['publisher'] = i0.Variable<String>(publisher);
    map['publicationDate'] = i0.Variable<String>(publicationDate);
    return map;
  }

  i1.DictionariesCompanion toCompanion(bool nullToAbsent) {
    return i1.DictionariesCompanion(
      id: i0.Value(id),
      name: i0.Value(name),
      language: i0.Value(language),
      publisher: i0.Value(publisher),
      publicationDate: i0.Value(publicationDate),
    );
  }

  factory Dictionary.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Dictionary(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      language: serializer.fromJson<String>(json['language']),
      publisher: serializer.fromJson<String>(json['publisher']),
      publicationDate: serializer.fromJson<String>(json['publicationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'language': serializer.toJson<String>(language),
      'publisher': serializer.toJson<String>(publisher),
      'publicationDate': serializer.toJson<String>(publicationDate),
    };
  }

  i1.Dictionary copyWith({
    String? id,
    String? name,
    String? language,
    String? publisher,
    String? publicationDate,
  }) => i1.Dictionary(
    id: id ?? this.id,
    name: name ?? this.name,
    language: language ?? this.language,
    publisher: publisher ?? this.publisher,
    publicationDate: publicationDate ?? this.publicationDate,
  );
  Dictionary copyWithCompanion(i1.DictionariesCompanion data) {
    return Dictionary(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      language: data.language.present ? data.language.value : this.language,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      publicationDate: data.publicationDate.present
          ? data.publicationDate.value
          : this.publicationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dictionary(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('language: $language, ')
          ..write('publisher: $publisher, ')
          ..write('publicationDate: $publicationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, language, publisher, publicationDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Dictionary &&
          other.id == this.id &&
          other.name == this.name &&
          other.language == this.language &&
          other.publisher == this.publisher &&
          other.publicationDate == this.publicationDate);
}

class DictionariesCompanion extends i0.UpdateCompanion<i1.Dictionary> {
  final i0.Value<String> id;
  final i0.Value<String> name;
  final i0.Value<String> language;
  final i0.Value<String> publisher;
  final i0.Value<String> publicationDate;
  const DictionariesCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.language = const i0.Value.absent(),
    this.publisher = const i0.Value.absent(),
    this.publicationDate = const i0.Value.absent(),
  });
  DictionariesCompanion.insert({
    required String id,
    required String name,
    required String language,
    required String publisher,
    required String publicationDate,
  }) : id = i0.Value(id),
       name = i0.Value(name),
       language = i0.Value(language),
       publisher = i0.Value(publisher),
       publicationDate = i0.Value(publicationDate);
  static i0.Insertable<i1.Dictionary> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? name,
    i0.Expression<String>? language,
    i0.Expression<String>? publisher,
    i0.Expression<String>? publicationDate,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (language != null) 'language': language,
      if (publisher != null) 'publisher': publisher,
      if (publicationDate != null) 'publicationDate': publicationDate,
    });
  }

  i1.DictionariesCompanion copyWith({
    i0.Value<String>? id,
    i0.Value<String>? name,
    i0.Value<String>? language,
    i0.Value<String>? publisher,
    i0.Value<String>? publicationDate,
  }) {
    return i1.DictionariesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      language: language ?? this.language,
      publisher: publisher ?? this.publisher,
      publicationDate: publicationDate ?? this.publicationDate,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (language.present) {
      map['language'] = i0.Variable<String>(language.value);
    }
    if (publisher.present) {
      map['publisher'] = i0.Variable<String>(publisher.value);
    }
    if (publicationDate.present) {
      map['publicationDate'] = i0.Variable<String>(publicationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionariesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('language: $language, ')
          ..write('publisher: $publisher, ')
          ..write('publicationDate: $publicationDate')
          ..write(')'))
        .toString();
  }
}

class DictionaryEntries extends i0.Table
    with i0.TableInfo<DictionaryEntries, i1.DictionaryEntry> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  DictionaryEntries(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _dictionaryMeta = const i0.VerificationMeta(
    'dictionary',
  );
  late final i0.GeneratedColumn<String> dictionary = i0.GeneratedColumn<String>(
    'dictionary',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _lemmaMeta = const i0.VerificationMeta(
    'lemma',
  );
  late final i0.GeneratedColumn<String> lemma = i0.GeneratedColumn<String>(
    'lemma',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _partOfSpeechMeta =
      const i0.VerificationMeta('partOfSpeech');
  late final i0.GeneratedColumn<String> partOfSpeech =
      i0.GeneratedColumn<String>(
        'partOfSpeech',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  static const i0.VerificationMeta _inflectionMeta = const i0.VerificationMeta(
    'inflection',
  );
  late final i0.GeneratedColumn<String> inflection = i0.GeneratedColumn<String>(
    'inflection',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _idxMeta = const i0.VerificationMeta('idx');
  late final i0.GeneratedColumn<int> idx = i0.GeneratedColumn<int>(
    'idx',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (idx >= 0)',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    dictionary,
    lemma,
    partOfSpeech,
    inflection,
    idx,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'DictionaryEntries';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.DictionaryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dictionary')) {
      context.handle(
        _dictionaryMeta,
        dictionary.isAcceptableOrUnknown(data['dictionary']!, _dictionaryMeta),
      );
    } else if (isInserting) {
      context.missing(_dictionaryMeta);
    }
    if (data.containsKey('lemma')) {
      context.handle(
        _lemmaMeta,
        lemma.isAcceptableOrUnknown(data['lemma']!, _lemmaMeta),
      );
    } else if (isInserting) {
      context.missing(_lemmaMeta);
    }
    if (data.containsKey('partOfSpeech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['partOfSpeech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('inflection')) {
      context.handle(
        _inflectionMeta,
        inflection.isAcceptableOrUnknown(data['inflection']!, _inflectionMeta),
      );
    }
    if (data.containsKey('idx')) {
      context.handle(
        _idxMeta,
        idx.isAcceptableOrUnknown(data['idx']!, _idxMeta),
      );
    } else if (isInserting) {
      context.missing(_idxMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {dictionary, idx};
  @override
  List<Set<i0.GeneratedColumn>> get uniqueKeys => [
    {lemma, dictionary},
  ];
  @override
  i1.DictionaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.DictionaryEntry(
      dictionary: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionary'],
      )!,
      lemma: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lemma'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}partOfSpeech'],
      ),
      inflection: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}inflection'],
      ),
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}idx'],
      )!,
    );
  }

  @override
  DictionaryEntries createAlias(String alias) {
    return DictionaryEntries(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(dictionary, idx)',
    'FOREIGN KEY(dictionary)REFERENCES Dictionaries(id)',
    'UNIQUE(lemma, dictionary)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class DictionaryEntry extends i0.DataClass
    implements i0.Insertable<i1.DictionaryEntry> {
  final String dictionary;
  final String lemma;

  ///not primary key but should still used to join with DictEntrySenses
  final String? partOfSpeech;
  final String? inflection;
  final int idx;
  const DictionaryEntry({
    required this.dictionary,
    required this.lemma,
    this.partOfSpeech,
    this.inflection,
    required this.idx,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['dictionary'] = i0.Variable<String>(dictionary);
    map['lemma'] = i0.Variable<String>(lemma);
    if (!nullToAbsent || partOfSpeech != null) {
      map['partOfSpeech'] = i0.Variable<String>(partOfSpeech);
    }
    if (!nullToAbsent || inflection != null) {
      map['inflection'] = i0.Variable<String>(inflection);
    }
    map['idx'] = i0.Variable<int>(idx);
    return map;
  }

  i1.DictionaryEntriesCompanion toCompanion(bool nullToAbsent) {
    return i1.DictionaryEntriesCompanion(
      dictionary: i0.Value(dictionary),
      lemma: i0.Value(lemma),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(partOfSpeech),
      inflection: inflection == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(inflection),
      idx: i0.Value(idx),
    );
  }

  factory DictionaryEntry.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return DictionaryEntry(
      dictionary: serializer.fromJson<String>(json['dictionary']),
      lemma: serializer.fromJson<String>(json['lemma']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      inflection: serializer.fromJson<String?>(json['inflection']),
      idx: serializer.fromJson<int>(json['idx']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dictionary': serializer.toJson<String>(dictionary),
      'lemma': serializer.toJson<String>(lemma),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'inflection': serializer.toJson<String?>(inflection),
      'idx': serializer.toJson<int>(idx),
    };
  }

  i1.DictionaryEntry copyWith({
    String? dictionary,
    String? lemma,
    i0.Value<String?> partOfSpeech = const i0.Value.absent(),
    i0.Value<String?> inflection = const i0.Value.absent(),
    int? idx,
  }) => i1.DictionaryEntry(
    dictionary: dictionary ?? this.dictionary,
    lemma: lemma ?? this.lemma,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    inflection: inflection.present ? inflection.value : this.inflection,
    idx: idx ?? this.idx,
  );
  DictionaryEntry copyWithCompanion(i1.DictionaryEntriesCompanion data) {
    return DictionaryEntry(
      dictionary: data.dictionary.present
          ? data.dictionary.value
          : this.dictionary,
      lemma: data.lemma.present ? data.lemma.value : this.lemma,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      inflection: data.inflection.present
          ? data.inflection.value
          : this.inflection,
      idx: data.idx.present ? data.idx.value : this.idx,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryEntry(')
          ..write('dictionary: $dictionary, ')
          ..write('lemma: $lemma, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('inflection: $inflection, ')
          ..write('idx: $idx')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(dictionary, lemma, partOfSpeech, inflection, idx);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.DictionaryEntry &&
          other.dictionary == this.dictionary &&
          other.lemma == this.lemma &&
          other.partOfSpeech == this.partOfSpeech &&
          other.inflection == this.inflection &&
          other.idx == this.idx);
}

class DictionaryEntriesCompanion
    extends i0.UpdateCompanion<i1.DictionaryEntry> {
  final i0.Value<String> dictionary;
  final i0.Value<String> lemma;
  final i0.Value<String?> partOfSpeech;
  final i0.Value<String?> inflection;
  final i0.Value<int> idx;
  const DictionaryEntriesCompanion({
    this.dictionary = const i0.Value.absent(),
    this.lemma = const i0.Value.absent(),
    this.partOfSpeech = const i0.Value.absent(),
    this.inflection = const i0.Value.absent(),
    this.idx = const i0.Value.absent(),
  });
  DictionaryEntriesCompanion.insert({
    required String dictionary,
    required String lemma,
    this.partOfSpeech = const i0.Value.absent(),
    this.inflection = const i0.Value.absent(),
    required int idx,
  }) : dictionary = i0.Value(dictionary),
       lemma = i0.Value(lemma),
       idx = i0.Value(idx);
  static i0.Insertable<i1.DictionaryEntry> custom({
    i0.Expression<String>? dictionary,
    i0.Expression<String>? lemma,
    i0.Expression<String>? partOfSpeech,
    i0.Expression<String>? inflection,
    i0.Expression<int>? idx,
  }) {
    return i0.RawValuesInsertable({
      if (dictionary != null) 'dictionary': dictionary,
      if (lemma != null) 'lemma': lemma,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      if (inflection != null) 'inflection': inflection,
      if (idx != null) 'idx': idx,
    });
  }

  i1.DictionaryEntriesCompanion copyWith({
    i0.Value<String>? dictionary,
    i0.Value<String>? lemma,
    i0.Value<String?>? partOfSpeech,
    i0.Value<String?>? inflection,
    i0.Value<int>? idx,
  }) {
    return i1.DictionaryEntriesCompanion(
      dictionary: dictionary ?? this.dictionary,
      lemma: lemma ?? this.lemma,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      inflection: inflection ?? this.inflection,
      idx: idx ?? this.idx,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (dictionary.present) {
      map['dictionary'] = i0.Variable<String>(dictionary.value);
    }
    if (lemma.present) {
      map['lemma'] = i0.Variable<String>(lemma.value);
    }
    if (partOfSpeech.present) {
      map['partOfSpeech'] = i0.Variable<String>(partOfSpeech.value);
    }
    if (inflection.present) {
      map['inflection'] = i0.Variable<String>(inflection.value);
    }
    if (idx.present) {
      map['idx'] = i0.Variable<int>(idx.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryEntriesCompanion(')
          ..write('dictionary: $dictionary, ')
          ..write('lemma: $lemma, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('inflection: $inflection, ')
          ..write('idx: $idx')
          ..write(')'))
        .toString();
  }
}

class DictionaryAlphabets extends i0.Table
    with i0.TableInfo<DictionaryAlphabets, i1.DictionaryAlphabet> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  DictionaryAlphabets(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _dictionaryMeta = const i0.VerificationMeta(
    'dictionary',
  );
  late final i0.GeneratedColumn<String> dictionary = i0.GeneratedColumn<String>(
    'dictionary',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _letterMeta = const i0.VerificationMeta(
    'letter',
  );
  late final i0.GeneratedColumn<String> letter = i0.GeneratedColumn<String>(
    'letter',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _firstEntryIndexMeta =
      const i0.VerificationMeta('firstEntryIndex');
  late final i0.GeneratedColumn<int> firstEntryIndex = i0.GeneratedColumn<int>(
    'firstEntryIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    dictionary,
    letter,
    firstEntryIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'DictionaryAlphabets';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.DictionaryAlphabet> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dictionary')) {
      context.handle(
        _dictionaryMeta,
        dictionary.isAcceptableOrUnknown(data['dictionary']!, _dictionaryMeta),
      );
    } else if (isInserting) {
      context.missing(_dictionaryMeta);
    }
    if (data.containsKey('letter')) {
      context.handle(
        _letterMeta,
        letter.isAcceptableOrUnknown(data['letter']!, _letterMeta),
      );
    } else if (isInserting) {
      context.missing(_letterMeta);
    }
    if (data.containsKey('firstEntryIndex')) {
      context.handle(
        _firstEntryIndexMeta,
        firstEntryIndex.isAcceptableOrUnknown(
          data['firstEntryIndex']!,
          _firstEntryIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstEntryIndexMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {dictionary, letter};
  @override
  List<Set<i0.GeneratedColumn>> get uniqueKeys => [
    {dictionary, firstEntryIndex},
  ];
  @override
  i1.DictionaryAlphabet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.DictionaryAlphabet(
      dictionary: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionary'],
      )!,
      letter: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}letter'],
      )!,
      firstEntryIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}firstEntryIndex'],
      )!,
    );
  }

  @override
  DictionaryAlphabets createAlias(String alias) {
    return DictionaryAlphabets(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(dictionary, letter)',
    'FOREIGN KEY(dictionary, firstEntryIndex)REFERENCES DictionaryEntries(dictionary, idx)',
    'UNIQUE(dictionary, firstEntryIndex)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class DictionaryAlphabet extends i0.DataClass
    implements i0.Insertable<i1.DictionaryAlphabet> {
  final String dictionary;
  final String letter;
  final int firstEntryIndex;
  const DictionaryAlphabet({
    required this.dictionary,
    required this.letter,
    required this.firstEntryIndex,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['dictionary'] = i0.Variable<String>(dictionary);
    map['letter'] = i0.Variable<String>(letter);
    map['firstEntryIndex'] = i0.Variable<int>(firstEntryIndex);
    return map;
  }

  i1.DictionaryAlphabetsCompanion toCompanion(bool nullToAbsent) {
    return i1.DictionaryAlphabetsCompanion(
      dictionary: i0.Value(dictionary),
      letter: i0.Value(letter),
      firstEntryIndex: i0.Value(firstEntryIndex),
    );
  }

  factory DictionaryAlphabet.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return DictionaryAlphabet(
      dictionary: serializer.fromJson<String>(json['dictionary']),
      letter: serializer.fromJson<String>(json['letter']),
      firstEntryIndex: serializer.fromJson<int>(json['firstEntryIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dictionary': serializer.toJson<String>(dictionary),
      'letter': serializer.toJson<String>(letter),
      'firstEntryIndex': serializer.toJson<int>(firstEntryIndex),
    };
  }

  i1.DictionaryAlphabet copyWith({
    String? dictionary,
    String? letter,
    int? firstEntryIndex,
  }) => i1.DictionaryAlphabet(
    dictionary: dictionary ?? this.dictionary,
    letter: letter ?? this.letter,
    firstEntryIndex: firstEntryIndex ?? this.firstEntryIndex,
  );
  DictionaryAlphabet copyWithCompanion(i1.DictionaryAlphabetsCompanion data) {
    return DictionaryAlphabet(
      dictionary: data.dictionary.present
          ? data.dictionary.value
          : this.dictionary,
      letter: data.letter.present ? data.letter.value : this.letter,
      firstEntryIndex: data.firstEntryIndex.present
          ? data.firstEntryIndex.value
          : this.firstEntryIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryAlphabet(')
          ..write('dictionary: $dictionary, ')
          ..write('letter: $letter, ')
          ..write('firstEntryIndex: $firstEntryIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dictionary, letter, firstEntryIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.DictionaryAlphabet &&
          other.dictionary == this.dictionary &&
          other.letter == this.letter &&
          other.firstEntryIndex == this.firstEntryIndex);
}

class DictionaryAlphabetsCompanion
    extends i0.UpdateCompanion<i1.DictionaryAlphabet> {
  final i0.Value<String> dictionary;
  final i0.Value<String> letter;
  final i0.Value<int> firstEntryIndex;
  const DictionaryAlphabetsCompanion({
    this.dictionary = const i0.Value.absent(),
    this.letter = const i0.Value.absent(),
    this.firstEntryIndex = const i0.Value.absent(),
  });
  DictionaryAlphabetsCompanion.insert({
    required String dictionary,
    required String letter,
    required int firstEntryIndex,
  }) : dictionary = i0.Value(dictionary),
       letter = i0.Value(letter),
       firstEntryIndex = i0.Value(firstEntryIndex);
  static i0.Insertable<i1.DictionaryAlphabet> custom({
    i0.Expression<String>? dictionary,
    i0.Expression<String>? letter,
    i0.Expression<int>? firstEntryIndex,
  }) {
    return i0.RawValuesInsertable({
      if (dictionary != null) 'dictionary': dictionary,
      if (letter != null) 'letter': letter,
      if (firstEntryIndex != null) 'firstEntryIndex': firstEntryIndex,
    });
  }

  i1.DictionaryAlphabetsCompanion copyWith({
    i0.Value<String>? dictionary,
    i0.Value<String>? letter,
    i0.Value<int>? firstEntryIndex,
  }) {
    return i1.DictionaryAlphabetsCompanion(
      dictionary: dictionary ?? this.dictionary,
      letter: letter ?? this.letter,
      firstEntryIndex: firstEntryIndex ?? this.firstEntryIndex,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (dictionary.present) {
      map['dictionary'] = i0.Variable<String>(dictionary.value);
    }
    if (letter.present) {
      map['letter'] = i0.Variable<String>(letter.value);
    }
    if (firstEntryIndex.present) {
      map['firstEntryIndex'] = i0.Variable<int>(firstEntryIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryAlphabetsCompanion(')
          ..write('dictionary: $dictionary, ')
          ..write('letter: $letter, ')
          ..write('firstEntryIndex: $firstEntryIndex')
          ..write(')'))
        .toString();
  }
}

class DictEntrySenses extends i0.Table
    with i0.TableInfo<DictEntrySenses, i1.DictEntrySense> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  DictEntrySenses(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _dictionaryMeta = const i0.VerificationMeta(
    'dictionary',
  );
  late final i0.GeneratedColumn<String> dictionary = i0.GeneratedColumn<String>(
    'dictionary',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _lemmaMeta = const i0.VerificationMeta(
    'lemma',
  );
  late final i0.GeneratedColumn<String> lemma = i0.GeneratedColumn<String>(
    'lemma',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _lvlMeta = const i0.VerificationMeta('lvl');
  late final i0.GeneratedColumn<String> lvl = i0.GeneratedColumn<String>(
    'lvl',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (lvl REGEXP \'^\\d{3}(\\.\\d{3})*\$\')',
  );
  static const i0.VerificationMeta _prettyLevelMeta = const i0.VerificationMeta(
    'prettyLevel',
  );
  late final i0.GeneratedColumn<String> prettyLevel =
      i0.GeneratedColumn<String>(
        'prettyLevel',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _contentMeta = const i0.VerificationMeta(
    'content',
  );
  late final i0.GeneratedColumn<String> content = i0.GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    dictionary,
    lemma,
    lvl,
    prettyLevel,
    content,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'DictEntrySenses';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.DictEntrySense> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dictionary')) {
      context.handle(
        _dictionaryMeta,
        dictionary.isAcceptableOrUnknown(data['dictionary']!, _dictionaryMeta),
      );
    } else if (isInserting) {
      context.missing(_dictionaryMeta);
    }
    if (data.containsKey('lemma')) {
      context.handle(
        _lemmaMeta,
        lemma.isAcceptableOrUnknown(data['lemma']!, _lemmaMeta),
      );
    } else if (isInserting) {
      context.missing(_lemmaMeta);
    }
    if (data.containsKey('lvl')) {
      context.handle(
        _lvlMeta,
        lvl.isAcceptableOrUnknown(data['lvl']!, _lvlMeta),
      );
    } else if (isInserting) {
      context.missing(_lvlMeta);
    }
    if (data.containsKey('prettyLevel')) {
      context.handle(
        _prettyLevelMeta,
        prettyLevel.isAcceptableOrUnknown(
          data['prettyLevel']!,
          _prettyLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prettyLevelMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {dictionary, lemma, lvl};
  @override
  i1.DictEntrySense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.DictEntrySense(
      dictionary: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionary'],
      )!,
      lemma: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lemma'],
      )!,
      lvl: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lvl'],
      )!,
      prettyLevel: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}prettyLevel'],
      )!,
      content: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
    );
  }

  @override
  DictEntrySenses createAlias(String alias) {
    return DictEntrySenses(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(dictionary, lemma, lvl)',
    'FOREIGN KEY(lemma, dictionary)REFERENCES DictionaryEntries(lemma, dictionary)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class DictEntrySense extends i0.DataClass
    implements i0.Insertable<i1.DictEntrySense> {
  final String dictionary;
  final String lemma;
  final String lvl;
  final String prettyLevel;
  final String content;
  const DictEntrySense({
    required this.dictionary,
    required this.lemma,
    required this.lvl,
    required this.prettyLevel,
    required this.content,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['dictionary'] = i0.Variable<String>(dictionary);
    map['lemma'] = i0.Variable<String>(lemma);
    map['lvl'] = i0.Variable<String>(lvl);
    map['prettyLevel'] = i0.Variable<String>(prettyLevel);
    map['content'] = i0.Variable<String>(content);
    return map;
  }

  i1.DictEntrySensesCompanion toCompanion(bool nullToAbsent) {
    return i1.DictEntrySensesCompanion(
      dictionary: i0.Value(dictionary),
      lemma: i0.Value(lemma),
      lvl: i0.Value(lvl),
      prettyLevel: i0.Value(prettyLevel),
      content: i0.Value(content),
    );
  }

  factory DictEntrySense.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return DictEntrySense(
      dictionary: serializer.fromJson<String>(json['dictionary']),
      lemma: serializer.fromJson<String>(json['lemma']),
      lvl: serializer.fromJson<String>(json['lvl']),
      prettyLevel: serializer.fromJson<String>(json['prettyLevel']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dictionary': serializer.toJson<String>(dictionary),
      'lemma': serializer.toJson<String>(lemma),
      'lvl': serializer.toJson<String>(lvl),
      'prettyLevel': serializer.toJson<String>(prettyLevel),
      'content': serializer.toJson<String>(content),
    };
  }

  i1.DictEntrySense copyWith({
    String? dictionary,
    String? lemma,
    String? lvl,
    String? prettyLevel,
    String? content,
  }) => i1.DictEntrySense(
    dictionary: dictionary ?? this.dictionary,
    lemma: lemma ?? this.lemma,
    lvl: lvl ?? this.lvl,
    prettyLevel: prettyLevel ?? this.prettyLevel,
    content: content ?? this.content,
  );
  DictEntrySense copyWithCompanion(i1.DictEntrySensesCompanion data) {
    return DictEntrySense(
      dictionary: data.dictionary.present
          ? data.dictionary.value
          : this.dictionary,
      lemma: data.lemma.present ? data.lemma.value : this.lemma,
      lvl: data.lvl.present ? data.lvl.value : this.lvl,
      prettyLevel: data.prettyLevel.present
          ? data.prettyLevel.value
          : this.prettyLevel,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictEntrySense(')
          ..write('dictionary: $dictionary, ')
          ..write('lemma: $lemma, ')
          ..write('lvl: $lvl, ')
          ..write('prettyLevel: $prettyLevel, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dictionary, lemma, lvl, prettyLevel, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.DictEntrySense &&
          other.dictionary == this.dictionary &&
          other.lemma == this.lemma &&
          other.lvl == this.lvl &&
          other.prettyLevel == this.prettyLevel &&
          other.content == this.content);
}

class DictEntrySensesCompanion extends i0.UpdateCompanion<i1.DictEntrySense> {
  final i0.Value<String> dictionary;
  final i0.Value<String> lemma;
  final i0.Value<String> lvl;
  final i0.Value<String> prettyLevel;
  final i0.Value<String> content;
  const DictEntrySensesCompanion({
    this.dictionary = const i0.Value.absent(),
    this.lemma = const i0.Value.absent(),
    this.lvl = const i0.Value.absent(),
    this.prettyLevel = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
  });
  DictEntrySensesCompanion.insert({
    required String dictionary,
    required String lemma,
    required String lvl,
    required String prettyLevel,
    required String content,
  }) : dictionary = i0.Value(dictionary),
       lemma = i0.Value(lemma),
       lvl = i0.Value(lvl),
       prettyLevel = i0.Value(prettyLevel),
       content = i0.Value(content);
  static i0.Insertable<i1.DictEntrySense> custom({
    i0.Expression<String>? dictionary,
    i0.Expression<String>? lemma,
    i0.Expression<String>? lvl,
    i0.Expression<String>? prettyLevel,
    i0.Expression<String>? content,
  }) {
    return i0.RawValuesInsertable({
      if (dictionary != null) 'dictionary': dictionary,
      if (lemma != null) 'lemma': lemma,
      if (lvl != null) 'lvl': lvl,
      if (prettyLevel != null) 'prettyLevel': prettyLevel,
      if (content != null) 'content': content,
    });
  }

  i1.DictEntrySensesCompanion copyWith({
    i0.Value<String>? dictionary,
    i0.Value<String>? lemma,
    i0.Value<String>? lvl,
    i0.Value<String>? prettyLevel,
    i0.Value<String>? content,
  }) {
    return i1.DictEntrySensesCompanion(
      dictionary: dictionary ?? this.dictionary,
      lemma: lemma ?? this.lemma,
      lvl: lvl ?? this.lvl,
      prettyLevel: prettyLevel ?? this.prettyLevel,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (dictionary.present) {
      map['dictionary'] = i0.Variable<String>(dictionary.value);
    }
    if (lemma.present) {
      map['lemma'] = i0.Variable<String>(lemma.value);
    }
    if (lvl.present) {
      map['lvl'] = i0.Variable<String>(lvl.value);
    }
    if (prettyLevel.present) {
      map['prettyLevel'] = i0.Variable<String>(prettyLevel.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictEntrySensesCompanion(')
          ..write('dictionary: $dictionary, ')
          ..write('lemma: $lemma, ')
          ..write('lvl: $lvl, ')
          ..write('prettyLevel: $prettyLevel, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class DictEntrySenseQuotes extends i0.Table
    with i0.TableInfo<DictEntrySenseQuotes, i1.DictEntrySenseQuote> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  DictEntrySenseQuotes(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _dictionaryMeta = const i0.VerificationMeta(
    'dictionary',
  );
  late final i0.GeneratedColumn<String> dictionary = i0.GeneratedColumn<String>(
    'dictionary',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _lemmaMeta = const i0.VerificationMeta(
    'lemma',
  );
  late final i0.GeneratedColumn<String> lemma = i0.GeneratedColumn<String>(
    'lemma',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _lvlMeta = const i0.VerificationMeta('lvl');
  late final i0.GeneratedColumn<String> lvl = i0.GeneratedColumn<String>(
    'lvl',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _seqMeta = const i0.VerificationMeta('seq');
  late final i0.GeneratedColumn<int> seq = i0.GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (seq >= 0)',
  );
  static const i0.VerificationMeta _contentMeta = const i0.VerificationMeta(
    'content',
  );
  late final i0.GeneratedColumn<String> content = i0.GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _translationMeta = const i0.VerificationMeta(
    'translation',
  );
  late final i0.GeneratedColumn<String> translation =
      i0.GeneratedColumn<String>(
        'translation',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: false,
        $customConstraints: '',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    dictionary,
    lemma,
    lvl,
    seq,
    content,
    translation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'DictEntrySenseQuotes';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.DictEntrySenseQuote> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dictionary')) {
      context.handle(
        _dictionaryMeta,
        dictionary.isAcceptableOrUnknown(data['dictionary']!, _dictionaryMeta),
      );
    } else if (isInserting) {
      context.missing(_dictionaryMeta);
    }
    if (data.containsKey('lemma')) {
      context.handle(
        _lemmaMeta,
        lemma.isAcceptableOrUnknown(data['lemma']!, _lemmaMeta),
      );
    } else if (isInserting) {
      context.missing(_lemmaMeta);
    }
    if (data.containsKey('lvl')) {
      context.handle(
        _lvlMeta,
        lvl.isAcceptableOrUnknown(data['lvl']!, _lvlMeta),
      );
    } else if (isInserting) {
      context.missing(_lvlMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {dictionary, lemma, lvl, seq};
  @override
  i1.DictEntrySenseQuote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.DictEntrySenseQuote(
      dictionary: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionary'],
      )!,
      lemma: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lemma'],
      )!,
      lvl: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lvl'],
      )!,
      seq: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}seq'],
      )!,
      content: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
    );
  }

  @override
  DictEntrySenseQuotes createAlias(String alias) {
    return DictEntrySenseQuotes(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(dictionary, lemma, lvl, seq)',
    'FOREIGN KEY(dictionary, lemma, lvl)REFERENCES DictEntrySenses(dictionary, lemma, lvl)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class DictEntrySenseQuote extends i0.DataClass
    implements i0.Insertable<i1.DictEntrySenseQuote> {
  final String dictionary;
  final String lemma;
  final String lvl;
  final int seq;
  final String content;
  final String? translation;
  const DictEntrySenseQuote({
    required this.dictionary,
    required this.lemma,
    required this.lvl,
    required this.seq,
    required this.content,
    this.translation,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['dictionary'] = i0.Variable<String>(dictionary);
    map['lemma'] = i0.Variable<String>(lemma);
    map['lvl'] = i0.Variable<String>(lvl);
    map['seq'] = i0.Variable<int>(seq);
    map['content'] = i0.Variable<String>(content);
    if (!nullToAbsent || translation != null) {
      map['translation'] = i0.Variable<String>(translation);
    }
    return map;
  }

  i1.DictEntrySenseQuotesCompanion toCompanion(bool nullToAbsent) {
    return i1.DictEntrySenseQuotesCompanion(
      dictionary: i0.Value(dictionary),
      lemma: i0.Value(lemma),
      lvl: i0.Value(lvl),
      seq: i0.Value(seq),
      content: i0.Value(content),
      translation: translation == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(translation),
    );
  }

  factory DictEntrySenseQuote.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return DictEntrySenseQuote(
      dictionary: serializer.fromJson<String>(json['dictionary']),
      lemma: serializer.fromJson<String>(json['lemma']),
      lvl: serializer.fromJson<String>(json['lvl']),
      seq: serializer.fromJson<int>(json['seq']),
      content: serializer.fromJson<String>(json['content']),
      translation: serializer.fromJson<String?>(json['translation']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dictionary': serializer.toJson<String>(dictionary),
      'lemma': serializer.toJson<String>(lemma),
      'lvl': serializer.toJson<String>(lvl),
      'seq': serializer.toJson<int>(seq),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String?>(translation),
    };
  }

  i1.DictEntrySenseQuote copyWith({
    String? dictionary,
    String? lemma,
    String? lvl,
    int? seq,
    String? content,
    i0.Value<String?> translation = const i0.Value.absent(),
  }) => i1.DictEntrySenseQuote(
    dictionary: dictionary ?? this.dictionary,
    lemma: lemma ?? this.lemma,
    lvl: lvl ?? this.lvl,
    seq: seq ?? this.seq,
    content: content ?? this.content,
    translation: translation.present ? translation.value : this.translation,
  );
  DictEntrySenseQuote copyWithCompanion(i1.DictEntrySenseQuotesCompanion data) {
    return DictEntrySenseQuote(
      dictionary: data.dictionary.present
          ? data.dictionary.value
          : this.dictionary,
      lemma: data.lemma.present ? data.lemma.value : this.lemma,
      lvl: data.lvl.present ? data.lvl.value : this.lvl,
      seq: data.seq.present ? data.seq.value : this.seq,
      content: data.content.present ? data.content.value : this.content,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictEntrySenseQuote(')
          ..write('dictionary: $dictionary, ')
          ..write('lemma: $lemma, ')
          ..write('lvl: $lvl, ')
          ..write('seq: $seq, ')
          ..write('content: $content, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(dictionary, lemma, lvl, seq, content, translation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.DictEntrySenseQuote &&
          other.dictionary == this.dictionary &&
          other.lemma == this.lemma &&
          other.lvl == this.lvl &&
          other.seq == this.seq &&
          other.content == this.content &&
          other.translation == this.translation);
}

class DictEntrySenseQuotesCompanion
    extends i0.UpdateCompanion<i1.DictEntrySenseQuote> {
  final i0.Value<String> dictionary;
  final i0.Value<String> lemma;
  final i0.Value<String> lvl;
  final i0.Value<int> seq;
  final i0.Value<String> content;
  final i0.Value<String?> translation;
  const DictEntrySenseQuotesCompanion({
    this.dictionary = const i0.Value.absent(),
    this.lemma = const i0.Value.absent(),
    this.lvl = const i0.Value.absent(),
    this.seq = const i0.Value.absent(),
    this.content = const i0.Value.absent(),
    this.translation = const i0.Value.absent(),
  });
  DictEntrySenseQuotesCompanion.insert({
    required String dictionary,
    required String lemma,
    required String lvl,
    required int seq,
    required String content,
    this.translation = const i0.Value.absent(),
  }) : dictionary = i0.Value(dictionary),
       lemma = i0.Value(lemma),
       lvl = i0.Value(lvl),
       seq = i0.Value(seq),
       content = i0.Value(content);
  static i0.Insertable<i1.DictEntrySenseQuote> custom({
    i0.Expression<String>? dictionary,
    i0.Expression<String>? lemma,
    i0.Expression<String>? lvl,
    i0.Expression<int>? seq,
    i0.Expression<String>? content,
    i0.Expression<String>? translation,
  }) {
    return i0.RawValuesInsertable({
      if (dictionary != null) 'dictionary': dictionary,
      if (lemma != null) 'lemma': lemma,
      if (lvl != null) 'lvl': lvl,
      if (seq != null) 'seq': seq,
      if (content != null) 'content': content,
      if (translation != null) 'translation': translation,
    });
  }

  i1.DictEntrySenseQuotesCompanion copyWith({
    i0.Value<String>? dictionary,
    i0.Value<String>? lemma,
    i0.Value<String>? lvl,
    i0.Value<int>? seq,
    i0.Value<String>? content,
    i0.Value<String?>? translation,
  }) {
    return i1.DictEntrySenseQuotesCompanion(
      dictionary: dictionary ?? this.dictionary,
      lemma: lemma ?? this.lemma,
      lvl: lvl ?? this.lvl,
      seq: seq ?? this.seq,
      content: content ?? this.content,
      translation: translation ?? this.translation,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (dictionary.present) {
      map['dictionary'] = i0.Variable<String>(dictionary.value);
    }
    if (lemma.present) {
      map['lemma'] = i0.Variable<String>(lemma.value);
    }
    if (lvl.present) {
      map['lvl'] = i0.Variable<String>(lvl.value);
    }
    if (seq.present) {
      map['seq'] = i0.Variable<int>(seq.value);
    }
    if (content.present) {
      map['content'] = i0.Variable<String>(content.value);
    }
    if (translation.present) {
      map['translation'] = i0.Variable<String>(translation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictEntrySenseQuotesCompanion(')
          ..write('dictionary: $dictionary, ')
          ..write('lemma: $lemma, ')
          ..write('lvl: $lvl, ')
          ..write('seq: $seq, ')
          ..write('content: $content, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }
}

class DictionaryDictionary extends i0.DataClass {
  final String id;
  final String name;
  final String language;
  final String publisher;
  final String publicationDate;
  final int numberOfEntries;
  const DictionaryDictionary({
    required this.id,
    required this.name,
    required this.language,
    required this.publisher,
    required this.publicationDate,
    required this.numberOfEntries,
  });
  factory DictionaryDictionary.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return DictionaryDictionary(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      language: serializer.fromJson<String>(json['language']),
      publisher: serializer.fromJson<String>(json['publisher']),
      publicationDate: serializer.fromJson<String>(json['publicationDate']),
      numberOfEntries: serializer.fromJson<int>(json['numberOfEntries']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'language': serializer.toJson<String>(language),
      'publisher': serializer.toJson<String>(publisher),
      'publicationDate': serializer.toJson<String>(publicationDate),
      'numberOfEntries': serializer.toJson<int>(numberOfEntries),
    };
  }

  i1.DictionaryDictionary copyWith({
    String? id,
    String? name,
    String? language,
    String? publisher,
    String? publicationDate,
    int? numberOfEntries,
  }) => i1.DictionaryDictionary(
    id: id ?? this.id,
    name: name ?? this.name,
    language: language ?? this.language,
    publisher: publisher ?? this.publisher,
    publicationDate: publicationDate ?? this.publicationDate,
    numberOfEntries: numberOfEntries ?? this.numberOfEntries,
  );
  @override
  String toString() {
    return (StringBuffer('DictionaryDictionary(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('language: $language, ')
          ..write('publisher: $publisher, ')
          ..write('publicationDate: $publicationDate, ')
          ..write('numberOfEntries: $numberOfEntries')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    language,
    publisher,
    publicationDate,
    numberOfEntries,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.DictionaryDictionary &&
          other.id == this.id &&
          other.name == this.name &&
          other.language == this.language &&
          other.publisher == this.publisher &&
          other.publicationDate == this.publicationDate &&
          other.numberOfEntries == this.numberOfEntries);
}

class DictionaryDictionaries
    extends i0.ViewInfo<i1.DictionaryDictionaries, i1.DictionaryDictionary>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  DictionaryDictionaries(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    name,
    language,
    publisher,
    publicationDate,
    numberOfEntries,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'dictionary.Dictionaries';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "dictionary.Dictionaries" AS SELECT Dictionaries.*, COALESCE(DictionaryCounts.numberOfEntries, 0) AS numberOfEntries FROM Dictionaries LEFT OUTER JOIN (SELECT dictionary, COUNT(*) AS numberOfEntries FROM DictionaryEntries GROUP BY dictionary) AS DictionaryCounts ON Dictionaries.id = DictionaryCounts.dictionary',
  };
  @override
  DictionaryDictionaries get asDslTable => this;
  @override
  i1.DictionaryDictionary map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.DictionaryDictionary(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      language: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      publisher: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      )!,
      publicationDate: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}publicationDate'],
      )!,
      numberOfEntries: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}numberOfEntries'],
      )!,
    );
  }

  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> language = i0.GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> publisher = i0.GeneratedColumn<String>(
    'publisher',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> publicationDate =
      i0.GeneratedColumn<String>(
        'publicationDate',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
      );
  late final i0.GeneratedColumn<int> numberOfEntries = i0.GeneratedColumn<int>(
    'numberOfEntries',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  @override
  DictionaryDictionaries createAlias(String alias) {
    return DictionaryDictionaries(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {'Dictionaries', 'DictionaryEntries'};
}

class DictionaryDictionaryEntry extends i0.DataClass {
  final String dictionary;
  final String lemma;
  final String? partOfSpeech;
  final String? inflection;
  final int idx;
  final int numberOfSenses;
  const DictionaryDictionaryEntry({
    required this.dictionary,
    required this.lemma,
    this.partOfSpeech,
    this.inflection,
    required this.idx,
    required this.numberOfSenses,
  });
  factory DictionaryDictionaryEntry.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return DictionaryDictionaryEntry(
      dictionary: serializer.fromJson<String>(json['dictionary']),
      lemma: serializer.fromJson<String>(json['lemma']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      inflection: serializer.fromJson<String?>(json['inflection']),
      idx: serializer.fromJson<int>(json['idx']),
      numberOfSenses: serializer.fromJson<int>(json['numberOfSenses']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dictionary': serializer.toJson<String>(dictionary),
      'lemma': serializer.toJson<String>(lemma),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'inflection': serializer.toJson<String?>(inflection),
      'idx': serializer.toJson<int>(idx),
      'numberOfSenses': serializer.toJson<int>(numberOfSenses),
    };
  }

  i1.DictionaryDictionaryEntry copyWith({
    String? dictionary,
    String? lemma,
    i0.Value<String?> partOfSpeech = const i0.Value.absent(),
    i0.Value<String?> inflection = const i0.Value.absent(),
    int? idx,
    int? numberOfSenses,
  }) => i1.DictionaryDictionaryEntry(
    dictionary: dictionary ?? this.dictionary,
    lemma: lemma ?? this.lemma,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    inflection: inflection.present ? inflection.value : this.inflection,
    idx: idx ?? this.idx,
    numberOfSenses: numberOfSenses ?? this.numberOfSenses,
  );
  @override
  String toString() {
    return (StringBuffer('DictionaryDictionaryEntry(')
          ..write('dictionary: $dictionary, ')
          ..write('lemma: $lemma, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('inflection: $inflection, ')
          ..write('idx: $idx, ')
          ..write('numberOfSenses: $numberOfSenses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    dictionary,
    lemma,
    partOfSpeech,
    inflection,
    idx,
    numberOfSenses,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.DictionaryDictionaryEntry &&
          other.dictionary == this.dictionary &&
          other.lemma == this.lemma &&
          other.partOfSpeech == this.partOfSpeech &&
          other.inflection == this.inflection &&
          other.idx == this.idx &&
          other.numberOfSenses == this.numberOfSenses);
}

class DictionaryDictionaryEntries
    extends
        i0.ViewInfo<
          i1.DictionaryDictionaryEntries,
          i1.DictionaryDictionaryEntry
        >
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  DictionaryDictionaryEntries(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    dictionary,
    lemma,
    partOfSpeech,
    inflection,
    idx,
    numberOfSenses,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'dictionary.DictionaryEntries';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "dictionary.DictionaryEntries" AS SELECT DictionaryEntries.*, COALESCE(SenseCounts.numberOfSenses, 0) AS numberOfSenses FROM DictionaryEntries LEFT OUTER JOIN (SELECT dictionary, lemma, COUNT(*) AS numberOfSenses FROM DictEntrySenses WHERE lvl BETWEEN \'000\' AND \'999\' GROUP BY dictionary, lemma) AS SenseCounts ON DictionaryEntries.dictionary = SenseCounts.dictionary AND DictionaryEntries.lemma = SenseCounts.lemma ORDER BY DictionaryEntries.dictionary, DictionaryEntries.idx',
  };
  @override
  DictionaryDictionaryEntries get asDslTable => this;
  @override
  i1.DictionaryDictionaryEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.DictionaryDictionaryEntry(
      dictionary: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionary'],
      )!,
      lemma: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lemma'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}partOfSpeech'],
      ),
      inflection: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}inflection'],
      ),
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}idx'],
      )!,
      numberOfSenses: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}numberOfSenses'],
      )!,
    );
  }

  late final i0.GeneratedColumn<String> dictionary = i0.GeneratedColumn<String>(
    'dictionary',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> lemma = i0.GeneratedColumn<String>(
    'lemma',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> partOfSpeech =
      i0.GeneratedColumn<String>(
        'partOfSpeech',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
      );
  late final i0.GeneratedColumn<String> inflection = i0.GeneratedColumn<String>(
    'inflection',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> idx = i0.GeneratedColumn<int>(
    'idx',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<int> numberOfSenses = i0.GeneratedColumn<int>(
    'numberOfSenses',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  @override
  DictionaryDictionaryEntries createAlias(String alias) {
    return DictionaryDictionaryEntries(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {'DictionaryEntries', 'DictEntrySenses'};
}

class DictionaryDrift extends i2.ModularAccessor {
  DictionaryDrift(i0.GeneratedDatabase db) : super(db);
  Future<int> fillDictionaryAlphabets() {
    return customInsert(
      'INSERT INTO DictionaryAlphabets SELECT dictionary, UPPER(SUBSTR(lemma, 1, 1)), MIN(idx) FROM DictionaryEntries GROUP BY dictionary, UPPER(SUBSTR(lemma, 1, 1))',
      variables: [],
      updates: {dictionaryAlphabets},
    );
  }

  i0.Selectable<i3.Dictionary> getDictionaries() {
    return customSelect(
      'SELECT id, name, language, publisher, CAST(publicationDate AS TEXT) AS publicationDate, numberOfEntries FROM "dictionary.Dictionaries"',
      variables: [],
      readsFrom: {dictionaries, dictionaryEntries},
    ).map(
      (i0.QueryRow row) => i3.Dictionary(
        id: row.read<String>('id'),
        name: row.read<String>('name'),
        language: row.read<String>('language'),
        publisher: row.read<String>('publisher'),
        publicationDate: row.read<DateTime>('publicationDate'),
        numberOfEntries: row.read<int>('numberOfEntries'),
      ),
    );
  }

  i0.Selectable<i4.Entry> getDictionaryEntries(String var1) {
    return customSelect(
      'SELECT * FROM "dictionary.DictionaryEntries" WHERE dictionary = ?1',
      variables: [i0.Variable<String>(var1)],
      readsFrom: {dictionaryEntries, dictEntrySenses},
    ).map(
      (i0.QueryRow row) => i4.Entry(
        dictionary: row.read<String>('dictionary'),
        lemma: row.read<String>('lemma'),
        inflection: row.readNullable<String>('inflection'),
        partOfSpeech: row.readNullable<String>('partOfSpeech'),
        numberOfSenses: row.read<int>('numberOfSenses'),
      ),
    );
  }

  i0.Selectable<int> getDictionaryAlphabetLetterPosition(
    String var1,
    String var2,
  ) {
    return customSelect(
      'SELECT firstEntryIndex FROM DictionaryAlphabets WHERE dictionary = ?1 AND letter = ?2 LIMIT 1',
      variables: [i0.Variable<String>(var1), i0.Variable<String>(var2)],
      readsFrom: {dictionaryAlphabets},
    ).map((i0.QueryRow row) => row.read<int>('firstEntryIndex'));
  }

  i0.Selectable<i5.EntrySense> getDictionaryEntrySenses(
    String var1,
    String var2,
  ) {
    return customSelect(
      'SELECT prettyLevel, content, Senses.dictionary AS "\$n_0", Senses.lemma AS "\$n_1", Senses.lvl AS "\$n_2" FROM DictEntrySenses AS Senses WHERE dictionary = ?1 AND lemma = ?2 ORDER BY dictionary, lemma, lvl',
      variables: [i0.Variable<String>(var1), i0.Variable<String>(var2)],
      readsFrom: {dictEntrySenses, dictEntrySenseQuotes},
    ).asyncMap(
      (i0.QueryRow row) async => i5.EntrySense(
        prettyLevel: row.read<String>('prettyLevel'),
        content: row.read<String>('content'),
        quotes:
            await customSelect(
                  'SELECT seq, content, translation FROM DictEntrySenseQuotes WHERE dictionary = ?1 AND lemma = ?2 AND lvl = ?3 ORDER BY dictionary, lemma, lvl, seq',
                  variables: [
                    i0.Variable<String>(row.read('\$n_0')),
                    i0.Variable<String>(row.read('\$n_1')),
                    i0.Variable<String>(row.read('\$n_2')),
                  ],
                  readsFrom: {dictEntrySenseQuotes, dictEntrySenses},
                )
                .map(
                  (i0.QueryRow row) => i5.EntrySenseQuote(
                    seq: row.read<int>('seq'),
                    content: row.read<String>('content'),
                    translation: row.readNullable<String>('translation'),
                  ),
                )
                .get(),
      ),
    );
  }

  i1.DictionaryAlphabets get dictionaryAlphabets => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.DictionaryAlphabets>('DictionaryAlphabets');
  i1.DictionaryEntries get dictionaryEntries => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.DictionaryEntries>('DictionaryEntries');
  i1.DictionaryDictionaries get dictionaryDictionaries =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.DictionaryDictionaries>('dictionary.Dictionaries');
  i1.Dictionaries get dictionaries => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.Dictionaries>('Dictionaries');
  i1.DictionaryDictionaryEntries get dictionaryDictionaryEntries =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.DictionaryDictionaryEntries>(
        'dictionary.DictionaryEntries',
      );
  i1.DictEntrySenses get dictEntrySenses => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.DictEntrySenses>('DictEntrySenses');
  i1.DictEntrySenseQuotes get dictEntrySenseQuotes => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.DictEntrySenseQuotes>('DictEntrySenseQuotes');
}
