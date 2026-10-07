// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/concordance/concordance.drift.dart'
    as i1;
import 'package:drift/internal/modular.dart' as i2;
import 'package:latin_reader/src/component/concordance/concordance_query.dart'
    as i3;
import 'package:latin_reader/src/component/concordance/grammar_values_api.dart'
    as i4;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart'
    as i5;
import 'package:latin_reader/src/component/library/library.drift.dart' as i6;

typedef $ConcordanceDetailsCreateCompanionBuilder =
    i1.ConcordanceDetailsCompanion Function({
      required String form,
      required int item,
      required String dictionaryRef,
    });
typedef $ConcordanceDetailsUpdateCompanionBuilder =
    i1.ConcordanceDetailsCompanion Function({
      i0.Value<String> form,
      i0.Value<int> item,
      i0.Value<String> dictionaryRef,
    });

class $ConcordanceDetailsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ConcordanceDetails> {
  $ConcordanceDetailsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ConcordanceDetailsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ConcordanceDetails> {
  $ConcordanceDetailsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get dictionaryRef => $composableBuilder(
    column: $table.dictionaryRef,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ConcordanceDetailsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ConcordanceDetails> {
  $ConcordanceDetailsAnnotationComposer({
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
    column: $table.dictionaryRef,
    builder: (column) => column,
  );
}

class $ConcordanceDetailsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ConcordanceDetails,
          i1.ConcordanceDetail,
          i1.$ConcordanceDetailsFilterComposer,
          i1.$ConcordanceDetailsOrderingComposer,
          i1.$ConcordanceDetailsAnnotationComposer,
          $ConcordanceDetailsCreateCompanionBuilder,
          $ConcordanceDetailsUpdateCompanionBuilder,
          (
            i1.ConcordanceDetail,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ConcordanceDetails,
              i1.ConcordanceDetail
            >,
          ),
          i1.ConcordanceDetail,
          i0.PrefetchHooks Function()
        > {
  $ConcordanceDetailsTableManager(
    i0.GeneratedDatabase db,
    i1.ConcordanceDetails table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ConcordanceDetailsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$ConcordanceDetailsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$ConcordanceDetailsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> form = const i0.Value.absent(),
                i0.Value<int> item = const i0.Value.absent(),
                i0.Value<String> dictionaryRef = const i0.Value.absent(),
              }) => i1.ConcordanceDetailsCompanion(
                form: form,
                item: item,
                dictionaryRef: dictionaryRef,
              ),
          createCompanionCallback:
              ({
                required String form,
                required int item,
                required String dictionaryRef,
              }) => i1.ConcordanceDetailsCompanion.insert(
                form: form,
                item: item,
                dictionaryRef: dictionaryRef,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ConcordanceDetailsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ConcordanceDetails,
      i1.ConcordanceDetail,
      i1.$ConcordanceDetailsFilterComposer,
      i1.$ConcordanceDetailsOrderingComposer,
      i1.$ConcordanceDetailsAnnotationComposer,
      $ConcordanceDetailsCreateCompanionBuilder,
      $ConcordanceDetailsUpdateCompanionBuilder,
      (
        i1.ConcordanceDetail,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ConcordanceDetails,
          i1.ConcordanceDetail
        >,
      ),
      i1.ConcordanceDetail,
      i0.PrefetchHooks Function()
    >;
typedef $ConcordanceDetailInflectionsCreateCompanionBuilder =
    i1.ConcordanceDetailInflectionsCompanion Function({
      required String form,
      required int item,
      required int cnt,
      required String partOfSpeech,
      i0.Value<String?> gramCase,
      i0.Value<String?> number,
      i0.Value<String?> gender,
      i0.Value<String?> declension,
      i0.Value<String?> person,
      i0.Value<String?> verbForm,
      i0.Value<String?> tense,
      i0.Value<String?> voice,
    });
typedef $ConcordanceDetailInflectionsUpdateCompanionBuilder =
    i1.ConcordanceDetailInflectionsCompanion Function({
      i0.Value<String> form,
      i0.Value<int> item,
      i0.Value<int> cnt,
      i0.Value<String> partOfSpeech,
      i0.Value<String?> gramCase,
      i0.Value<String?> number,
      i0.Value<String?> gender,
      i0.Value<String?> declension,
      i0.Value<String?> person,
      i0.Value<String?> verbForm,
      i0.Value<String?> tense,
      i0.Value<String?> voice,
    });

class $ConcordanceDetailInflectionsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ConcordanceDetailInflections> {
  $ConcordanceDetailInflectionsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get gramCase => $composableBuilder(
    column: $table.gramCase,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get declension => $composableBuilder(
    column: $table.declension,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get person => $composableBuilder(
    column: $table.person,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get verbForm => $composableBuilder(
    column: $table.verbForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get tense => $composableBuilder(
    column: $table.tense,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get voice => $composableBuilder(
    column: $table.voice,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ConcordanceDetailInflectionsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ConcordanceDetailInflections> {
  $ConcordanceDetailInflectionsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get gramCase => $composableBuilder(
    column: $table.gramCase,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get declension => $composableBuilder(
    column: $table.declension,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get person => $composableBuilder(
    column: $table.person,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get verbForm => $composableBuilder(
    column: $table.verbForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get tense => $composableBuilder(
    column: $table.tense,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get voice => $composableBuilder(
    column: $table.voice,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ConcordanceDetailInflectionsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.ConcordanceDetailInflections> {
  $ConcordanceDetailInflectionsAnnotationComposer({
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
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get gramCase =>
      $composableBuilder(column: $table.gramCase, builder: (column) => column);

  i0.GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  i0.GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  i0.GeneratedColumn<String> get declension => $composableBuilder(
    column: $table.declension,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get person =>
      $composableBuilder(column: $table.person, builder: (column) => column);

  i0.GeneratedColumn<String> get verbForm =>
      $composableBuilder(column: $table.verbForm, builder: (column) => column);

  i0.GeneratedColumn<String> get tense =>
      $composableBuilder(column: $table.tense, builder: (column) => column);

  i0.GeneratedColumn<String> get voice =>
      $composableBuilder(column: $table.voice, builder: (column) => column);
}

class $ConcordanceDetailInflectionsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ConcordanceDetailInflections,
          i1.ConcordanceDetailInflection,
          i1.$ConcordanceDetailInflectionsFilterComposer,
          i1.$ConcordanceDetailInflectionsOrderingComposer,
          i1.$ConcordanceDetailInflectionsAnnotationComposer,
          $ConcordanceDetailInflectionsCreateCompanionBuilder,
          $ConcordanceDetailInflectionsUpdateCompanionBuilder,
          (
            i1.ConcordanceDetailInflection,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ConcordanceDetailInflections,
              i1.ConcordanceDetailInflection
            >,
          ),
          i1.ConcordanceDetailInflection,
          i0.PrefetchHooks Function()
        > {
  $ConcordanceDetailInflectionsTableManager(
    i0.GeneratedDatabase db,
    i1.ConcordanceDetailInflections table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ConcordanceDetailInflectionsFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              i1.$ConcordanceDetailInflectionsOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$ConcordanceDetailInflectionsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<String> form = const i0.Value.absent(),
                i0.Value<int> item = const i0.Value.absent(),
                i0.Value<int> cnt = const i0.Value.absent(),
                i0.Value<String> partOfSpeech = const i0.Value.absent(),
                i0.Value<String?> gramCase = const i0.Value.absent(),
                i0.Value<String?> number = const i0.Value.absent(),
                i0.Value<String?> gender = const i0.Value.absent(),
                i0.Value<String?> declension = const i0.Value.absent(),
                i0.Value<String?> person = const i0.Value.absent(),
                i0.Value<String?> verbForm = const i0.Value.absent(),
                i0.Value<String?> tense = const i0.Value.absent(),
                i0.Value<String?> voice = const i0.Value.absent(),
              }) => i1.ConcordanceDetailInflectionsCompanion(
                form: form,
                item: item,
                cnt: cnt,
                partOfSpeech: partOfSpeech,
                gramCase: gramCase,
                number: number,
                gender: gender,
                declension: declension,
                person: person,
                verbForm: verbForm,
                tense: tense,
                voice: voice,
              ),
          createCompanionCallback:
              ({
                required String form,
                required int item,
                required int cnt,
                required String partOfSpeech,
                i0.Value<String?> gramCase = const i0.Value.absent(),
                i0.Value<String?> number = const i0.Value.absent(),
                i0.Value<String?> gender = const i0.Value.absent(),
                i0.Value<String?> declension = const i0.Value.absent(),
                i0.Value<String?> person = const i0.Value.absent(),
                i0.Value<String?> verbForm = const i0.Value.absent(),
                i0.Value<String?> tense = const i0.Value.absent(),
                i0.Value<String?> voice = const i0.Value.absent(),
              }) => i1.ConcordanceDetailInflectionsCompanion.insert(
                form: form,
                item: item,
                cnt: cnt,
                partOfSpeech: partOfSpeech,
                gramCase: gramCase,
                number: number,
                gender: gender,
                declension: declension,
                person: person,
                verbForm: verbForm,
                tense: tense,
                voice: voice,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ConcordanceDetailInflectionsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ConcordanceDetailInflections,
      i1.ConcordanceDetailInflection,
      i1.$ConcordanceDetailInflectionsFilterComposer,
      i1.$ConcordanceDetailInflectionsOrderingComposer,
      i1.$ConcordanceDetailInflectionsAnnotationComposer,
      $ConcordanceDetailInflectionsCreateCompanionBuilder,
      $ConcordanceDetailInflectionsUpdateCompanionBuilder,
      (
        i1.ConcordanceDetailInflection,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ConcordanceDetailInflections,
          i1.ConcordanceDetailInflection
        >,
      ),
      i1.ConcordanceDetailInflection,
      i0.PrefetchHooks Function()
    >;
typedef $ConcordanceCountableWordCandidateAnalysesCreateCompanionBuilder =
    i1.ConcordanceCountableWordCandidateAnalysesCompanion Function({
      required String workId,
      required int idx,
      required int componentOrdinal,
      required String form,
      required int item,
    });
typedef $ConcordanceCountableWordCandidateAnalysesUpdateCompanionBuilder =
    i1.ConcordanceCountableWordCandidateAnalysesCompanion Function({
      i0.Value<String> workId,
      i0.Value<int> idx,
      i0.Value<int> componentOrdinal,
      i0.Value<String> form,
      i0.Value<int> item,
    });

class $ConcordanceCountableWordCandidateAnalysesFilterComposer
    extends
        i0.Composer<
          i0.GeneratedDatabase,
          i1.ConcordanceCountableWordCandidateAnalyses
        > {
  $ConcordanceCountableWordCandidateAnalysesFilterComposer({
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

  i0.ColumnFilters<int> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get componentOrdinal => $composableBuilder(
    column: $table.componentOrdinal,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $ConcordanceCountableWordCandidateAnalysesOrderingComposer
    extends
        i0.Composer<
          i0.GeneratedDatabase,
          i1.ConcordanceCountableWordCandidateAnalyses
        > {
  $ConcordanceCountableWordCandidateAnalysesOrderingComposer({
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

  i0.ColumnOrderings<int> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get componentOrdinal => $composableBuilder(
    column: $table.componentOrdinal,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $ConcordanceCountableWordCandidateAnalysesAnnotationComposer
    extends
        i0.Composer<
          i0.GeneratedDatabase,
          i1.ConcordanceCountableWordCandidateAnalyses
        > {
  $ConcordanceCountableWordCandidateAnalysesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<int> get idx =>
      $composableBuilder(column: $table.idx, builder: (column) => column);

  i0.GeneratedColumn<int> get componentOrdinal => $composableBuilder(
    column: $table.componentOrdinal,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  i0.GeneratedColumn<int> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);
}

class $ConcordanceCountableWordCandidateAnalysesTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.ConcordanceCountableWordCandidateAnalyses,
          i1.ConcordanceCountableWordCandidateAnalyse,
          i1.$ConcordanceCountableWordCandidateAnalysesFilterComposer,
          i1.$ConcordanceCountableWordCandidateAnalysesOrderingComposer,
          i1.$ConcordanceCountableWordCandidateAnalysesAnnotationComposer,
          $ConcordanceCountableWordCandidateAnalysesCreateCompanionBuilder,
          $ConcordanceCountableWordCandidateAnalysesUpdateCompanionBuilder,
          (
            i1.ConcordanceCountableWordCandidateAnalyse,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.ConcordanceCountableWordCandidateAnalyses,
              i1.ConcordanceCountableWordCandidateAnalyse
            >,
          ),
          i1.ConcordanceCountableWordCandidateAnalyse,
          i0.PrefetchHooks Function()
        > {
  $ConcordanceCountableWordCandidateAnalysesTableManager(
    i0.GeneratedDatabase db,
    i1.ConcordanceCountableWordCandidateAnalyses table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$ConcordanceCountableWordCandidateAnalysesFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              i1.$ConcordanceCountableWordCandidateAnalysesOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$ConcordanceCountableWordCandidateAnalysesAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<int> idx = const i0.Value.absent(),
                i0.Value<int> componentOrdinal = const i0.Value.absent(),
                i0.Value<String> form = const i0.Value.absent(),
                i0.Value<int> item = const i0.Value.absent(),
              }) => i1.ConcordanceCountableWordCandidateAnalysesCompanion(
                workId: workId,
                idx: idx,
                componentOrdinal: componentOrdinal,
                form: form,
                item: item,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required int idx,
                required int componentOrdinal,
                required String form,
                required int item,
              }) =>
                  i1.ConcordanceCountableWordCandidateAnalysesCompanion.insert(
                    workId: workId,
                    idx: idx,
                    componentOrdinal: componentOrdinal,
                    form: form,
                    item: item,
                  ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ConcordanceCountableWordCandidateAnalysesProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.ConcordanceCountableWordCandidateAnalyses,
      i1.ConcordanceCountableWordCandidateAnalyse,
      i1.$ConcordanceCountableWordCandidateAnalysesFilterComposer,
      i1.$ConcordanceCountableWordCandidateAnalysesOrderingComposer,
      i1.$ConcordanceCountableWordCandidateAnalysesAnnotationComposer,
      $ConcordanceCountableWordCandidateAnalysesCreateCompanionBuilder,
      $ConcordanceCountableWordCandidateAnalysesUpdateCompanionBuilder,
      (
        i1.ConcordanceCountableWordCandidateAnalyse,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.ConcordanceCountableWordCandidateAnalyses,
          i1.ConcordanceCountableWordCandidateAnalyse
        >,
      ),
      i1.ConcordanceCountableWordCandidateAnalyse,
      i0.PrefetchHooks Function()
    >;

class ConcordanceDetails extends i0.Table
    with i0.TableInfo<ConcordanceDetails, i1.ConcordanceDetail> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ConcordanceDetails(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _itemMeta = const i0.VerificationMeta(
    'item',
  );
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
    'item',
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
  List<i0.GeneratedColumn> get $columns => [form, item, dictionaryRef];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ConcordanceDetails';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ConcordanceDetail> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    } else if (isInserting) {
      context.missing(_itemMeta);
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
  Set<i0.GeneratedColumn> get $primaryKey => {form, item};
  @override
  i1.ConcordanceDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConcordanceDetail(
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      item: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      dictionaryRef: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionaryRef'],
      )!,
    );
  }

  @override
  ConcordanceDetails createAlias(String alias) {
    return ConcordanceDetails(attachedDatabase, alias);
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

class ConcordanceDetail extends i0.DataClass
    implements i0.Insertable<i1.ConcordanceDetail> {
  final String form;
  final int item;
  final String dictionaryRef;
  const ConcordanceDetail({
    required this.form,
    required this.item,
    required this.dictionaryRef,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['form'] = i0.Variable<String>(form);
    map['item'] = i0.Variable<int>(item);
    map['dictionaryRef'] = i0.Variable<String>(dictionaryRef);
    return map;
  }

  i1.ConcordanceDetailsCompanion toCompanion(bool nullToAbsent) {
    return i1.ConcordanceDetailsCompanion(
      form: i0.Value(form),
      item: i0.Value(item),
      dictionaryRef: i0.Value(dictionaryRef),
    );
  }

  factory ConcordanceDetail.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConcordanceDetail(
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

  i1.ConcordanceDetail copyWith({
    String? form,
    int? item,
    String? dictionaryRef,
  }) => i1.ConcordanceDetail(
    form: form ?? this.form,
    item: item ?? this.item,
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
  );
  ConcordanceDetail copyWithCompanion(i1.ConcordanceDetailsCompanion data) {
    return ConcordanceDetail(
      form: data.form.present ? data.form.value : this.form,
      item: data.item.present ? data.item.value : this.item,
      dictionaryRef: data.dictionaryRef.present
          ? data.dictionaryRef.value
          : this.dictionaryRef,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConcordanceDetail(')
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
      (other is i1.ConcordanceDetail &&
          other.form == this.form &&
          other.item == this.item &&
          other.dictionaryRef == this.dictionaryRef);
}

class ConcordanceDetailsCompanion
    extends i0.UpdateCompanion<i1.ConcordanceDetail> {
  final i0.Value<String> form;
  final i0.Value<int> item;
  final i0.Value<String> dictionaryRef;
  const ConcordanceDetailsCompanion({
    this.form = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
    this.dictionaryRef = const i0.Value.absent(),
  });
  ConcordanceDetailsCompanion.insert({
    required String form,
    required int item,
    required String dictionaryRef,
  }) : form = i0.Value(form),
       item = i0.Value(item),
       dictionaryRef = i0.Value(dictionaryRef);
  static i0.Insertable<i1.ConcordanceDetail> custom({
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

  i1.ConcordanceDetailsCompanion copyWith({
    i0.Value<String>? form,
    i0.Value<int>? item,
    i0.Value<String>? dictionaryRef,
  }) {
    return i1.ConcordanceDetailsCompanion(
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
    return (StringBuffer('ConcordanceDetailsCompanion(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('dictionaryRef: $dictionaryRef')
          ..write(')'))
        .toString();
  }
}

i0.Index get concordanceDetailsDictRef => i0.Index(
  'ConcordanceDetails_DictRef',
  'CREATE INDEX ConcordanceDetails_DictRef ON ConcordanceDetails (dictionaryRef)',
);

class ConcordanceDetailInflections extends i0.Table
    with
        i0.TableInfo<
          ConcordanceDetailInflections,
          i1.ConcordanceDetailInflection
        > {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ConcordanceDetailInflections(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _itemMeta = const i0.VerificationMeta(
    'item',
  );
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _cntMeta = const i0.VerificationMeta('cnt');
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
    'cnt',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _partOfSpeechMeta =
      const i0.VerificationMeta('partOfSpeech');
  late final i0.GeneratedColumn<String> partOfSpeech =
      i0.GeneratedColumn<String>(
        'partOfSpeech',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _gramCaseMeta = const i0.VerificationMeta(
    'gramCase',
  );
  late final i0.GeneratedColumn<String> gramCase = i0.GeneratedColumn<String>(
    'gramCase',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _numberMeta = const i0.VerificationMeta(
    'number',
  );
  late final i0.GeneratedColumn<String> number = i0.GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _genderMeta = const i0.VerificationMeta(
    'gender',
  );
  late final i0.GeneratedColumn<String> gender = i0.GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _declensionMeta = const i0.VerificationMeta(
    'declension',
  );
  late final i0.GeneratedColumn<String> declension = i0.GeneratedColumn<String>(
    'declension',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _personMeta = const i0.VerificationMeta(
    'person',
  );
  late final i0.GeneratedColumn<String> person = i0.GeneratedColumn<String>(
    'person',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _verbFormMeta = const i0.VerificationMeta(
    'verbForm',
  );
  late final i0.GeneratedColumn<String> verbForm = i0.GeneratedColumn<String>(
    'verbForm',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _tenseMeta = const i0.VerificationMeta(
    'tense',
  );
  late final i0.GeneratedColumn<String> tense = i0.GeneratedColumn<String>(
    'tense',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _voiceMeta = const i0.VerificationMeta(
    'voice',
  );
  late final i0.GeneratedColumn<String> voice = i0.GeneratedColumn<String>(
    'voice',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    form,
    item,
    cnt,
    partOfSpeech,
    gramCase,
    number,
    gender,
    declension,
    person,
    verbForm,
    tense,
    voice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ConcordanceDetailInflections';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ConcordanceDetailInflection> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('cnt')) {
      context.handle(
        _cntMeta,
        cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta),
      );
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    if (data.containsKey('partOfSpeech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['partOfSpeech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('gramCase')) {
      context.handle(
        _gramCaseMeta,
        gramCase.isAcceptableOrUnknown(data['gramCase']!, _gramCaseMeta),
      );
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('declension')) {
      context.handle(
        _declensionMeta,
        declension.isAcceptableOrUnknown(data['declension']!, _declensionMeta),
      );
    }
    if (data.containsKey('person')) {
      context.handle(
        _personMeta,
        person.isAcceptableOrUnknown(data['person']!, _personMeta),
      );
    }
    if (data.containsKey('verbForm')) {
      context.handle(
        _verbFormMeta,
        verbForm.isAcceptableOrUnknown(data['verbForm']!, _verbFormMeta),
      );
    }
    if (data.containsKey('tense')) {
      context.handle(
        _tenseMeta,
        tense.isAcceptableOrUnknown(data['tense']!, _tenseMeta),
      );
    }
    if (data.containsKey('voice')) {
      context.handle(
        _voiceMeta,
        voice.isAcceptableOrUnknown(data['voice']!, _voiceMeta),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {form, item, cnt};
  @override
  i1.ConcordanceDetailInflection map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConcordanceDetailInflection(
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      item: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      cnt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}cnt'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}partOfSpeech'],
      )!,
      gramCase: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}gramCase'],
      ),
      number: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      gender: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      declension: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}declension'],
      ),
      person: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}person'],
      ),
      verbForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}verbForm'],
      ),
      tense: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}tense'],
      ),
      voice: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}voice'],
      ),
    );
  }

  @override
  ConcordanceDetailInflections createAlias(String alias) {
    return ConcordanceDetailInflections(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(form, item, cnt)',
    'FOREIGN KEY(form, item)REFERENCES ConcordanceDetails(form, item)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ConcordanceDetailInflection extends i0.DataClass
    implements i0.Insertable<i1.ConcordanceDetailInflection> {
  final String form;
  final int item;
  final int cnt;
  final String partOfSpeech;
  final String? gramCase;
  final String? number;
  final String? gender;
  final String? declension;
  final String? person;
  final String? verbForm;
  final String? tense;
  final String? voice;
  const ConcordanceDetailInflection({
    required this.form,
    required this.item,
    required this.cnt,
    required this.partOfSpeech,
    this.gramCase,
    this.number,
    this.gender,
    this.declension,
    this.person,
    this.verbForm,
    this.tense,
    this.voice,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['form'] = i0.Variable<String>(form);
    map['item'] = i0.Variable<int>(item);
    map['cnt'] = i0.Variable<int>(cnt);
    map['partOfSpeech'] = i0.Variable<String>(partOfSpeech);
    if (!nullToAbsent || gramCase != null) {
      map['gramCase'] = i0.Variable<String>(gramCase);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = i0.Variable<String>(number);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = i0.Variable<String>(gender);
    }
    if (!nullToAbsent || declension != null) {
      map['declension'] = i0.Variable<String>(declension);
    }
    if (!nullToAbsent || person != null) {
      map['person'] = i0.Variable<String>(person);
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
    return map;
  }

  i1.ConcordanceDetailInflectionsCompanion toCompanion(bool nullToAbsent) {
    return i1.ConcordanceDetailInflectionsCompanion(
      form: i0.Value(form),
      item: i0.Value(item),
      cnt: i0.Value(cnt),
      partOfSpeech: i0.Value(partOfSpeech),
      gramCase: gramCase == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(gramCase),
      number: number == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(number),
      gender: gender == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(gender),
      declension: declension == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(declension),
      person: person == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(person),
      verbForm: verbForm == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(verbForm),
      tense: tense == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(tense),
      voice: voice == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(voice),
    );
  }

  factory ConcordanceDetailInflection.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConcordanceDetailInflection(
      form: serializer.fromJson<String>(json['form']),
      item: serializer.fromJson<int>(json['item']),
      cnt: serializer.fromJson<int>(json['cnt']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      gramCase: serializer.fromJson<String?>(json['gramCase']),
      number: serializer.fromJson<String?>(json['number']),
      gender: serializer.fromJson<String?>(json['gender']),
      declension: serializer.fromJson<String?>(json['declension']),
      person: serializer.fromJson<String?>(json['person']),
      verbForm: serializer.fromJson<String?>(json['verbForm']),
      tense: serializer.fromJson<String?>(json['tense']),
      voice: serializer.fromJson<String?>(json['voice']),
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
      'gramCase': serializer.toJson<String?>(gramCase),
      'number': serializer.toJson<String?>(number),
      'gender': serializer.toJson<String?>(gender),
      'declension': serializer.toJson<String?>(declension),
      'person': serializer.toJson<String?>(person),
      'verbForm': serializer.toJson<String?>(verbForm),
      'tense': serializer.toJson<String?>(tense),
      'voice': serializer.toJson<String?>(voice),
    };
  }

  i1.ConcordanceDetailInflection copyWith({
    String? form,
    int? item,
    int? cnt,
    String? partOfSpeech,
    i0.Value<String?> gramCase = const i0.Value.absent(),
    i0.Value<String?> number = const i0.Value.absent(),
    i0.Value<String?> gender = const i0.Value.absent(),
    i0.Value<String?> declension = const i0.Value.absent(),
    i0.Value<String?> person = const i0.Value.absent(),
    i0.Value<String?> verbForm = const i0.Value.absent(),
    i0.Value<String?> tense = const i0.Value.absent(),
    i0.Value<String?> voice = const i0.Value.absent(),
  }) => i1.ConcordanceDetailInflection(
    form: form ?? this.form,
    item: item ?? this.item,
    cnt: cnt ?? this.cnt,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    gramCase: gramCase.present ? gramCase.value : this.gramCase,
    number: number.present ? number.value : this.number,
    gender: gender.present ? gender.value : this.gender,
    declension: declension.present ? declension.value : this.declension,
    person: person.present ? person.value : this.person,
    verbForm: verbForm.present ? verbForm.value : this.verbForm,
    tense: tense.present ? tense.value : this.tense,
    voice: voice.present ? voice.value : this.voice,
  );
  ConcordanceDetailInflection copyWithCompanion(
    i1.ConcordanceDetailInflectionsCompanion data,
  ) {
    return ConcordanceDetailInflection(
      form: data.form.present ? data.form.value : this.form,
      item: data.item.present ? data.item.value : this.item,
      cnt: data.cnt.present ? data.cnt.value : this.cnt,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      gramCase: data.gramCase.present ? data.gramCase.value : this.gramCase,
      number: data.number.present ? data.number.value : this.number,
      gender: data.gender.present ? data.gender.value : this.gender,
      declension: data.declension.present
          ? data.declension.value
          : this.declension,
      person: data.person.present ? data.person.value : this.person,
      verbForm: data.verbForm.present ? data.verbForm.value : this.verbForm,
      tense: data.tense.present ? data.tense.value : this.tense,
      voice: data.voice.present ? data.voice.value : this.voice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConcordanceDetailInflection(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('gramCase: $gramCase, ')
          ..write('number: $number, ')
          ..write('gender: $gender, ')
          ..write('declension: $declension, ')
          ..write('person: $person, ')
          ..write('verbForm: $verbForm, ')
          ..write('tense: $tense, ')
          ..write('voice: $voice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    form,
    item,
    cnt,
    partOfSpeech,
    gramCase,
    number,
    gender,
    declension,
    person,
    verbForm,
    tense,
    voice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ConcordanceDetailInflection &&
          other.form == this.form &&
          other.item == this.item &&
          other.cnt == this.cnt &&
          other.partOfSpeech == this.partOfSpeech &&
          other.gramCase == this.gramCase &&
          other.number == this.number &&
          other.gender == this.gender &&
          other.declension == this.declension &&
          other.person == this.person &&
          other.verbForm == this.verbForm &&
          other.tense == this.tense &&
          other.voice == this.voice);
}

class ConcordanceDetailInflectionsCompanion
    extends i0.UpdateCompanion<i1.ConcordanceDetailInflection> {
  final i0.Value<String> form;
  final i0.Value<int> item;
  final i0.Value<int> cnt;
  final i0.Value<String> partOfSpeech;
  final i0.Value<String?> gramCase;
  final i0.Value<String?> number;
  final i0.Value<String?> gender;
  final i0.Value<String?> declension;
  final i0.Value<String?> person;
  final i0.Value<String?> verbForm;
  final i0.Value<String?> tense;
  final i0.Value<String?> voice;
  const ConcordanceDetailInflectionsCompanion({
    this.form = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
    this.partOfSpeech = const i0.Value.absent(),
    this.gramCase = const i0.Value.absent(),
    this.number = const i0.Value.absent(),
    this.gender = const i0.Value.absent(),
    this.declension = const i0.Value.absent(),
    this.person = const i0.Value.absent(),
    this.verbForm = const i0.Value.absent(),
    this.tense = const i0.Value.absent(),
    this.voice = const i0.Value.absent(),
  });
  ConcordanceDetailInflectionsCompanion.insert({
    required String form,
    required int item,
    required int cnt,
    required String partOfSpeech,
    this.gramCase = const i0.Value.absent(),
    this.number = const i0.Value.absent(),
    this.gender = const i0.Value.absent(),
    this.declension = const i0.Value.absent(),
    this.person = const i0.Value.absent(),
    this.verbForm = const i0.Value.absent(),
    this.tense = const i0.Value.absent(),
    this.voice = const i0.Value.absent(),
  }) : form = i0.Value(form),
       item = i0.Value(item),
       cnt = i0.Value(cnt),
       partOfSpeech = i0.Value(partOfSpeech);
  static i0.Insertable<i1.ConcordanceDetailInflection> custom({
    i0.Expression<String>? form,
    i0.Expression<int>? item,
    i0.Expression<int>? cnt,
    i0.Expression<String>? partOfSpeech,
    i0.Expression<String>? gramCase,
    i0.Expression<String>? number,
    i0.Expression<String>? gender,
    i0.Expression<String>? declension,
    i0.Expression<String>? person,
    i0.Expression<String>? verbForm,
    i0.Expression<String>? tense,
    i0.Expression<String>? voice,
  }) {
    return i0.RawValuesInsertable({
      if (form != null) 'form': form,
      if (item != null) 'item': item,
      if (cnt != null) 'cnt': cnt,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      if (gramCase != null) 'gramCase': gramCase,
      if (number != null) 'number': number,
      if (gender != null) 'gender': gender,
      if (declension != null) 'declension': declension,
      if (person != null) 'person': person,
      if (verbForm != null) 'verbForm': verbForm,
      if (tense != null) 'tense': tense,
      if (voice != null) 'voice': voice,
    });
  }

  i1.ConcordanceDetailInflectionsCompanion copyWith({
    i0.Value<String>? form,
    i0.Value<int>? item,
    i0.Value<int>? cnt,
    i0.Value<String>? partOfSpeech,
    i0.Value<String?>? gramCase,
    i0.Value<String?>? number,
    i0.Value<String?>? gender,
    i0.Value<String?>? declension,
    i0.Value<String?>? person,
    i0.Value<String?>? verbForm,
    i0.Value<String?>? tense,
    i0.Value<String?>? voice,
  }) {
    return i1.ConcordanceDetailInflectionsCompanion(
      form: form ?? this.form,
      item: item ?? this.item,
      cnt: cnt ?? this.cnt,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      gramCase: gramCase ?? this.gramCase,
      number: number ?? this.number,
      gender: gender ?? this.gender,
      declension: declension ?? this.declension,
      person: person ?? this.person,
      verbForm: verbForm ?? this.verbForm,
      tense: tense ?? this.tense,
      voice: voice ?? this.voice,
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
    if (gramCase.present) {
      map['gramCase'] = i0.Variable<String>(gramCase.value);
    }
    if (number.present) {
      map['number'] = i0.Variable<String>(number.value);
    }
    if (gender.present) {
      map['gender'] = i0.Variable<String>(gender.value);
    }
    if (declension.present) {
      map['declension'] = i0.Variable<String>(declension.value);
    }
    if (person.present) {
      map['person'] = i0.Variable<String>(person.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConcordanceDetailInflectionsCompanion(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('cnt: $cnt, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('gramCase: $gramCase, ')
          ..write('number: $number, ')
          ..write('gender: $gender, ')
          ..write('declension: $declension, ')
          ..write('person: $person, ')
          ..write('verbForm: $verbForm, ')
          ..write('tense: $tense, ')
          ..write('voice: $voice')
          ..write(')'))
        .toString();
  }
}

class ConcordanceCountableWordCandidateAnalyses extends i0.Table
    with
        i0.TableInfo<
          ConcordanceCountableWordCandidateAnalyses,
          i1.ConcordanceCountableWordCandidateAnalyse
        > {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  ConcordanceCountableWordCandidateAnalyses(
    this.attachedDatabase, [
    this._alias,
  ]);
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
  static const i0.VerificationMeta _idxMeta = const i0.VerificationMeta('idx');
  late final i0.GeneratedColumn<int> idx = i0.GeneratedColumn<int>(
    'idx',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _componentOrdinalMeta =
      const i0.VerificationMeta('componentOrdinal');
  late final i0.GeneratedColumn<int> componentOrdinal = i0.GeneratedColumn<int>(
    'componentOrdinal',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (componentOrdinal IN (0, 1))',
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
  static const i0.VerificationMeta _itemMeta = const i0.VerificationMeta(
    'item',
  );
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    idx,
    componentOrdinal,
    form,
    item,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ConcordanceCountableWordCandidateAnalyses';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ConcordanceCountableWordCandidateAnalyse> instance, {
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
    if (data.containsKey('idx')) {
      context.handle(
        _idxMeta,
        idx.isAcceptableOrUnknown(data['idx']!, _idxMeta),
      );
    } else if (isInserting) {
      context.missing(_idxMeta);
    }
    if (data.containsKey('componentOrdinal')) {
      context.handle(
        _componentOrdinalMeta,
        componentOrdinal.isAcceptableOrUnknown(
          data['componentOrdinal']!,
          _componentOrdinalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentOrdinalMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {
    workId,
    idx,
    componentOrdinal,
    form,
    item,
  };
  @override
  i1.ConcordanceCountableWordCandidateAnalyse map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConcordanceCountableWordCandidateAnalyse(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}idx'],
      )!,
      componentOrdinal: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}componentOrdinal'],
      )!,
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      item: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
    );
  }

  @override
  ConcordanceCountableWordCandidateAnalyses createAlias(String alias) {
    return ConcordanceCountableWordCandidateAnalyses(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, idx, componentOrdinal, form, item)',
    'FOREIGN KEY(form, item)REFERENCES ConcordanceDetails(form, item)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ConcordanceCountableWordCandidateAnalyse extends i0.DataClass
    implements i0.Insertable<i1.ConcordanceCountableWordCandidateAnalyse> {
  final String workId;
  final int idx;
  final int componentOrdinal;

  /// 0: lookup form; 1: enclitic
  final String form;
  final int item;
  const ConcordanceCountableWordCandidateAnalyse({
    required this.workId,
    required this.idx,
    required this.componentOrdinal,
    required this.form,
    required this.item,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['idx'] = i0.Variable<int>(idx);
    map['componentOrdinal'] = i0.Variable<int>(componentOrdinal);
    map['form'] = i0.Variable<String>(form);
    map['item'] = i0.Variable<int>(item);
    return map;
  }

  i1.ConcordanceCountableWordCandidateAnalysesCompanion toCompanion(
    bool nullToAbsent,
  ) {
    return i1.ConcordanceCountableWordCandidateAnalysesCompanion(
      workId: i0.Value(workId),
      idx: i0.Value(idx),
      componentOrdinal: i0.Value(componentOrdinal),
      form: i0.Value(form),
      item: i0.Value(item),
    );
  }

  factory ConcordanceCountableWordCandidateAnalyse.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConcordanceCountableWordCandidateAnalyse(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<int>(json['idx']),
      componentOrdinal: serializer.fromJson<int>(json['componentOrdinal']),
      form: serializer.fromJson<String>(json['form']),
      item: serializer.fromJson<int>(json['item']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<int>(idx),
      'componentOrdinal': serializer.toJson<int>(componentOrdinal),
      'form': serializer.toJson<String>(form),
      'item': serializer.toJson<int>(item),
    };
  }

  i1.ConcordanceCountableWordCandidateAnalyse copyWith({
    String? workId,
    int? idx,
    int? componentOrdinal,
    String? form,
    int? item,
  }) => i1.ConcordanceCountableWordCandidateAnalyse(
    workId: workId ?? this.workId,
    idx: idx ?? this.idx,
    componentOrdinal: componentOrdinal ?? this.componentOrdinal,
    form: form ?? this.form,
    item: item ?? this.item,
  );
  ConcordanceCountableWordCandidateAnalyse copyWithCompanion(
    i1.ConcordanceCountableWordCandidateAnalysesCompanion data,
  ) {
    return ConcordanceCountableWordCandidateAnalyse(
      workId: data.workId.present ? data.workId.value : this.workId,
      idx: data.idx.present ? data.idx.value : this.idx,
      componentOrdinal: data.componentOrdinal.present
          ? data.componentOrdinal.value
          : this.componentOrdinal,
      form: data.form.present ? data.form.value : this.form,
      item: data.item.present ? data.item.value : this.item,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConcordanceCountableWordCandidateAnalyse(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('componentOrdinal: $componentOrdinal, ')
          ..write('form: $form, ')
          ..write('item: $item')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, idx, componentOrdinal, form, item);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ConcordanceCountableWordCandidateAnalyse &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.componentOrdinal == this.componentOrdinal &&
          other.form == this.form &&
          other.item == this.item);
}

class ConcordanceCountableWordCandidateAnalysesCompanion
    extends i0.UpdateCompanion<i1.ConcordanceCountableWordCandidateAnalyse> {
  final i0.Value<String> workId;
  final i0.Value<int> idx;
  final i0.Value<int> componentOrdinal;
  final i0.Value<String> form;
  final i0.Value<int> item;
  const ConcordanceCountableWordCandidateAnalysesCompanion({
    this.workId = const i0.Value.absent(),
    this.idx = const i0.Value.absent(),
    this.componentOrdinal = const i0.Value.absent(),
    this.form = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
  });
  ConcordanceCountableWordCandidateAnalysesCompanion.insert({
    required String workId,
    required int idx,
    required int componentOrdinal,
    required String form,
    required int item,
  }) : workId = i0.Value(workId),
       idx = i0.Value(idx),
       componentOrdinal = i0.Value(componentOrdinal),
       form = i0.Value(form),
       item = i0.Value(item);
  static i0.Insertable<i1.ConcordanceCountableWordCandidateAnalyse> custom({
    i0.Expression<String>? workId,
    i0.Expression<int>? idx,
    i0.Expression<int>? componentOrdinal,
    i0.Expression<String>? form,
    i0.Expression<int>? item,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (componentOrdinal != null) 'componentOrdinal': componentOrdinal,
      if (form != null) 'form': form,
      if (item != null) 'item': item,
    });
  }

  i1.ConcordanceCountableWordCandidateAnalysesCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<int>? idx,
    i0.Value<int>? componentOrdinal,
    i0.Value<String>? form,
    i0.Value<int>? item,
  }) {
    return i1.ConcordanceCountableWordCandidateAnalysesCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      componentOrdinal: componentOrdinal ?? this.componentOrdinal,
      form: form ?? this.form,
      item: item ?? this.item,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (idx.present) {
      map['idx'] = i0.Variable<int>(idx.value);
    }
    if (componentOrdinal.present) {
      map['componentOrdinal'] = i0.Variable<int>(componentOrdinal.value);
    }
    if (form.present) {
      map['form'] = i0.Variable<String>(form.value);
    }
    if (item.present) {
      map['item'] = i0.Variable<int>(item.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConcordanceCountableWordCandidateAnalysesCompanion(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('componentOrdinal: $componentOrdinal, ')
          ..write('form: $form, ')
          ..write('item: $item')
          ..write(')'))
        .toString();
  }
}

i0.Index get concordanceCountableWordCandidateAnalysesAnalysis => i0.Index(
  'ConcordanceCountableWordCandidateAnalyses_Analysis',
  'CREATE INDEX ConcordanceCountableWordCandidateAnalyses_Analysis ON ConcordanceCountableWordCandidateAnalyses (form, item)',
);

class ConcordanceAnalysesWithOptionalInflection extends i0.DataClass {
  final String form;
  final int item;
  final String dictionaryRef;
  final String? partOfSpeech;
  final String? gramCase;
  final String? number;
  final String? gender;
  final String? declension;
  final String? person;
  final String? verbForm;
  final String? tense;
  final String? voice;
  const ConcordanceAnalysesWithOptionalInflection({
    required this.form,
    required this.item,
    required this.dictionaryRef,
    this.partOfSpeech,
    this.gramCase,
    this.number,
    this.gender,
    this.declension,
    this.person,
    this.verbForm,
    this.tense,
    this.voice,
  });
  factory ConcordanceAnalysesWithOptionalInflection.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConcordanceAnalysesWithOptionalInflection(
      form: serializer.fromJson<String>(json['form']),
      item: serializer.fromJson<int>(json['item']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      gramCase: serializer.fromJson<String?>(json['gramCase']),
      number: serializer.fromJson<String?>(json['number']),
      gender: serializer.fromJson<String?>(json['gender']),
      declension: serializer.fromJson<String?>(json['declension']),
      person: serializer.fromJson<String?>(json['person']),
      verbForm: serializer.fromJson<String?>(json['verbForm']),
      tense: serializer.fromJson<String?>(json['tense']),
      voice: serializer.fromJson<String?>(json['voice']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String>(form),
      'item': serializer.toJson<int>(item),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'gramCase': serializer.toJson<String?>(gramCase),
      'number': serializer.toJson<String?>(number),
      'gender': serializer.toJson<String?>(gender),
      'declension': serializer.toJson<String?>(declension),
      'person': serializer.toJson<String?>(person),
      'verbForm': serializer.toJson<String?>(verbForm),
      'tense': serializer.toJson<String?>(tense),
      'voice': serializer.toJson<String?>(voice),
    };
  }

  i1.ConcordanceAnalysesWithOptionalInflection copyWith({
    String? form,
    int? item,
    String? dictionaryRef,
    i0.Value<String?> partOfSpeech = const i0.Value.absent(),
    i0.Value<String?> gramCase = const i0.Value.absent(),
    i0.Value<String?> number = const i0.Value.absent(),
    i0.Value<String?> gender = const i0.Value.absent(),
    i0.Value<String?> declension = const i0.Value.absent(),
    i0.Value<String?> person = const i0.Value.absent(),
    i0.Value<String?> verbForm = const i0.Value.absent(),
    i0.Value<String?> tense = const i0.Value.absent(),
    i0.Value<String?> voice = const i0.Value.absent(),
  }) => i1.ConcordanceAnalysesWithOptionalInflection(
    form: form ?? this.form,
    item: item ?? this.item,
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    gramCase: gramCase.present ? gramCase.value : this.gramCase,
    number: number.present ? number.value : this.number,
    gender: gender.present ? gender.value : this.gender,
    declension: declension.present ? declension.value : this.declension,
    person: person.present ? person.value : this.person,
    verbForm: verbForm.present ? verbForm.value : this.verbForm,
    tense: tense.present ? tense.value : this.tense,
    voice: voice.present ? voice.value : this.voice,
  );
  @override
  String toString() {
    return (StringBuffer('ConcordanceAnalysesWithOptionalInflection(')
          ..write('form: $form, ')
          ..write('item: $item, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('gramCase: $gramCase, ')
          ..write('number: $number, ')
          ..write('gender: $gender, ')
          ..write('declension: $declension, ')
          ..write('person: $person, ')
          ..write('verbForm: $verbForm, ')
          ..write('tense: $tense, ')
          ..write('voice: $voice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    form,
    item,
    dictionaryRef,
    partOfSpeech,
    gramCase,
    number,
    gender,
    declension,
    person,
    verbForm,
    tense,
    voice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ConcordanceAnalysesWithOptionalInflection &&
          other.form == this.form &&
          other.item == this.item &&
          other.dictionaryRef == this.dictionaryRef &&
          other.partOfSpeech == this.partOfSpeech &&
          other.gramCase == this.gramCase &&
          other.number == this.number &&
          other.gender == this.gender &&
          other.declension == this.declension &&
          other.person == this.person &&
          other.verbForm == this.verbForm &&
          other.tense == this.tense &&
          other.voice == this.voice);
}

class ConcordanceAnalysesWithOptionalInflections
    extends
        i0.ViewInfo<
          i1.ConcordanceAnalysesWithOptionalInflections,
          i1.ConcordanceAnalysesWithOptionalInflection
        >
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  ConcordanceAnalysesWithOptionalInflections(
    this.attachedDatabase, [
    this._alias,
  ]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    form,
    item,
    dictionaryRef,
    partOfSpeech,
    gramCase,
    number,
    gender,
    declension,
    person,
    verbForm,
    tense,
    voice,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'concordance.AnalysesWithOptionalInflections';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "concordance.AnalysesWithOptionalInflections" AS SELECT Details.form, Details.item, Details.dictionaryRef, Infl.partOfSpeech, Infl.gramCase, Infl.number, Infl.gender, Infl.declension, Infl.person, Infl.verbForm, Infl.tense, Infl.voice FROM ConcordanceDetails AS Details LEFT OUTER JOIN ConcordanceDetailInflections AS Infl ON Infl.form = Details.form AND Infl.item = Details.item',
  };
  @override
  ConcordanceAnalysesWithOptionalInflections get asDslTable => this;
  @override
  i1.ConcordanceAnalysesWithOptionalInflection map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConcordanceAnalysesWithOptionalInflection(
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      item: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      dictionaryRef: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionaryRef'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}partOfSpeech'],
      ),
      gramCase: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}gramCase'],
      ),
      number: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      gender: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      declension: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}declension'],
      ),
      person: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}person'],
      ),
      verbForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}verbForm'],
      ),
      tense: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}tense'],
      ),
      voice: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}voice'],
      ),
    );
  }

  late final i0.GeneratedColumn<String> form = i0.GeneratedColumn<String>(
    'form',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> item = i0.GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>(
        'dictionaryRef',
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
  late final i0.GeneratedColumn<String> gramCase = i0.GeneratedColumn<String>(
    'gramCase',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> number = i0.GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> gender = i0.GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> declension = i0.GeneratedColumn<String>(
    'declension',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> person = i0.GeneratedColumn<String>(
    'person',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> verbForm = i0.GeneratedColumn<String>(
    'verbForm',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> tense = i0.GeneratedColumn<String>(
    'tense',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> voice = i0.GeneratedColumn<String>(
    'voice',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  @override
  ConcordanceAnalysesWithOptionalInflections createAlias(String alias) {
    return ConcordanceAnalysesWithOptionalInflections(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {
    'ConcordanceDetails',
    'ConcordanceDetailInflections',
  };
}

class ConcordanceLemma extends i0.DataClass {
  final String dictionaryRef;
  final String? lnsLemma;
  final String? lnsPartOfSpeech;
  final String? lnsInflection;
  const ConcordanceLemma({
    required this.dictionaryRef,
    this.lnsLemma,
    this.lnsPartOfSpeech,
    this.lnsInflection,
  });
  factory ConcordanceLemma.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConcordanceLemma(
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      lnsLemma: serializer.fromJson<String?>(json['lnsLemma']),
      lnsPartOfSpeech: serializer.fromJson<String?>(json['lnsPartOfSpeech']),
      lnsInflection: serializer.fromJson<String?>(json['lnsInflection']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'lnsLemma': serializer.toJson<String?>(lnsLemma),
      'lnsPartOfSpeech': serializer.toJson<String?>(lnsPartOfSpeech),
      'lnsInflection': serializer.toJson<String?>(lnsInflection),
    };
  }

  i1.ConcordanceLemma copyWith({
    String? dictionaryRef,
    i0.Value<String?> lnsLemma = const i0.Value.absent(),
    i0.Value<String?> lnsPartOfSpeech = const i0.Value.absent(),
    i0.Value<String?> lnsInflection = const i0.Value.absent(),
  }) => i1.ConcordanceLemma(
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    lnsLemma: lnsLemma.present ? lnsLemma.value : this.lnsLemma,
    lnsPartOfSpeech: lnsPartOfSpeech.present
        ? lnsPartOfSpeech.value
        : this.lnsPartOfSpeech,
    lnsInflection: lnsInflection.present
        ? lnsInflection.value
        : this.lnsInflection,
  );
  @override
  String toString() {
    return (StringBuffer('ConcordanceLemma(')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('lnsLemma: $lnsLemma, ')
          ..write('lnsPartOfSpeech: $lnsPartOfSpeech, ')
          ..write('lnsInflection: $lnsInflection')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(dictionaryRef, lnsLemma, lnsPartOfSpeech, lnsInflection);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ConcordanceLemma &&
          other.dictionaryRef == this.dictionaryRef &&
          other.lnsLemma == this.lnsLemma &&
          other.lnsPartOfSpeech == this.lnsPartOfSpeech &&
          other.lnsInflection == this.lnsInflection);
}

class ConcordanceLemmas
    extends i0.ViewInfo<i1.ConcordanceLemmas, i1.ConcordanceLemma>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  ConcordanceLemmas(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    dictionaryRef,
    lnsLemma,
    lnsPartOfSpeech,
    lnsInflection,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'concordance.Lemmas';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "concordance.Lemmas" AS SELECT DISTINCT Details.dictionaryRef, Resolved.lemma AS lnsLemma, Resolved.partOfSpeech AS lnsPartOfSpeech, Resolved.inflection AS lnsInflection FROM ConcordanceDetails AS Details LEFT OUTER JOIN "dictionary.ResolvedLnsRefs" AS Resolved ON Resolved.dictionaryRef = Details.dictionaryRef',
  };
  @override
  ConcordanceLemmas get asDslTable => this;
  @override
  i1.ConcordanceLemma map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConcordanceLemma(
      dictionaryRef: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionaryRef'],
      )!,
      lnsLemma: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lnsLemma'],
      ),
      lnsPartOfSpeech: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lnsPartOfSpeech'],
      ),
      lnsInflection: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}lnsInflection'],
      ),
    );
  }

  late final i0.GeneratedColumn<String> dictionaryRef =
      i0.GeneratedColumn<String>(
        'dictionaryRef',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
      );
  late final i0.GeneratedColumn<String> lnsLemma = i0.GeneratedColumn<String>(
    'lnsLemma',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> lnsPartOfSpeech =
      i0.GeneratedColumn<String>(
        'lnsPartOfSpeech',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
      );
  late final i0.GeneratedColumn<String> lnsInflection =
      i0.GeneratedColumn<String>(
        'lnsInflection',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
      );
  @override
  ConcordanceLemmas createAlias(String alias) {
    return ConcordanceLemmas(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {
    'ConcordanceDetails',
    'LnsRefResolutions',
    'DictionaryEntries',
    'Dictionaries',
  };
}

class ConcordanceGrammarValue extends i0.DataClass {
  final String partOfSpeech;
  final String feature;
  final String? value;
  const ConcordanceGrammarValue({
    required this.partOfSpeech,
    required this.feature,
    this.value,
  });
  factory ConcordanceGrammarValue.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConcordanceGrammarValue(
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      feature: serializer.fromJson<String>(json['feature']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'feature': serializer.toJson<String>(feature),
      'value': serializer.toJson<String?>(value),
    };
  }

  i1.ConcordanceGrammarValue copyWith({
    String? partOfSpeech,
    String? feature,
    i0.Value<String?> value = const i0.Value.absent(),
  }) => i1.ConcordanceGrammarValue(
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    feature: feature ?? this.feature,
    value: value.present ? value.value : this.value,
  );
  @override
  String toString() {
    return (StringBuffer('ConcordanceGrammarValue(')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('feature: $feature, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(partOfSpeech, feature, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ConcordanceGrammarValue &&
          other.partOfSpeech == this.partOfSpeech &&
          other.feature == this.feature &&
          other.value == this.value);
}

class ConcordanceGrammarValues
    extends i0.ViewInfo<i1.ConcordanceGrammarValues, i1.ConcordanceGrammarValue>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  ConcordanceGrammarValues(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [partOfSpeech, feature, value];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'concordance.GrammarValues';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "concordance.GrammarValues" AS SELECT partOfSpeech, \'partOfSpeech\' AS feature, partOfSpeech AS value FROM ConcordanceDetailInflections UNION SELECT partOfSpeech, \'gramCase\', gramCase FROM ConcordanceDetailInflections WHERE gramCase IS NOT NULL UNION SELECT partOfSpeech, \'number\', number FROM ConcordanceDetailInflections WHERE number IS NOT NULL UNION SELECT partOfSpeech, \'gender\', gender FROM ConcordanceDetailInflections WHERE gender IS NOT NULL UNION SELECT partOfSpeech, \'declension\', declension FROM ConcordanceDetailInflections WHERE declension IS NOT NULL UNION SELECT partOfSpeech, \'person\', person FROM ConcordanceDetailInflections WHERE person IS NOT NULL UNION SELECT partOfSpeech, \'verbForm\', verbForm FROM ConcordanceDetailInflections WHERE verbForm IS NOT NULL UNION SELECT partOfSpeech, \'tense\', tense FROM ConcordanceDetailInflections WHERE tense IS NOT NULL UNION SELECT partOfSpeech, \'voice\', voice FROM ConcordanceDetailInflections WHERE voice IS NOT NULL',
  };
  @override
  ConcordanceGrammarValues get asDslTable => this;
  @override
  i1.ConcordanceGrammarValue map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConcordanceGrammarValue(
      partOfSpeech: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}partOfSpeech'],
      )!,
      feature: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}feature'],
      )!,
      value: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  late final i0.GeneratedColumn<String> partOfSpeech =
      i0.GeneratedColumn<String>(
        'partOfSpeech',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
      );
  late final i0.GeneratedColumn<String> feature = i0.GeneratedColumn<String>(
    'feature',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> value = i0.GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  @override
  ConcordanceGrammarValues createAlias(String alias) {
    return ConcordanceGrammarValues(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {'ConcordanceDetailInflections'};
}

class ConcordanceDrift extends i2.ModularAccessor {
  ConcordanceDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i3.LemmaChoice> searchConcordanceLemmas({
    required String prefix,
    required int limit,
  }) {
    return customSelect(
      'SELECT COALESCE(lnsLemma, dictionaryRef) AS label, GROUP_CONCAT(dictionaryRef) AS dictionaryRefs, MIN(lnsPartOfSpeech) AS partOfSpeech, MIN(lnsInflection) AS inflection FROM "concordance.Lemmas" GROUP BY COALESCE(lnsLemma, dictionaryRef) HAVING MAX(dictionaryRef LIKE ?1 || \'%\' OR lnsLemma LIKE ?1 || \'%\') ORDER BY COALESCE(lnsLemma, dictionaryRef) <> ?1, LENGTH(COALESCE(lnsLemma, dictionaryRef)), COALESCE(lnsLemma, dictionaryRef) LIMIT ?2',
      variables: [i0.Variable<String>(prefix), i0.Variable<int>(limit)],
      readsFrom: {
        concordanceDetails,
        lnsRefResolutions,
        dictionaryEntries,
        dictionaries,
      },
    ).map(
      (i0.QueryRow row) => i3.LemmaChoice.fromSql(
        label: row.read<String>('label'),
        dictionaryRefs: row.readNullable<String>('dictionaryRefs'),
        partOfSpeech: row.readNullable<String>('partOfSpeech'),
        inflection: row.readNullable<String>('inflection'),
      ),
    );
  }

  i0.Selectable<i4.GrammarValueRow> getConcordanceGrammarValues() {
    return customSelect(
      'SELECT partOfSpeech, feature, value FROM "concordance.GrammarValues" ORDER BY partOfSpeech, feature, value',
      variables: [],
      readsFrom: {concordanceDetailInflections},
    ).map(
      (i0.QueryRow row) => i4.GrammarValueRow.fromSql(
        partOfSpeech: row.read<String>('partOfSpeech'),
        feature: row.read<String>('feature'),
        value: row.readNullable<String>('value'),
      ),
    );
  }

  i0.Selectable<GetConcordanceHitsResult> getConcordanceHits({
    required String works,
    required String phrase,
    int? fromIdx,
    int? toIdx,
    required List<bool> isTitleValues,
    required int sortNeighbour,
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 8;
    final expandedisTitleValues = $expandVar(
      $arrayStartIndex,
      isTitleValues.length,
    );
    $arrayStartIndex += isTitleValues.length;
    return customSelect(
      'WITH WorkOrder AS (SELECT CAST(Work."key" AS INTEGER) AS position, Work.value AS workId FROM json_each(?1)AS Work), Criteria AS MATERIALIZED (SELECT CAST(Word."key" AS INTEGER) + 1 AS slot, IFNULL(json_extract(Word.value, \'\$.distance\'), 1000000) AS distance, CAST(json_extract(Word.value, \'\$.spellings\') AS TEXT) AS spellings, CAST(json_extract(Word.value, \'\$.macronSpellings\') AS TEXT) AS macronSpellings, CAST(json_extract(Word.value, \'\$.lemma\') AS TEXT) AS lemma, CAST(json_extract(Word.value, \'\$.partOfSpeech\') AS TEXT) AS partOfSpeech, CAST(json_extract(Word.value, \'\$.gramCase\') AS TEXT) AS gramCase, CAST(json_extract(Word.value, \'\$.number\') AS TEXT) AS number, CAST(json_extract(Word.value, \'\$.gender\') AS TEXT) AS gender, CAST(json_extract(Word.value, \'\$.declension\') AS TEXT) AS declension, CAST(json_extract(Word.value, \'\$.person\') AS TEXT) AS person, CAST(json_extract(Word.value, \'\$.verbForm\') AS TEXT) AS verbForm, CAST(json_extract(Word.value, \'\$.tense\') AS TEXT) AS tense, CAST(json_extract(Word.value, \'\$.voice\') AS TEXT) AS voice FROM json_each(?2)AS Word), Spellings AS MATERIALIZED (SELECT Criteria.slot, Spelling.value AS form FROM Criteria,json_each(Criteria.spellings)AS Spelling), MacronSpellings AS MATERIALIZED (SELECT Criteria.slot, Spelling.value AS form FROM Criteria,json_each(Criteria.macronSpellings)AS Spelling), LemmaRefs AS MATERIALIZED (SELECT Criteria.slot, Ref.value AS dictionaryRef FROM Criteria,json_each(Criteria.lemma)AS Ref), Analysed AS MATERIALIZED (SELECT Criteria.slot, Analyses.form, Analyses.item FROM Criteria CROSS JOIN "concordance.AnalysesWithOptionalInflections" AS Analyses WHERE Criteria.spellings IS NULL AND(Criteria.lemma IS NULL OR Analyses.dictionaryRef IN (SELECT dictionaryRef FROM LemmaRefs WHERE LemmaRefs.slot = Criteria.slot))AND(Criteria.partOfSpeech IS NULL OR Analyses.partOfSpeech = Criteria.partOfSpeech)AND(Criteria.gramCase IS NULL OR instr(\'/\' || Analyses.gramCase || \'/\', \'/\' || Criteria.gramCase || \'/\') > 0)AND(Criteria.number IS NULL OR instr(\'/\' || Analyses.number || \'/\', \'/\' || Criteria.number || \'/\') > 0)AND(Criteria.gender IS NULL OR instr(\'/\' || Analyses.gender || \'/\', \'/\' || Criteria.gender || \'/\') > 0)AND(Criteria.declension IS NULL OR Analyses.declension = Criteria.declension)AND(Criteria.person IS NULL OR instr(\'/\' || Analyses.person || \'/\', \'/\' || Criteria.person || \'/\') > 0)AND(Criteria.verbForm IS NULL OR instr(\'/\' || Analyses.verbForm || \'/\', \'/\' || Criteria.verbForm || \'/\') > 0)AND(Criteria.tense IS NULL OR instr(\'/\' || Analyses.tense || \'/\', \'/\' || Criteria.tense || \'/\') > 0)AND(Criteria.voice IS NULL OR instr(\'/\' || Analyses.voice || \'/\', \'/\' || Criteria.voice || \'/\') > 0)), Slot1Matches AS (SELECT WorkOrder.position, Spelled.workId, Spelled.idx FROM WorkOrder CROSS JOIN WorkContents AS Spelled WHERE Spelled.workId = WorkOrder.workId AND +Spelled.idx BETWEEN ?3 AND ?4 AND(Spelled.lookupForm IN (SELECT form FROM Spellings WHERE slot = 1) OR Spelled.enclitic IN (SELECT form FROM Spellings WHERE slot = 1) OR(Spelled.enclitic IS NOT NULL AND Spelled.baseNormForm IN (SELECT form FROM Spellings WHERE slot = 1)))AND(NOT EXISTS (SELECT * FROM MacronSpellings WHERE slot = 1) OR Spelled.macronLookupForm IN (SELECT form FROM MacronSpellings WHERE slot = 1) OR Spelled.enclitic IN (SELECT form FROM MacronSpellings WHERE slot = 1) OR(Spelled.enclitic IS NOT NULL AND Spelled.macronBaseNormForm IN (SELECT form FROM MacronSpellings WHERE slot = 1)))UNION SELECT WorkOrder.position, Candidate.workId, Candidate.idx FROM WorkOrder CROSS JOIN Analysed CROSS JOIN ConcordanceCountableWordCandidateAnalyses AS Candidate WHERE Analysed.slot = 1 AND Candidate.form = Analysed.form AND Candidate.item = Analysed.item AND Candidate.workId = WorkOrder.workId AND Candidate.idx BETWEEN ?3 AND ?4), Hits AS (SELECT Slot1Matches.position, t1.workId, t1.sentenceIdx, t1.sourceReference AS reference, t1.isTitle, t1.idx AS firstIdx, COALESCE(t3.idx, t2.idx, t1.idx) AS lastIdx, t1.wordIdx AS firstWordIdx, COALESCE(t3.wordIdx, t2.wordIdx, t1.wordIdx) AS lastWordIdx, t1.idx AS slot1Idx, t2.idx AS slot2Idx, t3.idx AS slot3Idx FROM Slot1Matches CROSS JOIN WorkContents AS t1 LEFT OUTER JOIN WorkContents AS t2 ON EXISTS (SELECT * FROM Criteria WHERE slot = 2) AND t2.workId = t1.workId AND t2.sentenceIdx = t1.sentenceIdx AND t2.isTitle = t1.isTitle AND t2.wordIdx BETWEEN t1.wordIdx + 1 AND t1.wordIdx + (SELECT distance FROM Criteria WHERE slot = 2) AND t2.idx BETWEEN ?3 AND ?4 AND(t2.lookupForm IN (SELECT form FROM Spellings WHERE slot = 2) OR t2.enclitic IN (SELECT form FROM Spellings WHERE slot = 2) OR(t2.enclitic IS NOT NULL AND t2.baseNormForm IN (SELECT form FROM Spellings WHERE slot = 2))OR EXISTS (SELECT * FROM ConcordanceCountableWordCandidateAnalyses AS Candidate WHERE Candidate.workId = t2.workId AND Candidate.idx = t2.idx AND (+Candidate.form, Candidate.item) IN (SELECT form, item FROM Analysed WHERE slot = 2)))AND(NOT EXISTS (SELECT * FROM MacronSpellings WHERE slot = 2) OR t2.macronLookupForm IN (SELECT form FROM MacronSpellings WHERE slot = 2) OR t2.enclitic IN (SELECT form FROM MacronSpellings WHERE slot = 2) OR(t2.enclitic IS NOT NULL AND t2.macronBaseNormForm IN (SELECT form FROM MacronSpellings WHERE slot = 2)))LEFT OUTER JOIN WorkContents AS t3 ON EXISTS (SELECT * FROM Criteria WHERE slot = 3) AND t3.workId = t2.workId AND t3.sentenceIdx = t2.sentenceIdx AND t3.isTitle = t2.isTitle AND t3.wordIdx BETWEEN t2.wordIdx + 1 AND t2.wordIdx + (SELECT distance FROM Criteria WHERE slot = 3) AND t3.idx BETWEEN ?3 AND ?4 AND(t3.lookupForm IN (SELECT form FROM Spellings WHERE slot = 3) OR t3.enclitic IN (SELECT form FROM Spellings WHERE slot = 3) OR(t3.enclitic IS NOT NULL AND t3.baseNormForm IN (SELECT form FROM Spellings WHERE slot = 3))OR EXISTS (SELECT * FROM ConcordanceCountableWordCandidateAnalyses AS Candidate WHERE Candidate.workId = t3.workId AND Candidate.idx = t3.idx AND (+Candidate.form, Candidate.item) IN (SELECT form, item FROM Analysed WHERE slot = 3)))AND(NOT EXISTS (SELECT * FROM MacronSpellings WHERE slot = 3) OR t3.macronLookupForm IN (SELECT form FROM MacronSpellings WHERE slot = 3) OR t3.enclitic IN (SELECT form FROM MacronSpellings WHERE slot = 3) OR(t3.enclitic IS NOT NULL AND t3.macronBaseNormForm IN (SELECT form FROM MacronSpellings WHERE slot = 3)))WHERE t1.workId = Slot1Matches.workId AND t1.idx = Slot1Matches.idx AND t1.isTitle IN ($expandedisTitleValues) AND(t2.idx IS NOT NULL OR NOT EXISTS (SELECT * FROM Criteria WHERE slot = 2))AND(t3.idx IS NOT NULL OR NOT EXISTS (SELECT * FROM Criteria WHERE slot = 3))), Sorted AS (SELECT Hits.*, (SELECT LOWER(Neighbour.normForm) FROM WorkContents AS Neighbour WHERE ?5 <> 0 AND Neighbour.workId = Hits.workId AND Neighbour.sentenceIdx = Hits.sentenceIdx AND Neighbour.isTitle = Hits.isTitle AND Neighbour.wordIdx = ?5 + IIF(?5 > 0, Hits.lastWordIdx, Hits.firstWordIdx)) AS sortKey FROM Hits), Page AS (SELECT Sorted.*, COUNT(*)OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalHits FROM Sorted ORDER BY Sorted.sortKey IS NULL, Sorted.sortKey, Sorted.position, Sorted.firstIdx, Sorted.lastIdx, Sorted.slot2Idx, Sorted.slot3Idx LIMIT ?6 OFFSET ?7) SELECT Page.*, Context.idx AS contextIdx, Context.word AS contextWord, Context.macronizedWord AS contextMacronizedWord, Context.sourceReference AS contextReference FROM Page CROSS JOIN WorkContents AS Context WHERE Context.workId = Page.workId AND Context.idx BETWEEN Page.firstIdx - 12 AND Page.lastIdx + 12 ORDER BY Page.sortKey IS NULL, Page.sortKey, Page.position, Page.firstIdx, Page.lastIdx, Page.slot2Idx, Page.slot3Idx, Context.idx',
      variables: [
        i0.Variable<String>(works),
        i0.Variable<String>(phrase),
        i0.Variable<int>(fromIdx),
        i0.Variable<int>(toIdx),
        i0.Variable<int>(sortNeighbour),
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in isTitleValues) i0.Variable<bool>($),
      ],
      readsFrom: {
        workContents,
        concordanceCountableWordCandidateAnalyses,
        concordanceDetails,
        concordanceDetailInflections,
      },
    ).map(
      (i0.QueryRow row) => GetConcordanceHitsResult(
        position: row.read<int>('position'),
        workId: row.read<String>('workId'),
        sentenceIdx: row.read<int>('sentenceIdx'),
        reference: row.read<String>('reference'),
        isTitle: row.read<bool>('isTitle'),
        firstIdx: row.read<int>('firstIdx'),
        lastIdx: row.read<int>('lastIdx'),
        firstWordIdx: row.readNullable<int>('firstWordIdx'),
        lastWordIdx: row.readNullable<int>('lastWordIdx'),
        slot1Idx: row.read<int>('slot1Idx'),
        slot2Idx: row.readNullable<int>('slot2Idx'),
        slot3Idx: row.readNullable<int>('slot3Idx'),
        sortKey: row.readNullable<String>('sortKey'),
        totalHits: row.read<int>('totalHits'),
        contextIdx: row.read<int>('contextIdx'),
        contextWord: row.read<String>('contextWord'),
        contextMacronizedWord: row.read<String>('contextMacronizedWord'),
        contextReference: row.read<String>('contextReference'),
      ),
    );
  }

  i1.ConcordanceLemmas get concordanceLemmas => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ConcordanceLemmas>('concordance.Lemmas');
  i1.ConcordanceDetails get concordanceDetails => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ConcordanceDetails>('ConcordanceDetails');
  i5.LnsRefResolutions get lnsRefResolutions => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i5.LnsRefResolutions>('LnsRefResolutions');
  i5.DictionaryEntries get dictionaryEntries => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i5.DictionaryEntries>('DictionaryEntries');
  i5.Dictionaries get dictionaries => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i5.Dictionaries>('Dictionaries');
  i1.ConcordanceGrammarValues get concordanceGrammarValues =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.ConcordanceGrammarValues>('concordance.GrammarValues');
  i1.ConcordanceDetailInflections get concordanceDetailInflections =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.ConcordanceDetailInflections>(
        'ConcordanceDetailInflections',
      );
  i1.ConcordanceAnalysesWithOptionalInflections
  get concordanceAnalysesWithOptionalInflections =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.ConcordanceAnalysesWithOptionalInflections>(
        'concordance.AnalysesWithOptionalInflections',
      );
  i6.WorkContents get workContents => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i6.WorkContents>('WorkContents');
  i1.ConcordanceCountableWordCandidateAnalyses
  get concordanceCountableWordCandidateAnalyses =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.ConcordanceCountableWordCandidateAnalyses>(
        'ConcordanceCountableWordCandidateAnalyses',
      );
  i6.LibraryDrift get libraryDrift => this.accessor(i6.LibraryDrift.new);
  i5.DictionaryDrift get dictionaryDrift =>
      this.accessor(i5.DictionaryDrift.new);
}

class GetConcordanceHitsResult {
  final int position;
  final String workId;
  final int sentenceIdx;
  final String reference;
  final bool isTitle;
  final int firstIdx;
  final int lastIdx;
  final int? firstWordIdx;
  final int? lastWordIdx;
  final int slot1Idx;
  final int? slot2Idx;
  final int? slot3Idx;
  final String? sortKey;
  final int totalHits;
  final int contextIdx;
  final String contextWord;
  final String contextMacronizedWord;
  final String contextReference;
  GetConcordanceHitsResult({
    required this.position,
    required this.workId,
    required this.sentenceIdx,
    required this.reference,
    required this.isTitle,
    required this.firstIdx,
    required this.lastIdx,
    this.firstWordIdx,
    this.lastWordIdx,
    required this.slot1Idx,
    this.slot2Idx,
    this.slot3Idx,
    this.sortKey,
    required this.totalHits,
    required this.contextIdx,
    required this.contextWord,
    required this.contextMacronizedWord,
    required this.contextReference,
  });
}
