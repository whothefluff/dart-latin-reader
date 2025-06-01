// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/morph_analysis/morph_analysis.drift.dart'
    as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:latin_reader/src/component/morph_analysis/morphological_search_api.dart'
    as i3;
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart'
    as i4;

typedef $MorphologicalDetailsCreateCompanionBuilder
    = i1.MorphologicalDetailsCompanion Function({
  required String form,
  required int item,
  required String dictionaryRef,
});
typedef $MorphologicalDetailsUpdateCompanionBuilder
    = i1.MorphologicalDetailsCompanion Function({
  i0.Value<String> form,
  i0.Value<int> item,
  i0.Value<String> dictionaryRef,
});

class $MorphologicalDetailsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.MorphologicalDetails> {
  $MorphologicalDetailsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get item => $composableBuilder(
      column: $table.item, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get dictionaryRef => $composableBuilder(
      column: $table.dictionaryRef,
      builder: (column) => i0.ColumnFilters(column));
}

class $MorphologicalDetailsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.MorphologicalDetails> {
  $MorphologicalDetailsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get item => $composableBuilder(
      column: $table.item, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get dictionaryRef => $composableBuilder(
      column: $table.dictionaryRef,
      builder: (column) => i0.ColumnOrderings(column));
}

class $MorphologicalDetailsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.MorphologicalDetails> {
  $MorphologicalDetailsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  i0.GeneratedColumn<int> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);

