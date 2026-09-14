// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/word_frequency/word_frequency.drift.dart'
    as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:latin_reader/src/component/word_frequency/word_frequency_api.dart'
    as i3;
import 'package:latin_reader/src/component/word_frequency/resolved_freq_morph_form_api.dart'
    as i4;

typedef $ScopedFormFreqCreateCompanionBuilder =
    i1.ScopedFormFreqCompanion Function({
      required String workId,
      required String form,
      required String macronForm,
      required int occurrences,
    });
typedef $ScopedFormFreqUpdateCompanionBuilder =
    i1.ScopedFormFreqCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> form,
      i0.Value<String> macronForm,
      i0.Value<int> occurrences,
    });

class $ScopedFormFreqFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFormFreq> {
  $ScopedFormFreqFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ScopedFormFreqOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFormFreq> {
  $ScopedFormFreqOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ScopedFormFreqAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFormFreq> {
  $ScopedFormFreqAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  i0.GeneratedColumn<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => column,
  );
}

class $ScopedFormFreqTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ScopedFormFreq,
          i1.ScopedFormFreqData,
          i1.$ScopedFormFreqFilterComposer,
          i1.$ScopedFormFreqOrderingComposer,
          i1.$ScopedFormFreqAnnotationComposer,
          $ScopedFormFreqCreateCompanionBuilder,
          $ScopedFormFreqUpdateCompanionBuilder,
          (
            i1.ScopedFormFreqData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ScopedFormFreq,
              i1.ScopedFormFreqData
            >,
          ),
          i1.ScopedFormFreqData,
          i0.PrefetchHooks Function()
        > {
  $ScopedFormFreqTableManager(i0.GeneratedDatabase db, i1.ScopedFormFreq table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ScopedFormFreqFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$ScopedFormFreqOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ScopedFormFreqAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> form = const i0.Value.absent(),
                i0.Value<String> macronForm = const i0.Value.absent(),
                i0.Value<int> occurrences = const i0.Value.absent(),
              }) => i1.ScopedFormFreqCompanion(
                workId: workId,
                form: form,
                macronForm: macronForm,
                occurrences: occurrences,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String form,
                required String macronForm,
                required int occurrences,
              }) => i1.ScopedFormFreqCompanion.insert(
                workId: workId,
                form: form,
                macronForm: macronForm,
                occurrences: occurrences,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ScopedFormFreqProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ScopedFormFreq,
      i1.ScopedFormFreqData,
      i1.$ScopedFormFreqFilterComposer,
      i1.$ScopedFormFreqOrderingComposer,
      i1.$ScopedFormFreqAnnotationComposer,
      $ScopedFormFreqCreateCompanionBuilder,
      $ScopedFormFreqUpdateCompanionBuilder,
      (
        i1.ScopedFormFreqData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ScopedFormFreq,
          i1.ScopedFormFreqData
        >,
      ),
      i1.ScopedFormFreqData,
      i0.PrefetchHooks Function()
    >;
typedef $ResolvedFreqMorphFormsCreateCompanionBuilder =
    i1.ResolvedFreqMorphFormsCompanion Function({
      required String workId,
      required String form,
      required String macronForm,
      required String morphForm,
      required int morphItem,
      required String dictionaryRef,
    });
typedef $ResolvedFreqMorphFormsUpdateCompanionBuilder =
    i1.ResolvedFreqMorphFormsCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> form,
      i0.Value<String> macronForm,
      i0.Value<String> morphForm,
      i0.Value<int> morphItem,
      i0.Value<String> dictionaryRef,
    });

class $ResolvedFreqMorphFormsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ResolvedFreqMorphForms> {
  $ResolvedFreqMorphFormsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get morphForm => $composableBuilder(
    column: $table.morphForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get morphItem => $composableBuilder(
    column: $table.morphItem,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ResolvedFreqMorphFormsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ResolvedFreqMorphForms> {
  $ResolvedFreqMorphFormsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get morphForm => $composableBuilder(
    column: $table.morphForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get morphItem => $composableBuilder(
    column: $table.morphItem,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ResolvedFreqMorphFormsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ResolvedFreqMorphForms> {
  $ResolvedFreqMorphFormsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  i0.GeneratedColumn<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get morphForm =>
      $composableBuilder(column: $table.morphForm, builder: (column) => column);

  i0.GeneratedColumn<int> get morphItem =>
      $composableBuilder(column: $table.morphItem, builder: (column) => column);

  i0.GeneratedColumn<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => column,
  );
}

class $ResolvedFreqMorphFormsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ResolvedFreqMorphForms,
          i1.ResolvedFreqMorphForm,
          i1.$ResolvedFreqMorphFormsFilterComposer,
          i1.$ResolvedFreqMorphFormsOrderingComposer,
          i1.$ResolvedFreqMorphFormsAnnotationComposer,
          $ResolvedFreqMorphFormsCreateCompanionBuilder,
          $ResolvedFreqMorphFormsUpdateCompanionBuilder,
          (
            i1.ResolvedFreqMorphForm,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ResolvedFreqMorphForms,
              i1.ResolvedFreqMorphForm
            >,
          ),
          i1.ResolvedFreqMorphForm,
          i0.PrefetchHooks Function()
        > {
  $ResolvedFreqMorphFormsTableManager(
    i0.GeneratedDatabase db,
    i1.ResolvedFreqMorphForms table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ResolvedFreqMorphFormsFilterComposer($db: db, $table: table),
          createOrderingComposer: () => i1
              .$ResolvedFreqMorphFormsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ResolvedFreqMorphFormsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> form = const i0.Value.absent(),
                i0.Value<String> macronForm = const i0.Value.absent(),
                i0.Value<String> morphForm = const i0.Value.absent(),
                i0.Value<int> morphItem = const i0.Value.absent(),
                i0.Value<String> dictionaryRef = const i0.Value.absent(),
              }) => i1.ResolvedFreqMorphFormsCompanion(
                workId: workId,
                form: form,
                macronForm: macronForm,
                morphForm: morphForm,
                morphItem: morphItem,
                dictionaryRef: dictionaryRef,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String form,
                required String macronForm,
                required String morphForm,
                required int morphItem,
                required String dictionaryRef,
              }) => i1.ResolvedFreqMorphFormsCompanion.insert(
                workId: workId,
                form: form,
                macronForm: macronForm,
                morphForm: morphForm,
                morphItem: morphItem,
                dictionaryRef: dictionaryRef,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ResolvedFreqMorphFormsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ResolvedFreqMorphForms,
      i1.ResolvedFreqMorphForm,
      i1.$ResolvedFreqMorphFormsFilterComposer,
      i1.$ResolvedFreqMorphFormsOrderingComposer,
      i1.$ResolvedFreqMorphFormsAnnotationComposer,
      $ResolvedFreqMorphFormsCreateCompanionBuilder,
      $ResolvedFreqMorphFormsUpdateCompanionBuilder,
      (
        i1.ResolvedFreqMorphForm,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ResolvedFreqMorphForms,
          i1.ResolvedFreqMorphForm
        >,
      ),
      i1.ResolvedFreqMorphForm,
      i0.PrefetchHooks Function()
    >;
typedef $ScopedFormLemmaFreqCreateCompanionBuilder =
    i1.ScopedFormLemmaFreqCompanion Function({
      required String workId,
      required String form,
      required String macronForm,
      required String dictionaryRef,
      required int possibleOccurrences,
      required int singleCandidateOccurrences,
    });
typedef $ScopedFormLemmaFreqUpdateCompanionBuilder =
    i1.ScopedFormLemmaFreqCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> form,
      i0.Value<String> macronForm,
      i0.Value<String> dictionaryRef,
      i0.Value<int> possibleOccurrences,
      i0.Value<int> singleCandidateOccurrences,
    });

class $ScopedFormLemmaFreqFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFormLemmaFreq> {
  $ScopedFormLemmaFreqFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get possibleOccurrences => $composableBuilder(
    column: $table.possibleOccurrences,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get singleCandidateOccurrences => $composableBuilder(
    column: $table.singleCandidateOccurrences,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ScopedFormLemmaFreqOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFormLemmaFreq> {
  $ScopedFormLemmaFreqOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get possibleOccurrences => $composableBuilder(
    column: $table.possibleOccurrences,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get singleCandidateOccurrences => $composableBuilder(
    column: $table.singleCandidateOccurrences,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ScopedFormLemmaFreqAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFormLemmaFreq> {
  $ScopedFormLemmaFreqAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  i0.GeneratedColumn<String> get macronForm => $composableBuilder(
    column: $table.macronForm,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get possibleOccurrences => $composableBuilder(
    column: $table.possibleOccurrences,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get singleCandidateOccurrences => $composableBuilder(
    column: $table.singleCandidateOccurrences,
    builder: (column) => column,
  );
}

class $ScopedFormLemmaFreqTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ScopedFormLemmaFreq,
          i1.ScopedFormLemmaFreqData,
          i1.$ScopedFormLemmaFreqFilterComposer,
          i1.$ScopedFormLemmaFreqOrderingComposer,
          i1.$ScopedFormLemmaFreqAnnotationComposer,
          $ScopedFormLemmaFreqCreateCompanionBuilder,
          $ScopedFormLemmaFreqUpdateCompanionBuilder,
          (
            i1.ScopedFormLemmaFreqData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ScopedFormLemmaFreq,
              i1.ScopedFormLemmaFreqData
            >,
          ),
          i1.ScopedFormLemmaFreqData,
          i0.PrefetchHooks Function()
        > {
  $ScopedFormLemmaFreqTableManager(
    i0.GeneratedDatabase db,
    i1.ScopedFormLemmaFreq table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ScopedFormLemmaFreqFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$ScopedFormLemmaFreqOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ScopedFormLemmaFreqAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> form = const i0.Value.absent(),
                i0.Value<String> macronForm = const i0.Value.absent(),
                i0.Value<String> dictionaryRef = const i0.Value.absent(),
                i0.Value<int> possibleOccurrences = const i0.Value.absent(),
                i0.Value<int> singleCandidateOccurrences =
                    const i0.Value.absent(),
              }) => i1.ScopedFormLemmaFreqCompanion(
                workId: workId,
                form: form,
                macronForm: macronForm,
                dictionaryRef: dictionaryRef,
                possibleOccurrences: possibleOccurrences,
                singleCandidateOccurrences: singleCandidateOccurrences,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String form,
                required String macronForm,
                required String dictionaryRef,
                required int possibleOccurrences,
                required int singleCandidateOccurrences,
              }) => i1.ScopedFormLemmaFreqCompanion.insert(
                workId: workId,
                form: form,
                macronForm: macronForm,
                dictionaryRef: dictionaryRef,
                possibleOccurrences: possibleOccurrences,
                singleCandidateOccurrences: singleCandidateOccurrences,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ScopedFormLemmaFreqProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ScopedFormLemmaFreq,
      i1.ScopedFormLemmaFreqData,
      i1.$ScopedFormLemmaFreqFilterComposer,
      i1.$ScopedFormLemmaFreqOrderingComposer,
      i1.$ScopedFormLemmaFreqAnnotationComposer,
      $ScopedFormLemmaFreqCreateCompanionBuilder,
      $ScopedFormLemmaFreqUpdateCompanionBuilder,
      (
        i1.ScopedFormLemmaFreqData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ScopedFormLemmaFreq,
          i1.ScopedFormLemmaFreqData
        >,
      ),
      i1.ScopedFormLemmaFreqData,
      i0.PrefetchHooks Function()
    >;
typedef $ScopedLemmaFreqCreateCompanionBuilder =
    i1.ScopedLemmaFreqCompanion Function({
      required String workId,
      required String dictionaryRef,
      required int possibleOccurrences,
      required int singleCandidateOccurrences,
    });
typedef $ScopedLemmaFreqUpdateCompanionBuilder =
    i1.ScopedLemmaFreqCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> dictionaryRef,
      i0.Value<int> possibleOccurrences,
      i0.Value<int> singleCandidateOccurrences,
    });

class $ScopedLemmaFreqFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedLemmaFreq> {
  $ScopedLemmaFreqFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get possibleOccurrences => $composableBuilder(
    column: $table.possibleOccurrences,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get singleCandidateOccurrences => $composableBuilder(
    column: $table.singleCandidateOccurrences,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ScopedLemmaFreqOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedLemmaFreq> {
  $ScopedLemmaFreqOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get possibleOccurrences => $composableBuilder(
    column: $table.possibleOccurrences,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get singleCandidateOccurrences => $composableBuilder(
    column: $table.singleCandidateOccurrences,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ScopedLemmaFreqAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedLemmaFreq> {
  $ScopedLemmaFreqAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get possibleOccurrences => $composableBuilder(
    column: $table.possibleOccurrences,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get singleCandidateOccurrences => $composableBuilder(
    column: $table.singleCandidateOccurrences,
    builder: (column) => column,
  );
}

class $ScopedLemmaFreqTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ScopedLemmaFreq,
          i1.ScopedLemmaFreqData,
          i1.$ScopedLemmaFreqFilterComposer,
          i1.$ScopedLemmaFreqOrderingComposer,
          i1.$ScopedLemmaFreqAnnotationComposer,
          $ScopedLemmaFreqCreateCompanionBuilder,
          $ScopedLemmaFreqUpdateCompanionBuilder,
          (
            i1.ScopedLemmaFreqData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ScopedLemmaFreq,
              i1.ScopedLemmaFreqData
            >,
          ),
          i1.ScopedLemmaFreqData,
          i0.PrefetchHooks Function()
        > {
  $ScopedLemmaFreqTableManager(
    i0.GeneratedDatabase db,
    i1.ScopedLemmaFreq table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ScopedLemmaFreqFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$ScopedLemmaFreqOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ScopedLemmaFreqAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> dictionaryRef = const i0.Value.absent(),
                i0.Value<int> possibleOccurrences = const i0.Value.absent(),
                i0.Value<int> singleCandidateOccurrences =
                    const i0.Value.absent(),
              }) => i1.ScopedLemmaFreqCompanion(
                workId: workId,
                dictionaryRef: dictionaryRef,
                possibleOccurrences: possibleOccurrences,
                singleCandidateOccurrences: singleCandidateOccurrences,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String dictionaryRef,
                required int possibleOccurrences,
                required int singleCandidateOccurrences,
              }) => i1.ScopedLemmaFreqCompanion.insert(
                workId: workId,
                dictionaryRef: dictionaryRef,
                possibleOccurrences: possibleOccurrences,
                singleCandidateOccurrences: singleCandidateOccurrences,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ScopedLemmaFreqProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ScopedLemmaFreq,
      i1.ScopedLemmaFreqData,
      i1.$ScopedLemmaFreqFilterComposer,
      i1.$ScopedLemmaFreqOrderingComposer,
      i1.$ScopedLemmaFreqAnnotationComposer,
      $ScopedLemmaFreqCreateCompanionBuilder,
      $ScopedLemmaFreqUpdateCompanionBuilder,
      (
        i1.ScopedLemmaFreqData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ScopedLemmaFreq,
          i1.ScopedLemmaFreqData
        >,
      ),
      i1.ScopedLemmaFreqData,
      i0.PrefetchHooks Function()
    >;
typedef $ScopedFreqTotalsCreateCompanionBuilder =
    i1.ScopedFreqTotalsCompanion Function({
      required String workId,
      required int totalForms,
      required int totalMacronForms,
      required int totalLemmas,
      required int totalTokens,
      required int noCandidateTokens,
      required int singleCandidateTokens,
      required int multipleCandidateTokens,
    });
typedef $ScopedFreqTotalsUpdateCompanionBuilder =
    i1.ScopedFreqTotalsCompanion Function({
      i0.Value<String> workId,
      i0.Value<int> totalForms,
      i0.Value<int> totalMacronForms,
      i0.Value<int> totalLemmas,
      i0.Value<int> totalTokens,
      i0.Value<int> noCandidateTokens,
      i0.Value<int> singleCandidateTokens,
      i0.Value<int> multipleCandidateTokens,
    });

class $ScopedFreqTotalsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFreqTotals> {
  $ScopedFreqTotalsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get totalForms => $composableBuilder(
    column: $table.totalForms,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get totalMacronForms => $composableBuilder(
    column: $table.totalMacronForms,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get totalLemmas => $composableBuilder(
    column: $table.totalLemmas,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get totalTokens => $composableBuilder(
    column: $table.totalTokens,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get noCandidateTokens => $composableBuilder(
    column: $table.noCandidateTokens,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get singleCandidateTokens => $composableBuilder(
    column: $table.singleCandidateTokens,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get multipleCandidateTokens => $composableBuilder(
    column: $table.multipleCandidateTokens,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ScopedFreqTotalsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFreqTotals> {
  $ScopedFreqTotalsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get totalForms => $composableBuilder(
    column: $table.totalForms,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get totalMacronForms => $composableBuilder(
    column: $table.totalMacronForms,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get totalLemmas => $composableBuilder(
    column: $table.totalLemmas,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get totalTokens => $composableBuilder(
    column: $table.totalTokens,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get noCandidateTokens => $composableBuilder(
    column: $table.noCandidateTokens,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get singleCandidateTokens => $composableBuilder(
    column: $table.singleCandidateTokens,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get multipleCandidateTokens => $composableBuilder(
    column: $table.multipleCandidateTokens,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ScopedFreqTotalsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ScopedFreqTotals> {
  $ScopedFreqTotalsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<int> get totalForms => $composableBuilder(
    column: $table.totalForms,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get totalMacronForms => $composableBuilder(
    column: $table.totalMacronForms,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get totalLemmas => $composableBuilder(
    column: $table.totalLemmas,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get totalTokens => $composableBuilder(
    column: $table.totalTokens,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get noCandidateTokens => $composableBuilder(
    column: $table.noCandidateTokens,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get singleCandidateTokens => $composableBuilder(
    column: $table.singleCandidateTokens,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get multipleCandidateTokens => $composableBuilder(
    column: $table.multipleCandidateTokens,
    builder: (column) => column,
  );
}

class $ScopedFreqTotalsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ScopedFreqTotals,
          i1.ScopedFreqTotal,
          i1.$ScopedFreqTotalsFilterComposer,
          i1.$ScopedFreqTotalsOrderingComposer,
          i1.$ScopedFreqTotalsAnnotationComposer,
          $ScopedFreqTotalsCreateCompanionBuilder,
          $ScopedFreqTotalsUpdateCompanionBuilder,
          (
            i1.ScopedFreqTotal,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ScopedFreqTotals,
              i1.ScopedFreqTotal
            >,
          ),
          i1.ScopedFreqTotal,
          i0.PrefetchHooks Function()
        > {
  $ScopedFreqTotalsTableManager(
    i0.GeneratedDatabase db,
    i1.ScopedFreqTotals table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ScopedFreqTotalsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$ScopedFreqTotalsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ScopedFreqTotalsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<int> totalForms = const i0.Value.absent(),
                i0.Value<int> totalMacronForms = const i0.Value.absent(),
                i0.Value<int> totalLemmas = const i0.Value.absent(),
                i0.Value<int> totalTokens = const i0.Value.absent(),
                i0.Value<int> noCandidateTokens = const i0.Value.absent(),
                i0.Value<int> singleCandidateTokens = const i0.Value.absent(),
                i0.Value<int> multipleCandidateTokens = const i0.Value.absent(),
              }) => i1.ScopedFreqTotalsCompanion(
                workId: workId,
                totalForms: totalForms,
                totalMacronForms: totalMacronForms,
                totalLemmas: totalLemmas,
                totalTokens: totalTokens,
                noCandidateTokens: noCandidateTokens,
                singleCandidateTokens: singleCandidateTokens,
                multipleCandidateTokens: multipleCandidateTokens,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required int totalForms,
                required int totalMacronForms,
                required int totalLemmas,
                required int totalTokens,
                required int noCandidateTokens,
                required int singleCandidateTokens,
                required int multipleCandidateTokens,
              }) => i1.ScopedFreqTotalsCompanion.insert(
                workId: workId,
                totalForms: totalForms,
                totalMacronForms: totalMacronForms,
                totalLemmas: totalLemmas,
                totalTokens: totalTokens,
                noCandidateTokens: noCandidateTokens,
                singleCandidateTokens: singleCandidateTokens,
                multipleCandidateTokens: multipleCandidateTokens,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ScopedFreqTotalsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ScopedFreqTotals,
      i1.ScopedFreqTotal,
      i1.$ScopedFreqTotalsFilterComposer,
      i1.$ScopedFreqTotalsOrderingComposer,
      i1.$ScopedFreqTotalsAnnotationComposer,
      $ScopedFreqTotalsCreateCompanionBuilder,
      $ScopedFreqTotalsUpdateCompanionBuilder,
      (
        i1.ScopedFreqTotal,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ScopedFreqTotals,
          i1.ScopedFreqTotal
        >,
      ),
      i1.ScopedFreqTotal,
      i0.PrefetchHooks Function()
    >;

class ScopedFormFreq extends i0.Table
    with i0.TableInfo<ScopedFormFreq, i1.ScopedFormFreqData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScopedFormFreq(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _workIdMeta = const i0.VerificationMeta(
    'workId',
  );
  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _formMeta = const i0.VerificationMeta(
    'form',
  );
  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _macronFormMeta = const i0.VerificationMeta(
    'macronForm',
  );
  late final i0.GeneratedColumn<String> macronForm = i0.GeneratedColumn<String>(
    'macronForm',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _occurrencesMeta = const i0.VerificationMeta(
    'occurrences',
  );
  late final i0.GeneratedColumn<int> occurrences = i0.GeneratedColumn<int>(
    'occurrences',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (occurrences > 0)',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    form,
    macronForm,
    occurrences,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ScopedFormFreq';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ScopedFormFreqData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(
        _workIdMeta,
        workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('macronForm')) {
      context.handle(
        _macronFormMeta,
        macronForm.isAcceptableOrUnknown(data['macronForm']!, _macronFormMeta),
      );
    } else if (isInserting) {
      context.missing(_macronFormMeta);
    }
    if (data.containsKey('occurrences')) {
      context.handle(
        _occurrencesMeta,
        occurrences.isAcceptableOrUnknown(
          data['occurrences']!,
          _occurrencesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_occurrencesMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, form, macronForm};
  @override
  i1.ScopedFormFreqData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ScopedFormFreqData(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      macronForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronForm'],
      )!,
      occurrences: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}occurrences'],
      )!,
    );
  }

  @override
  ScopedFormFreq createAlias(String alias) {
    return ScopedFormFreq(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, form, macronForm)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScopedFormFreqData extends i0.DataClass
    implements i0.Insertable<i1.ScopedFormFreqData> {
  final String workId;
  final String form;
  final String macronForm;
  final int occurrences;
  const ScopedFormFreqData({
    required this.workId,
    required this.form,
    required this.macronForm,
    required this.occurrences,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['form'] = i0.Variable<String>(form);
    map['macronForm'] = i0.Variable<String>(macronForm);
    map['occurrences'] = i0.Variable<int>(occurrences);
    return map;
  }

  i1.ScopedFormFreqCompanion toCompanion(bool nullToAbsent) {
    return i1.ScopedFormFreqCompanion(
      workId: i0.Value(workId),
      form: i0.Value(form),
      macronForm: i0.Value(macronForm),
      occurrences: i0.Value(occurrences),
    );
  }

  factory ScopedFormFreqData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ScopedFormFreqData(
      workId: serializer.fromJson<String>(json['workId']),
      form: serializer.fromJson<String>(json['form']),
      macronForm: serializer.fromJson<String>(json['macronForm']),
      occurrences: serializer.fromJson<int>(json['occurrences']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'form': serializer.toJson<String>(form),
      'macronForm': serializer.toJson<String>(macronForm),
      'occurrences': serializer.toJson<int>(occurrences),
    };
  }

  i1.ScopedFormFreqData copyWith({
    String? workId,
    String? form,
    String? macronForm,
    int? occurrences,
  }) => i1.ScopedFormFreqData(
    workId: workId ?? this.workId,
    form: form ?? this.form,
    macronForm: macronForm ?? this.macronForm,
    occurrences: occurrences ?? this.occurrences,
  );
  ScopedFormFreqData copyWithCompanion(i1.ScopedFormFreqCompanion data) {
    return ScopedFormFreqData(
      workId: data.workId.present ? data.workId.value : this.workId,
      form: data.form.present ? data.form.value : this.form,
      macronForm: data.macronForm.present
          ? data.macronForm.value
          : this.macronForm,
      occurrences: data.occurrences.present
          ? data.occurrences.value
          : this.occurrences,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScopedFormFreqData(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('occurrences: $occurrences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, form, macronForm, occurrences);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ScopedFormFreqData &&
          other.workId == this.workId &&
          other.form == this.form &&
          other.macronForm == this.macronForm &&
          other.occurrences == this.occurrences);
}

class ScopedFormFreqCompanion
    extends i0.UpdateCompanion<i1.ScopedFormFreqData> {
  final i0.Value<String> workId;
  final i0.Value<String> form;
  final i0.Value<String> macronForm;
  final i0.Value<int> occurrences;
  const ScopedFormFreqCompanion({
    this.workId = const i0.Value.absent(),
    this.form = const i0.Value.absent(),
    this.macronForm = const i0.Value.absent(),
    this.occurrences = const i0.Value.absent(),
  });
  ScopedFormFreqCompanion.insert({
    required String workId,
    required String form,
    required String macronForm,
    required int occurrences,
  }) : workId = i0.Value(workId),
       form = i0.Value(form),
       macronForm = i0.Value(macronForm),
       occurrences = i0.Value(occurrences);
  static i0.Insertable<i1.ScopedFormFreqData> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? form,
    i0.Expression<String>? macronForm,
    i0.Expression<int>? occurrences,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (form != null) 'form': form,
      if (macronForm != null) 'macronForm': macronForm,
      if (occurrences != null) 'occurrences': occurrences,
    });
  }

  i1.ScopedFormFreqCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? form,
    i0.Value<String>? macronForm,
    i0.Value<int>? occurrences,
  }) {
    return i1.ScopedFormFreqCompanion(
      workId: workId ?? this.workId,
      form: form ?? this.form,
      macronForm: macronForm ?? this.macronForm,
      occurrences: occurrences ?? this.occurrences,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (form.present) {
      map['form'] = i0.Variable<String>(form.value);
    }
    if (macronForm.present) {
      map['macronForm'] = i0.Variable<String>(macronForm.value);
    }
    if (occurrences.present) {
      map['occurrences'] = i0.Variable<int>(occurrences.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScopedFormFreqCompanion(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('occurrences: $occurrences')
          ..write(')'))
        .toString();
  }
}

class ResolvedFreqMorphForms extends i0.Table
    with i0.TableInfo<ResolvedFreqMorphForms, i1.ResolvedFreqMorphForm> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ResolvedFreqMorphForms(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _workIdMeta = const i0.VerificationMeta(
    'workId',
  );
  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _formMeta = const i0.VerificationMeta(
    'form',
  );
  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _macronFormMeta = const i0.VerificationMeta(
    'macronForm',
  );
  late final i0.GeneratedColumn<String> macronForm = i0.GeneratedColumn<String>(
    'macronForm',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _morphFormMeta = const i0.VerificationMeta(
    'morphForm',
  );
  late final i0.GeneratedColumn<String> morphForm = i0.GeneratedColumn<String>(
    'morphForm',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _morphItemMeta = const i0.VerificationMeta(
    'morphItem',
  );
  late final i0.GeneratedColumn<int> morphItem = i0.GeneratedColumn<int>(
    'morphItem',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _dictionaryRefMeta =
      const i0.VerificationMeta('dictionaryRef');
  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>(
        'dictionaryRef',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    form,
    macronForm,
    morphForm,
    morphItem,
    dictionaryRef,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ResolvedFreqMorphForms';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ResolvedFreqMorphForm> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(
        _workIdMeta,
        workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('macronForm')) {
      context.handle(
        _macronFormMeta,
        macronForm.isAcceptableOrUnknown(data['macronForm']!, _macronFormMeta),
      );
    } else if (isInserting) {
      context.missing(_macronFormMeta);
    }
    if (data.containsKey('morphForm')) {
      context.handle(
        _morphFormMeta,
        morphForm.isAcceptableOrUnknown(data['morphForm']!, _morphFormMeta),
      );
    } else if (isInserting) {
      context.missing(_morphFormMeta);
    }
    if (data.containsKey('morphItem')) {
      context.handle(
        _morphItemMeta,
        morphItem.isAcceptableOrUnknown(data['morphItem']!, _morphItemMeta),
      );
    } else if (isInserting) {
      context.missing(_morphItemMeta);
    }
    if (data.containsKey('dictionaryRef')) {
      context.handle(
        _dictionaryRefMeta,
        dictionaryRef.isAcceptableOrUnknown(
          data['dictionaryRef']!,
          _dictionaryRefMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dictionaryRefMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {
    workId,
    form,
    macronForm,
    morphForm,
    morphItem,
  };
  @override
  i1.ResolvedFreqMorphForm map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ResolvedFreqMorphForm(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      macronForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronForm'],
      )!,
      morphForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}morphForm'],
      )!,
      morphItem: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}morphItem'],
      )!,
      dictionaryRef: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionaryRef'],
      )!,
    );
  }

  @override
  ResolvedFreqMorphForms createAlias(String alias) {
    return ResolvedFreqMorphForms(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, form, macronForm, morphForm, morphItem)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ResolvedFreqMorphForm extends i0.DataClass
    implements i0.Insertable<i1.ResolvedFreqMorphForm> {
  final String workId;
  final String form;
  final String macronForm;
  final String morphForm;
  final int morphItem;
  final String dictionaryRef;
  const ResolvedFreqMorphForm({
    required this.workId,
    required this.form,
    required this.macronForm,
    required this.morphForm,
    required this.morphItem,
    required this.dictionaryRef,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['form'] = i0.Variable<String>(form);
    map['macronForm'] = i0.Variable<String>(macronForm);
    map['morphForm'] = i0.Variable<String>(morphForm);
    map['morphItem'] = i0.Variable<int>(morphItem);
    map['dictionaryRef'] = i0.Variable<String>(dictionaryRef);
    return map;
  }

  i1.ResolvedFreqMorphFormsCompanion toCompanion(bool nullToAbsent) {
    return i1.ResolvedFreqMorphFormsCompanion(
      workId: i0.Value(workId),
      form: i0.Value(form),
      macronForm: i0.Value(macronForm),
      morphForm: i0.Value(morphForm),
      morphItem: i0.Value(morphItem),
      dictionaryRef: i0.Value(dictionaryRef),
    );
  }

  factory ResolvedFreqMorphForm.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ResolvedFreqMorphForm(
      workId: serializer.fromJson<String>(json['workId']),
      form: serializer.fromJson<String>(json['form']),
      macronForm: serializer.fromJson<String>(json['macronForm']),
      morphForm: serializer.fromJson<String>(json['morphForm']),
      morphItem: serializer.fromJson<int>(json['morphItem']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'form': serializer.toJson<String>(form),
      'macronForm': serializer.toJson<String>(macronForm),
      'morphForm': serializer.toJson<String>(morphForm),
      'morphItem': serializer.toJson<int>(morphItem),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
    };
  }

  i1.ResolvedFreqMorphForm copyWith({
    String? workId,
    String? form,
    String? macronForm,
    String? morphForm,
    int? morphItem,
    String? dictionaryRef,
  }) => i1.ResolvedFreqMorphForm(
    workId: workId ?? this.workId,
    form: form ?? this.form,
    macronForm: macronForm ?? this.macronForm,
    morphForm: morphForm ?? this.morphForm,
    morphItem: morphItem ?? this.morphItem,
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
  );
  ResolvedFreqMorphForm copyWithCompanion(
    i1.ResolvedFreqMorphFormsCompanion data,
  ) {
    return ResolvedFreqMorphForm(
      workId: data.workId.present ? data.workId.value : this.workId,
      form: data.form.present ? data.form.value : this.form,
      macronForm: data.macronForm.present
          ? data.macronForm.value
          : this.macronForm,
      morphForm: data.morphForm.present ? data.morphForm.value : this.morphForm,
      morphItem: data.morphItem.present ? data.morphItem.value : this.morphItem,
      dictionaryRef: data.dictionaryRef.present
          ? data.dictionaryRef.value
          : this.dictionaryRef,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResolvedFreqMorphForm(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('morphForm: $morphForm, ')
          ..write('morphItem: $morphItem, ')
          ..write('dictionaryRef: $dictionaryRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workId,
    form,
    macronForm,
    morphForm,
    morphItem,
    dictionaryRef,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ResolvedFreqMorphForm &&
          other.workId == this.workId &&
          other.form == this.form &&
          other.macronForm == this.macronForm &&
          other.morphForm == this.morphForm &&
          other.morphItem == this.morphItem &&
          other.dictionaryRef == this.dictionaryRef);
}

class ResolvedFreqMorphFormsCompanion
    extends i0.UpdateCompanion<i1.ResolvedFreqMorphForm> {
  final i0.Value<String> workId;
  final i0.Value<String> form;
  final i0.Value<String> macronForm;
  final i0.Value<String> morphForm;
  final i0.Value<int> morphItem;
  final i0.Value<String> dictionaryRef;
  const ResolvedFreqMorphFormsCompanion({
    this.workId = const i0.Value.absent(),
    this.form = const i0.Value.absent(),
    this.macronForm = const i0.Value.absent(),
    this.morphForm = const i0.Value.absent(),
    this.morphItem = const i0.Value.absent(),
    this.dictionaryRef = const i0.Value.absent(),
  });
  ResolvedFreqMorphFormsCompanion.insert({
    required String workId,
    required String form,
    required String macronForm,
    required String morphForm,
    required int morphItem,
    required String dictionaryRef,
  }) : workId = i0.Value(workId),
       form = i0.Value(form),
       macronForm = i0.Value(macronForm),
       morphForm = i0.Value(morphForm),
       morphItem = i0.Value(morphItem),
       dictionaryRef = i0.Value(dictionaryRef);
  static i0.Insertable<i1.ResolvedFreqMorphForm> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? form,
    i0.Expression<String>? macronForm,
    i0.Expression<String>? morphForm,
    i0.Expression<int>? morphItem,
    i0.Expression<String>? dictionaryRef,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (form != null) 'form': form,
      if (macronForm != null) 'macronForm': macronForm,
      if (morphForm != null) 'morphForm': morphForm,
      if (morphItem != null) 'morphItem': morphItem,
      if (dictionaryRef != null) 'dictionaryRef': dictionaryRef,
    });
  }

  i1.ResolvedFreqMorphFormsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? form,
    i0.Value<String>? macronForm,
    i0.Value<String>? morphForm,
    i0.Value<int>? morphItem,
    i0.Value<String>? dictionaryRef,
  }) {
    return i1.ResolvedFreqMorphFormsCompanion(
      workId: workId ?? this.workId,
      form: form ?? this.form,
      macronForm: macronForm ?? this.macronForm,
      morphForm: morphForm ?? this.morphForm,
      morphItem: morphItem ?? this.morphItem,
      dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (form.present) {
      map['form'] = i0.Variable<String>(form.value);
    }
    if (macronForm.present) {
      map['macronForm'] = i0.Variable<String>(macronForm.value);
    }
    if (morphForm.present) {
      map['morphForm'] = i0.Variable<String>(morphForm.value);
    }
    if (morphItem.present) {
      map['morphItem'] = i0.Variable<int>(morphItem.value);
    }
    if (dictionaryRef.present) {
      map['dictionaryRef'] = i0.Variable<String>(dictionaryRef.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResolvedFreqMorphFormsCompanion(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('morphForm: $morphForm, ')
          ..write('morphItem: $morphItem, ')
          ..write('dictionaryRef: $dictionaryRef')
          ..write(')'))
        .toString();
  }
}

i0.Index get resolvedFreqMorphFormsLemma => i0.Index(
  'ResolvedFreqMorphForms_Lemma',
  'CREATE INDEX ResolvedFreqMorphForms_Lemma ON ResolvedFreqMorphForms (workId, dictionaryRef)',
);

class ScopedFormLemmaFreq extends i0.Table
    with i0.TableInfo<ScopedFormLemmaFreq, i1.ScopedFormLemmaFreqData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScopedFormLemmaFreq(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _workIdMeta = const i0.VerificationMeta(
    'workId',
  );
  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _formMeta = const i0.VerificationMeta(
    'form',
  );
  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _macronFormMeta = const i0.VerificationMeta(
    'macronForm',
  );
  late final i0.GeneratedColumn<String> macronForm = i0.GeneratedColumn<String>(
    'macronForm',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _dictionaryRefMeta =
      const i0.VerificationMeta('dictionaryRef');
  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>(
        'dictionaryRef',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _possibleOccurrencesMeta =
      const i0.VerificationMeta('possibleOccurrences');
  late final i0.GeneratedColumn<int> possibleOccurrences =
      i0.GeneratedColumn<int>(
        'possibleOccurrences',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL CHECK (possibleOccurrences > 0)',
      );
  static const i0.VerificationMeta _singleCandidateOccurrencesMeta =
      const i0.VerificationMeta('singleCandidateOccurrences');
  late final i0.GeneratedColumn<int>
  singleCandidateOccurrences = i0.GeneratedColumn<int>(
    'singleCandidateOccurrences',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (singleCandidateOccurrences BETWEEN 0 AND possibleOccurrences)',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    form,
    macronForm,
    dictionaryRef,
    possibleOccurrences,
    singleCandidateOccurrences,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ScopedFormLemmaFreq';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ScopedFormLemmaFreqData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(
        _workIdMeta,
        workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('macronForm')) {
      context.handle(
        _macronFormMeta,
        macronForm.isAcceptableOrUnknown(data['macronForm']!, _macronFormMeta),
      );
    } else if (isInserting) {
      context.missing(_macronFormMeta);
    }
    if (data.containsKey('dictionaryRef')) {
      context.handle(
        _dictionaryRefMeta,
        dictionaryRef.isAcceptableOrUnknown(
          data['dictionaryRef']!,
          _dictionaryRefMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dictionaryRefMeta);
    }
    if (data.containsKey('possibleOccurrences')) {
      context.handle(
        _possibleOccurrencesMeta,
        possibleOccurrences.isAcceptableOrUnknown(
          data['possibleOccurrences']!,
          _possibleOccurrencesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_possibleOccurrencesMeta);
    }
    if (data.containsKey('singleCandidateOccurrences')) {
      context.handle(
        _singleCandidateOccurrencesMeta,
        singleCandidateOccurrences.isAcceptableOrUnknown(
          data['singleCandidateOccurrences']!,
          _singleCandidateOccurrencesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_singleCandidateOccurrencesMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {
    workId,
    form,
    macronForm,
    dictionaryRef,
  };
  @override
  i1.ScopedFormLemmaFreqData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ScopedFormLemmaFreqData(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      macronForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronForm'],
      )!,
      dictionaryRef: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionaryRef'],
      )!,
      possibleOccurrences: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}possibleOccurrences'],
      )!,
      singleCandidateOccurrences: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}singleCandidateOccurrences'],
      )!,
    );
  }

  @override
  ScopedFormLemmaFreq createAlias(String alias) {
    return ScopedFormLemmaFreq(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, form, macronForm, dictionaryRef)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScopedFormLemmaFreqData extends i0.DataClass
    implements i0.Insertable<i1.ScopedFormLemmaFreqData> {
  final String workId;
  final String form;
  final String macronForm;
  final String dictionaryRef;
  final int possibleOccurrences;
  final int singleCandidateOccurrences;
  const ScopedFormLemmaFreqData({
    required this.workId,
    required this.form,
    required this.macronForm,
    required this.dictionaryRef,
    required this.possibleOccurrences,
    required this.singleCandidateOccurrences,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['form'] = i0.Variable<String>(form);
    map['macronForm'] = i0.Variable<String>(macronForm);
    map['dictionaryRef'] = i0.Variable<String>(dictionaryRef);
    map['possibleOccurrences'] = i0.Variable<int>(possibleOccurrences);
    map['singleCandidateOccurrences'] = i0.Variable<int>(
      singleCandidateOccurrences,
    );
    return map;
  }

  i1.ScopedFormLemmaFreqCompanion toCompanion(bool nullToAbsent) {
    return i1.ScopedFormLemmaFreqCompanion(
      workId: i0.Value(workId),
      form: i0.Value(form),
      macronForm: i0.Value(macronForm),
      dictionaryRef: i0.Value(dictionaryRef),
      possibleOccurrences: i0.Value(possibleOccurrences),
      singleCandidateOccurrences: i0.Value(singleCandidateOccurrences),
    );
  }

  factory ScopedFormLemmaFreqData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ScopedFormLemmaFreqData(
      workId: serializer.fromJson<String>(json['workId']),
      form: serializer.fromJson<String>(json['form']),
      macronForm: serializer.fromJson<String>(json['macronForm']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      possibleOccurrences: serializer.fromJson<int>(
        json['possibleOccurrences'],
      ),
      singleCandidateOccurrences: serializer.fromJson<int>(
        json['singleCandidateOccurrences'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'form': serializer.toJson<String>(form),
      'macronForm': serializer.toJson<String>(macronForm),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'possibleOccurrences': serializer.toJson<int>(possibleOccurrences),
      'singleCandidateOccurrences': serializer.toJson<int>(
        singleCandidateOccurrences,
      ),
    };
  }

  i1.ScopedFormLemmaFreqData copyWith({
    String? workId,
    String? form,
    String? macronForm,
    String? dictionaryRef,
    int? possibleOccurrences,
    int? singleCandidateOccurrences,
  }) => i1.ScopedFormLemmaFreqData(
    workId: workId ?? this.workId,
    form: form ?? this.form,
    macronForm: macronForm ?? this.macronForm,
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    possibleOccurrences: possibleOccurrences ?? this.possibleOccurrences,
    singleCandidateOccurrences:
        singleCandidateOccurrences ?? this.singleCandidateOccurrences,
  );
  ScopedFormLemmaFreqData copyWithCompanion(
    i1.ScopedFormLemmaFreqCompanion data,
  ) {
    return ScopedFormLemmaFreqData(
      workId: data.workId.present ? data.workId.value : this.workId,
      form: data.form.present ? data.form.value : this.form,
      macronForm: data.macronForm.present
          ? data.macronForm.value
          : this.macronForm,
      dictionaryRef: data.dictionaryRef.present
          ? data.dictionaryRef.value
          : this.dictionaryRef,
      possibleOccurrences: data.possibleOccurrences.present
          ? data.possibleOccurrences.value
          : this.possibleOccurrences,
      singleCandidateOccurrences: data.singleCandidateOccurrences.present
          ? data.singleCandidateOccurrences.value
          : this.singleCandidateOccurrences,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScopedFormLemmaFreqData(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('possibleOccurrences: $possibleOccurrences, ')
          ..write('singleCandidateOccurrences: $singleCandidateOccurrences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workId,
    form,
    macronForm,
    dictionaryRef,
    possibleOccurrences,
    singleCandidateOccurrences,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ScopedFormLemmaFreqData &&
          other.workId == this.workId &&
          other.form == this.form &&
          other.macronForm == this.macronForm &&
          other.dictionaryRef == this.dictionaryRef &&
          other.possibleOccurrences == this.possibleOccurrences &&
          other.singleCandidateOccurrences == this.singleCandidateOccurrences);
}

class ScopedFormLemmaFreqCompanion
    extends i0.UpdateCompanion<i1.ScopedFormLemmaFreqData> {
  final i0.Value<String> workId;
  final i0.Value<String> form;
  final i0.Value<String> macronForm;
  final i0.Value<String> dictionaryRef;
  final i0.Value<int> possibleOccurrences;
  final i0.Value<int> singleCandidateOccurrences;
  const ScopedFormLemmaFreqCompanion({
    this.workId = const i0.Value.absent(),
    this.form = const i0.Value.absent(),
    this.macronForm = const i0.Value.absent(),
    this.dictionaryRef = const i0.Value.absent(),
    this.possibleOccurrences = const i0.Value.absent(),
    this.singleCandidateOccurrences = const i0.Value.absent(),
  });
  ScopedFormLemmaFreqCompanion.insert({
    required String workId,
    required String form,
    required String macronForm,
    required String dictionaryRef,
    required int possibleOccurrences,
    required int singleCandidateOccurrences,
  }) : workId = i0.Value(workId),
       form = i0.Value(form),
       macronForm = i0.Value(macronForm),
       dictionaryRef = i0.Value(dictionaryRef),
       possibleOccurrences = i0.Value(possibleOccurrences),
       singleCandidateOccurrences = i0.Value(singleCandidateOccurrences);
  static i0.Insertable<i1.ScopedFormLemmaFreqData> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? form,
    i0.Expression<String>? macronForm,
    i0.Expression<String>? dictionaryRef,
    i0.Expression<int>? possibleOccurrences,
    i0.Expression<int>? singleCandidateOccurrences,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (form != null) 'form': form,
      if (macronForm != null) 'macronForm': macronForm,
      if (dictionaryRef != null) 'dictionaryRef': dictionaryRef,
      if (possibleOccurrences != null)
        'possibleOccurrences': possibleOccurrences,
      if (singleCandidateOccurrences != null)
        'singleCandidateOccurrences': singleCandidateOccurrences,
    });
  }

  i1.ScopedFormLemmaFreqCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? form,
    i0.Value<String>? macronForm,
    i0.Value<String>? dictionaryRef,
    i0.Value<int>? possibleOccurrences,
    i0.Value<int>? singleCandidateOccurrences,
  }) {
    return i1.ScopedFormLemmaFreqCompanion(
      workId: workId ?? this.workId,
      form: form ?? this.form,
      macronForm: macronForm ?? this.macronForm,
      dictionaryRef: dictionaryRef ?? this.dictionaryRef,
      possibleOccurrences: possibleOccurrences ?? this.possibleOccurrences,
      singleCandidateOccurrences:
          singleCandidateOccurrences ?? this.singleCandidateOccurrences,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (form.present) {
      map['form'] = i0.Variable<String>(form.value);
    }
    if (macronForm.present) {
      map['macronForm'] = i0.Variable<String>(macronForm.value);
    }
    if (dictionaryRef.present) {
      map['dictionaryRef'] = i0.Variable<String>(dictionaryRef.value);
    }
    if (possibleOccurrences.present) {
      map['possibleOccurrences'] = i0.Variable<int>(possibleOccurrences.value);
    }
    if (singleCandidateOccurrences.present) {
      map['singleCandidateOccurrences'] = i0.Variable<int>(
        singleCandidateOccurrences.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScopedFormLemmaFreqCompanion(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('possibleOccurrences: $possibleOccurrences, ')
          ..write('singleCandidateOccurrences: $singleCandidateOccurrences')
          ..write(')'))
        .toString();
  }
}

i0.Index get scopedFormLemmaFreqMacronForm => i0.Index(
  'ScopedFormLemmaFreq_MacronForm',
  'CREATE INDEX ScopedFormLemmaFreq_MacronForm ON ScopedFormLemmaFreq (macronForm, workId)',
);

class ScopedLemmaFreq extends i0.Table
    with i0.TableInfo<ScopedLemmaFreq, i1.ScopedLemmaFreqData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScopedLemmaFreq(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _workIdMeta = const i0.VerificationMeta(
    'workId',
  );
  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _dictionaryRefMeta =
      const i0.VerificationMeta('dictionaryRef');
  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>(
        'dictionaryRef',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _possibleOccurrencesMeta =
      const i0.VerificationMeta('possibleOccurrences');
  late final i0.GeneratedColumn<int> possibleOccurrences =
      i0.GeneratedColumn<int>(
        'possibleOccurrences',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL CHECK (possibleOccurrences > 0)',
      );
  static const i0.VerificationMeta _singleCandidateOccurrencesMeta =
      const i0.VerificationMeta('singleCandidateOccurrences');
  late final i0.GeneratedColumn<int>
  singleCandidateOccurrences = i0.GeneratedColumn<int>(
    'singleCandidateOccurrences',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (singleCandidateOccurrences BETWEEN 0 AND possibleOccurrences)',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    dictionaryRef,
    possibleOccurrences,
    singleCandidateOccurrences,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ScopedLemmaFreq';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ScopedLemmaFreqData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(
        _workIdMeta,
        workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('dictionaryRef')) {
      context.handle(
        _dictionaryRefMeta,
        dictionaryRef.isAcceptableOrUnknown(
          data['dictionaryRef']!,
          _dictionaryRefMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dictionaryRefMeta);
    }
    if (data.containsKey('possibleOccurrences')) {
      context.handle(
        _possibleOccurrencesMeta,
        possibleOccurrences.isAcceptableOrUnknown(
          data['possibleOccurrences']!,
          _possibleOccurrencesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_possibleOccurrencesMeta);
    }
    if (data.containsKey('singleCandidateOccurrences')) {
      context.handle(
        _singleCandidateOccurrencesMeta,
        singleCandidateOccurrences.isAcceptableOrUnknown(
          data['singleCandidateOccurrences']!,
          _singleCandidateOccurrencesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_singleCandidateOccurrencesMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, dictionaryRef};
  @override
  i1.ScopedLemmaFreqData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ScopedLemmaFreqData(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      dictionaryRef: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionaryRef'],
      )!,
      possibleOccurrences: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}possibleOccurrences'],
      )!,
      singleCandidateOccurrences: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}singleCandidateOccurrences'],
      )!,
    );
  }

  @override
  ScopedLemmaFreq createAlias(String alias) {
    return ScopedLemmaFreq(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, dictionaryRef)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScopedLemmaFreqData extends i0.DataClass
    implements i0.Insertable<i1.ScopedLemmaFreqData> {
  final String workId;
  final String dictionaryRef;
  final int possibleOccurrences;
  final int singleCandidateOccurrences;
  const ScopedLemmaFreqData({
    required this.workId,
    required this.dictionaryRef,
    required this.possibleOccurrences,
    required this.singleCandidateOccurrences,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['dictionaryRef'] = i0.Variable<String>(dictionaryRef);
    map['possibleOccurrences'] = i0.Variable<int>(possibleOccurrences);
    map['singleCandidateOccurrences'] = i0.Variable<int>(
      singleCandidateOccurrences,
    );
    return map;
  }

  i1.ScopedLemmaFreqCompanion toCompanion(bool nullToAbsent) {
    return i1.ScopedLemmaFreqCompanion(
      workId: i0.Value(workId),
      dictionaryRef: i0.Value(dictionaryRef),
      possibleOccurrences: i0.Value(possibleOccurrences),
      singleCandidateOccurrences: i0.Value(singleCandidateOccurrences),
    );
  }

  factory ScopedLemmaFreqData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ScopedLemmaFreqData(
      workId: serializer.fromJson<String>(json['workId']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      possibleOccurrences: serializer.fromJson<int>(
        json['possibleOccurrences'],
      ),
      singleCandidateOccurrences: serializer.fromJson<int>(
        json['singleCandidateOccurrences'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'possibleOccurrences': serializer.toJson<int>(possibleOccurrences),
      'singleCandidateOccurrences': serializer.toJson<int>(
        singleCandidateOccurrences,
      ),
    };
  }

  i1.ScopedLemmaFreqData copyWith({
    String? workId,
    String? dictionaryRef,
    int? possibleOccurrences,
    int? singleCandidateOccurrences,
  }) => i1.ScopedLemmaFreqData(
    workId: workId ?? this.workId,
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    possibleOccurrences: possibleOccurrences ?? this.possibleOccurrences,
    singleCandidateOccurrences:
        singleCandidateOccurrences ?? this.singleCandidateOccurrences,
  );
  ScopedLemmaFreqData copyWithCompanion(i1.ScopedLemmaFreqCompanion data) {
    return ScopedLemmaFreqData(
      workId: data.workId.present ? data.workId.value : this.workId,
      dictionaryRef: data.dictionaryRef.present
          ? data.dictionaryRef.value
          : this.dictionaryRef,
      possibleOccurrences: data.possibleOccurrences.present
          ? data.possibleOccurrences.value
          : this.possibleOccurrences,
      singleCandidateOccurrences: data.singleCandidateOccurrences.present
          ? data.singleCandidateOccurrences.value
          : this.singleCandidateOccurrences,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScopedLemmaFreqData(')
          ..write('workId: $workId, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('possibleOccurrences: $possibleOccurrences, ')
          ..write('singleCandidateOccurrences: $singleCandidateOccurrences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workId,
    dictionaryRef,
    possibleOccurrences,
    singleCandidateOccurrences,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ScopedLemmaFreqData &&
          other.workId == this.workId &&
          other.dictionaryRef == this.dictionaryRef &&
          other.possibleOccurrences == this.possibleOccurrences &&
          other.singleCandidateOccurrences == this.singleCandidateOccurrences);
}

class ScopedLemmaFreqCompanion
    extends i0.UpdateCompanion<i1.ScopedLemmaFreqData> {
  final i0.Value<String> workId;
  final i0.Value<String> dictionaryRef;
  final i0.Value<int> possibleOccurrences;
  final i0.Value<int> singleCandidateOccurrences;
  const ScopedLemmaFreqCompanion({
    this.workId = const i0.Value.absent(),
    this.dictionaryRef = const i0.Value.absent(),
    this.possibleOccurrences = const i0.Value.absent(),
    this.singleCandidateOccurrences = const i0.Value.absent(),
  });
  ScopedLemmaFreqCompanion.insert({
    required String workId,
    required String dictionaryRef,
    required int possibleOccurrences,
    required int singleCandidateOccurrences,
  }) : workId = i0.Value(workId),
       dictionaryRef = i0.Value(dictionaryRef),
       possibleOccurrences = i0.Value(possibleOccurrences),
       singleCandidateOccurrences = i0.Value(singleCandidateOccurrences);
  static i0.Insertable<i1.ScopedLemmaFreqData> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? dictionaryRef,
    i0.Expression<int>? possibleOccurrences,
    i0.Expression<int>? singleCandidateOccurrences,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (dictionaryRef != null) 'dictionaryRef': dictionaryRef,
      if (possibleOccurrences != null)
        'possibleOccurrences': possibleOccurrences,
      if (singleCandidateOccurrences != null)
        'singleCandidateOccurrences': singleCandidateOccurrences,
    });
  }

  i1.ScopedLemmaFreqCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? dictionaryRef,
    i0.Value<int>? possibleOccurrences,
    i0.Value<int>? singleCandidateOccurrences,
  }) {
    return i1.ScopedLemmaFreqCompanion(
      workId: workId ?? this.workId,
      dictionaryRef: dictionaryRef ?? this.dictionaryRef,
      possibleOccurrences: possibleOccurrences ?? this.possibleOccurrences,
      singleCandidateOccurrences:
          singleCandidateOccurrences ?? this.singleCandidateOccurrences,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (dictionaryRef.present) {
      map['dictionaryRef'] = i0.Variable<String>(dictionaryRef.value);
    }
    if (possibleOccurrences.present) {
      map['possibleOccurrences'] = i0.Variable<int>(possibleOccurrences.value);
    }
    if (singleCandidateOccurrences.present) {
      map['singleCandidateOccurrences'] = i0.Variable<int>(
        singleCandidateOccurrences.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScopedLemmaFreqCompanion(')
          ..write('workId: $workId, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('possibleOccurrences: $possibleOccurrences, ')
          ..write('singleCandidateOccurrences: $singleCandidateOccurrences')
          ..write(')'))
        .toString();
  }
}

class ScopedFreqTotals extends i0.Table
    with i0.TableInfo<ScopedFreqTotals, i1.ScopedFreqTotal> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ScopedFreqTotals(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _workIdMeta = const i0.VerificationMeta(
    'workId',
  );
  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _totalFormsMeta = const i0.VerificationMeta(
    'totalForms',
  );
  late final i0.GeneratedColumn<int> totalForms = i0.GeneratedColumn<int>(
    'totalForms',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _totalMacronFormsMeta =
      const i0.VerificationMeta('totalMacronForms');
  late final i0.GeneratedColumn<int> totalMacronForms = i0.GeneratedColumn<int>(
    'totalMacronForms',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _totalLemmasMeta = const i0.VerificationMeta(
    'totalLemmas',
  );
  late final i0.GeneratedColumn<int> totalLemmas = i0.GeneratedColumn<int>(
    'totalLemmas',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _totalTokensMeta = const i0.VerificationMeta(
    'totalTokens',
  );
  late final i0.GeneratedColumn<int> totalTokens = i0.GeneratedColumn<int>(
    'totalTokens',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _noCandidateTokensMeta =
      const i0.VerificationMeta('noCandidateTokens');
  late final i0.GeneratedColumn<int> noCandidateTokens =
      i0.GeneratedColumn<int>(
        'noCandidateTokens',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL CHECK (noCandidateTokens >= 0)',
      );
  static const i0.VerificationMeta _singleCandidateTokensMeta =
      const i0.VerificationMeta('singleCandidateTokens');
  late final i0.GeneratedColumn<int> singleCandidateTokens =
      i0.GeneratedColumn<int>(
        'singleCandidateTokens',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL CHECK (singleCandidateTokens >= 0)',
      );
  static const i0.VerificationMeta _multipleCandidateTokensMeta =
      const i0.VerificationMeta('multipleCandidateTokens');
  late final i0.GeneratedColumn<int> multipleCandidateTokens =
      i0.GeneratedColumn<int>(
        'multipleCandidateTokens',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL CHECK (multipleCandidateTokens >= 0)',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    totalForms,
    totalMacronForms,
    totalLemmas,
    totalTokens,
    noCandidateTokens,
    singleCandidateTokens,
    multipleCandidateTokens,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ScopedFreqTotals';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ScopedFreqTotal> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(
        _workIdMeta,
        workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('totalForms')) {
      context.handle(
        _totalFormsMeta,
        totalForms.isAcceptableOrUnknown(data['totalForms']!, _totalFormsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalFormsMeta);
    }
    if (data.containsKey('totalMacronForms')) {
      context.handle(
        _totalMacronFormsMeta,
        totalMacronForms.isAcceptableOrUnknown(
          data['totalMacronForms']!,
          _totalMacronFormsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalMacronFormsMeta);
    }
    if (data.containsKey('totalLemmas')) {
      context.handle(
        _totalLemmasMeta,
        totalLemmas.isAcceptableOrUnknown(
          data['totalLemmas']!,
          _totalLemmasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLemmasMeta);
    }
    if (data.containsKey('totalTokens')) {
      context.handle(
        _totalTokensMeta,
        totalTokens.isAcceptableOrUnknown(
          data['totalTokens']!,
          _totalTokensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalTokensMeta);
    }
    if (data.containsKey('noCandidateTokens')) {
      context.handle(
        _noCandidateTokensMeta,
        noCandidateTokens.isAcceptableOrUnknown(
          data['noCandidateTokens']!,
          _noCandidateTokensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_noCandidateTokensMeta);
    }
    if (data.containsKey('singleCandidateTokens')) {
      context.handle(
        _singleCandidateTokensMeta,
        singleCandidateTokens.isAcceptableOrUnknown(
          data['singleCandidateTokens']!,
          _singleCandidateTokensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_singleCandidateTokensMeta);
    }
    if (data.containsKey('multipleCandidateTokens')) {
      context.handle(
        _multipleCandidateTokensMeta,
        multipleCandidateTokens.isAcceptableOrUnknown(
          data['multipleCandidateTokens']!,
          _multipleCandidateTokensMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_multipleCandidateTokensMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId};
  @override
  i1.ScopedFreqTotal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ScopedFreqTotal(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      totalForms: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}totalForms'],
      )!,
      totalMacronForms: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}totalMacronForms'],
      )!,
      totalLemmas: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}totalLemmas'],
      )!,
      totalTokens: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}totalTokens'],
      )!,
      noCandidateTokens: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}noCandidateTokens'],
      )!,
      singleCandidateTokens: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}singleCandidateTokens'],
      )!,
      multipleCandidateTokens: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}multipleCandidateTokens'],
      )!,
    );
  }

  @override
  ScopedFreqTotals createAlias(String alias) {
    return ScopedFreqTotals(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId)',
    'CHECK(totalTokens = noCandidateTokens + singleCandidateTokens + multipleCandidateTokens)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ScopedFreqTotal extends i0.DataClass
    implements i0.Insertable<i1.ScopedFreqTotal> {
  final String workId;
  final int totalForms;

  /// don't aggregate, just for reference
  final int totalMacronForms;

  /// don't aggregate, just for reference
  final int totalLemmas;

  /// don't aggregate, just for reference
  final int totalTokens;
  final int noCandidateTokens;
  final int singleCandidateTokens;
  final int multipleCandidateTokens;
  const ScopedFreqTotal({
    required this.workId,
    required this.totalForms,
    required this.totalMacronForms,
    required this.totalLemmas,
    required this.totalTokens,
    required this.noCandidateTokens,
    required this.singleCandidateTokens,
    required this.multipleCandidateTokens,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['totalForms'] = i0.Variable<int>(totalForms);
    map['totalMacronForms'] = i0.Variable<int>(totalMacronForms);
    map['totalLemmas'] = i0.Variable<int>(totalLemmas);
    map['totalTokens'] = i0.Variable<int>(totalTokens);
    map['noCandidateTokens'] = i0.Variable<int>(noCandidateTokens);
    map['singleCandidateTokens'] = i0.Variable<int>(singleCandidateTokens);
    map['multipleCandidateTokens'] = i0.Variable<int>(multipleCandidateTokens);
    return map;
  }

  i1.ScopedFreqTotalsCompanion toCompanion(bool nullToAbsent) {
    return i1.ScopedFreqTotalsCompanion(
      workId: i0.Value(workId),
      totalForms: i0.Value(totalForms),
      totalMacronForms: i0.Value(totalMacronForms),
      totalLemmas: i0.Value(totalLemmas),
      totalTokens: i0.Value(totalTokens),
      noCandidateTokens: i0.Value(noCandidateTokens),
      singleCandidateTokens: i0.Value(singleCandidateTokens),
      multipleCandidateTokens: i0.Value(multipleCandidateTokens),
    );
  }

  factory ScopedFreqTotal.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ScopedFreqTotal(
      workId: serializer.fromJson<String>(json['workId']),
      totalForms: serializer.fromJson<int>(json['totalForms']),
      totalMacronForms: serializer.fromJson<int>(json['totalMacronForms']),
      totalLemmas: serializer.fromJson<int>(json['totalLemmas']),
      totalTokens: serializer.fromJson<int>(json['totalTokens']),
      noCandidateTokens: serializer.fromJson<int>(json['noCandidateTokens']),
      singleCandidateTokens: serializer.fromJson<int>(
        json['singleCandidateTokens'],
      ),
      multipleCandidateTokens: serializer.fromJson<int>(
        json['multipleCandidateTokens'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'totalForms': serializer.toJson<int>(totalForms),
      'totalMacronForms': serializer.toJson<int>(totalMacronForms),
      'totalLemmas': serializer.toJson<int>(totalLemmas),
      'totalTokens': serializer.toJson<int>(totalTokens),
      'noCandidateTokens': serializer.toJson<int>(noCandidateTokens),
      'singleCandidateTokens': serializer.toJson<int>(singleCandidateTokens),
      'multipleCandidateTokens': serializer.toJson<int>(
        multipleCandidateTokens,
      ),
    };
  }

  i1.ScopedFreqTotal copyWith({
    String? workId,
    int? totalForms,
    int? totalMacronForms,
    int? totalLemmas,
    int? totalTokens,
    int? noCandidateTokens,
    int? singleCandidateTokens,
    int? multipleCandidateTokens,
  }) => i1.ScopedFreqTotal(
    workId: workId ?? this.workId,
    totalForms: totalForms ?? this.totalForms,
    totalMacronForms: totalMacronForms ?? this.totalMacronForms,
    totalLemmas: totalLemmas ?? this.totalLemmas,
    totalTokens: totalTokens ?? this.totalTokens,
    noCandidateTokens: noCandidateTokens ?? this.noCandidateTokens,
    singleCandidateTokens: singleCandidateTokens ?? this.singleCandidateTokens,
    multipleCandidateTokens:
        multipleCandidateTokens ?? this.multipleCandidateTokens,
  );
  ScopedFreqTotal copyWithCompanion(i1.ScopedFreqTotalsCompanion data) {
    return ScopedFreqTotal(
      workId: data.workId.present ? data.workId.value : this.workId,
      totalForms: data.totalForms.present
          ? data.totalForms.value
          : this.totalForms,
      totalMacronForms: data.totalMacronForms.present
          ? data.totalMacronForms.value
          : this.totalMacronForms,
      totalLemmas: data.totalLemmas.present
          ? data.totalLemmas.value
          : this.totalLemmas,
      totalTokens: data.totalTokens.present
          ? data.totalTokens.value
          : this.totalTokens,
      noCandidateTokens: data.noCandidateTokens.present
          ? data.noCandidateTokens.value
          : this.noCandidateTokens,
      singleCandidateTokens: data.singleCandidateTokens.present
          ? data.singleCandidateTokens.value
          : this.singleCandidateTokens,
      multipleCandidateTokens: data.multipleCandidateTokens.present
          ? data.multipleCandidateTokens.value
          : this.multipleCandidateTokens,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScopedFreqTotal(')
          ..write('workId: $workId, ')
          ..write('totalForms: $totalForms, ')
          ..write('totalMacronForms: $totalMacronForms, ')
          ..write('totalLemmas: $totalLemmas, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('noCandidateTokens: $noCandidateTokens, ')
          ..write('singleCandidateTokens: $singleCandidateTokens, ')
          ..write('multipleCandidateTokens: $multipleCandidateTokens')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workId,
    totalForms,
    totalMacronForms,
    totalLemmas,
    totalTokens,
    noCandidateTokens,
    singleCandidateTokens,
    multipleCandidateTokens,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ScopedFreqTotal &&
          other.workId == this.workId &&
          other.totalForms == this.totalForms &&
          other.totalMacronForms == this.totalMacronForms &&
          other.totalLemmas == this.totalLemmas &&
          other.totalTokens == this.totalTokens &&
          other.noCandidateTokens == this.noCandidateTokens &&
          other.singleCandidateTokens == this.singleCandidateTokens &&
          other.multipleCandidateTokens == this.multipleCandidateTokens);
}

class ScopedFreqTotalsCompanion extends i0.UpdateCompanion<i1.ScopedFreqTotal> {
  final i0.Value<String> workId;
  final i0.Value<int> totalForms;
  final i0.Value<int> totalMacronForms;
  final i0.Value<int> totalLemmas;
  final i0.Value<int> totalTokens;
  final i0.Value<int> noCandidateTokens;
  final i0.Value<int> singleCandidateTokens;
  final i0.Value<int> multipleCandidateTokens;
  const ScopedFreqTotalsCompanion({
    this.workId = const i0.Value.absent(),
    this.totalForms = const i0.Value.absent(),
    this.totalMacronForms = const i0.Value.absent(),
    this.totalLemmas = const i0.Value.absent(),
    this.totalTokens = const i0.Value.absent(),
    this.noCandidateTokens = const i0.Value.absent(),
    this.singleCandidateTokens = const i0.Value.absent(),
    this.multipleCandidateTokens = const i0.Value.absent(),
  });
  ScopedFreqTotalsCompanion.insert({
    required String workId,
    required int totalForms,
    required int totalMacronForms,
    required int totalLemmas,
    required int totalTokens,
    required int noCandidateTokens,
    required int singleCandidateTokens,
    required int multipleCandidateTokens,
  }) : workId = i0.Value(workId),
       totalForms = i0.Value(totalForms),
       totalMacronForms = i0.Value(totalMacronForms),
       totalLemmas = i0.Value(totalLemmas),
       totalTokens = i0.Value(totalTokens),
       noCandidateTokens = i0.Value(noCandidateTokens),
       singleCandidateTokens = i0.Value(singleCandidateTokens),
       multipleCandidateTokens = i0.Value(multipleCandidateTokens);
  static i0.Insertable<i1.ScopedFreqTotal> custom({
    i0.Expression<String>? workId,
    i0.Expression<int>? totalForms,
    i0.Expression<int>? totalMacronForms,
    i0.Expression<int>? totalLemmas,
    i0.Expression<int>? totalTokens,
    i0.Expression<int>? noCandidateTokens,
    i0.Expression<int>? singleCandidateTokens,
    i0.Expression<int>? multipleCandidateTokens,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (totalForms != null) 'totalForms': totalForms,
      if (totalMacronForms != null) 'totalMacronForms': totalMacronForms,
      if (totalLemmas != null) 'totalLemmas': totalLemmas,
      if (totalTokens != null) 'totalTokens': totalTokens,
      if (noCandidateTokens != null) 'noCandidateTokens': noCandidateTokens,
      if (singleCandidateTokens != null)
        'singleCandidateTokens': singleCandidateTokens,
      if (multipleCandidateTokens != null)
        'multipleCandidateTokens': multipleCandidateTokens,
    });
  }

  i1.ScopedFreqTotalsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<int>? totalForms,
    i0.Value<int>? totalMacronForms,
    i0.Value<int>? totalLemmas,
    i0.Value<int>? totalTokens,
    i0.Value<int>? noCandidateTokens,
    i0.Value<int>? singleCandidateTokens,
    i0.Value<int>? multipleCandidateTokens,
  }) {
    return i1.ScopedFreqTotalsCompanion(
      workId: workId ?? this.workId,
      totalForms: totalForms ?? this.totalForms,
      totalMacronForms: totalMacronForms ?? this.totalMacronForms,
      totalLemmas: totalLemmas ?? this.totalLemmas,
      totalTokens: totalTokens ?? this.totalTokens,
      noCandidateTokens: noCandidateTokens ?? this.noCandidateTokens,
      singleCandidateTokens:
          singleCandidateTokens ?? this.singleCandidateTokens,
      multipleCandidateTokens:
          multipleCandidateTokens ?? this.multipleCandidateTokens,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (totalForms.present) {
      map['totalForms'] = i0.Variable<int>(totalForms.value);
    }
    if (totalMacronForms.present) {
      map['totalMacronForms'] = i0.Variable<int>(totalMacronForms.value);
    }
    if (totalLemmas.present) {
      map['totalLemmas'] = i0.Variable<int>(totalLemmas.value);
    }
    if (totalTokens.present) {
      map['totalTokens'] = i0.Variable<int>(totalTokens.value);
    }
    if (noCandidateTokens.present) {
      map['noCandidateTokens'] = i0.Variable<int>(noCandidateTokens.value);
    }
    if (singleCandidateTokens.present) {
      map['singleCandidateTokens'] = i0.Variable<int>(
        singleCandidateTokens.value,
      );
    }
    if (multipleCandidateTokens.present) {
      map['multipleCandidateTokens'] = i0.Variable<int>(
        multipleCandidateTokens.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScopedFreqTotalsCompanion(')
          ..write('workId: $workId, ')
          ..write('totalForms: $totalForms, ')
          ..write('totalMacronForms: $totalMacronForms, ')
          ..write('totalLemmas: $totalLemmas, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('noCandidateTokens: $noCandidateTokens, ')
          ..write('singleCandidateTokens: $singleCandidateTokens, ')
          ..write('multipleCandidateTokens: $multipleCandidateTokens')
          ..write(')'))
        .toString();
  }
}

class WordFrequencyDrift extends i2.ModularAccessor {
  WordFrequencyDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i3.FormFrequencyRow> getFormFrequenciesDesc({
    required List<String> workIds,
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedworkIds = $expandVar($arrayStartIndex, workIds.length);
    $arrayStartIndex += workIds.length;
    return customSelect(
      'WITH Page AS (SELECT form, SUM(occurrences) AS occurrences FROM ScopedFormFreq WHERE workId IN ($expandedworkIds) GROUP BY form ORDER BY occurrences DESC, form LIMIT ?1 OFFSET ?2) SELECT Page.form, Page.occurrences, (SELECT GROUP_CONCAT(DISTINCT ScopedFormLemmaFreq.dictionaryRef) FROM ScopedFormLemmaFreq WHERE ScopedFormLemmaFreq.form = Page.form AND ScopedFormLemmaFreq.workId IN ($expandedworkIds)) AS possibleLemmas FROM Page ORDER BY Page.occurrences DESC, Page.form',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in workIds) i0.Variable<String>($),
      ],
      readsFrom: {scopedFormFreq, scopedFormLemmaFreq},
    ).map(
      (i0.QueryRow row) => i3.FormFrequencyRow.fromFormSql(
        form: row.read<String>('form'),
        occurrences: row.readNullable<int>('occurrences'),
        possibleLemmas: row.readNullable<String>('possibleLemmas'),
      ),
    );
  }

  i0.Selectable<i3.FormFrequencyRow> getFormFrequenciesAsc({
    required List<String> workIds,
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedworkIds = $expandVar($arrayStartIndex, workIds.length);
    $arrayStartIndex += workIds.length;
    return customSelect(
      'WITH Page AS (SELECT form, SUM(occurrences) AS occurrences FROM ScopedFormFreq WHERE workId IN ($expandedworkIds) GROUP BY form ORDER BY occurrences ASC, form LIMIT ?1 OFFSET ?2) SELECT Page.form, Page.occurrences, (SELECT GROUP_CONCAT(DISTINCT ScopedFormLemmaFreq.dictionaryRef) FROM ScopedFormLemmaFreq WHERE ScopedFormLemmaFreq.form = Page.form AND ScopedFormLemmaFreq.workId IN ($expandedworkIds)) AS possibleLemmas FROM Page ORDER BY Page.occurrences ASC, Page.form',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in workIds) i0.Variable<String>($),
      ],
      readsFrom: {scopedFormFreq, scopedFormLemmaFreq},
    ).map(
      (i0.QueryRow row) => i3.FormFrequencyRow.fromFormSql(
        form: row.read<String>('form'),
        occurrences: row.readNullable<int>('occurrences'),
        possibleLemmas: row.readNullable<String>('possibleLemmas'),
      ),
    );
  }

  i0.Selectable<i3.FormFrequencyRow> getMacronFormFrequenciesDesc({
    required List<String> workIds,
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedworkIds = $expandVar($arrayStartIndex, workIds.length);
    $arrayStartIndex += workIds.length;
    return customSelect(
      'WITH Page AS (SELECT macronForm, MIN(form) AS form, SUM(occurrences) AS occurrences FROM ScopedFormFreq WHERE workId IN ($expandedworkIds) GROUP BY macronForm ORDER BY occurrences DESC, macronForm LIMIT ?1 OFFSET ?2) SELECT Page.macronForm, Page.form, Page.occurrences, (SELECT GROUP_CONCAT(DISTINCT ScopedFormLemmaFreq.dictionaryRef) FROM ScopedFormLemmaFreq WHERE ScopedFormLemmaFreq.macronForm = Page.macronForm AND ScopedFormLemmaFreq.workId IN ($expandedworkIds)) AS possibleLemmas FROM Page ORDER BY Page.occurrences DESC, Page.macronForm',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in workIds) i0.Variable<String>($),
      ],
      readsFrom: {scopedFormFreq, scopedFormLemmaFreq},
    ).map(
      (i0.QueryRow row) => i3.FormFrequencyRow.fromMacronFormSql(
        macronForm: row.read<String>('macronForm'),
        form: row.readNullable<String>('form'),
        occurrences: row.readNullable<int>('occurrences'),
        possibleLemmas: row.readNullable<String>('possibleLemmas'),
      ),
    );
  }

  i0.Selectable<i3.FormFrequencyRow> getMacronFormFrequenciesAsc({
    required List<String> workIds,
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedworkIds = $expandVar($arrayStartIndex, workIds.length);
    $arrayStartIndex += workIds.length;
    return customSelect(
      'WITH Page AS (SELECT macronForm, MIN(form) AS form, SUM(occurrences) AS occurrences FROM ScopedFormFreq WHERE workId IN ($expandedworkIds) GROUP BY macronForm ORDER BY occurrences ASC, macronForm LIMIT ?1 OFFSET ?2) SELECT Page.macronForm, Page.form, Page.occurrences, (SELECT GROUP_CONCAT(DISTINCT ScopedFormLemmaFreq.dictionaryRef) FROM ScopedFormLemmaFreq WHERE ScopedFormLemmaFreq.macronForm = Page.macronForm AND ScopedFormLemmaFreq.workId IN ($expandedworkIds)) AS possibleLemmas FROM Page ORDER BY Page.occurrences ASC, Page.macronForm',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in workIds) i0.Variable<String>($),
      ],
      readsFrom: {scopedFormFreq, scopedFormLemmaFreq},
    ).map(
      (i0.QueryRow row) => i3.FormFrequencyRow.fromMacronFormSql(
        macronForm: row.read<String>('macronForm'),
        form: row.readNullable<String>('form'),
        occurrences: row.readNullable<int>('occurrences'),
        possibleLemmas: row.readNullable<String>('possibleLemmas'),
      ),
    );
  }

  i0.Selectable<i3.LemmaFrequencyRow> getLemmaFrequenciesDesc(
    List<String> var1, {
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT dictionaryRef, SUM(possibleOccurrences) AS possibleOccurrences, SUM(singleCandidateOccurrences) AS singleCandidateOccurrences FROM ScopedLemmaFreq WHERE workId IN ($expandedvar1) GROUP BY dictionaryRef ORDER BY possibleOccurrences DESC, dictionaryRef LIMIT ?1 OFFSET ?2',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in var1) i0.Variable<String>($),
      ],
      readsFrom: {scopedLemmaFreq},
    ).map(
      (i0.QueryRow row) => i3.LemmaFrequencyRow.fromLemmaSql(
        dictionaryRef: row.read<String>('dictionaryRef'),
        possibleOccurrences: row.readNullable<int>('possibleOccurrences'),
        singleCandidateOccurrences: row.readNullable<int>(
          'singleCandidateOccurrences',
        ),
      ),
    );
  }

  i0.Selectable<i3.LemmaFrequencyRow> getLemmaFrequenciesAsc(
    List<String> var1, {
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT dictionaryRef, SUM(possibleOccurrences) AS possibleOccurrences, SUM(singleCandidateOccurrences) AS singleCandidateOccurrences FROM ScopedLemmaFreq WHERE workId IN ($expandedvar1) GROUP BY dictionaryRef ORDER BY possibleOccurrences ASC, dictionaryRef LIMIT ?1 OFFSET ?2',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in var1) i0.Variable<String>($),
      ],
      readsFrom: {scopedLemmaFreq},
    ).map(
      (i0.QueryRow row) => i3.LemmaFrequencyRow.fromLemmaSql(
        dictionaryRef: row.read<String>('dictionaryRef'),
        possibleOccurrences: row.readNullable<int>('possibleOccurrences'),
        singleCandidateOccurrences: row.readNullable<int>(
          'singleCandidateOccurrences',
        ),
      ),
    );
  }

  i0.Selectable<i3.FrequencyCoverage> getFrequencyCoverage(List<String> var1) {
    var $arrayStartIndex = 1;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT SUM(totalTokens) AS totalTokens, SUM(noCandidateTokens) AS noCandidateTokens, SUM(singleCandidateTokens) AS singleCandidateTokens, SUM(multipleCandidateTokens) AS multipleCandidateTokens FROM ScopedFreqTotals WHERE workId IN ($expandedvar1)',
      variables: [for (var $ in var1) i0.Variable<String>($)],
      readsFrom: {scopedFreqTotals},
    ).map(
      (i0.QueryRow row) => i3.FrequencyCoverage(
        totalTokens: row.readNullable<int>('totalTokens'),
        noCandidateTokens: row.readNullable<int>('noCandidateTokens'),
        singleCandidateTokens: row.readNullable<int>('singleCandidateTokens'),
        multipleCandidateTokens: row.readNullable<int>(
          'multipleCandidateTokens',
        ),
      ),
    );
  }

  i0.Selectable<int> getTotalForms(List<String> var1) {
    var $arrayStartIndex = 1;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT COUNT(DISTINCT form) AS totalForms FROM ScopedFormFreq WHERE workId IN ($expandedvar1)',
      variables: [for (var $ in var1) i0.Variable<String>($)],
      readsFrom: {scopedFormFreq},
    ).map((i0.QueryRow row) => row.read<int>('totalForms'));
  }

  i0.Selectable<int> getTotalMacronForms(List<String> var1) {
    var $arrayStartIndex = 1;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT COUNT(DISTINCT macronForm) AS totalMacronForms FROM ScopedFormFreq WHERE workId IN ($expandedvar1)',
      variables: [for (var $ in var1) i0.Variable<String>($)],
      readsFrom: {scopedFormFreq},
    ).map((i0.QueryRow row) => row.read<int>('totalMacronForms'));
  }

  i0.Selectable<int> getTotalLemmas(List<String> var1) {
    var $arrayStartIndex = 1;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT COUNT(DISTINCT dictionaryRef) AS totalLemmas FROM ScopedLemmaFreq WHERE workId IN ($expandedvar1)',
      variables: [for (var $ in var1) i0.Variable<String>($)],
      readsFrom: {scopedLemmaFreq},
    ).map((i0.QueryRow row) => row.read<int>('totalLemmas'));
  }

  i0.Selectable<i4.FrequencyMorphCandidate> getFormMorphIdentities({
    required List<String> workIds,
    required String form,
  }) {
    var $arrayStartIndex = 2;
    final expandedworkIds = $expandVar($arrayStartIndex, workIds.length);
    $arrayStartIndex += workIds.length;
    return customSelect(
      'SELECT DISTINCT form, morphForm, morphItem, dictionaryRef FROM ResolvedFreqMorphForms WHERE workId IN ($expandedworkIds) AND form = ?1 ORDER BY morphForm, morphItem',
      variables: [
        i0.Variable<String>(form),
        for (var $ in workIds) i0.Variable<String>($),
      ],
      readsFrom: {resolvedFreqMorphForms},
    ).map(
      (i0.QueryRow row) => i4.FrequencyMorphCandidate(
        form: row.read<String>('form'),
        morphForm: row.read<String>('morphForm'),
        morphItem: row.read<int>('morphItem'),
        dictionaryRef: row.read<String>('dictionaryRef'),
      ),
    );
  }

  i0.Selectable<i4.FrequencyMorphCandidate> getMacronFormMorphIdentities({
    required List<String> workIds,
    required String form,
    required String macronForm,
  }) {
    var $arrayStartIndex = 3;
    final expandedworkIds = $expandVar($arrayStartIndex, workIds.length);
    $arrayStartIndex += workIds.length;
    return customSelect(
      'SELECT DISTINCT form, morphForm, morphItem, dictionaryRef FROM ResolvedFreqMorphForms WHERE workId IN ($expandedworkIds) AND form = ?1 AND macronForm = ?2 ORDER BY morphForm, morphItem',
      variables: [
        i0.Variable<String>(form),
        i0.Variable<String>(macronForm),
        for (var $ in workIds) i0.Variable<String>($),
      ],
      readsFrom: {resolvedFreqMorphForms},
    ).map(
      (i0.QueryRow row) => i4.FrequencyMorphCandidate(
        form: row.read<String>('form'),
        morphForm: row.read<String>('morphForm'),
        morphItem: row.read<int>('morphItem'),
        dictionaryRef: row.read<String>('dictionaryRef'),
      ),
    );
  }

  i0.Selectable<i4.FrequencyMorphCandidate> getLemmaMorphIdentities({
    required List<String> workIds,
    required String dictionaryRef,
  }) {
    var $arrayStartIndex = 2;
    final expandedworkIds = $expandVar($arrayStartIndex, workIds.length);
    $arrayStartIndex += workIds.length;
    return customSelect(
      'SELECT DISTINCT form, morphForm, morphItem, dictionaryRef FROM ResolvedFreqMorphForms WHERE workId IN ($expandedworkIds) AND dictionaryRef = ?1 ORDER BY morphForm, morphItem',
      variables: [
        i0.Variable<String>(dictionaryRef),
        for (var $ in workIds) i0.Variable<String>($),
      ],
      readsFrom: {resolvedFreqMorphForms},
    ).map(
      (i0.QueryRow row) => i4.FrequencyMorphCandidate(
        form: row.read<String>('form'),
        morphForm: row.read<String>('morphForm'),
        morphItem: row.read<int>('morphItem'),
        dictionaryRef: row.read<String>('dictionaryRef'),
      ),
    );
  }

  i1.ScopedFormFreq get scopedFormFreq => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ScopedFormFreq>('ScopedFormFreq');
  i1.ScopedFormLemmaFreq get scopedFormLemmaFreq => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ScopedFormLemmaFreq>('ScopedFormLemmaFreq');
  i1.ScopedLemmaFreq get scopedLemmaFreq => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ScopedLemmaFreq>('ScopedLemmaFreq');
  i1.ScopedFreqTotals get scopedFreqTotals => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ScopedFreqTotals>('ScopedFreqTotals');
  i1.ResolvedFreqMorphForms get resolvedFreqMorphForms =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.ResolvedFreqMorphForms>('ResolvedFreqMorphForms');
}