  i0.GeneratedColumn<String> get dictionaryRef => $composableBuilder(
      column: $table.dictionaryRef, builder: (column) => column);
}

class $MorphologicalDetailsTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.MorphologicalDetails,
    i1.MorphologicalDetail,
    i1.$MorphologicalDetailsFilterComposer,
    i1.$MorphologicalDetailsOrderingComposer,
    i1.$MorphologicalDetailsAnnotationComposer,
    $MorphologicalDetailsCreateCompanionBuilder,
    $MorphologicalDetailsUpdateCompanionBuilder,
    (
      i1.MorphologicalDetail,
      i0.BaseReferences<i0.GeneratedDatabase, i1.MorphologicalDetails,
          i1.MorphologicalDetail>
    ),
    i1.MorphologicalDetail,
    i0.PrefetchHooks Function()> {
  $MorphologicalDetailsTableManager(
      i0.GeneratedDatabase db, i1.MorphologicalDetails table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$MorphologicalDetailsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$MorphologicalDetailsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => i1
              .$MorphologicalDetailsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> form = const i0.Value.absent(),
            i0.Value<int> item = const i0.Value.absent(),
            i0.Value<String> dictionaryRef = const i0.Value.absent(),
          }) =>
              i1.MorphologicalDetailsCompanion(
            form: form,
            item: item,
            dictionaryRef: dictionaryRef,
          ),
          createCompanionCallback: ({
            required String form,
            required int item,
            required String dictionaryRef,
          }) =>
              i1.MorphologicalDetailsCompanion.insert(
            form: form,
            item: item,
            dictionaryRef: dictionaryRef,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $MorphologicalDetailsProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.MorphologicalDetails,
    i1.MorphologicalDetail,
    i1.$MorphologicalDetailsFilterComposer,
    i1.$MorphologicalDetailsOrderingComposer,
    i1.$MorphologicalDetailsAnnotationComposer,
    $MorphologicalDetailsCreateCompanionBuilder,
    $MorphologicalDetailsUpdateCompanionBuilder,
    (
      i1.MorphologicalDetail,
      i0.BaseReferences<i0.GeneratedDatabase, i1.MorphologicalDetails,
          i1.MorphologicalDetail>
    ),
    i1.MorphologicalDetail,
    i0.PrefetchHooks Function()>;
typedef $MorphologicalDetailInflectionsCreateCompanionBuilder
    = i1.MorphologicalDetailInflectionsCompanion Function({
  required String form,
  required int item,
  required int cnt,
  required String partOfSpeech,
  required String stem,
  i0.Value<String?> suffix,
  i0.Value<String?> segmentsInfo,
  i0.Value<String?> gender,
  i0.Value<String?> number,
  i0.Value<String?> declension,
  i0.Value<String?> gramCase,
  i0.Value<String?> verbForm,
  i0.Value<String?> tense,
  i0.Value<String?> voice,
  i0.Value<String?> person,
});
typedef $MorphologicalDetailInflectionsUpdateCompanionBuilder
    = i1.MorphologicalDetailInflectionsCompanion Function({
  i0.Value<String> form,
  i0.Value<int> item,
  i0.Value<int> cnt,
  i0.Value<String> partOfSpeech,
  i0.Value<String> stem,
  i0.Value<String?> suffix,
  i0.Value<String?> segmentsInfo,
  i0.Value<String?> gender,
  i0.Value<String?> number,
  i0.Value<String?> declension,
  i0.Value<String?> gramCase,
  i0.Value<String?> verbForm,
  i0.Value<String?> tense,
  i0.Value<String?> voice,
  i0.Value<String?> person,
});

class $MorphologicalDetailInflectionsFilterComposer extends i0
    .Composer<i0.GeneratedDatabase, i1.MorphologicalDetailInflections> {
  $MorphologicalDetailInflectionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get item => $composableBuilder(
      column: $table.item, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get cnt => $composableBuilder(
      column: $table.cnt, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get stem => $composableBuilder(
      column: $table.stem, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get suffix => $composableBuilder(
      column: $table.suffix, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get segmentsInfo => $composableBuilder(
      column: $table.segmentsInfo,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get declension => $composableBuilder(
      column: $table.declension, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get gramCase => $composableBuilder(
      column: $table.gramCase, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get verbForm => $composableBuilder(
      column: $table.verbForm, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get tense => $composableBuilder(
      column: $table.tense, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get voice => $composableBuilder(
      column: $table.voice, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get person => $composableBuilder(
      column: $table.person, builder: (column) => i0.ColumnFilters(column));
}

class $MorphologicalDetailInflectionsOrderingComposer extends i0
    .Composer<i0.GeneratedDatabase, i1.MorphologicalDetailInflections> {
  $MorphologicalDetailInflectionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get item => $composableBuilder(
      column: $table.item, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get cnt => $composableBuilder(
      column: $table.cnt, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get stem => $composableBuilder(
      column: $table.stem, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get suffix => $composableBuilder(
      column: $table.suffix, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get segmentsInfo => $composableBuilder(
      column: $table.segmentsInfo,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get declension => $composableBuilder(
      column: $table.declension,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get gramCase => $composableBuilder(
      column: $table.gramCase, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get verbForm => $composableBuilder(
      column: $table.verbForm, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get tense => $composableBuilder(
      column: $table.tense, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get voice => $composableBuilder(
      column: $table.voice, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get person => $composableBuilder(
      column: $table.person, builder: (column) => i0.ColumnOrderings(column));
}

class $MorphologicalDetailInflectionsAnnotationComposer extends i0
    .Composer<i0.GeneratedDatabase, i1.MorphologicalDetailInflections> {
  $MorphologicalDetailInflectionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  i0.GeneratedColumn<int> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);

  i0.GeneratedColumn<int> get cnt =>
      $composableBuilder(column: $table.cnt, builder: (column) => column);

  i0.GeneratedColumn<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech, builder: (column) => column);

  i0.GeneratedColumn<String> get stem =>
      $composableBuilder(column: $table.stem, builder: (column) => column);

  i0.GeneratedColumn<String> get suffix =>
      $composableBuilder(column: $table.suffix, builder: (column) => column);

  i0.GeneratedColumn<String> get segmentsInfo => $composableBuilder(
      column: $table.segmentsInfo, builder: (column) => column);

  i0.GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  i0.GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  i0.GeneratedColumn<String> get declension => $composableBuilder(
      column: $table.declension, builder: (column) => column);

  i0.GeneratedColumn<String> get gramCase =>
      $composableBuilder(column: $table.gramCase, builder: (column) => column);

  i0.GeneratedColumn<String> get verbForm =>
      $composableBuilder(column: $table.verbForm, builder: (column) => column);

  i0.GeneratedColumn<String> get tense =>
      $composableBuilder(column: $table.tense, builder: (column) => column);

  i0.GeneratedColumn<String> get voice =>
      $composableBuilder(column: $table.voice, builder: (column) => column);

  i0.GeneratedColumn<String> get person =>
      $composableBuilder(column: $table.person, builder: (column) => column);
}

class $MorphologicalDetailInflectionsTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.MorphologicalDetailInflections,
    i1.MorphologicalDetailInflection,
    i1.$MorphologicalDetailInflectionsFilterComposer,
    i1.$MorphologicalDetailInflectionsOrderingComposer,
    i1.$MorphologicalDetailInflectionsAnnotationComposer,
    $MorphologicalDetailInflectionsCreateCompanionBuilder,
    $MorphologicalDetailInflectionsUpdateCompanionBuilder,
    (
      i1.MorphologicalDetailInflection,
      i0.BaseReferences<i0.GeneratedDatabase, i1.MorphologicalDetailInflections,
          i1.MorphologicalDetailInflection>
    ),
    i1.MorphologicalDetailInflection,
    i0.PrefetchHooks Function()> {
  $MorphologicalDetailInflectionsTableManager(
      i0.GeneratedDatabase db, i1.MorphologicalDetailInflections table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$MorphologicalDetailInflectionsFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              i1.$MorphologicalDetailInflectionsOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$MorphologicalDetailInflectionsAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> form = const i0.Value.absent(),
            i0.Value<int> item = const i0.Value.absent(),
            i0.Value<int> cnt = const i0.Value.absent(),
            i0.Value<String> partOfSpeech = const i0.Value.absent(),
            i0.Value<String> stem = const i0.Value.absent(),
            i0.Value<String?> suffix = const i0.Value.absent(),
            i0.Value<String?> segmentsInfo = const i0.Value.absent(),
            i0.Value<String?> gender = const i0.Value.absent(),
            i0.Value<String?> number = const i0.Value.absent(),
            i0.Value<String?> declension = const i0.Value.absent(),
            i0.Value<String?> gramCase = const i0.Value.absent(),
            i0.Value<String?> verbForm = const i0.Value.absent(),
            i0.Value<String?> tense = const i0.Value.absent(),
            i0.Value<String?> voice = const i0.Value.absent(),
            i0.Value<String?> person = const i0.Value.absent(),
          }) =>
              i1.MorphologicalDetailInflectionsCompanion(
            form: form,
            item: item,
            cnt: cnt,
            partOfSpeech: partOfSpeech,
            stem: stem,
            suffix: suffix,
            segmentsInfo: segmentsInfo,
            gender: gender,
            number: number,
            declension: declension,
            gramCase: gramCase,
            verbForm: verbForm,
            tense: tense,
            voice: voice,
            person: person,
          ),
          createCompanionCallback: ({
            required String form,
            required int item,
            required int cnt,
            required String partOfSpeech,
            required String stem,
            i0.Value<String?> suffix = const i0.Value.absent(),
            i0.Value<String?> segmentsInfo = const i0.Value.absent(),
            i0.Value<String?> gender = const i0.Value.absent(),
            i0.Value<String?> number = const i0.Value.absent(),
            i0.Value<String?> declension = const i0.Value.absent(),
            i0.Value<String?> gramCase = const i0.Value.absent(),
            i0.Value<String?> verbForm = const i0.Value.absent(),
            i0.Value<String?> tense = const i0.Value.absent(),
            i0.Value<String?> voice = const i0.Value.absent(),
            i0.Value<String?> person = const i0.Value.absent(),
          }) =>
              i1.MorphologicalDetailInflectionsCompanion.insert(
            form: form,
            item: item,
            cnt: cnt,
            partOfSpeech: partOfSpeech,
            stem: stem,
            suffix: suffix,
            segmentsInfo: segmentsInfo,
            gender: gender,
            number: number,
            declension: declension,
            gramCase: gramCase,
            verbForm: verbForm,
            tense: tense,
            voice: voice,
            person: person,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $MorphologicalDetailInflectionsProcessedTableManager
    = i0.ProcessedTableManager<
        i0.GeneratedDatabase,
        i1.MorphologicalDetailInflections,
        i1.MorphologicalDetailInflection,
        i1.$MorphologicalDetailInflectionsFilterComposer,
        i1.$MorphologicalDetailInflectionsOrderingComposer,
        i1.$MorphologicalDetailInflectionsAnnotationComposer,
        $MorphologicalDetailInflectionsCreateCompanionBuilder,
        $MorphologicalDetailInflectionsUpdateCompanionBuilder,
        (
          i1.MorphologicalDetailInflection,
          i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.MorphologicalDetailInflections,
              i1.MorphologicalDetailInflection>
        ),
        i1.MorphologicalDetailInflection,
        i0.PrefetchHooks Function()>;
typedef $SearchableMorphDetInflectionsCreateCompanionBuilder
    = i1.SearchableMorphDetInflectionsCompanion Function({
  i0.Value<String?> form,
  i0.Value<String?> macronizedForm,
  i0.Value<String?> item,
  i0.Value<String?> cnt,
  i0.Value<int> rowid,
});
typedef $SearchableMorphDetInflectionsUpdateCompanionBuilder
    = i1.SearchableMorphDetInflectionsCompanion Function({
  i0.Value<String?> form,
  i0.Value<String?> macronizedForm,
  i0.Value<String?> item,
  i0.Value<String?> cnt,
  i0.Value<int> rowid,
});

class $SearchableMorphDetInflectionsFilterComposer extends i0
    .Composer<i0.GeneratedDatabase, i1.SearchableMorphDetInflections> {
  $SearchableMorphDetInflectionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get macronizedForm => $composableBuilder(
      column: $table.macronizedForm,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get item => $composableBuilder(
      column: $table.item, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get cnt => $composableBuilder(
      column: $table.cnt, builder: (column) => i0.ColumnFilters(column));
}

class $SearchableMorphDetInflectionsOrderingComposer extends i0
    .Composer<i0.GeneratedDatabase, i1.SearchableMorphDetInflections> {
  $SearchableMorphDetInflectionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get macronizedForm => $composableBuilder(
      column: $table.macronizedForm,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get item => $composableBuilder(
      column: $table.item, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get cnt => $composableBuilder(
      column: $table.cnt, builder: (column) => i0.ColumnOrderings(column));
}

class $SearchableMorphDetInflectionsAnnotationComposer extends i0
    .Composer<i0.GeneratedDatabase, i1.SearchableMorphDetInflections> {
  $SearchableMorphDetInflectionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  i0.GeneratedColumn<String> get macronizedForm => $composableBuilder(
      column: $table.macronizedForm, builder: (column) => column);

  i0.GeneratedColumn<String> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);

  i0.GeneratedColumn<String> get cnt =>
      $composableBuilder(column: $table.cnt, builder: (column) => column);
}

class $SearchableMorphDetInflectionsTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.SearchableMorphDetInflections,
    i1.SearchableMorphDetInflection,
    i1.$SearchableMorphDetInflectionsFilterComposer,
    i1.$SearchableMorphDetInflectionsOrderingComposer,
    i1.$SearchableMorphDetInflectionsAnnotationComposer,
    $SearchableMorphDetInflectionsCreateCompanionBuilder,
    $SearchableMorphDetInflectionsUpdateCompanionBuilder,
    (
      i1.SearchableMorphDetInflection,
      i0.BaseReferences<i0.GeneratedDatabase, i1.SearchableMorphDetInflections,
          i1.SearchableMorphDetInflection>
    ),
    i1.SearchableMorphDetInflection,
    i0.PrefetchHooks Function()> {
  $SearchableMorphDetInflectionsTableManager(
      i0.GeneratedDatabase db, i1.SearchableMorphDetInflections table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$SearchableMorphDetInflectionsFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              i1.$SearchableMorphDetInflectionsOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$SearchableMorphDetInflectionsAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String?> form = const i0.Value.absent(),
            i0.Value<String?> macronizedForm = const i0.Value.absent(),
            i0.Value<String?> item = const i0.Value.absent(),
            i0.Value<String?> cnt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.SearchableMorphDetInflectionsCompanion(
            form: form,
            macronizedForm: macronizedForm,
            item: item,
            cnt: cnt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            i0.Value<String?> form = const i0.Value.absent(),
            i0.Value<String?> macronizedForm = const i0.Value.absent(),
            i0.Value<String?> item = const i0.Value.absent(),
            i0.Value<String?> cnt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.SearchableMorphDetInflectionsCompanion.insert(
            form: form,
            macronizedForm: macronizedForm,
            item: item,
            cnt: cnt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $SearchableMorphDetInflectionsProcessedTableManager
    = i0.ProcessedTableManager<
        i0.GeneratedDatabase,
        i1.SearchableMorphDetInflections,
        i1.SearchableMorphDetInflection,
        i1.$SearchableMorphDetInflectionsFilterComposer,
        i1.$SearchableMorphDetInflectionsOrderingComposer,
        i1.$SearchableMorphDetInflectionsAnnotationComposer,
        $SearchableMorphDetInflectionsCreateCompanionBuilder,
        $SearchableMorphDetInflectionsUpdateCompanionBuilder,
        (
          i1.SearchableMorphDetInflection,
          i0.BaseReferences<i0.GeneratedDatabase,
              i1.SearchableMorphDetInflections, i1.SearchableMorphDetInflection>
        ),
        i1.SearchableMorphDetInflection,
        i0.PrefetchHooks Function()>;

class MorphologicalDetails extends i0.Table
    with i0.TableInfo<MorphologicalDetails, i1.MorphologicalDetail> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  MorphologicalDetails(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _formMeta =
      const i0.VerificationMeta('form');
  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
      'form', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _itemMeta =
      const i0.VerificationMeta('item');
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
      'item', aliasedName, false,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (item >= 0)');
  static const i0.VerificationMeta _dictionaryRefMeta =
      const i0.VerificationMeta('dictionaryRef');
  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>('dictionaryRef', aliasedName, false,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  @override
  List<i0.GeneratedColumn> get $columns => [form, item, dictionaryRef];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'MorphologicalDetails';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.MorphologicalDetail> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item']!, _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('dictionaryRef')) {
      context.handle(
          _dictionaryRefMeta,
          dictionaryRef.isAcceptableOrUnknown(
              data['dictionaryRef']!, _dictionaryRefMeta));
    } else if (isInserting) {
      context.missing(_dictionaryRefMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {form, item};
  @override
  i1.MorphologicalDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.MorphologicalDetail(
      form: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}form'])!,
      item: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}item'])!,
      dictionaryRef: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}dictionaryRef'])!,
    );
  }

  @override
  MorphologicalDetails createAlias(String alias) {
    return MorphologicalDetails(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const ['PRIMARY KEY(form, item)'];
  @override
  bool get dontWriteConstraints => true;
}

class MorphologicalDetail extends i0.DataClass
    implements i0.Insertable<i1.MorphologicalDetail> {
  final String form;
  final int item;
  final String dictionaryRef;
  const MorphologicalDetail(
      {required this.form, required this.item, required this.dictionaryRef});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['form'] = i0.Variable<String>(form);
    map['item'] = i0.Variable<int>(item);
    map['dictionaryRef'] = i0.Variable<String>(dictionaryRef);
    return map;
  }

  i1.MorphologicalDetailsCompanion toCompanion(bool nullToAbsent) {
    return i1.MorphologicalDetailsCompanion(
      form: i0.Value(form),
      item: i0.Value(item),
      dictionaryRef: i0.Value(dictionaryRef),
    );
  }

  factory MorphologicalDetail.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return MorphologicalDetail(
      form: serializer.fromJson<String>(json['form']),
      item: serializer.fromJson<int>(json['item']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String>(form),
      'item': serializer.toJson<int>(item),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
    };
  }

  i1.MorphologicalDetail copyWith(
          {String? form, int? item, String? dictionaryRef}) =>
      i1.MorphologicalDetail(
        form: form ?? this.form,
        item: item ?? this.item,
        dictionaryRef: dictionaryRef ?? this.dictionaryRef,
      );
  MorphologicalDetail copyWithCompanion(i1.MorphologicalDetailsCompanion data) {
    return MorphologicalDetail(
      form: data.form.present ? data.form.value : this.form,
      item: data.item.present ? data.item.value : this.item,
      dictionaryRef: data.dictionaryRef.present
          ? data.dictionaryRef.value
          : this.dictionaryRef,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MorphologicalDetail(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('dictionaryRef: $dictionaryRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(form, item, dictionaryRef);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.MorphologicalDetail &&
          other.form == this.form &&
          other.item == this.item &&
          other.dictionaryRef == this.dictionaryRef);
}

class MorphologicalDetailsCompanion
    extends i0.UpdateCompanion<i1.MorphologicalDetail> {
  final i0.Value<String> form;
  final i0.Value<int> item;
  final i0.Value<String> dictionaryRef;
  const MorphologicalDetailsCompanion({
    this.form = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
    this.dictionaryRef = const i0.Value.absent(),
  });
  MorphologicalDetailsCompanion.insert({
    required String form,
    required int item,
    required String dictionaryRef,
  })  : form = i0.Value(form),
        item = i0.Value(item),
        dictionaryRef = i0.Value(dictionaryRef);
  static i0.Insertable<i1.MorphologicalDetail> custom({
    i0.Expression<String>? form,
    i0.Expression<int>? item,
    i0.Expression<String>? dictionaryRef,
  }) {
    return i0.RawValuesInsertable({
      if (form != null) 'form': form,
      if (item != null) 'item': item,
      if (dictionaryRef != null) 'dictionaryRef': dictionaryRef,
    });
  }

  i1.MorphologicalDetailsCompanion copyWith(
      {i0.Value<String>? form,
      i0.Value<int>? item,
      i0.Value<String>? dictionaryRef}) {
    return i1.MorphologicalDetailsCompanion(
      form: form ?? this.form,
      item: item ?? this.item,
      dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (form.present) {
      map['form'] = i0.Variable<String>(form.value);
    }
    if (item.present) {
      map['item'] = i0.Variable<int>(item.value);
    }
    if (dictionaryRef.present) {
      map['dictionaryRef'] = i0.Variable<String>(dictionaryRef.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MorphologicalDetailsCompanion(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('dictionaryRef: $dictionaryRef')
          ..write(')'))
        .toString();
  }
}

class MorphologicalDetailInflections extends i0.Table
    with
        i0.TableInfo<MorphologicalDetailInflections,
            i1.MorphologicalDetailInflection> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  MorphologicalDetailInflections(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _formMeta =
      const i0.VerificationMeta('form');
  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
      'form', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _itemMeta =
      const i0.VerificationMeta('item');
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
      'item', aliasedName, false,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _cntMeta = const i0.VerificationMeta('cnt');
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
      'cnt', aliasedName, false,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (cnt >= 0)');
  static const i0.VerificationMeta _partOfSpeechMeta =
      const i0.VerificationMeta('partOfSpeech');
  late final i0.GeneratedColumn<String> partOfSpeech =
      i0.GeneratedColumn<String>('partOfSpeech', aliasedName, false,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _stemMeta =
      const i0.VerificationMeta('stem');
  late final i0.GeneratedColumn<String> stem = i0.GeneratedColumn<String>(
      'stem', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _suffixMeta =
      const i0.VerificationMeta('suffix');
  late final i0.GeneratedColumn<String> suffix = i0.GeneratedColumn<String>(
      'suffix', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _segmentsInfoMeta =
      const i0.VerificationMeta('segmentsInfo');
  late final i0.GeneratedColumn<String> segmentsInfo =
      i0.GeneratedColumn<String>('segmentsInfo', aliasedName, true,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const i0.VerificationMeta _genderMeta =
      const i0.VerificationMeta('gender');
  late final i0.GeneratedColumn<String> gender = i0.GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _numberMeta =
      const i0.VerificationMeta('number');
  late final i0.GeneratedColumn<String> number = i0.GeneratedColumn<String>(
      'number', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _declensionMeta =
      const i0.VerificationMeta('declension');
  late final i0.GeneratedColumn<String> declension = i0.GeneratedColumn<String>(
      'declension', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _gramCaseMeta =
      const i0.VerificationMeta('gramCase');
  late final i0.GeneratedColumn<String> gramCase = i0.GeneratedColumn<String>(
      'gramCase', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _verbFormMeta =
      const i0.VerificationMeta('verbForm');
  late final i0.GeneratedColumn<String> verbForm = i0.GeneratedColumn<String>(
      'verbForm', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _tenseMeta =
      const i0.VerificationMeta('tense');
  late final i0.GeneratedColumn<String> tense = i0.GeneratedColumn<String>(
      'tense', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _voiceMeta =
      const i0.VerificationMeta('voice');
  late final i0.GeneratedColumn<String> voice = i0.GeneratedColumn<String>(
      'voice', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _personMeta =
      const i0.VerificationMeta('person');
  late final i0.GeneratedColumn<String> person = i0.GeneratedColumn<String>(
      'person', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns => [
        form,
        item,
        cnt,
        partOfSpeech,
        stem,
        suffix,
        segmentsInfo,
        gender,
        number,
        declension,
        gramCase,
        verbForm,
        tense,
        voice,
        person
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'MorphologicalDetailInflections';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.MorphologicalDetailInflection> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item']!, _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('cnt')) {
      context.handle(
          _cntMeta, cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta));
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    if (data.containsKey('partOfSpeech')) {
      context.handle(
          _partOfSpeechMeta,
          partOfSpeech.isAcceptableOrUnknown(
              data['partOfSpeech']!, _partOfSpeechMeta));
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('stem')) {
      context.handle(
          _stemMeta, stem.isAcceptableOrUnknown(data['stem']!, _stemMeta));
    } else if (isInserting) {
      context.missing(_stemMeta);
    }
    if (data.containsKey('suffix')) {
      context.handle(_suffixMeta,
          suffix.isAcceptableOrUnknown(data['suffix']!, _suffixMeta));
    }
    if (data.containsKey('segmentsInfo')) {
      context.handle(
          _segmentsInfoMeta,
          segmentsInfo.isAcceptableOrUnknown(
              data['segmentsInfo']!, _segmentsInfoMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    }
    if (data.containsKey('declension')) {
      context.handle(
          _declensionMeta,
          declension.isAcceptableOrUnknown(
              data['declension']!, _declensionMeta));
    }
    if (data.containsKey('gramCase')) {
      context.handle(_gramCaseMeta,
          gramCase.isAcceptableOrUnknown(data['gramCase']!, _gramCaseMeta));
    }
    if (data.containsKey('verbForm')) {
      context.handle(_verbFormMeta,
          verbForm.isAcceptableOrUnknown(data['verbForm']!, _verbFormMeta));
    }
    if (data.containsKey('tense')) {
      context.handle(
          _tenseMeta, tense.isAcceptableOrUnknown(data['tense']!, _tenseMeta));
    }
    if (data.containsKey('voice')) {
      context.handle(
          _voiceMeta, voice.isAcceptableOrUnknown(data['voice']!, _voiceMeta));
    }
    if (data.containsKey('person')) {
      context.handle(_personMeta,
          person.isAcceptableOrUnknown(data['person']!, _personMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {form, item, cnt};
  @override
  i1.MorphologicalDetailInflection map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.MorphologicalDetailInflection(
      form: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}form'])!,
      item: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}item'])!,
      cnt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}cnt'])!,
      partOfSpeech: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}partOfSpeech'])!,
      stem: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}stem'])!,
      suffix: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}suffix']),
      segmentsInfo: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}segmentsInfo']),
      gender: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}gender']),
      number: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}number']),
      declension: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}declension']),
      gramCase: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}gramCase']),
      verbForm: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}verbForm']),
      tense: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}tense']),
      voice: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}voice']),
      person: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}person']),
    );
  }

  @override
  MorphologicalDetailInflections createAlias(String alias) {
    return MorphologicalDetailInflections(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(form, item, cnt)',
        'FOREIGN KEY(form, item)REFERENCES MorphologicalDetails(form, item)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class MorphologicalDetailInflection extends i0.DataClass
    implements i0.Insertable<i1.MorphologicalDetailInflection> {
  final String form;
  final int item;
  final int cnt;
  final String partOfSpeech;
  final String stem;
  final String? suffix;
  final String? segmentsInfo;
  final String? gender;
  final String? number;
  final String? declension;
  final String? gramCase;
  final String? verbForm;
  final String? tense;
  final String? voice;
  final String? person;
  const MorphologicalDetailInflection(
      {required this.form,
      required this.item,
      required this.cnt,
      required this.partOfSpeech,
      required this.stem,
      this.suffix,
      this.segmentsInfo,
      this.gender,
      this.number,
      this.declension,
      this.gramCase,
      this.verbForm,
      this.tense,
      this.voice,
      this.person});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['form'] = i0.Variable<String>(form);
    map['item'] = i0.Variable<int>(item);
    map['cnt'] = i0.Variable<int>(cnt);
    map['partOfSpeech'] = i0.Variable<String>(partOfSpeech);
    map['stem'] = i0.Variable<String>(stem);
    if (!nullToAbsent || suffix != null) {
      map['suffix'] = i0.Variable<String>(suffix);
    }
    if (!nullToAbsent || segmentsInfo != null) {
      map['segmentsInfo'] = i0.Variable<String>(segmentsInfo);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = i0.Variable<String>(gender);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = i0.Variable<String>(number);
    }
    if (!nullToAbsent || declension != null) {
      map['declension'] = i0.Variable<String>(declension);
    }
    if (!nullToAbsent || gramCase != null) {
      map['gramCase'] = i0.Variable<String>(gramCase);
    }
    if (!nullToAbsent || verbForm != null) {
      map['verbForm'] = i0.Variable<String>(verbForm);
    }
    if (!nullToAbsent || tense != null) {
      map['tense'] = i0.Variable<String>(tense);
    }
    if (!nullToAbsent || voice != null) {
      map['voice'] = i0.Variable<String>(voice);
    }
    if (!nullToAbsent || person != null) {
      map['person'] = i0.Variable<String>(person);
    }
    return map;
  }

  i1.MorphologicalDetailInflectionsCompanion toCompanion(bool nullToAbsent) {
    return i1.MorphologicalDetailInflectionsCompanion(
      form: i0.Value(form),
      item: i0.Value(item),
      cnt: i0.Value(cnt),
      partOfSpeech: i0.Value(partOfSpeech),
      stem: i0.Value(stem),
      suffix: suffix == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(suffix),
      segmentsInfo: segmentsInfo == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(segmentsInfo),
      gender: gender == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(gender),
      number: number == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(number),
      declension: declension == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(declension),
      gramCase: gramCase == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(gramCase),
      verbForm: verbForm == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(verbForm),
      tense: tense == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(tense),
      voice: voice == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(voice),
      person: person == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(person),
    );
  }

  factory MorphologicalDetailInflection.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return MorphologicalDetailInflection(
      form: serializer.fromJson<String>(json['form']),
      item: serializer.fromJson<int>(json['item']),
      cnt: serializer.fromJson<int>(json['cnt']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      stem: serializer.fromJson<String>(json['stem']),
      suffix: serializer.fromJson<String?>(json['suffix']),
      segmentsInfo: serializer.fromJson<String?>(json['segmentsInfo']),
      gender: serializer.fromJson<String?>(json['gender']),
      number: serializer.fromJson<String?>(json['number']),
      declension: serializer.fromJson<String?>(json['declension']),
      gramCase: serializer.fromJson<String?>(json['gramCase']),
      verbForm: serializer.fromJson<String?>(json['verbForm']),
      tense: serializer.fromJson<String?>(json['tense']),
      voice: serializer.fromJson<String?>(json['voice']),
      person: serializer.fromJson<String?>(json['person']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String>(form),
      'item': serializer.toJson<int>(item),
      'cnt': serializer.toJson<int>(cnt),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'stem': serializer.toJson<String>(stem),
      'suffix': serializer.toJson<String?>(suffix),
      'segmentsInfo': serializer.toJson<String?>(segmentsInfo),
      'gender': serializer.toJson<String?>(gender),
      'number': serializer.toJson<String?>(number),
      'declension': serializer.toJson<String?>(declension),
      'gramCase': serializer.toJson<String?>(gramCase),
      'verbForm': serializer.toJson<String?>(verbForm),
      'tense': serializer.toJson<String?>(tense),
      'voice': serializer.toJson<String?>(voice),
      'person': serializer.toJson<String?>(person),
    };
  }

  i1.MorphologicalDetailInflection copyWith(
          {String? form,
          int? item,
          int? cnt,
          String? partOfSpeech,
          String? stem,
          i0.Value<String?> suffix = const i0.Value.absent(),
          i0.Value<String?> segmentsInfo = const i0.Value.absent(),
          i0.Value<String?> gender = const i0.Value.absent(),
          i0.Value<String?> number = const i0.Value.absent(),
          i0.Value<String?> declension = const i0.Value.absent(),
          i0.Value<String?> gramCase = const i0.Value.absent(),
          i0.Value<String?> verbForm = const i0.Value.absent(),
          i0.Value<String?> tense = const i0.Value.absent(),
          i0.Value<String?> voice = const i0.Value.absent(),
          i0.Value<String?> person = const i0.Value.absent()}) =>
      i1.MorphologicalDetailInflection(
        form: form ?? this.form,
        item: item ?? this.item,
        cnt: cnt ?? this.cnt,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        stem: stem ?? this.stem,
        suffix: suffix.present ? suffix.value : this.suffix,
        segmentsInfo:
            segmentsInfo.present ? segmentsInfo.value : this.segmentsInfo,
        gender: gender.present ? gender.value : this.gender,
        number: number.present ? number.value : this.number,
        declension: declension.present ? declension.value : this.declension,
        gramCase: gramCase.present ? gramCase.value : this.gramCase,
        verbForm: verbForm.present ? verbForm.value : this.verbForm,
        tense: tense.present ? tense.value : this.tense,
        voice: voice.present ? voice.value : this.voice,
        person: person.present ? person.value : this.person,
      );
  MorphologicalDetailInflection copyWithCompanion(
      i1.MorphologicalDetailInflectionsCompanion data) {
    return MorphologicalDetailInflection(
      form: data.form.present ? data.form.value : this.form,
      item: data.item.present ? data.item.value : this.item,
      cnt: data.cnt.present ? data.cnt.value : this.cnt,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      stem: data.stem.present ? data.stem.value : this.stem,
      suffix: data.suffix.present ? data.suffix.value : this.suffix,
      segmentsInfo: data.segmentsInfo.present
          ? data.segmentsInfo.value
          : this.segmentsInfo,
      gender: data.gender.present ? data.gender.value : this.gender,
      number: data.number.present ? data.number.value : this.number,
      declension:
          data.declension.present ? data.declension.value : this.declension,
      gramCase: data.gramCase.present ? data.gramCase.value : this.gramCase,
      verbForm: data.verbForm.present ? data.verbForm.value : this.verbForm,
      tense: data.tense.present ? data.tense.value : this.tense,
      voice: data.voice.present ? data.voice.value : this.voice,
      person: data.person.present ? data.person.value : this.person,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MorphologicalDetailInflection(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('stem: $stem, ')
          ..write('suffix: $suffix, ')
          ..write('segmentsInfo: $segmentsInfo, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('declension: $declension, ')
          ..write('gramCase: $gramCase, ')
          ..write('verbForm: $verbForm, ')
          ..write('tense: $tense, ')
          ..write('voice: $voice, ')
          ..write('person: $person')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      form,
      item,
      cnt,
      partOfSpeech,
      stem,
      suffix,
      segmentsInfo,
      gender,
      number,
      declension,
      gramCase,
      verbForm,
      tense,
      voice,
      person);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.MorphologicalDetailInflection &&
          other.form == this.form &&
          other.item == this.item &&
          other.cnt == this.cnt &&
          other.partOfSpeech == this.partOfSpeech &&
          other.stem == this.stem &&
          other.suffix == this.suffix &&
          other.segmentsInfo == this.segmentsInfo &&
          other.gender == this.gender &&
          other.number == this.number &&
          other.declension == this.declension &&
          other.gramCase == this.gramCase &&
          other.verbForm == this.verbForm &&
          other.tense == this.tense &&
          other.voice == this.voice &&
          other.person == this.person);
}

class MorphologicalDetailInflectionsCompanion
    extends i0.UpdateCompanion<i1.MorphologicalDetailInflection> {
  final i0.Value<String> form;
  final i0.Value<int> item;
  final i0.Value<int> cnt;
  final i0.Value<String> partOfSpeech;
  final i0.Value<String> stem;
  final i0.Value<String?> suffix;
  final i0.Value<String?> segmentsInfo;
  final i0.Value<String?> gender;
  final i0.Value<String?> number;
  final i0.Value<String?> declension;
  final i0.Value<String?> gramCase;
  final i0.Value<String?> verbForm;
  final i0.Value<String?> tense;
  final i0.Value<String?> voice;
  final i0.Value<String?> person;
  const MorphologicalDetailInflectionsCompanion({
    this.form = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
    this.partOfSpeech = const i0.Value.absent(),
    this.stem = const i0.Value.absent(),
    this.suffix = const i0.Value.absent(),
    this.segmentsInfo = const i0.Value.absent(),
    this.gender = const i0.Value.absent(),
    this.number = const i0.Value.absent(),
    this.declension = const i0.Value.absent(),
    this.gramCase = const i0.Value.absent(),
    this.verbForm = const i0.Value.absent(),
    this.tense = const i0.Value.absent(),
    this.voice = const i0.Value.absent(),
    this.person = const i0.Value.absent(),
  });
  MorphologicalDetailInflectionsCompanion.insert({
    required String form,
    required int item,
    required int cnt,
    required String partOfSpeech,
    required String stem,
    this.suffix = const i0.Value.absent(),
    this.segmentsInfo = const i0.Value.absent(),
    this.gender = const i0.Value.absent(),
    this.number = const i0.Value.absent(),
    this.declension = const i0.Value.absent(),
    this.gramCase = const i0.Value.absent(),
    this.verbForm = const i0.Value.absent(),
    this.tense = const i0.Value.absent(),
    this.voice = const i0.Value.absent(),
    this.person = const i0.Value.absent(),
  })  : form = i0.Value(form),
        item = i0.Value(item),
        cnt = i0.Value(cnt),
        partOfSpeech = i0.Value(partOfSpeech),
        stem = i0.Value(stem);
  static i0.Insertable<i1.MorphologicalDetailInflection> custom({
    i0.Expression<String>? form,
    i0.Expression<int>? item,
    i0.Expression<int>? cnt,
    i0.Expression<String>? partOfSpeech,
    i0.Expression<String>? stem,
    i0.Expression<String>? suffix,
    i0.Expression<String>? segmentsInfo,
    i0.Expression<String>? gender,
    i0.Expression<String>? number,
    i0.Expression<String>? declension,
    i0.Expression<String>? gramCase,
    i0.Expression<String>? verbForm,
    i0.Expression<String>? tense,
    i0.Expression<String>? voice,
    i0.Expression<String>? person,
  }) {
    return i0.RawValuesInsertable({
      if (form != null) 'form': form,
      if (item != null) 'item': item,
      if (cnt != null) 'cnt': cnt,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      if (stem != null) 'stem': stem,
      if (suffix != null) 'suffix': suffix,
      if (segmentsInfo != null) 'segmentsInfo': segmentsInfo,
      if (gender != null) 'gender': gender,
      if (number != null) 'number': number,
      if (declension != null) 'declension': declension,
      if (gramCase != null) 'gramCase': gramCase,
      if (verbForm != null) 'verbForm': verbForm,
      if (tense != null) 'tense': tense,
      if (voice != null) 'voice': voice,
      if (person != null) 'person': person,
    });
  }

  i1.MorphologicalDetailInflectionsCompanion copyWith(
      {i0.Value<String>? form,
      i0.Value<int>? item,
      i0.Value<int>? cnt,
      i0.Value<String>? partOfSpeech,
      i0.Value<String>? stem,
      i0.Value<String?>? suffix,
      i0.Value<String?>? segmentsInfo,
      i0.Value<String?>? gender,
      i0.Value<String?>? number,
      i0.Value<String?>? declension,
      i0.Value<String?>? gramCase,
      i0.Value<String?>? verbForm,
      i0.Value<String?>? tense,
      i0.Value<String?>? voice,
      i0.Value<String?>? person}) {
    return i1.MorphologicalDetailInflectionsCompanion(
      form: form ?? this.form,
      item: item ?? this.item,
      cnt: cnt ?? this.cnt,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      stem: stem ?? this.stem,
      suffix: suffix ?? this.suffix,
      segmentsInfo: segmentsInfo ?? this.segmentsInfo,
      gender: gender ?? this.gender,
      number: number ?? this.number,
      declension: declension ?? this.declension,
      gramCase: gramCase ?? this.gramCase,
      verbForm: verbForm ?? this.verbForm,
      tense: tense ?? this.tense,
      voice: voice ?? this.voice,
      person: person ?? this.person,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (form.present) {
      map['form'] = i0.Variable<String>(form.value);
    }
    if (item.present) {
      map['item'] = i0.Variable<int>(item.value);
    }
    if (cnt.present) {
      map['cnt'] = i0.Variable<int>(cnt.value);
    }
    if (partOfSpeech.present) {
      map['partOfSpeech'] = i0.Variable<String>(partOfSpeech.value);
    }
    if (stem.present) {
      map['stem'] = i0.Variable<String>(stem.value);
    }
    if (suffix.present) {
      map['suffix'] = i0.Variable<String>(suffix.value);
    }
    if (segmentsInfo.present) {
      map['segmentsInfo'] = i0.Variable<String>(segmentsInfo.value);
    }
    if (gender.present) {
      map['gender'] = i0.Variable<String>(gender.value);
    }
    if (number.present) {
      map['number'] = i0.Variable<String>(number.value);
    }
    if (declension.present) {
      map['declension'] = i0.Variable<String>(declension.value);
    }
    if (gramCase.present) {
      map['gramCase'] = i0.Variable<String>(gramCase.value);
    }
    if (verbForm.present) {
      map['verbForm'] = i0.Variable<String>(verbForm.value);
    }
    if (tense.present) {
      map['tense'] = i0.Variable<String>(tense.value);
    }
    if (voice.present) {
      map['voice'] = i0.Variable<String>(voice.value);
    }
    if (person.present) {
      map['person'] = i0.Variable<String>(person.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MorphologicalDetailInflectionsCompanion(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('stem: $stem, ')
          ..write('suffix: $suffix, ')
          ..write('segmentsInfo: $segmentsInfo, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('declension: $declension, ')
          ..write('gramCase: $gramCase, ')
          ..write('verbForm: $verbForm, ')
          ..write('tense: $tense, ')
          ..write('voice: $voice, ')
          ..write('person: $person')
          ..write(')'))
        .toString();
  }
}

class SearchableMorphDetInflections extends i0.Table
    with
        i0.TableInfo<SearchableMorphDetInflections,
            i1.SearchableMorphDetInflection>,
        i0.VirtualTableInfo<SearchableMorphDetInflections,
            i1.SearchableMorphDetInflection> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  SearchableMorphDetInflections(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _formMeta =
      const i0.VerificationMeta('form');
  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
      'form', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _macronizedFormMeta =
      const i0.VerificationMeta('macronizedForm');
  late final i0.GeneratedColumn<String> macronizedForm =
      i0.GeneratedColumn<String>('macronizedForm', aliasedName, true,
          type: i0.DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const i0.VerificationMeta _itemMeta =
      const i0.VerificationMeta('item');
  late final i0.GeneratedColumn<String> item = i0.GeneratedColumn<String>(
      'item', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _cntMeta = const i0.VerificationMeta('cnt');
  late final i0.GeneratedColumn<String> cnt = i0.GeneratedColumn<String>(
      'cnt', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<i0.GeneratedColumn> get $columns => [form, macronizedForm, item, cnt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'SearchableMorphDetInflections';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.SearchableMorphDetInflection> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    }
    if (data.containsKey('macronizedForm')) {
      context.handle(
          _macronizedFormMeta,
          macronizedForm.isAcceptableOrUnknown(
              data['macronizedForm']!, _macronizedFormMeta));
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item']!, _itemMeta));
    }
    if (data.containsKey('cnt')) {
      context.handle(
          _cntMeta, cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => const {};
  @override
  i1.SearchableMorphDetInflection map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.SearchableMorphDetInflection(
      form: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}form']),
      macronizedForm: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}macronizedForm']),
      item: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}item']),
      cnt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}cnt']),
    );
  }

  @override
  SearchableMorphDetInflections createAlias(String alias) {
    return SearchableMorphDetInflections(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs =>
      'fts5(form, macronizedForm, item UNINDEXED, cnt UNINDEXED, tokenize = "trigram remove_diacritics 0 case_sensitive 0")';
}

class SearchableMorphDetInflection extends i0.DataClass
    implements i0.Insertable<i1.SearchableMorphDetInflection> {
  final String? form;
  final String? macronizedForm;
  final String? item;
  final String? cnt;
  const SearchableMorphDetInflection(
      {this.form, this.macronizedForm, this.item, this.cnt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (!nullToAbsent || form != null) {
      map['form'] = i0.Variable<String>(form);
    }
    if (!nullToAbsent || macronizedForm != null) {
      map['macronizedForm'] = i0.Variable<String>(macronizedForm);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = i0.Variable<String>(item);
    }
    if (!nullToAbsent || cnt != null) {
      map['cnt'] = i0.Variable<String>(cnt);
    }
    return map;
  }

  i1.SearchableMorphDetInflectionsCompanion toCompanion(bool nullToAbsent) {
    return i1.SearchableMorphDetInflectionsCompanion(
      form: form == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(form),
      macronizedForm: macronizedForm == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(macronizedForm),
      item: item == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(item),
      cnt:
          cnt == null && nullToAbsent ? const i0.Value.absent() : i0.Value(cnt),
    );
  }

  factory SearchableMorphDetInflection.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return SearchableMorphDetInflection(
      form: serializer.fromJson<String?>(json['form']),
      macronizedForm: serializer.fromJson<String?>(json['macronizedForm']),
      item: serializer.fromJson<String?>(json['item']),
      cnt: serializer.fromJson<String?>(json['cnt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String?>(form),
      'macronizedForm': serializer.toJson<String?>(macronizedForm),
      'item': serializer.toJson<String?>(item),
      'cnt': serializer.toJson<String?>(cnt),
    };
  }

  i1.SearchableMorphDetInflection copyWith(
          {i0.Value<String?> form = const i0.Value.absent(),
          i0.Value<String?> macronizedForm = const i0.Value.absent(),
          i0.Value<String?> item = const i0.Value.absent(),
          i0.Value<String?> cnt = const i0.Value.absent()}) =>
      i1.SearchableMorphDetInflection(
        form: form.present ? form.value : this.form,
        macronizedForm:
            macronizedForm.present ? macronizedForm.value : this.macronizedForm,
        item: item.present ? item.value : this.item,
        cnt: cnt.present ? cnt.value : this.cnt,
      );
  SearchableMorphDetInflection copyWithCompanion(
      i1.SearchableMorphDetInflectionsCompanion data) {
    return SearchableMorphDetInflection(
      form: data.form.present ? data.form.value : this.form,
      macronizedForm: data.macronizedForm.present
          ? data.macronizedForm.value
          : this.macronizedForm,
      item: data.item.present ? data.item.value : this.item,
      cnt: data.cnt.present ? data.cnt.value : this.cnt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchableMorphDetInflection(')
          ..write('form: $form, ')
          ..write('macronizedForm: $macronizedForm, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(form, macronizedForm, item, cnt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.SearchableMorphDetInflection &&
          other.form == this.form &&
          other.macronizedForm == this.macronizedForm &&
          other.item == this.item &&
          other.cnt == this.cnt);
}

class SearchableMorphDetInflectionsCompanion
    extends i0.UpdateCompanion<i1.SearchableMorphDetInflection> {
  final i0.Value<String?> form;
  final i0.Value<String?> macronizedForm;
  final i0.Value<String?> item;
  final i0.Value<String?> cnt;
  final i0.Value<int> rowid;
  const SearchableMorphDetInflectionsCompanion({
    this.form = const i0.Value.absent(),
    this.macronizedForm = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  SearchableMorphDetInflectionsCompanion.insert({
    this.form = const i0.Value.absent(),
    this.macronizedForm = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  static i0.Insertable<i1.SearchableMorphDetInflection> custom({
    i0.Expression<String>? form,
    i0.Expression<String>? macronizedForm,
    i0.Expression<String>? item,
    i0.Expression<String>? cnt,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (form != null) 'form': form,
      if (macronizedForm != null) 'macronizedForm': macronizedForm,
      if (item != null) 'item': item,
      if (cnt != null) 'cnt': cnt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.SearchableMorphDetInflectionsCompanion copyWith(
      {i0.Value<String?>? form,
      i0.Value<String?>? macronizedForm,
      i0.Value<String?>? item,
      i0.Value<String?>? cnt,
      i0.Value<int>? rowid}) {
    return i1.SearchableMorphDetInflectionsCompanion(
      form: form ?? this.form,
      macronizedForm: macronizedForm ?? this.macronizedForm,
      item: item ?? this.item,
      cnt: cnt ?? this.cnt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (form.present) {
      map['form'] = i0.Variable<String>(form.value);
    }
    if (macronizedForm.present) {
      map['macronizedForm'] = i0.Variable<String>(macronizedForm.value);
    }
    if (item.present) {
      map['item'] = i0.Variable<String>(item.value);
    }
    if (cnt.present) {
      map['cnt'] = i0.Variable<String>(cnt.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchableMorphDetInflectionsCompanion(')
          ..write('form: $form, ')
          ..write('macronizedForm: $macronizedForm, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class MorphologyPeekData extends i0.DataClass {
  final String form;
  final String? partOfSpeech;
  final String dictionaryRef;
  final String? additional;
  final int item;
  final int cnt;
  const MorphologyPeekData(
      {required this.form,
      this.partOfSpeech,
      required this.dictionaryRef,
      this.additional,
      required this.item,
      required this.cnt});
  factory MorphologyPeekData.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return MorphologyPeekData(
      form: serializer.fromJson<String>(json['form']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      additional: serializer.fromJson<String?>(json['additional']),
      item: serializer.fromJson<int>(json['item']),
      cnt: serializer.fromJson<int>(json['cnt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String>(form),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'additional': serializer.toJson<String?>(additional),
      'item': serializer.toJson<int>(item),
      'cnt': serializer.toJson<int>(cnt),
    };
  }

  i1.MorphologyPeekData copyWith(
          {String? form,
          i0.Value<String?> partOfSpeech = const i0.Value.absent(),
          String? dictionaryRef,
          i0.Value<String?> additional = const i0.Value.absent(),
          int? item,
          int? cnt}) =>
      i1.MorphologyPeekData(
        form: form ?? this.form,
        partOfSpeech:
            partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
        dictionaryRef: dictionaryRef ?? this.dictionaryRef,
        additional: additional.present ? additional.value : this.additional,
        item: item ?? this.item,
        cnt: cnt ?? this.cnt,
      );
  @override
  String toString() {
    return (StringBuffer('MorphologyPeekData(')
          ..write('form: $form, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('additional: $additional, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(form, partOfSpeech, dictionaryRef, additional, item, cnt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.MorphologyPeekData &&
          other.form == this.form &&
          other.partOfSpeech == this.partOfSpeech &&
          other.dictionaryRef == this.dictionaryRef &&
          other.additional == this.additional &&
          other.item == this.item &&
          other.cnt == this.cnt);
}

class MorphologyPeek
    extends i0.ViewInfo<i1.MorphologyPeek, i1.MorphologyPeekData>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  MorphologyPeek(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns =>
      [form, partOfSpeech, dictionaryRef, additional, item, cnt];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'morphology.Peek';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
        i0.SqlDialect.sqlite:
            'CREATE VIEW "morphology.Peek" AS WITH InflectionData AS (SELECT Infl.form, IIF(Infl.verbForm IS NULL, Infl.partOfSpeech, NULL) AS partOfSpeech, MorphologicalDetails.dictionaryRef, COALESCE(IIF(Infl.verbForm IS NULL AND Infl.segmentsInfo IN (\'irregular\', \'indeclinable\'), Infl.segmentsInfo, NULL), Infl.verbForm) AS additional, Infl.item, Infl.cnt FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item WHERE Infl.partOfSpeech = \'adjective\' UNION ALL SELECT Infl.form, Infl.partOfSpeech, MorphologicalDetails.dictionaryRef, IIF(Infl.suffix IS NOT NULL, \'-\' || Infl.suffix || \' suffix\', NULL) AS additional, Infl.item, Infl.cnt FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item WHERE Infl.partOfSpeech = \'adverb\' UNION ALL SELECT Infl.form, Infl.partOfSpeech, MorphologicalDetails.dictionaryRef, NULL AS additional, Infl.item, Infl.cnt FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item WHERE Infl.partOfSpeech = \'conjunction\' UNION ALL SELECT Infl.form, Infl.partOfSpeech, MorphologicalDetails.dictionaryRef, NULL AS additional, Infl.item, Infl.cnt FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item WHERE Infl.partOfSpeech = \'interjection\' UNION ALL SELECT Infl.form, IIF(Infl.verbForm IS NULL, Infl.partOfSpeech, NULL) AS partOfSpeech, MorphologicalDetails.dictionaryRef, COALESCE(Infl.verbForm, Infl.declension || \' declension\') AS additional, Infl.item, Infl.cnt FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item WHERE Infl.partOfSpeech = \'noun\' UNION ALL SELECT Infl.form, Infl.partOfSpeech, MorphologicalDetails.dictionaryRef, NULL AS additional, Infl.item, Infl.cnt FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item WHERE Infl.partOfSpeech = \'preposition\' UNION ALL SELECT Infl.form, Infl.partOfSpeech, MorphologicalDetails.dictionaryRef, Infl.segmentsInfo AS additional, Infl.item, Infl.cnt FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item WHERE Infl.partOfSpeech = \'verb\') SELECT form, partOfSpeech, dictionaryRef, additional, item, cnt FROM InflectionData ORDER BY form, item, cnt',
      };
  @override
  MorphologyPeek get asDslTable => this;
  @override
  i1.MorphologyPeekData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.MorphologyPeekData(
      form: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}form'])!,
      partOfSpeech: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}partOfSpeech']),
      dictionaryRef: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}dictionaryRef'])!,
      additional: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}additional']),
      item: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}item'])!,
      cnt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}cnt'])!,
    );
  }

  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
      'form', aliasedName, false,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> partOfSpeech =
      i0.GeneratedColumn<String>('partOfSpeech', aliasedName, true,
          type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>('dictionaryRef', aliasedName, false,
          type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> additional = i0.GeneratedColumn<String>(
      'additional', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
      'item', aliasedName, false,
      type: i0.DriftSqlType.int);
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
      'cnt', aliasedName, false,
      type: i0.DriftSqlType.int);
  @override
  MorphologyPeek createAlias(String alias) {
    return MorphologyPeek(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables =>
      const {'MorphologicalDetailInflections', 'MorphologicalDetails'};
}

class MorphologyAnalysis extends i0.DataClass {
  final String form;
  final int item;
  final int cnt;
  final String macronizedForm;
  final String dictionaryRef;
  final String partOfSpeech;
  final String stem;
  final String? suffix;
  final String? segmentsInfo;
  final String? gender;
  final String? number;
  final String? declension;
  final String? gramCase;
  final String? verbForm;
  final String? tense;
  final String? voice;
  final String? person;
  final String? additional;
  const MorphologyAnalysis(
      {required this.form,
      required this.item,
      required this.cnt,
      required this.macronizedForm,
      required this.dictionaryRef,
      required this.partOfSpeech,
      required this.stem,
      this.suffix,
      this.segmentsInfo,
      this.gender,
      this.number,
      this.declension,
      this.gramCase,
      this.verbForm,
      this.tense,
      this.voice,
      this.person,
      this.additional});
  factory MorphologyAnalysis.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return MorphologyAnalysis(
      form: serializer.fromJson<String>(json['form']),
      item: serializer.fromJson<int>(json['item']),
      cnt: serializer.fromJson<int>(json['cnt']),
      macronizedForm: serializer.fromJson<String>(json['macronizedForm']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      stem: serializer.fromJson<String>(json['stem']),
      suffix: serializer.fromJson<String?>(json['suffix']),
      segmentsInfo: serializer.fromJson<String?>(json['segmentsInfo']),
      gender: serializer.fromJson<String?>(json['gender']),
      number: serializer.fromJson<String?>(json['number']),
      declension: serializer.fromJson<String?>(json['declension']),
      gramCase: serializer.fromJson<String?>(json['gramCase']),
      verbForm: serializer.fromJson<String?>(json['verbForm']),
      tense: serializer.fromJson<String?>(json['tense']),
      voice: serializer.fromJson<String?>(json['voice']),
      person: serializer.fromJson<String?>(json['person']),
      additional: serializer.fromJson<String?>(json['additional']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String>(form),
      'item': serializer.toJson<int>(item),
      'cnt': serializer.toJson<int>(cnt),
      'macronizedForm': serializer.toJson<String>(macronizedForm),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'stem': serializer.toJson<String>(stem),
      'suffix': serializer.toJson<String?>(suffix),
      'segmentsInfo': serializer.toJson<String?>(segmentsInfo),
      'gender': serializer.toJson<String?>(gender),
      'number': serializer.toJson<String?>(number),
      'declension': serializer.toJson<String?>(declension),
      'gramCase': serializer.toJson<String?>(gramCase),
      'verbForm': serializer.toJson<String?>(verbForm),
      'tense': serializer.toJson<String?>(tense),
      'voice': serializer.toJson<String?>(voice),
      'person': serializer.toJson<String?>(person),
      'additional': serializer.toJson<String?>(additional),
    };
  }

  i1.MorphologyAnalysis copyWith(
          {String? form,
          int? item,
          int? cnt,
          String? macronizedForm,
          String? dictionaryRef,
          String? partOfSpeech,
          String? stem,
          i0.Value<String?> suffix = const i0.Value.absent(),
          i0.Value<String?> segmentsInfo = const i0.Value.absent(),
          i0.Value<String?> gender = const i0.Value.absent(),
          i0.Value<String?> number = const i0.Value.absent(),
          i0.Value<String?> declension = const i0.Value.absent(),
          i0.Value<String?> gramCase = const i0.Value.absent(),
          i0.Value<String?> verbForm = const i0.Value.absent(),
          i0.Value<String?> tense = const i0.Value.absent(),
          i0.Value<String?> voice = const i0.Value.absent(),
          i0.Value<String?> person = const i0.Value.absent(),
          i0.Value<String?> additional = const i0.Value.absent()}) =>
      i1.MorphologyAnalysis(
        form: form ?? this.form,
        item: item ?? this.item,
        cnt: cnt ?? this.cnt,
        macronizedForm: macronizedForm ?? this.macronizedForm,
        dictionaryRef: dictionaryRef ?? this.dictionaryRef,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        stem: stem ?? this.stem,
        suffix: suffix.present ? suffix.value : this.suffix,
        segmentsInfo:
            segmentsInfo.present ? segmentsInfo.value : this.segmentsInfo,
        gender: gender.present ? gender.value : this.gender,
        number: number.present ? number.value : this.number,
        declension: declension.present ? declension.value : this.declension,
        gramCase: gramCase.present ? gramCase.value : this.gramCase,
        verbForm: verbForm.present ? verbForm.value : this.verbForm,
        tense: tense.present ? tense.value : this.tense,
        voice: voice.present ? voice.value : this.voice,
        person: person.present ? person.value : this.person,
        additional: additional.present ? additional.value : this.additional,
      );
  @override
  String toString() {
    return (StringBuffer('MorphologyAnalysis(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt, ')
          ..write('macronizedForm: $macronizedForm, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('stem: $stem, ')
          ..write('suffix: $suffix, ')
          ..write('segmentsInfo: $segmentsInfo, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('declension: $declension, ')
          ..write('gramCase: $gramCase, ')
          ..write('verbForm: $verbForm, ')
          ..write('tense: $tense, ')
          ..write('voice: $voice, ')
          ..write('person: $person, ')
          ..write('additional: $additional')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      form,
      item,
      cnt,
      macronizedForm,
      dictionaryRef,
      partOfSpeech,
      stem,
      suffix,
      segmentsInfo,
      gender,
      number,
      declension,
      gramCase,
      verbForm,
      tense,
      voice,
      person,
      additional);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.MorphologyAnalysis &&
          other.form == this.form &&
          other.item == this.item &&
          other.cnt == this.cnt &&
          other.macronizedForm == this.macronizedForm &&
          other.dictionaryRef == this.dictionaryRef &&
          other.partOfSpeech == this.partOfSpeech &&
          other.stem == this.stem &&
          other.suffix == this.suffix &&
          other.segmentsInfo == this.segmentsInfo &&
          other.gender == this.gender &&
          other.number == this.number &&
          other.declension == this.declension &&
          other.gramCase == this.gramCase &&
          other.verbForm == this.verbForm &&
          other.tense == this.tense &&
          other.voice == this.voice &&
          other.person == this.person &&
          other.additional == this.additional);
}

class MorphologyAnalyses
    extends i0.ViewInfo<i1.MorphologyAnalyses, i1.MorphologyAnalysis>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  MorphologyAnalyses(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
        form,
        item,
        cnt,
        macronizedForm,
        dictionaryRef,
        partOfSpeech,
        stem,
        suffix,
        segmentsInfo,
        gender,
        number,
        declension,
        gramCase,
        verbForm,
        tense,
        voice,
        person,
        additional
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'morphology.Analyses';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
        i0.SqlDialect.sqlite:
            'CREATE VIEW "morphology.Analyses" AS SELECT Infl.form, Infl.item, Infl.cnt, CONCAT("REPLACE"(Infl.stem, \'-\', \'\'), Infl.suffix) AS macronizedForm, MorphologicalDetails.dictionaryRef, Infl.partOfSpeech, Infl.stem, Infl.suffix, Infl.segmentsInfo, Infl.gender, Infl.number, Infl.declension, Infl.gramCase, Infl.verbForm, Infl.tense, Infl.voice, Infl.person, Peek.additional FROM MorphologicalDetailInflections AS Infl INNER JOIN MorphologicalDetails ON Infl.form = MorphologicalDetails.form AND Infl.item = MorphologicalDetails.item INNER JOIN "morphology.Peek" AS Peek ON Infl.form = Peek.form AND Infl.item = Peek.item AND Infl.cnt = Peek.cnt',
      };
  @override
  MorphologyAnalyses get asDslTable => this;
  @override
  i1.MorphologyAnalysis map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.MorphologyAnalysis(
      form: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}form'])!,
      item: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}item'])!,
      cnt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}cnt'])!,
      macronizedForm: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}macronizedForm'])!,
      dictionaryRef: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}dictionaryRef'])!,
      partOfSpeech: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}partOfSpeech'])!,
      stem: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}stem'])!,
      suffix: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}suffix']),
      segmentsInfo: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}segmentsInfo']),
      gender: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}gender']),
      number: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}number']),
      declension: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}declension']),
      gramCase: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}gramCase']),
      verbForm: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}verbForm']),
      tense: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}tense']),
      voice: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}voice']),
      person: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}person']),
      additional: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}additional']),
    );
  }

  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
      'form', aliasedName, false,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
      'item', aliasedName, false,
      type: i0.DriftSqlType.int);
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
      'cnt', aliasedName, false,
      type: i0.DriftSqlType.int);
  late final i0.GeneratedColumn<String> macronizedForm =
      i0.GeneratedColumn<String>('macronizedForm', aliasedName, false,
          type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>('dictionaryRef', aliasedName, false,
          type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> partOfSpeech =
      i0.GeneratedColumn<String>('partOfSpeech', aliasedName, false,
          type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> stem = i0.GeneratedColumn<String>(
      'stem', aliasedName, false,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> suffix = i0.GeneratedColumn<String>(
      'suffix', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> segmentsInfo =
      i0.GeneratedColumn<String>('segmentsInfo', aliasedName, true,
          type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> gender = i0.GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> number = i0.GeneratedColumn<String>(
      'number', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> declension = i0.GeneratedColumn<String>(
      'declension', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> gramCase = i0.GeneratedColumn<String>(
      'gramCase', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> verbForm = i0.GeneratedColumn<String>(
      'verbForm', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> tense = i0.GeneratedColumn<String>(
      'tense', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> voice = i0.GeneratedColumn<String>(
      'voice', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> person = i0.GeneratedColumn<String>(
      'person', aliasedName, true,
      type: i0.DriftSqlType.string);
  late final i0.GeneratedColumn<String> additional = i0.GeneratedColumn<String>(
      'additional', aliasedName, true,
      type: i0.DriftSqlType.string);
  @override
  MorphologyAnalyses createAlias(String alias) {
    return MorphologyAnalyses(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables =>
      const {'MorphologicalDetailInflections', 'MorphologicalDetails'};
}

class MorphAnalysisDrift extends i2.ModularAccessor {
  MorphAnalysisDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i3.Result> searchMorphologicalDataWithFts(String var1) {
    return customSelect(
        'SELECT Peek.*, Search.macronizedForm FROM SearchableMorphDetInflections AS Search INNER JOIN "morphology.Peek" AS Peek ON Search.form = Peek.form AND Search.item = Peek.item AND Search.cnt = Peek.cnt WHERE Search.form MATCH ?1 ORDER BY BM25(SearchableMorphDetInflections), Peek.form, Peek.item, Peek.cnt',
        variables: [
          i0.Variable<String>(var1)
        ],
        readsFrom: {
          searchableMorphDetInflections,
          morphologicalDetailInflections,
          morphologicalDetails,
        }).map((i0.QueryRow row) => i3.Result(
          form: row.read<String>('form'),
          macronizedForm: row.readNullable<String>('macronizedForm'),
          partOfSpeech: row.readNullable<String>('partOfSpeech'),
          dictionaryRef: row.read<String>('dictionaryRef'),
          additional: row.readNullable<String>('additional'),
          item: row.read<int>('item'),
          cnt: row.read<int>('cnt'),
        ));
  }

  i0.Selectable<i3.Result> searchMorphologicalDataWithLike(String var1) {
    return customSelect(
        'SELECT Peek.*, Search.macronizedForm FROM SearchableMorphDetInflections AS Search INNER JOIN "morphology.Peek" AS Peek ON Search.form = Peek.form AND Search.item = Peek.item AND Search.cnt = Peek.cnt WHERE Search.form LIKE ?1 ORDER BY Peek.form, Peek.item, Peek.cnt',
        variables: [
          i0.Variable<String>(var1)
        ],
        readsFrom: {
          searchableMorphDetInflections,
          morphologicalDetailInflections,
          morphologicalDetails,
        }).map((i0.QueryRow row) => i3.Result(
          form: row.read<String>('form'),
          macronizedForm: row.readNullable<String>('macronizedForm'),
          partOfSpeech: row.readNullable<String>('partOfSpeech'),
          dictionaryRef: row.read<String>('dictionaryRef'),
          additional: row.readNullable<String>('additional'),
          item: row.read<int>('item'),
          cnt: row.read<int>('cnt'),
        ));
  }

  i0.Selectable<i3.Result> searchMacronizedMorphologicalDataWithFts(
      String var1) {
    return customSelect(
        'SELECT Peek.*, Search.macronizedForm FROM SearchableMorphDetInflections AS Search INNER JOIN "morphology.Peek" AS Peek ON Search.form = Peek.form AND Search.item = Peek.item AND Search.cnt = Peek.cnt WHERE Search.macronizedForm MATCH ?1 ORDER BY BM25(SearchableMorphDetInflections), Peek.form, Peek.item, Peek.cnt',
        variables: [
          i0.Variable<String>(var1)
        ],
        readsFrom: {
          searchableMorphDetInflections,
          morphologicalDetailInflections,
          morphologicalDetails,
        }).map((i0.QueryRow row) => i3.Result(
          form: row.read<String>('form'),
          macronizedForm: row.readNullable<String>('macronizedForm'),
          partOfSpeech: row.readNullable<String>('partOfSpeech'),
          dictionaryRef: row.read<String>('dictionaryRef'),
          additional: row.readNullable<String>('additional'),
          item: row.read<int>('item'),
          cnt: row.read<int>('cnt'),
        ));
  }

  i0.Selectable<i3.Result> searchMacronizedMorphologicalDataWithLike(
      String var1) {
    return customSelect(
        'SELECT Peek.*, Search.macronizedForm FROM SearchableMorphDetInflections AS Search INNER JOIN "morphology.Peek" AS Peek ON Search.form = Peek.form AND Search.item = Peek.item AND Search.cnt = Peek.cnt WHERE Search.macronizedForm LIKE ?1 ORDER BY Peek.form, Peek.item, Peek.cnt',
        variables: [
          i0.Variable<String>(var1)
        ],
        readsFrom: {
          searchableMorphDetInflections,
          morphologicalDetailInflections,
          morphologicalDetails,
        }).map((i0.QueryRow row) => i3.Result(
          form: row.read<String>('form'),
          macronizedForm: row.readNullable<String>('macronizedForm'),
          partOfSpeech: row.readNullable<String>('partOfSpeech'),
          dictionaryRef: row.read<String>('dictionaryRef'),
          additional: row.readNullable<String>('additional'),
          item: row.read<int>('item'),
          cnt: row.read<int>('cnt'),
        ));
  }

  i0.Selectable<i4.AnalysisKey> getAnalysisKeysOf(String var1) {
    return customSelect(
        'SELECT form, CAST(item AS INT) AS item, CAST(cnt AS INT) AS cnt FROM SearchableMorphDetInflections WHERE form LIKE ?1 ORDER BY form, item, cnt',
        variables: [
          i0.Variable<String>(var1)
        ],
        readsFrom: {
          searchableMorphDetInflections,
        }).map((i0.QueryRow row) => i4.AnalysisKey(
          form: row.readNullable<String>('form'),
          item: row.readNullable<int>('item'),
          cnt: row.readNullable<int>('cnt'),
        ));
  }

  i0.Selectable<i4.AnalysisKey> getAnalysisKeysOfMacronized(String var1) {
    return customSelect(
        'SELECT form, CAST(item AS INT) AS item, CAST(cnt AS INT) AS cnt FROM SearchableMorphDetInflections WHERE macronizedForm LIKE ?1 ORDER BY form, item, cnt',
        variables: [
          i0.Variable<String>(var1)
        ],
        readsFrom: {
          searchableMorphDetInflections,
        }).map((i0.QueryRow row) => i4.AnalysisKey(
          form: row.readNullable<String>('form'),
          item: row.readNullable<int>('item'),
          cnt: row.readNullable<int>('cnt'),
        ));
  }

  i0.Selectable<i1.MorphologyAnalysis> dummy() {
    return customSelect('SELECT * FROM "morphology.Analyses"',
        variables: [],
        readsFrom: {
          morphologicalDetailInflections,
          morphologicalDetails,
        }).asyncMap(morphologyAnalyses.mapFromRow);
  }

  i1.SearchableMorphDetInflections get searchableMorphDetInflections =>
      i2.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i1.SearchableMorphDetInflections>(
              'SearchableMorphDetInflections');
  i1.MorphologyPeek get morphologyPeek =>
      i2.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i1.MorphologyPeek>('morphology.Peek');
  i1.MorphologicalDetailInflections get morphologicalDetailInflections =>
      i2.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i1.MorphologicalDetailInflections>(
              'MorphologicalDetailInflections');
  i1.MorphologicalDetails get morphologicalDetails =>
      i2.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i1.MorphologicalDetails>('MorphologicalDetails');
  i1.MorphologyAnalyses get morphologyAnalyses =>
      i2.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i1.MorphologyAnalyses>('morphology.Analyses');
}
