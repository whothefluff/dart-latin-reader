// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/library/library.drift.dart' as i1;
import 'dart:typed_data' as i2;
import 'package:drift/internal/modular.dart' as i3;
import 'package:latin_reader/src/component/library/authors_api.dart' as i4;
import 'package:latin_reader/src/component/library/work_details_api.dart' as i5;
import 'package:latin_reader/src/component/library/work_contents_api.dart'
    as i6;

typedef $AuthorsCreateCompanionBuilder =
    i1.AuthorsCompanion Function({
      required String id,
      required String name,
      required String about,
      required i2.Uint8List image,
    });
typedef $AuthorsUpdateCompanionBuilder =
    i1.AuthorsCompanion Function({
      i0.Value<String> id,
      i0.Value<String> name,
      i0.Value<String> about,
      i0.Value<i2.Uint8List> image,
    });

class $AuthorsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Authors> {
  $AuthorsFilterComposer({
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

  i0.ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<i2.Uint8List> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $AuthorsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Authors> {
  $AuthorsOrderingComposer({
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

  i0.ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<i2.Uint8List> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $AuthorsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Authors> {
  $AuthorsAnnotationComposer({
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

  i0.GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);

  i0.GeneratedColumn<i2.Uint8List> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);
}

class $AuthorsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.Authors,
          i1.Author,
          i1.$AuthorsFilterComposer,
          i1.$AuthorsOrderingComposer,
          i1.$AuthorsAnnotationComposer,
          $AuthorsCreateCompanionBuilder,
          $AuthorsUpdateCompanionBuilder,
          (
            i1.Author,
            i0.BaseReferences<i0.GeneratedDatabase, i1.Authors, i1.Author>,
          ),
          i1.Author,
          i0.PrefetchHooks Function()
        > {
  $AuthorsTableManager(i0.GeneratedDatabase db, i1.Authors table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$AuthorsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$AuthorsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$AuthorsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> id = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<String> about = const i0.Value.absent(),
                i0.Value<i2.Uint8List> image = const i0.Value.absent(),
              }) => i1.AuthorsCompanion(
                id: id,
                name: name,
                about: about,
                image: image,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String about,
                required i2.Uint8List image,
              }) => i1.AuthorsCompanion.insert(
                id: id,
                name: name,
                about: about,
                image: image,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $AuthorsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.Authors,
      i1.Author,
      i1.$AuthorsFilterComposer,
      i1.$AuthorsOrderingComposer,
      i1.$AuthorsAnnotationComposer,
      $AuthorsCreateCompanionBuilder,
      $AuthorsUpdateCompanionBuilder,
      (
        i1.Author,
        i0.BaseReferences<i0.GeneratedDatabase, i1.Authors, i1.Author>,
      ),
      i1.Author,
      i0.PrefetchHooks Function()
    >;
typedef $AuthorAbbreviationsCreateCompanionBuilder =
    i1.AuthorAbbreviationsCompanion Function({
      required String authorId,
      required int id,
      required String val,
    });
typedef $AuthorAbbreviationsUpdateCompanionBuilder =
    i1.AuthorAbbreviationsCompanion Function({
      i0.Value<String> authorId,
      i0.Value<int> id,
      i0.Value<String> val,
    });

class $AuthorAbbreviationsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AuthorAbbreviations> {
  $AuthorAbbreviationsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get val => $composableBuilder(
    column: $table.val,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $AuthorAbbreviationsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AuthorAbbreviations> {
  $AuthorAbbreviationsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get val => $composableBuilder(
    column: $table.val,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $AuthorAbbreviationsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AuthorAbbreviations> {
  $AuthorAbbreviationsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get val =>
      $composableBuilder(column: $table.val, builder: (column) => column);
}

class $AuthorAbbreviationsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.AuthorAbbreviations,
          i1.AuthorAbbreviation,
          i1.$AuthorAbbreviationsFilterComposer,
          i1.$AuthorAbbreviationsOrderingComposer,
          i1.$AuthorAbbreviationsAnnotationComposer,
          $AuthorAbbreviationsCreateCompanionBuilder,
          $AuthorAbbreviationsUpdateCompanionBuilder,
          (
            i1.AuthorAbbreviation,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.AuthorAbbreviations,
              i1.AuthorAbbreviation
            >,
          ),
          i1.AuthorAbbreviation,
          i0.PrefetchHooks Function()
        > {
  $AuthorAbbreviationsTableManager(
    i0.GeneratedDatabase db,
    i1.AuthorAbbreviations table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$AuthorAbbreviationsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$AuthorAbbreviationsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$AuthorAbbreviationsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> authorId = const i0.Value.absent(),
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> val = const i0.Value.absent(),
              }) => i1.AuthorAbbreviationsCompanion(
                authorId: authorId,
                id: id,
                val: val,
              ),
          createCompanionCallback:
              ({
                required String authorId,
                required int id,
                required String val,
              }) => i1.AuthorAbbreviationsCompanion.insert(
                authorId: authorId,
                id: id,
                val: val,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $AuthorAbbreviationsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.AuthorAbbreviations,
      i1.AuthorAbbreviation,
      i1.$AuthorAbbreviationsFilterComposer,
      i1.$AuthorAbbreviationsOrderingComposer,
      i1.$AuthorAbbreviationsAnnotationComposer,
      $AuthorAbbreviationsCreateCompanionBuilder,
      $AuthorAbbreviationsUpdateCompanionBuilder,
      (
        i1.AuthorAbbreviation,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.AuthorAbbreviations,
          i1.AuthorAbbreviation
        >,
      ),
      i1.AuthorAbbreviation,
      i0.PrefetchHooks Function()
    >;
typedef $WorksCreateCompanionBuilder =
    i1.WorksCompanion Function({
      required String id,
      required String name,
      required String about,
    });
typedef $WorksUpdateCompanionBuilder =
    i1.WorksCompanion Function({
      i0.Value<String> id,
      i0.Value<String> name,
      i0.Value<String> about,
    });

class $WorksFilterComposer extends i0.Composer<i0.GeneratedDatabase, i1.Works> {
  $WorksFilterComposer({
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

  i0.ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorksOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Works> {
  $WorksOrderingComposer({
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

  i0.ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorksAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Works> {
  $WorksAnnotationComposer({
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

  i0.GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);
}

class $WorksTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.Works,
          i1.Work,
          i1.$WorksFilterComposer,
          i1.$WorksOrderingComposer,
          i1.$WorksAnnotationComposer,
          $WorksCreateCompanionBuilder,
          $WorksUpdateCompanionBuilder,
          (i1.Work, i0.BaseReferences<i0.GeneratedDatabase, i1.Works, i1.Work>),
          i1.Work,
          i0.PrefetchHooks Function()
        > {
  $WorksTableManager(i0.GeneratedDatabase db, i1.Works table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$WorksFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$WorksOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$WorksAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> id = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<String> about = const i0.Value.absent(),
              }) => i1.WorksCompanion(id: id, name: name, about: about),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String about,
              }) => i1.WorksCompanion.insert(id: id, name: name, about: about),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorksProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.Works,
      i1.Work,
      i1.$WorksFilterComposer,
      i1.$WorksOrderingComposer,
      i1.$WorksAnnotationComposer,
      $WorksCreateCompanionBuilder,
      $WorksUpdateCompanionBuilder,
      (i1.Work, i0.BaseReferences<i0.GeneratedDatabase, i1.Works, i1.Work>),
      i1.Work,
      i0.PrefetchHooks Function()
    >;
typedef $WorkAbbreviationsCreateCompanionBuilder =
    i1.WorkAbbreviationsCompanion Function({
      required String workId,
      required int id,
      required String val,
    });
typedef $WorkAbbreviationsUpdateCompanionBuilder =
    i1.WorkAbbreviationsCompanion Function({
      i0.Value<String> workId,
      i0.Value<int> id,
      i0.Value<String> val,
    });

class $WorkAbbreviationsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkAbbreviations> {
  $WorkAbbreviationsFilterComposer({
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

  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get val => $composableBuilder(
    column: $table.val,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorkAbbreviationsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkAbbreviations> {
  $WorkAbbreviationsOrderingComposer({
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

  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get val => $composableBuilder(
    column: $table.val,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorkAbbreviationsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkAbbreviations> {
  $WorkAbbreviationsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get val =>
      $composableBuilder(column: $table.val, builder: (column) => column);
}

class $WorkAbbreviationsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.WorkAbbreviations,
          i1.WorkAbbreviation,
          i1.$WorkAbbreviationsFilterComposer,
          i1.$WorkAbbreviationsOrderingComposer,
          i1.$WorkAbbreviationsAnnotationComposer,
          $WorkAbbreviationsCreateCompanionBuilder,
          $WorkAbbreviationsUpdateCompanionBuilder,
          (
            i1.WorkAbbreviation,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.WorkAbbreviations,
              i1.WorkAbbreviation
            >,
          ),
          i1.WorkAbbreviation,
          i0.PrefetchHooks Function()
        > {
  $WorkAbbreviationsTableManager(
    i0.GeneratedDatabase db,
    i1.WorkAbbreviations table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$WorkAbbreviationsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$WorkAbbreviationsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$WorkAbbreviationsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> val = const i0.Value.absent(),
              }) => i1.WorkAbbreviationsCompanion(
                workId: workId,
                id: id,
                val: val,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required int id,
                required String val,
              }) => i1.WorkAbbreviationsCompanion.insert(
                workId: workId,
                id: id,
                val: val,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorkAbbreviationsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.WorkAbbreviations,
      i1.WorkAbbreviation,
      i1.$WorkAbbreviationsFilterComposer,
      i1.$WorkAbbreviationsOrderingComposer,
      i1.$WorkAbbreviationsAnnotationComposer,
      $WorkAbbreviationsCreateCompanionBuilder,
      $WorkAbbreviationsUpdateCompanionBuilder,
      (
        i1.WorkAbbreviation,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.WorkAbbreviations,
          i1.WorkAbbreviation
        >,
      ),
      i1.WorkAbbreviation,
      i0.PrefetchHooks Function()
    >;
typedef $WorkContentsCreateCompanionBuilder =
    i1.WorkContentsCompanion Function({
      required String workId,
      required int idx,
      required String word,
      required String sourceReference,
    });
typedef $WorkContentsUpdateCompanionBuilder =
    i1.WorkContentsCompanion Function({
      i0.Value<String> workId,
      i0.Value<int> idx,
      i0.Value<String> word,
      i0.Value<String> sourceReference,
    });

class $WorkContentsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContents> {
  $WorkContentsFilterComposer({
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

  i0.ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorkContentsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContents> {
  $WorkContentsOrderingComposer({
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

  i0.ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorkContentsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContents> {
  $WorkContentsAnnotationComposer({
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

  i0.GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  i0.GeneratedColumn<String> get sourceReference => $composableBuilder(
    column: $table.sourceReference,
    builder: (column) => column,
  );
}

class $WorkContentsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.WorkContents,
          i1.WorkContent,
          i1.$WorkContentsFilterComposer,
          i1.$WorkContentsOrderingComposer,
          i1.$WorkContentsAnnotationComposer,
          $WorkContentsCreateCompanionBuilder,
          $WorkContentsUpdateCompanionBuilder,
          (
            i1.WorkContent,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.WorkContents,
              i1.WorkContent
            >,
          ),
          i1.WorkContent,
          i0.PrefetchHooks Function()
        > {
  $WorkContentsTableManager(i0.GeneratedDatabase db, i1.WorkContents table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$WorkContentsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$WorkContentsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$WorkContentsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<int> idx = const i0.Value.absent(),
                i0.Value<String> word = const i0.Value.absent(),
                i0.Value<String> sourceReference = const i0.Value.absent(),
              }) => i1.WorkContentsCompanion(
                workId: workId,
                idx: idx,
                word: word,
                sourceReference: sourceReference,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required int idx,
                required String word,
                required String sourceReference,
              }) => i1.WorkContentsCompanion.insert(
                workId: workId,
                idx: idx,
                word: word,
                sourceReference: sourceReference,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorkContentsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.WorkContents,
      i1.WorkContent,
      i1.$WorkContentsFilterComposer,
      i1.$WorkContentsOrderingComposer,
      i1.$WorkContentsAnnotationComposer,
      $WorkContentsCreateCompanionBuilder,
      $WorkContentsUpdateCompanionBuilder,
      (
        i1.WorkContent,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.WorkContents,
          i1.WorkContent
        >,
      ),
      i1.WorkContent,
      i0.PrefetchHooks Function()
    >;
typedef $WorkContentSubdivisionsCreateCompanionBuilder =
    i1.WorkContentSubdivisionsCompanion Function({
      required String workId,
      required String node,
      required String typ,
      required int cnt,
      required String name,
      i0.Value<String?> parent,
      required int fromIndex,
      required int toIndex,
    });
typedef $WorkContentSubdivisionsUpdateCompanionBuilder =
    i1.WorkContentSubdivisionsCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> node,
      i0.Value<String> typ,
      i0.Value<int> cnt,
      i0.Value<String> name,
      i0.Value<String?> parent,
      i0.Value<int> fromIndex,
      i0.Value<int> toIndex,
    });

class $WorkContentSubdivisionsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContentSubdivisions> {
  $WorkContentSubdivisionsFilterComposer({
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

  i0.ColumnFilters<String> get node => $composableBuilder(
    column: $table.node,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get typ => $composableBuilder(
    column: $table.typ,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get parent => $composableBuilder(
    column: $table.parent,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get fromIndex => $composableBuilder(
    column: $table.fromIndex,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get toIndex => $composableBuilder(
    column: $table.toIndex,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorkContentSubdivisionsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContentSubdivisions> {
  $WorkContentSubdivisionsOrderingComposer({
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

  i0.ColumnOrderings<String> get node => $composableBuilder(
    column: $table.node,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get typ => $composableBuilder(
    column: $table.typ,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get parent => $composableBuilder(
    column: $table.parent,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get fromIndex => $composableBuilder(
    column: $table.fromIndex,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get toIndex => $composableBuilder(
    column: $table.toIndex,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorkContentSubdivisionsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContentSubdivisions> {
  $WorkContentSubdivisionsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get node =>
      $composableBuilder(column: $table.node, builder: (column) => column);

  i0.GeneratedColumn<String> get typ =>
      $composableBuilder(column: $table.typ, builder: (column) => column);

  i0.GeneratedColumn<int> get cnt =>
      $composableBuilder(column: $table.cnt, builder: (column) => column);

  i0.GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  i0.GeneratedColumn<String> get parent =>
      $composableBuilder(column: $table.parent, builder: (column) => column);

  i0.GeneratedColumn<int> get fromIndex =>
      $composableBuilder(column: $table.fromIndex, builder: (column) => column);

  i0.GeneratedColumn<int> get toIndex =>
      $composableBuilder(column: $table.toIndex, builder: (column) => column);
}

class $WorkContentSubdivisionsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.WorkContentSubdivisions,
          i1.WorkContentSubdivision,
          i1.$WorkContentSubdivisionsFilterComposer,
          i1.$WorkContentSubdivisionsOrderingComposer,
          i1.$WorkContentSubdivisionsAnnotationComposer,
          $WorkContentSubdivisionsCreateCompanionBuilder,
          $WorkContentSubdivisionsUpdateCompanionBuilder,
          (
            i1.WorkContentSubdivision,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.WorkContentSubdivisions,
              i1.WorkContentSubdivision
            >,
          ),
          i1.WorkContentSubdivision,
          i0.PrefetchHooks Function()
        > {
  $WorkContentSubdivisionsTableManager(
    i0.GeneratedDatabase db,
    i1.WorkContentSubdivisions table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$WorkContentSubdivisionsFilterComposer($db: db, $table: table),
          createOrderingComposer: () => i1
              .$WorkContentSubdivisionsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$WorkContentSubdivisionsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> node = const i0.Value.absent(),
                i0.Value<String> typ = const i0.Value.absent(),
                i0.Value<int> cnt = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<String?> parent = const i0.Value.absent(),
                i0.Value<int> fromIndex = const i0.Value.absent(),
                i0.Value<int> toIndex = const i0.Value.absent(),
              }) => i1.WorkContentSubdivisionsCompanion(
                workId: workId,
                node: node,
                typ: typ,
                cnt: cnt,
                name: name,
                parent: parent,
                fromIndex: fromIndex,
                toIndex: toIndex,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String node,
                required String typ,
                required int cnt,
                required String name,
                i0.Value<String?> parent = const i0.Value.absent(),
                required int fromIndex,
                required int toIndex,
              }) => i1.WorkContentSubdivisionsCompanion.insert(
                workId: workId,
                node: node,
                typ: typ,
                cnt: cnt,
                name: name,
                parent: parent,
                fromIndex: fromIndex,
                toIndex: toIndex,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorkContentSubdivisionsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.WorkContentSubdivisions,
      i1.WorkContentSubdivision,
      i1.$WorkContentSubdivisionsFilterComposer,
      i1.$WorkContentSubdivisionsOrderingComposer,
      i1.$WorkContentSubdivisionsAnnotationComposer,
      $WorkContentSubdivisionsCreateCompanionBuilder,
      $WorkContentSubdivisionsUpdateCompanionBuilder,
      (
        i1.WorkContentSubdivision,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.WorkContentSubdivisions,
          i1.WorkContentSubdivision
        >,
      ),
      i1.WorkContentSubdivision,
      i0.PrefetchHooks Function()
    >;
typedef $WorkContentSupplementaryCreateCompanionBuilder =
    i1.WorkContentSupplementaryCompanion Function({
      required String workId,
      required String typ,
      required int cnt,
      required int fromIndex,
      required int toIndex,
      required String val,
    });
typedef $WorkContentSupplementaryUpdateCompanionBuilder =
    i1.WorkContentSupplementaryCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> typ,
      i0.Value<int> cnt,
      i0.Value<int> fromIndex,
      i0.Value<int> toIndex,
      i0.Value<String> val,
    });

class $WorkContentSupplementaryFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContentSupplementary> {
  $WorkContentSupplementaryFilterComposer({
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

  i0.ColumnFilters<String> get typ => $composableBuilder(
    column: $table.typ,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get fromIndex => $composableBuilder(
    column: $table.fromIndex,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get toIndex => $composableBuilder(
    column: $table.toIndex,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get val => $composableBuilder(
    column: $table.val,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorkContentSupplementaryOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContentSupplementary> {
  $WorkContentSupplementaryOrderingComposer({
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

  i0.ColumnOrderings<String> get typ => $composableBuilder(
    column: $table.typ,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get fromIndex => $composableBuilder(
    column: $table.fromIndex,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get toIndex => $composableBuilder(
    column: $table.toIndex,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get val => $composableBuilder(
    column: $table.val,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorkContentSupplementaryAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkContentSupplementary> {
  $WorkContentSupplementaryAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get typ =>
      $composableBuilder(column: $table.typ, builder: (column) => column);

  i0.GeneratedColumn<int> get cnt =>
      $composableBuilder(column: $table.cnt, builder: (column) => column);

  i0.GeneratedColumn<int> get fromIndex =>
      $composableBuilder(column: $table.fromIndex, builder: (column) => column);

  i0.GeneratedColumn<int> get toIndex =>
      $composableBuilder(column: $table.toIndex, builder: (column) => column);

  i0.GeneratedColumn<String> get val =>
      $composableBuilder(column: $table.val, builder: (column) => column);
}

class $WorkContentSupplementaryTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.WorkContentSupplementary,
          i1.WorkContentSupplementaryData,
          i1.$WorkContentSupplementaryFilterComposer,
          i1.$WorkContentSupplementaryOrderingComposer,
          i1.$WorkContentSupplementaryAnnotationComposer,
          $WorkContentSupplementaryCreateCompanionBuilder,
          $WorkContentSupplementaryUpdateCompanionBuilder,
          (
            i1.WorkContentSupplementaryData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.WorkContentSupplementary,
              i1.WorkContentSupplementaryData
            >,
          ),
          i1.WorkContentSupplementaryData,
          i0.PrefetchHooks Function()
        > {
  $WorkContentSupplementaryTableManager(
    i0.GeneratedDatabase db,
    i1.WorkContentSupplementary table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => i1
              .$WorkContentSupplementaryFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$WorkContentSupplementaryOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$WorkContentSupplementaryAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> typ = const i0.Value.absent(),
                i0.Value<int> cnt = const i0.Value.absent(),
                i0.Value<int> fromIndex = const i0.Value.absent(),
                i0.Value<int> toIndex = const i0.Value.absent(),
                i0.Value<String> val = const i0.Value.absent(),
              }) => i1.WorkContentSupplementaryCompanion(
                workId: workId,
                typ: typ,
                cnt: cnt,
                fromIndex: fromIndex,
                toIndex: toIndex,
                val: val,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String typ,
                required int cnt,
                required int fromIndex,
                required int toIndex,
                required String val,
              }) => i1.WorkContentSupplementaryCompanion.insert(
                workId: workId,
                typ: typ,
                cnt: cnt,
                fromIndex: fromIndex,
                toIndex: toIndex,
                val: val,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorkContentSupplementaryProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.WorkContentSupplementary,
      i1.WorkContentSupplementaryData,
      i1.$WorkContentSupplementaryFilterComposer,
      i1.$WorkContentSupplementaryOrderingComposer,
      i1.$WorkContentSupplementaryAnnotationComposer,
      $WorkContentSupplementaryCreateCompanionBuilder,
      $WorkContentSupplementaryUpdateCompanionBuilder,
      (
        i1.WorkContentSupplementaryData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.WorkContentSupplementary,
          i1.WorkContentSupplementaryData
        >,
      ),
      i1.WorkContentSupplementaryData,
      i0.PrefetchHooks Function()
    >;
typedef $MacronizationsCreateCompanionBuilder =
    i1.MacronizationsCompanion Function({
      required String word,
      required String macronizedWord,
      required int isUncertain,
    });
typedef $MacronizationsUpdateCompanionBuilder =
    i1.MacronizationsCompanion Function({
      i0.Value<String> word,
      i0.Value<String> macronizedWord,
      i0.Value<int> isUncertain,
    });

class $MacronizationsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Macronizations> {
  $MacronizationsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get isUncertain => $composableBuilder(
    column: $table.isUncertain,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $MacronizationsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Macronizations> {
  $MacronizationsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get isUncertain => $composableBuilder(
    column: $table.isUncertain,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $MacronizationsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.Macronizations> {
  $MacronizationsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  i0.GeneratedColumn<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get isUncertain => $composableBuilder(
    column: $table.isUncertain,
    builder: (column) => column,
  );
}

class $MacronizationsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.Macronizations,
          i1.Macronization,
          i1.$MacronizationsFilterComposer,
          i1.$MacronizationsOrderingComposer,
          i1.$MacronizationsAnnotationComposer,
          $MacronizationsCreateCompanionBuilder,
          $MacronizationsUpdateCompanionBuilder,
          (
            i1.Macronization,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.Macronizations,
              i1.Macronization
            >,
          ),
          i1.Macronization,
          i0.PrefetchHooks Function()
        > {
  $MacronizationsTableManager(i0.GeneratedDatabase db, i1.Macronizations table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$MacronizationsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$MacronizationsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$MacronizationsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> word = const i0.Value.absent(),
                i0.Value<String> macronizedWord = const i0.Value.absent(),
                i0.Value<int> isUncertain = const i0.Value.absent(),
              }) => i1.MacronizationsCompanion(
                word: word,
                macronizedWord: macronizedWord,
                isUncertain: isUncertain,
              ),
          createCompanionCallback:
              ({
                required String word,
                required String macronizedWord,
                required int isUncertain,
              }) => i1.MacronizationsCompanion.insert(
                word: word,
                macronizedWord: macronizedWord,
                isUncertain: isUncertain,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $MacronizationsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.Macronizations,
      i1.Macronization,
      i1.$MacronizationsFilterComposer,
      i1.$MacronizationsOrderingComposer,
      i1.$MacronizationsAnnotationComposer,
      $MacronizationsCreateCompanionBuilder,
      $MacronizationsUpdateCompanionBuilder,
      (
        i1.Macronization,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.Macronizations,
          i1.Macronization
        >,
      ),
      i1.Macronization,
      i0.PrefetchHooks Function()
    >;
typedef $WorkMacronizationsCreateCompanionBuilder =
    i1.WorkMacronizationsCompanion Function({
      required String workId,
      required String idx,
      required String macronizedWord,
    });
typedef $WorkMacronizationsUpdateCompanionBuilder =
    i1.WorkMacronizationsCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> idx,
      i0.Value<String> macronizedWord,
    });

class $WorkMacronizationsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkMacronizations> {
  $WorkMacronizationsFilterComposer({
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

  i0.ColumnFilters<String> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorkMacronizationsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkMacronizations> {
  $WorkMacronizationsOrderingComposer({
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

  i0.ColumnOrderings<String> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorkMacronizationsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkMacronizations> {
  $WorkMacronizationsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get idx =>
      $composableBuilder(column: $table.idx, builder: (column) => column);

  i0.GeneratedColumn<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => column,
  );
}

class $WorkMacronizationsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.WorkMacronizations,
          i1.WorkMacronization,
          i1.$WorkMacronizationsFilterComposer,
          i1.$WorkMacronizationsOrderingComposer,
          i1.$WorkMacronizationsAnnotationComposer,
          $WorkMacronizationsCreateCompanionBuilder,
          $WorkMacronizationsUpdateCompanionBuilder,
          (
            i1.WorkMacronization,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.WorkMacronizations,
              i1.WorkMacronization
            >,
          ),
          i1.WorkMacronization,
          i0.PrefetchHooks Function()
        > {
  $WorkMacronizationsTableManager(
    i0.GeneratedDatabase db,
    i1.WorkMacronizations table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$WorkMacronizationsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$WorkMacronizationsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$WorkMacronizationsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> idx = const i0.Value.absent(),
                i0.Value<String> macronizedWord = const i0.Value.absent(),
              }) => i1.WorkMacronizationsCompanion(
                workId: workId,
                idx: idx,
                macronizedWord: macronizedWord,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String idx,
                required String macronizedWord,
              }) => i1.WorkMacronizationsCompanion.insert(
                workId: workId,
                idx: idx,
                macronizedWord: macronizedWord,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorkMacronizationsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.WorkMacronizations,
      i1.WorkMacronization,
      i1.$WorkMacronizationsFilterComposer,
      i1.$WorkMacronizationsOrderingComposer,
      i1.$WorkMacronizationsAnnotationComposer,
      $WorkMacronizationsCreateCompanionBuilder,
      $WorkMacronizationsUpdateCompanionBuilder,
      (
        i1.WorkMacronization,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.WorkMacronizations,
          i1.WorkMacronization
        >,
      ),
      i1.WorkMacronization,
      i0.PrefetchHooks Function()
    >;
typedef $UserProvidedMacronizationsCreateCompanionBuilder =
    i1.UserProvidedMacronizationsCompanion Function({
      required String workId,
      required String idx,
      required String macronizedWord,
    });
typedef $UserProvidedMacronizationsUpdateCompanionBuilder =
    i1.UserProvidedMacronizationsCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> idx,
      i0.Value<String> macronizedWord,
    });

class $UserProvidedMacronizationsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.UserProvidedMacronizations> {
  $UserProvidedMacronizationsFilterComposer({
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

  i0.ColumnFilters<String> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $UserProvidedMacronizationsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.UserProvidedMacronizations> {
  $UserProvidedMacronizationsOrderingComposer({
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

  i0.ColumnOrderings<String> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $UserProvidedMacronizationsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.UserProvidedMacronizations> {
  $UserProvidedMacronizationsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  i0.GeneratedColumn<String> get idx =>
      $composableBuilder(column: $table.idx, builder: (column) => column);

  i0.GeneratedColumn<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => column,
  );
}

class $UserProvidedMacronizationsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.UserProvidedMacronizations,
          i1.UserProvidedMacronization,
          i1.$UserProvidedMacronizationsFilterComposer,
          i1.$UserProvidedMacronizationsOrderingComposer,
          i1.$UserProvidedMacronizationsAnnotationComposer,
          $UserProvidedMacronizationsCreateCompanionBuilder,
          $UserProvidedMacronizationsUpdateCompanionBuilder,
          (
            i1.UserProvidedMacronization,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.UserProvidedMacronizations,
              i1.UserProvidedMacronization
            >,
          ),
          i1.UserProvidedMacronization,
          i0.PrefetchHooks Function()
        > {
  $UserProvidedMacronizationsTableManager(
    i0.GeneratedDatabase db,
    i1.UserProvidedMacronizations table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$UserProvidedMacronizationsFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              i1.$UserProvidedMacronizationsOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$UserProvidedMacronizationsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> idx = const i0.Value.absent(),
                i0.Value<String> macronizedWord = const i0.Value.absent(),
              }) => i1.UserProvidedMacronizationsCompanion(
                workId: workId,
                idx: idx,
                macronizedWord: macronizedWord,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String idx,
                required String macronizedWord,
              }) => i1.UserProvidedMacronizationsCompanion.insert(
                workId: workId,
                idx: idx,
                macronizedWord: macronizedWord,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $UserProvidedMacronizationsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.UserProvidedMacronizations,
      i1.UserProvidedMacronization,
      i1.$UserProvidedMacronizationsFilterComposer,
      i1.$UserProvidedMacronizationsOrderingComposer,
      i1.$UserProvidedMacronizationsAnnotationComposer,
      $UserProvidedMacronizationsCreateCompanionBuilder,
      $UserProvidedMacronizationsUpdateCompanionBuilder,
      (
        i1.UserProvidedMacronization,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.UserProvidedMacronizations,
          i1.UserProvidedMacronization
        >,
      ),
      i1.UserProvidedMacronization,
      i0.PrefetchHooks Function()
    >;
typedef $AuthorsAndWorksCreateCompanionBuilder =
    i1.AuthorsAndWorksCompanion Function({
      required String authorId,
      required String workId,
    });
typedef $AuthorsAndWorksUpdateCompanionBuilder =
    i1.AuthorsAndWorksCompanion Function({
      i0.Value<String> authorId,
      i0.Value<String> workId,
    });

class $AuthorsAndWorksFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AuthorsAndWorks> {
  $AuthorsAndWorksFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $AuthorsAndWorksOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AuthorsAndWorks> {
  $AuthorsAndWorksOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get workId => $composableBuilder(
    column: $table.workId,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $AuthorsAndWorksAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.AuthorsAndWorks> {
  $AuthorsAndWorksAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  i0.GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);
}

class $AuthorsAndWorksTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.AuthorsAndWorks,
          i1.AuthorsAndWork,
          i1.$AuthorsAndWorksFilterComposer,
          i1.$AuthorsAndWorksOrderingComposer,
          i1.$AuthorsAndWorksAnnotationComposer,
          $AuthorsAndWorksCreateCompanionBuilder,
          $AuthorsAndWorksUpdateCompanionBuilder,
          (
            i1.AuthorsAndWork,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.AuthorsAndWorks,
              i1.AuthorsAndWork
            >,
          ),
          i1.AuthorsAndWork,
          i0.PrefetchHooks Function()
        > {
  $AuthorsAndWorksTableManager(
    i0.GeneratedDatabase db,
    i1.AuthorsAndWorks table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$AuthorsAndWorksFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$AuthorsAndWorksOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$AuthorsAndWorksAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> authorId = const i0.Value.absent(),
                i0.Value<String> workId = const i0.Value.absent(),
              }) => i1.AuthorsAndWorksCompanion(
                authorId: authorId,
                workId: workId,
              ),
          createCompanionCallback:
              ({required String authorId, required String workId}) =>
                  i1.AuthorsAndWorksCompanion.insert(
                    authorId: authorId,
                    workId: workId,
                  ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $AuthorsAndWorksProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.AuthorsAndWorks,
      i1.AuthorsAndWork,
      i1.$AuthorsAndWorksFilterComposer,
      i1.$AuthorsAndWorksOrderingComposer,
      i1.$AuthorsAndWorksAnnotationComposer,
      $AuthorsAndWorksCreateCompanionBuilder,
      $AuthorsAndWorksUpdateCompanionBuilder,
      (
        i1.AuthorsAndWork,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.AuthorsAndWorks,
          i1.AuthorsAndWork
        >,
      ),
      i1.AuthorsAndWork,
      i0.PrefetchHooks Function()
    >;

class Authors extends i0.Table with i0.TableInfo<Authors, i1.Author> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Authors(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _aboutMeta = const i0.VerificationMeta(
    'about',
  );
  late final i0.GeneratedColumn<String> about = i0.GeneratedColumn<String>(
    'about',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _imageMeta = const i0.VerificationMeta(
    'image',
  );
  late final i0.GeneratedColumn<i2.Uint8List> image =
      i0.GeneratedColumn<i2.Uint8List>(
        'image',
        aliasedName,
        false,
        type: i0.DriftSqlType.blob,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [id, name, about, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Authors';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.Author> instance, {
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
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
      );
    } else if (isInserting) {
      context.missing(_aboutMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Author map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Author(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      about: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}about'],
      )!,
      image: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.blob,
        data['${effectivePrefix}image'],
      )!,
    );
  }

  @override
  Authors createAlias(String alias) {
    return Authors(attachedDatabase, alias);
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

class Author extends i0.DataClass implements i0.Insertable<i1.Author> {
  final String id;
  final String name;
  final String about;

  ///TODO: add check with length range so that it always looks ok from the page
  final i2.Uint8List image;
  const Author({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['name'] = i0.Variable<String>(name);
    map['about'] = i0.Variable<String>(about);
    map['image'] = i0.Variable<i2.Uint8List>(image);
    return map;
  }

  i1.AuthorsCompanion toCompanion(bool nullToAbsent) {
    return i1.AuthorsCompanion(
      id: i0.Value(id),
      name: i0.Value(name),
      about: i0.Value(about),
      image: i0.Value(image),
    );
  }

  factory Author.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Author(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String>(json['about']),
      image: serializer.fromJson<i2.Uint8List>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String>(about),
      'image': serializer.toJson<i2.Uint8List>(image),
    };
  }

  i1.Author copyWith({
    String? id,
    String? name,
    String? about,
    i2.Uint8List? image,
  }) => i1.Author(
    id: id ?? this.id,
    name: name ?? this.name,
    about: about ?? this.about,
    image: image ?? this.image,
  );
  Author copyWithCompanion(i1.AuthorsCompanion data) {
    return Author(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      about: data.about.present ? data.about.value : this.about,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Author(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, about, i0.$driftBlobEquality.hash(image));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Author &&
          other.id == this.id &&
          other.name == this.name &&
          other.about == this.about &&
          i0.$driftBlobEquality.equals(other.image, this.image));
}

class AuthorsCompanion extends i0.UpdateCompanion<i1.Author> {
  final i0.Value<String> id;
  final i0.Value<String> name;
  final i0.Value<String> about;
  final i0.Value<i2.Uint8List> image;
  const AuthorsCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.about = const i0.Value.absent(),
    this.image = const i0.Value.absent(),
  });
  AuthorsCompanion.insert({
    required String id,
    required String name,
    required String about,
    required i2.Uint8List image,
  }) : id = i0.Value(id),
       name = i0.Value(name),
       about = i0.Value(about),
       image = i0.Value(image);
  static i0.Insertable<i1.Author> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? name,
    i0.Expression<String>? about,
    i0.Expression<i2.Uint8List>? image,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
      if (image != null) 'image': image,
    });
  }

  i1.AuthorsCompanion copyWith({
    i0.Value<String>? id,
    i0.Value<String>? name,
    i0.Value<String>? about,
    i0.Value<i2.Uint8List>? image,
  }) {
    return i1.AuthorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
      image: image ?? this.image,
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
    if (about.present) {
      map['about'] = i0.Variable<String>(about.value);
    }
    if (image.present) {
      map['image'] = i0.Variable<i2.Uint8List>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class AuthorAbbreviations extends i0.Table
    with i0.TableInfo<AuthorAbbreviations, i1.AuthorAbbreviation> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  AuthorAbbreviations(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _authorIdMeta = const i0.VerificationMeta(
    'authorId',
  );
  late final i0.GeneratedColumn<String> authorId = i0.GeneratedColumn<String>(
    'authorId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (id >= 0)',
  );
  static const i0.VerificationMeta _valMeta = const i0.VerificationMeta('val');
  late final i0.GeneratedColumn<String> val = i0.GeneratedColumn<String>(
    'val',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [authorId, id, val];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'AuthorAbbreviations';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.AuthorAbbreviation> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('authorId')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['authorId']!, _authorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('val')) {
      context.handle(
        _valMeta,
        val.isAcceptableOrUnknown(data['val']!, _valMeta),
      );
    } else if (isInserting) {
      context.missing(_valMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {authorId, id};
  @override
  i1.AuthorAbbreviation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.AuthorAbbreviation(
      authorId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}authorId'],
      )!,
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      val: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}val'],
      )!,
    );
  }

  @override
  AuthorAbbreviations createAlias(String alias) {
    return AuthorAbbreviations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(authorId, id)',
    'FOREIGN KEY(authorId)REFERENCES Authors(id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class AuthorAbbreviation extends i0.DataClass
    implements i0.Insertable<i1.AuthorAbbreviation> {
  final String authorId;
  final int id;
  final String val;
  const AuthorAbbreviation({
    required this.authorId,
    required this.id,
    required this.val,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['authorId'] = i0.Variable<String>(authorId);
    map['id'] = i0.Variable<int>(id);
    map['val'] = i0.Variable<String>(val);
    return map;
  }

  i1.AuthorAbbreviationsCompanion toCompanion(bool nullToAbsent) {
    return i1.AuthorAbbreviationsCompanion(
      authorId: i0.Value(authorId),
      id: i0.Value(id),
      val: i0.Value(val),
    );
  }

  factory AuthorAbbreviation.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return AuthorAbbreviation(
      authorId: serializer.fromJson<String>(json['authorId']),
      id: serializer.fromJson<int>(json['id']),
      val: serializer.fromJson<String>(json['val']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'authorId': serializer.toJson<String>(authorId),
      'id': serializer.toJson<int>(id),
      'val': serializer.toJson<String>(val),
    };
  }

  i1.AuthorAbbreviation copyWith({String? authorId, int? id, String? val}) =>
      i1.AuthorAbbreviation(
        authorId: authorId ?? this.authorId,
        id: id ?? this.id,
        val: val ?? this.val,
      );
  AuthorAbbreviation copyWithCompanion(i1.AuthorAbbreviationsCompanion data) {
    return AuthorAbbreviation(
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      id: data.id.present ? data.id.value : this.id,
      val: data.val.present ? data.val.value : this.val,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthorAbbreviation(')
          ..write('authorId: $authorId, ')
          ..write('id: $id, ')
          ..write('val: $val')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(authorId, id, val);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.AuthorAbbreviation &&
          other.authorId == this.authorId &&
          other.id == this.id &&
          other.val == this.val);
}

class AuthorAbbreviationsCompanion
    extends i0.UpdateCompanion<i1.AuthorAbbreviation> {
  final i0.Value<String> authorId;
  final i0.Value<int> id;
  final i0.Value<String> val;
  const AuthorAbbreviationsCompanion({
    this.authorId = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    this.val = const i0.Value.absent(),
  });
  AuthorAbbreviationsCompanion.insert({
    required String authorId,
    required int id,
    required String val,
  }) : authorId = i0.Value(authorId),
       id = i0.Value(id),
       val = i0.Value(val);
  static i0.Insertable<i1.AuthorAbbreviation> custom({
    i0.Expression<String>? authorId,
    i0.Expression<int>? id,
    i0.Expression<String>? val,
  }) {
    return i0.RawValuesInsertable({
      if (authorId != null) 'authorId': authorId,
      if (id != null) 'id': id,
      if (val != null) 'val': val,
    });
  }

  i1.AuthorAbbreviationsCompanion copyWith({
    i0.Value<String>? authorId,
    i0.Value<int>? id,
    i0.Value<String>? val,
  }) {
    return i1.AuthorAbbreviationsCompanion(
      authorId: authorId ?? this.authorId,
      id: id ?? this.id,
      val: val ?? this.val,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (authorId.present) {
      map['authorId'] = i0.Variable<String>(authorId.value);
    }
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (val.present) {
      map['val'] = i0.Variable<String>(val.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorAbbreviationsCompanion(')
          ..write('authorId: $authorId, ')
          ..write('id: $id, ')
          ..write('val: $val')
          ..write(')'))
        .toString();
  }
}

class Works extends i0.Table with i0.TableInfo<Works, i1.Work> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Works(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _aboutMeta = const i0.VerificationMeta(
    'about',
  );
  late final i0.GeneratedColumn<String> about = i0.GeneratedColumn<String>(
    'about',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [id, name, about];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Works';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.Work> instance, {
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
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
      );
    } else if (isInserting) {
      context.missing(_aboutMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Work map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Work(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      about: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}about'],
      )!,
    );
  }

  @override
  Works createAlias(String alias) {
    return Works(attachedDatabase, alias);
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

class Work extends i0.DataClass implements i0.Insertable<i1.Work> {
  final String id;
  final String name;
  final String about;
  const Work({required this.id, required this.name, required this.about});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['name'] = i0.Variable<String>(name);
    map['about'] = i0.Variable<String>(about);
    return map;
  }

  i1.WorksCompanion toCompanion(bool nullToAbsent) {
    return i1.WorksCompanion(
      id: i0.Value(id),
      name: i0.Value(name),
      about: i0.Value(about),
    );
  }

  factory Work.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Work(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String>(json['about']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String>(about),
    };
  }

  i1.Work copyWith({String? id, String? name, String? about}) => i1.Work(
    id: id ?? this.id,
    name: name ?? this.name,
    about: about ?? this.about,
  );
  Work copyWithCompanion(i1.WorksCompanion data) {
    return Work(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      about: data.about.present ? data.about.value : this.about,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Work(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, about);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Work &&
          other.id == this.id &&
          other.name == this.name &&
          other.about == this.about);
}

class WorksCompanion extends i0.UpdateCompanion<i1.Work> {
  final i0.Value<String> id;
  final i0.Value<String> name;
  final i0.Value<String> about;
  const WorksCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.about = const i0.Value.absent(),
  });
  WorksCompanion.insert({
    required String id,
    required String name,
    required String about,
  }) : id = i0.Value(id),
       name = i0.Value(name),
       about = i0.Value(about);
  static i0.Insertable<i1.Work> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? name,
    i0.Expression<String>? about,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
    });
  }

  i1.WorksCompanion copyWith({
    i0.Value<String>? id,
    i0.Value<String>? name,
    i0.Value<String>? about,
  }) {
    return i1.WorksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
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
    if (about.present) {
      map['about'] = i0.Variable<String>(about.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }
}

class WorkAbbreviations extends i0.Table
    with i0.TableInfo<WorkAbbreviations, i1.WorkAbbreviation> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkAbbreviations(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (id >= 0)',
  );
  static const i0.VerificationMeta _valMeta = const i0.VerificationMeta('val');
  late final i0.GeneratedColumn<String> val = i0.GeneratedColumn<String>(
    'val',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [workId, id, val];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkAbbreviations';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.WorkAbbreviation> instance, {
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('val')) {
      context.handle(
        _valMeta,
        val.isAcceptableOrUnknown(data['val']!, _valMeta),
      );
    } else if (isInserting) {
      context.missing(_valMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, id};
  @override
  i1.WorkAbbreviation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkAbbreviation(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      val: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}val'],
      )!,
    );
  }

  @override
  WorkAbbreviations createAlias(String alias) {
    return WorkAbbreviations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, id)',
    'FOREIGN KEY(workId)REFERENCES Works(id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkAbbreviation extends i0.DataClass
    implements i0.Insertable<i1.WorkAbbreviation> {
  final String workId;
  final int id;
  final String val;
  const WorkAbbreviation({
    required this.workId,
    required this.id,
    required this.val,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['id'] = i0.Variable<int>(id);
    map['val'] = i0.Variable<String>(val);
    return map;
  }

  i1.WorkAbbreviationsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkAbbreviationsCompanion(
      workId: i0.Value(workId),
      id: i0.Value(id),
      val: i0.Value(val),
    );
  }

  factory WorkAbbreviation.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkAbbreviation(
      workId: serializer.fromJson<String>(json['workId']),
      id: serializer.fromJson<int>(json['id']),
      val: serializer.fromJson<String>(json['val']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'id': serializer.toJson<int>(id),
      'val': serializer.toJson<String>(val),
    };
  }

  i1.WorkAbbreviation copyWith({String? workId, int? id, String? val}) =>
      i1.WorkAbbreviation(
        workId: workId ?? this.workId,
        id: id ?? this.id,
        val: val ?? this.val,
      );
  WorkAbbreviation copyWithCompanion(i1.WorkAbbreviationsCompanion data) {
    return WorkAbbreviation(
      workId: data.workId.present ? data.workId.value : this.workId,
      id: data.id.present ? data.id.value : this.id,
      val: data.val.present ? data.val.value : this.val,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkAbbreviation(')
          ..write('workId: $workId, ')
          ..write('id: $id, ')
          ..write('val: $val')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, id, val);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkAbbreviation &&
          other.workId == this.workId &&
          other.id == this.id &&
          other.val == this.val);
}

class WorkAbbreviationsCompanion
    extends i0.UpdateCompanion<i1.WorkAbbreviation> {
  final i0.Value<String> workId;
  final i0.Value<int> id;
  final i0.Value<String> val;
  const WorkAbbreviationsCompanion({
    this.workId = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    this.val = const i0.Value.absent(),
  });
  WorkAbbreviationsCompanion.insert({
    required String workId,
    required int id,
    required String val,
  }) : workId = i0.Value(workId),
       id = i0.Value(id),
       val = i0.Value(val);
  static i0.Insertable<i1.WorkAbbreviation> custom({
    i0.Expression<String>? workId,
    i0.Expression<int>? id,
    i0.Expression<String>? val,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (id != null) 'id': id,
      if (val != null) 'val': val,
    });
  }

  i1.WorkAbbreviationsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<int>? id,
    i0.Value<String>? val,
  }) {
    return i1.WorkAbbreviationsCompanion(
      workId: workId ?? this.workId,
      id: id ?? this.id,
      val: val ?? this.val,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (val.present) {
      map['val'] = i0.Variable<String>(val.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkAbbreviationsCompanion(')
          ..write('workId: $workId, ')
          ..write('id: $id, ')
          ..write('val: $val')
          ..write(')'))
        .toString();
  }
}

class WorkContents extends i0.Table
    with i0.TableInfo<WorkContents, i1.WorkContent> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkContents(this.attachedDatabase, [this._alias]);
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
    $customConstraints: 'NOT NULL CHECK (idx >= 0)',
  );
  static const i0.VerificationMeta _wordMeta = const i0.VerificationMeta(
    'word',
  );
  late final i0.GeneratedColumn<String> word = i0.GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _sourceReferenceMeta =
      const i0.VerificationMeta('sourceReference');
  late final i0.GeneratedColumn<String> sourceReference =
      i0.GeneratedColumn<String>(
        'sourceReference',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [workId, idx, word, sourceReference];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkContents';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.WorkContent> instance, {
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
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('sourceReference')) {
      context.handle(
        _sourceReferenceMeta,
        sourceReference.isAcceptableOrUnknown(
          data['sourceReference']!,
          _sourceReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceReferenceMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, idx};
  @override
  i1.WorkContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkContent(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}idx'],
      )!,
      word: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      sourceReference: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}sourceReference'],
      )!,
    );
  }

  @override
  WorkContents createAlias(String alias) {
    return WorkContents(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, idx)',
    'FOREIGN KEY(workId)REFERENCES Works(id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkContent extends i0.DataClass
    implements i0.Insertable<i1.WorkContent> {
  final String workId;
  final int idx;
  final String word;
  final String sourceReference;
  const WorkContent({
    required this.workId,
    required this.idx,
    required this.word,
    required this.sourceReference,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['idx'] = i0.Variable<int>(idx);
    map['word'] = i0.Variable<String>(word);
    map['sourceReference'] = i0.Variable<String>(sourceReference);
    return map;
  }

  i1.WorkContentsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkContentsCompanion(
      workId: i0.Value(workId),
      idx: i0.Value(idx),
      word: i0.Value(word),
      sourceReference: i0.Value(sourceReference),
    );
  }

  factory WorkContent.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkContent(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<int>(json['idx']),
      word: serializer.fromJson<String>(json['word']),
      sourceReference: serializer.fromJson<String>(json['sourceReference']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<int>(idx),
      'word': serializer.toJson<String>(word),
      'sourceReference': serializer.toJson<String>(sourceReference),
    };
  }

  i1.WorkContent copyWith({
    String? workId,
    int? idx,
    String? word,
    String? sourceReference,
  }) => i1.WorkContent(
    workId: workId ?? this.workId,
    idx: idx ?? this.idx,
    word: word ?? this.word,
    sourceReference: sourceReference ?? this.sourceReference,
  );
  WorkContent copyWithCompanion(i1.WorkContentsCompanion data) {
    return WorkContent(
      workId: data.workId.present ? data.workId.value : this.workId,
      idx: data.idx.present ? data.idx.value : this.idx,
      word: data.word.present ? data.word.value : this.word,
      sourceReference: data.sourceReference.present
          ? data.sourceReference.value
          : this.sourceReference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkContent(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('word: $word, ')
          ..write('sourceReference: $sourceReference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, idx, word, sourceReference);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkContent &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.word == this.word &&
          other.sourceReference == this.sourceReference);
}

class WorkContentsCompanion extends i0.UpdateCompanion<i1.WorkContent> {
  final i0.Value<String> workId;
  final i0.Value<int> idx;
  final i0.Value<String> word;
  final i0.Value<String> sourceReference;
  const WorkContentsCompanion({
    this.workId = const i0.Value.absent(),
    this.idx = const i0.Value.absent(),
    this.word = const i0.Value.absent(),
    this.sourceReference = const i0.Value.absent(),
  });
  WorkContentsCompanion.insert({
    required String workId,
    required int idx,
    required String word,
    required String sourceReference,
  }) : workId = i0.Value(workId),
       idx = i0.Value(idx),
       word = i0.Value(word),
       sourceReference = i0.Value(sourceReference);
  static i0.Insertable<i1.WorkContent> custom({
    i0.Expression<String>? workId,
    i0.Expression<int>? idx,
    i0.Expression<String>? word,
    i0.Expression<String>? sourceReference,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (word != null) 'word': word,
      if (sourceReference != null) 'sourceReference': sourceReference,
    });
  }

  i1.WorkContentsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<int>? idx,
    i0.Value<String>? word,
    i0.Value<String>? sourceReference,
  }) {
    return i1.WorkContentsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      word: word ?? this.word,
      sourceReference: sourceReference ?? this.sourceReference,
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
    if (word.present) {
      map['word'] = i0.Variable<String>(word.value);
    }
    if (sourceReference.present) {
      map['sourceReference'] = i0.Variable<String>(sourceReference.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentsCompanion(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('word: $word, ')
          ..write('sourceReference: $sourceReference')
          ..write(')'))
        .toString();
  }
}

class WorkContentSubdivisions extends i0.Table
    with i0.TableInfo<WorkContentSubdivisions, i1.WorkContentSubdivision> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkContentSubdivisions(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _nodeMeta = const i0.VerificationMeta(
    'node',
  );
  late final i0.GeneratedColumn<String> node = i0.GeneratedColumn<String>(
    'node',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (node LIKE \'________-____-____-____-____________\')',
  );
  static const i0.VerificationMeta _typMeta = const i0.VerificationMeta('typ');
  late final i0.GeneratedColumn<String> typ = i0.GeneratedColumn<String>(
    'typ',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (typ IN (\'VERS\', \'BOOK\', \'POEM\', \'PROL\', \'EPIL\', \'TITL\', \'PARA\'))',
  );
  static const i0.VerificationMeta _cntMeta = const i0.VerificationMeta('cnt');
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
    'cnt',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (cnt >= 0)',
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
  static const i0.VerificationMeta _parentMeta = const i0.VerificationMeta(
    'parent',
  );
  late final i0.GeneratedColumn<String> parent = i0.GeneratedColumn<String>(
    'parent',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'CHECK (parent IS NULL OR parent LIKE \'________-____-____-____-____________\')',
  );
  static const i0.VerificationMeta _fromIndexMeta = const i0.VerificationMeta(
    'fromIndex',
  );
  late final i0.GeneratedColumn<int> fromIndex = i0.GeneratedColumn<int>(
    'fromIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (fromIndex >= 0)',
  );
  static const i0.VerificationMeta _toIndexMeta = const i0.VerificationMeta(
    'toIndex',
  );
  late final i0.GeneratedColumn<int> toIndex = i0.GeneratedColumn<int>(
    'toIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (toIndex >= 0)',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    node,
    typ,
    cnt,
    name,
    parent,
    fromIndex,
    toIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkContentSubdivisions';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.WorkContentSubdivision> instance, {
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
    if (data.containsKey('node')) {
      context.handle(
        _nodeMeta,
        node.isAcceptableOrUnknown(data['node']!, _nodeMeta),
      );
    } else if (isInserting) {
      context.missing(_nodeMeta);
    }
    if (data.containsKey('typ')) {
      context.handle(
        _typMeta,
        typ.isAcceptableOrUnknown(data['typ']!, _typMeta),
      );
    } else if (isInserting) {
      context.missing(_typMeta);
    }
    if (data.containsKey('cnt')) {
      context.handle(
        _cntMeta,
        cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta),
      );
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent')) {
      context.handle(
        _parentMeta,
        parent.isAcceptableOrUnknown(data['parent']!, _parentMeta),
      );
    }
    if (data.containsKey('fromIndex')) {
      context.handle(
        _fromIndexMeta,
        fromIndex.isAcceptableOrUnknown(data['fromIndex']!, _fromIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_fromIndexMeta);
    }
    if (data.containsKey('toIndex')) {
      context.handle(
        _toIndexMeta,
        toIndex.isAcceptableOrUnknown(data['toIndex']!, _toIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_toIndexMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, node};
  @override
  i1.WorkContentSubdivision map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkContentSubdivision(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      node: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}node'],
      )!,
      typ: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}typ'],
      )!,
      cnt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}cnt'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      parent: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}parent'],
      ),
      fromIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}fromIndex'],
      )!,
      toIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}toIndex'],
      )!,
    );
  }

  @override
  WorkContentSubdivisions createAlias(String alias) {
    return WorkContentSubdivisions(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, node)',
    'FOREIGN KEY(workId, fromIndex)REFERENCES WorkContents(workId, idx)',
    'FOREIGN KEY(workId, toIndex)REFERENCES WorkContents(workId, idx)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkContentSubdivision extends i0.DataClass
    implements i0.Insertable<i1.WorkContentSubdivision> {
  final String workId;
  final String node;
  final String typ;

  ///add more as needed
  final int cnt;
  final String name;
  final String? parent;
  final int fromIndex;
  final int toIndex;
  const WorkContentSubdivision({
    required this.workId,
    required this.node,
    required this.typ,
    required this.cnt,
    required this.name,
    this.parent,
    required this.fromIndex,
    required this.toIndex,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['node'] = i0.Variable<String>(node);
    map['typ'] = i0.Variable<String>(typ);
    map['cnt'] = i0.Variable<int>(cnt);
    map['name'] = i0.Variable<String>(name);
    if (!nullToAbsent || parent != null) {
      map['parent'] = i0.Variable<String>(parent);
    }
    map['fromIndex'] = i0.Variable<int>(fromIndex);
    map['toIndex'] = i0.Variable<int>(toIndex);
    return map;
  }

  i1.WorkContentSubdivisionsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkContentSubdivisionsCompanion(
      workId: i0.Value(workId),
      node: i0.Value(node),
      typ: i0.Value(typ),
      cnt: i0.Value(cnt),
      name: i0.Value(name),
      parent: parent == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(parent),
      fromIndex: i0.Value(fromIndex),
      toIndex: i0.Value(toIndex),
    );
  }

  factory WorkContentSubdivision.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkContentSubdivision(
      workId: serializer.fromJson<String>(json['workId']),
      node: serializer.fromJson<String>(json['node']),
      typ: serializer.fromJson<String>(json['typ']),
      cnt: serializer.fromJson<int>(json['cnt']),
      name: serializer.fromJson<String>(json['name']),
      parent: serializer.fromJson<String?>(json['parent']),
      fromIndex: serializer.fromJson<int>(json['fromIndex']),
      toIndex: serializer.fromJson<int>(json['toIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'node': serializer.toJson<String>(node),
      'typ': serializer.toJson<String>(typ),
      'cnt': serializer.toJson<int>(cnt),
      'name': serializer.toJson<String>(name),
      'parent': serializer.toJson<String?>(parent),
      'fromIndex': serializer.toJson<int>(fromIndex),
      'toIndex': serializer.toJson<int>(toIndex),
    };
  }

  i1.WorkContentSubdivision copyWith({
    String? workId,
    String? node,
    String? typ,
    int? cnt,
    String? name,
    i0.Value<String?> parent = const i0.Value.absent(),
    int? fromIndex,
    int? toIndex,
  }) => i1.WorkContentSubdivision(
    workId: workId ?? this.workId,
    node: node ?? this.node,
    typ: typ ?? this.typ,
    cnt: cnt ?? this.cnt,
    name: name ?? this.name,
    parent: parent.present ? parent.value : this.parent,
    fromIndex: fromIndex ?? this.fromIndex,
    toIndex: toIndex ?? this.toIndex,
  );
  WorkContentSubdivision copyWithCompanion(
    i1.WorkContentSubdivisionsCompanion data,
  ) {
    return WorkContentSubdivision(
      workId: data.workId.present ? data.workId.value : this.workId,
      node: data.node.present ? data.node.value : this.node,
      typ: data.typ.present ? data.typ.value : this.typ,
      cnt: data.cnt.present ? data.cnt.value : this.cnt,
      name: data.name.present ? data.name.value : this.name,
      parent: data.parent.present ? data.parent.value : this.parent,
      fromIndex: data.fromIndex.present ? data.fromIndex.value : this.fromIndex,
      toIndex: data.toIndex.present ? data.toIndex.value : this.toIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentSubdivision(')
          ..write('workId: $workId, ')
          ..write('node: $node, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('name: $name, ')
          ..write('parent: $parent, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(workId, node, typ, cnt, name, parent, fromIndex, toIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkContentSubdivision &&
          other.workId == this.workId &&
          other.node == this.node &&
          other.typ == this.typ &&
          other.cnt == this.cnt &&
          other.name == this.name &&
          other.parent == this.parent &&
          other.fromIndex == this.fromIndex &&
          other.toIndex == this.toIndex);
}

class WorkContentSubdivisionsCompanion
    extends i0.UpdateCompanion<i1.WorkContentSubdivision> {
  final i0.Value<String> workId;
  final i0.Value<String> node;
  final i0.Value<String> typ;
  final i0.Value<int> cnt;
  final i0.Value<String> name;
  final i0.Value<String?> parent;
  final i0.Value<int> fromIndex;
  final i0.Value<int> toIndex;
  const WorkContentSubdivisionsCompanion({
    this.workId = const i0.Value.absent(),
    this.node = const i0.Value.absent(),
    this.typ = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.parent = const i0.Value.absent(),
    this.fromIndex = const i0.Value.absent(),
    this.toIndex = const i0.Value.absent(),
  });
  WorkContentSubdivisionsCompanion.insert({
    required String workId,
    required String node,
    required String typ,
    required int cnt,
    required String name,
    this.parent = const i0.Value.absent(),
    required int fromIndex,
    required int toIndex,
  }) : workId = i0.Value(workId),
       node = i0.Value(node),
       typ = i0.Value(typ),
       cnt = i0.Value(cnt),
       name = i0.Value(name),
       fromIndex = i0.Value(fromIndex),
       toIndex = i0.Value(toIndex);
  static i0.Insertable<i1.WorkContentSubdivision> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? node,
    i0.Expression<String>? typ,
    i0.Expression<int>? cnt,
    i0.Expression<String>? name,
    i0.Expression<String>? parent,
    i0.Expression<int>? fromIndex,
    i0.Expression<int>? toIndex,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (node != null) 'node': node,
      if (typ != null) 'typ': typ,
      if (cnt != null) 'cnt': cnt,
      if (name != null) 'name': name,
      if (parent != null) 'parent': parent,
      if (fromIndex != null) 'fromIndex': fromIndex,
      if (toIndex != null) 'toIndex': toIndex,
    });
  }

  i1.WorkContentSubdivisionsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? node,
    i0.Value<String>? typ,
    i0.Value<int>? cnt,
    i0.Value<String>? name,
    i0.Value<String?>? parent,
    i0.Value<int>? fromIndex,
    i0.Value<int>? toIndex,
  }) {
    return i1.WorkContentSubdivisionsCompanion(
      workId: workId ?? this.workId,
      node: node ?? this.node,
      typ: typ ?? this.typ,
      cnt: cnt ?? this.cnt,
      name: name ?? this.name,
      parent: parent ?? this.parent,
      fromIndex: fromIndex ?? this.fromIndex,
      toIndex: toIndex ?? this.toIndex,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (node.present) {
      map['node'] = i0.Variable<String>(node.value);
    }
    if (typ.present) {
      map['typ'] = i0.Variable<String>(typ.value);
    }
    if (cnt.present) {
      map['cnt'] = i0.Variable<int>(cnt.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (parent.present) {
      map['parent'] = i0.Variable<String>(parent.value);
    }
    if (fromIndex.present) {
      map['fromIndex'] = i0.Variable<int>(fromIndex.value);
    }
    if (toIndex.present) {
      map['toIndex'] = i0.Variable<int>(toIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentSubdivisionsCompanion(')
          ..write('workId: $workId, ')
          ..write('node: $node, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('name: $name, ')
          ..write('parent: $parent, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex')
          ..write(')'))
        .toString();
  }
}

class WorkContentSupplementary extends i0.Table
    with
        i0.TableInfo<
          WorkContentSupplementary,
          i1.WorkContentSupplementaryData
        > {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkContentSupplementary(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _typMeta = const i0.VerificationMeta('typ');
  late final i0.GeneratedColumn<String> typ = i0.GeneratedColumn<String>(
    'typ',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (typ IN (\'NOTE\', \'GAP\', \'ABBR\'))',
  );
  static const i0.VerificationMeta _cntMeta = const i0.VerificationMeta('cnt');
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
    'cnt',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (cnt >= 0)',
  );
  static const i0.VerificationMeta _fromIndexMeta = const i0.VerificationMeta(
    'fromIndex',
  );
  late final i0.GeneratedColumn<int> fromIndex = i0.GeneratedColumn<int>(
    'fromIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _toIndexMeta = const i0.VerificationMeta(
    'toIndex',
  );
  late final i0.GeneratedColumn<int> toIndex = i0.GeneratedColumn<int>(
    'toIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _valMeta = const i0.VerificationMeta('val');
  late final i0.GeneratedColumn<String> val = i0.GeneratedColumn<String>(
    'val',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    typ,
    cnt,
    fromIndex,
    toIndex,
    val,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkContentSupplementary';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.WorkContentSupplementaryData> instance, {
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
    if (data.containsKey('typ')) {
      context.handle(
        _typMeta,
        typ.isAcceptableOrUnknown(data['typ']!, _typMeta),
      );
    } else if (isInserting) {
      context.missing(_typMeta);
    }
    if (data.containsKey('cnt')) {
      context.handle(
        _cntMeta,
        cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta),
      );
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    if (data.containsKey('fromIndex')) {
      context.handle(
        _fromIndexMeta,
        fromIndex.isAcceptableOrUnknown(data['fromIndex']!, _fromIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_fromIndexMeta);
    }
    if (data.containsKey('toIndex')) {
      context.handle(
        _toIndexMeta,
        toIndex.isAcceptableOrUnknown(data['toIndex']!, _toIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_toIndexMeta);
    }
    if (data.containsKey('val')) {
      context.handle(
        _valMeta,
        val.isAcceptableOrUnknown(data['val']!, _valMeta),
      );
    } else if (isInserting) {
      context.missing(_valMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, typ, cnt};
  @override
  i1.WorkContentSupplementaryData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkContentSupplementaryData(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      typ: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}typ'],
      )!,
      cnt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}cnt'],
      )!,
      fromIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}fromIndex'],
      )!,
      toIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}toIndex'],
      )!,
      val: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}val'],
      )!,
    );
  }

  @override
  WorkContentSupplementary createAlias(String alias) {
    return WorkContentSupplementary(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, typ, cnt)',
    'FOREIGN KEY(workId)REFERENCES Works(id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkContentSupplementaryData extends i0.DataClass
    implements i0.Insertable<i1.WorkContentSupplementaryData> {
  final String workId;
  final String typ;
  final int cnt;
  final int fromIndex;
  final int toIndex;
  final String val;
  const WorkContentSupplementaryData({
    required this.workId,
    required this.typ,
    required this.cnt,
    required this.fromIndex,
    required this.toIndex,
    required this.val,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['typ'] = i0.Variable<String>(typ);
    map['cnt'] = i0.Variable<int>(cnt);
    map['fromIndex'] = i0.Variable<int>(fromIndex);
    map['toIndex'] = i0.Variable<int>(toIndex);
    map['val'] = i0.Variable<String>(val);
    return map;
  }

  i1.WorkContentSupplementaryCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkContentSupplementaryCompanion(
      workId: i0.Value(workId),
      typ: i0.Value(typ),
      cnt: i0.Value(cnt),
      fromIndex: i0.Value(fromIndex),
      toIndex: i0.Value(toIndex),
      val: i0.Value(val),
    );
  }

  factory WorkContentSupplementaryData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkContentSupplementaryData(
      workId: serializer.fromJson<String>(json['workId']),
      typ: serializer.fromJson<String>(json['typ']),
      cnt: serializer.fromJson<int>(json['cnt']),
      fromIndex: serializer.fromJson<int>(json['fromIndex']),
      toIndex: serializer.fromJson<int>(json['toIndex']),
      val: serializer.fromJson<String>(json['val']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'typ': serializer.toJson<String>(typ),
      'cnt': serializer.toJson<int>(cnt),
      'fromIndex': serializer.toJson<int>(fromIndex),
      'toIndex': serializer.toJson<int>(toIndex),
      'val': serializer.toJson<String>(val),
    };
  }

  i1.WorkContentSupplementaryData copyWith({
    String? workId,
    String? typ,
    int? cnt,
    int? fromIndex,
    int? toIndex,
    String? val,
  }) => i1.WorkContentSupplementaryData(
    workId: workId ?? this.workId,
    typ: typ ?? this.typ,
    cnt: cnt ?? this.cnt,
    fromIndex: fromIndex ?? this.fromIndex,
    toIndex: toIndex ?? this.toIndex,
    val: val ?? this.val,
  );
  WorkContentSupplementaryData copyWithCompanion(
    i1.WorkContentSupplementaryCompanion data,
  ) {
    return WorkContentSupplementaryData(
      workId: data.workId.present ? data.workId.value : this.workId,
      typ: data.typ.present ? data.typ.value : this.typ,
      cnt: data.cnt.present ? data.cnt.value : this.cnt,
      fromIndex: data.fromIndex.present ? data.fromIndex.value : this.fromIndex,
      toIndex: data.toIndex.present ? data.toIndex.value : this.toIndex,
      val: data.val.present ? data.val.value : this.val,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentSupplementaryData(')
          ..write('workId: $workId, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex, ')
          ..write('val: $val')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, typ, cnt, fromIndex, toIndex, val);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkContentSupplementaryData &&
          other.workId == this.workId &&
          other.typ == this.typ &&
          other.cnt == this.cnt &&
          other.fromIndex == this.fromIndex &&
          other.toIndex == this.toIndex &&
          other.val == this.val);
}

class WorkContentSupplementaryCompanion
    extends i0.UpdateCompanion<i1.WorkContentSupplementaryData> {
  final i0.Value<String> workId;
  final i0.Value<String> typ;
  final i0.Value<int> cnt;
  final i0.Value<int> fromIndex;
  final i0.Value<int> toIndex;
  final i0.Value<String> val;
  const WorkContentSupplementaryCompanion({
    this.workId = const i0.Value.absent(),
    this.typ = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
    this.fromIndex = const i0.Value.absent(),
    this.toIndex = const i0.Value.absent(),
    this.val = const i0.Value.absent(),
  });
  WorkContentSupplementaryCompanion.insert({
    required String workId,
    required String typ,
    required int cnt,
    required int fromIndex,
    required int toIndex,
    required String val,
  }) : workId = i0.Value(workId),
       typ = i0.Value(typ),
       cnt = i0.Value(cnt),
       fromIndex = i0.Value(fromIndex),
       toIndex = i0.Value(toIndex),
       val = i0.Value(val);
  static i0.Insertable<i1.WorkContentSupplementaryData> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? typ,
    i0.Expression<int>? cnt,
    i0.Expression<int>? fromIndex,
    i0.Expression<int>? toIndex,
    i0.Expression<String>? val,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (typ != null) 'typ': typ,
      if (cnt != null) 'cnt': cnt,
      if (fromIndex != null) 'fromIndex': fromIndex,
      if (toIndex != null) 'toIndex': toIndex,
      if (val != null) 'val': val,
    });
  }

  i1.WorkContentSupplementaryCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? typ,
    i0.Value<int>? cnt,
    i0.Value<int>? fromIndex,
    i0.Value<int>? toIndex,
    i0.Value<String>? val,
  }) {
    return i1.WorkContentSupplementaryCompanion(
      workId: workId ?? this.workId,
      typ: typ ?? this.typ,
      cnt: cnt ?? this.cnt,
      fromIndex: fromIndex ?? this.fromIndex,
      toIndex: toIndex ?? this.toIndex,
      val: val ?? this.val,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (typ.present) {
      map['typ'] = i0.Variable<String>(typ.value);
    }
    if (cnt.present) {
      map['cnt'] = i0.Variable<int>(cnt.value);
    }
    if (fromIndex.present) {
      map['fromIndex'] = i0.Variable<int>(fromIndex.value);
    }
    if (toIndex.present) {
      map['toIndex'] = i0.Variable<int>(toIndex.value);
    }
    if (val.present) {
      map['val'] = i0.Variable<String>(val.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentSupplementaryCompanion(')
          ..write('workId: $workId, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex, ')
          ..write('val: $val')
          ..write(')'))
        .toString();
  }
}

class Macronizations extends i0.Table
    with i0.TableInfo<Macronizations, i1.Macronization> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  Macronizations(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _wordMeta = const i0.VerificationMeta(
    'word',
  );
  late final i0.GeneratedColumn<String> word = i0.GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _macronizedWordMeta =
      const i0.VerificationMeta('macronizedWord');
  late final i0.GeneratedColumn<String> macronizedWord =
      i0.GeneratedColumn<String>(
        'macronizedWord',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _isUncertainMeta = const i0.VerificationMeta(
    'isUncertain',
  );
  late final i0.GeneratedColumn<int> isUncertain = i0.GeneratedColumn<int>(
    'isUncertain',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (isUncertain IN (0, 1))',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [word, macronizedWord, isUncertain];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Macronizations';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.Macronization> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('macronizedWord')) {
      context.handle(
        _macronizedWordMeta,
        macronizedWord.isAcceptableOrUnknown(
          data['macronizedWord']!,
          _macronizedWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_macronizedWordMeta);
    }
    if (data.containsKey('isUncertain')) {
      context.handle(
        _isUncertainMeta,
        isUncertain.isAcceptableOrUnknown(
          data['isUncertain']!,
          _isUncertainMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isUncertainMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {word, macronizedWord};
  @override
  i1.Macronization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Macronization(
      word: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      macronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronizedWord'],
      )!,
      isUncertain: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}isUncertain'],
      )!,
    );
  }

  @override
  Macronizations createAlias(String alias) {
    return Macronizations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(word, macronizedWord)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class Macronization extends i0.DataClass
    implements i0.Insertable<i1.Macronization> {
  final String word;
  final String macronizedWord;
  final int isUncertain;
  const Macronization({
    required this.word,
    required this.macronizedWord,
    required this.isUncertain,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['word'] = i0.Variable<String>(word);
    map['macronizedWord'] = i0.Variable<String>(macronizedWord);
    map['isUncertain'] = i0.Variable<int>(isUncertain);
    return map;
  }

  i1.MacronizationsCompanion toCompanion(bool nullToAbsent) {
    return i1.MacronizationsCompanion(
      word: i0.Value(word),
      macronizedWord: i0.Value(macronizedWord),
      isUncertain: i0.Value(isUncertain),
    );
  }

  factory Macronization.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Macronization(
      word: serializer.fromJson<String>(json['word']),
      macronizedWord: serializer.fromJson<String>(json['macronizedWord']),
      isUncertain: serializer.fromJson<int>(json['isUncertain']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'word': serializer.toJson<String>(word),
      'macronizedWord': serializer.toJson<String>(macronizedWord),
      'isUncertain': serializer.toJson<int>(isUncertain),
    };
  }

  i1.Macronization copyWith({
    String? word,
    String? macronizedWord,
    int? isUncertain,
  }) => i1.Macronization(
    word: word ?? this.word,
    macronizedWord: macronizedWord ?? this.macronizedWord,
    isUncertain: isUncertain ?? this.isUncertain,
  );
  Macronization copyWithCompanion(i1.MacronizationsCompanion data) {
    return Macronization(
      word: data.word.present ? data.word.value : this.word,
      macronizedWord: data.macronizedWord.present
          ? data.macronizedWord.value
          : this.macronizedWord,
      isUncertain: data.isUncertain.present
          ? data.isUncertain.value
          : this.isUncertain,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Macronization(')
          ..write('word: $word, ')
          ..write('macronizedWord: $macronizedWord, ')
          ..write('isUncertain: $isUncertain')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(word, macronizedWord, isUncertain);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Macronization &&
          other.word == this.word &&
          other.macronizedWord == this.macronizedWord &&
          other.isUncertain == this.isUncertain);
}

class MacronizationsCompanion extends i0.UpdateCompanion<i1.Macronization> {
  final i0.Value<String> word;
  final i0.Value<String> macronizedWord;
  final i0.Value<int> isUncertain;
  const MacronizationsCompanion({
    this.word = const i0.Value.absent(),
    this.macronizedWord = const i0.Value.absent(),
    this.isUncertain = const i0.Value.absent(),
  });
  MacronizationsCompanion.insert({
    required String word,
    required String macronizedWord,
    required int isUncertain,
  }) : word = i0.Value(word),
       macronizedWord = i0.Value(macronizedWord),
       isUncertain = i0.Value(isUncertain);
  static i0.Insertable<i1.Macronization> custom({
    i0.Expression<String>? word,
    i0.Expression<String>? macronizedWord,
    i0.Expression<int>? isUncertain,
  }) {
    return i0.RawValuesInsertable({
      if (word != null) 'word': word,
      if (macronizedWord != null) 'macronizedWord': macronizedWord,
      if (isUncertain != null) 'isUncertain': isUncertain,
    });
  }

  i1.MacronizationsCompanion copyWith({
    i0.Value<String>? word,
    i0.Value<String>? macronizedWord,
    i0.Value<int>? isUncertain,
  }) {
    return i1.MacronizationsCompanion(
      word: word ?? this.word,
      macronizedWord: macronizedWord ?? this.macronizedWord,
      isUncertain: isUncertain ?? this.isUncertain,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (word.present) {
      map['word'] = i0.Variable<String>(word.value);
    }
    if (macronizedWord.present) {
      map['macronizedWord'] = i0.Variable<String>(macronizedWord.value);
    }
    if (isUncertain.present) {
      map['isUncertain'] = i0.Variable<int>(isUncertain.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MacronizationsCompanion(')
          ..write('word: $word, ')
          ..write('macronizedWord: $macronizedWord, ')
          ..write('isUncertain: $isUncertain')
          ..write(')'))
        .toString();
  }
}

class WorkMacronizations extends i0.Table
    with i0.TableInfo<WorkMacronizations, i1.WorkMacronization> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkMacronizations(this.attachedDatabase, [this._alias]);
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
  late final i0.GeneratedColumn<String> idx = i0.GeneratedColumn<String>(
    'idx',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _macronizedWordMeta =
      const i0.VerificationMeta('macronizedWord');
  late final i0.GeneratedColumn<String> macronizedWord =
      i0.GeneratedColumn<String>(
        'macronizedWord',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [workId, idx, macronizedWord];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkMacronizations';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.WorkMacronization> instance, {
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
    if (data.containsKey('macronizedWord')) {
      context.handle(
        _macronizedWordMeta,
        macronizedWord.isAcceptableOrUnknown(
          data['macronizedWord']!,
          _macronizedWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_macronizedWordMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, idx};
  @override
  i1.WorkMacronization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkMacronization(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}idx'],
      )!,
      macronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronizedWord'],
      )!,
    );
  }

  @override
  WorkMacronizations createAlias(String alias) {
    return WorkMacronizations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, idx)',
    'FOREIGN KEY(workId, idx)REFERENCES WorkContents(workId, idx)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkMacronization extends i0.DataClass
    implements i0.Insertable<i1.WorkMacronization> {
  final String workId;
  final String idx;
  final String macronizedWord;
  const WorkMacronization({
    required this.workId,
    required this.idx,
    required this.macronizedWord,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['idx'] = i0.Variable<String>(idx);
    map['macronizedWord'] = i0.Variable<String>(macronizedWord);
    return map;
  }

  i1.WorkMacronizationsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkMacronizationsCompanion(
      workId: i0.Value(workId),
      idx: i0.Value(idx),
      macronizedWord: i0.Value(macronizedWord),
    );
  }

  factory WorkMacronization.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkMacronization(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<String>(json['idx']),
      macronizedWord: serializer.fromJson<String>(json['macronizedWord']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<String>(idx),
      'macronizedWord': serializer.toJson<String>(macronizedWord),
    };
  }

  i1.WorkMacronization copyWith({
    String? workId,
    String? idx,
    String? macronizedWord,
  }) => i1.WorkMacronization(
    workId: workId ?? this.workId,
    idx: idx ?? this.idx,
    macronizedWord: macronizedWord ?? this.macronizedWord,
  );
  WorkMacronization copyWithCompanion(i1.WorkMacronizationsCompanion data) {
    return WorkMacronization(
      workId: data.workId.present ? data.workId.value : this.workId,
      idx: data.idx.present ? data.idx.value : this.idx,
      macronizedWord: data.macronizedWord.present
          ? data.macronizedWord.value
          : this.macronizedWord,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkMacronization(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('macronizedWord: $macronizedWord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, idx, macronizedWord);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkMacronization &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.macronizedWord == this.macronizedWord);
}

class WorkMacronizationsCompanion
    extends i0.UpdateCompanion<i1.WorkMacronization> {
  final i0.Value<String> workId;
  final i0.Value<String> idx;
  final i0.Value<String> macronizedWord;
  const WorkMacronizationsCompanion({
    this.workId = const i0.Value.absent(),
    this.idx = const i0.Value.absent(),
    this.macronizedWord = const i0.Value.absent(),
  });
  WorkMacronizationsCompanion.insert({
    required String workId,
    required String idx,
    required String macronizedWord,
  }) : workId = i0.Value(workId),
       idx = i0.Value(idx),
       macronizedWord = i0.Value(macronizedWord);
  static i0.Insertable<i1.WorkMacronization> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? idx,
    i0.Expression<String>? macronizedWord,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (macronizedWord != null) 'macronizedWord': macronizedWord,
    });
  }

  i1.WorkMacronizationsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? idx,
    i0.Value<String>? macronizedWord,
  }) {
    return i1.WorkMacronizationsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      macronizedWord: macronizedWord ?? this.macronizedWord,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (idx.present) {
      map['idx'] = i0.Variable<String>(idx.value);
    }
    if (macronizedWord.present) {
      map['macronizedWord'] = i0.Variable<String>(macronizedWord.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkMacronizationsCompanion(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('macronizedWord: $macronizedWord')
          ..write(')'))
        .toString();
  }
}

class UserProvidedMacronizations extends i0.Table
    with
        i0.TableInfo<UserProvidedMacronizations, i1.UserProvidedMacronization> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  UserProvidedMacronizations(this.attachedDatabase, [this._alias]);
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
  late final i0.GeneratedColumn<String> idx = i0.GeneratedColumn<String>(
    'idx',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _macronizedWordMeta =
      const i0.VerificationMeta('macronizedWord');
  late final i0.GeneratedColumn<String> macronizedWord =
      i0.GeneratedColumn<String>(
        'macronizedWord',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<i0.GeneratedColumn> get $columns => [workId, idx, macronizedWord];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'UserProvidedMacronizations';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.UserProvidedMacronization> instance, {
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
    if (data.containsKey('macronizedWord')) {
      context.handle(
        _macronizedWordMeta,
        macronizedWord.isAcceptableOrUnknown(
          data['macronizedWord']!,
          _macronizedWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_macronizedWordMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, idx};
  @override
  i1.UserProvidedMacronization map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.UserProvidedMacronization(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}idx'],
      )!,
      macronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronizedWord'],
      )!,
    );
  }

  @override
  UserProvidedMacronizations createAlias(String alias) {
    return UserProvidedMacronizations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workId, idx)',
    'FOREIGN KEY(workId, idx)REFERENCES WorkContents(workId, idx)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class UserProvidedMacronization extends i0.DataClass
    implements i0.Insertable<i1.UserProvidedMacronization> {
  final String workId;
  final String idx;
  final String macronizedWord;
  const UserProvidedMacronization({
    required this.workId,
    required this.idx,
    required this.macronizedWord,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['idx'] = i0.Variable<String>(idx);
    map['macronizedWord'] = i0.Variable<String>(macronizedWord);
    return map;
  }

  i1.UserProvidedMacronizationsCompanion toCompanion(bool nullToAbsent) {
    return i1.UserProvidedMacronizationsCompanion(
      workId: i0.Value(workId),
      idx: i0.Value(idx),
      macronizedWord: i0.Value(macronizedWord),
    );
  }

  factory UserProvidedMacronization.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return UserProvidedMacronization(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<String>(json['idx']),
      macronizedWord: serializer.fromJson<String>(json['macronizedWord']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<String>(idx),
      'macronizedWord': serializer.toJson<String>(macronizedWord),
    };
  }

  i1.UserProvidedMacronization copyWith({
    String? workId,
    String? idx,
    String? macronizedWord,
  }) => i1.UserProvidedMacronization(
    workId: workId ?? this.workId,
    idx: idx ?? this.idx,
    macronizedWord: macronizedWord ?? this.macronizedWord,
  );
  UserProvidedMacronization copyWithCompanion(
    i1.UserProvidedMacronizationsCompanion data,
  ) {
    return UserProvidedMacronization(
      workId: data.workId.present ? data.workId.value : this.workId,
      idx: data.idx.present ? data.idx.value : this.idx,
      macronizedWord: data.macronizedWord.present
          ? data.macronizedWord.value
          : this.macronizedWord,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProvidedMacronization(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('macronizedWord: $macronizedWord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, idx, macronizedWord);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.UserProvidedMacronization &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.macronizedWord == this.macronizedWord);
}

class UserProvidedMacronizationsCompanion
    extends i0.UpdateCompanion<i1.UserProvidedMacronization> {
  final i0.Value<String> workId;
  final i0.Value<String> idx;
  final i0.Value<String> macronizedWord;
  const UserProvidedMacronizationsCompanion({
    this.workId = const i0.Value.absent(),
    this.idx = const i0.Value.absent(),
    this.macronizedWord = const i0.Value.absent(),
  });
  UserProvidedMacronizationsCompanion.insert({
    required String workId,
    required String idx,
    required String macronizedWord,
  }) : workId = i0.Value(workId),
       idx = i0.Value(idx),
       macronizedWord = i0.Value(macronizedWord);
  static i0.Insertable<i1.UserProvidedMacronization> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? idx,
    i0.Expression<String>? macronizedWord,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (macronizedWord != null) 'macronizedWord': macronizedWord,
    });
  }

  i1.UserProvidedMacronizationsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? idx,
    i0.Value<String>? macronizedWord,
  }) {
    return i1.UserProvidedMacronizationsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      macronizedWord: macronizedWord ?? this.macronizedWord,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    if (idx.present) {
      map['idx'] = i0.Variable<String>(idx.value);
    }
    if (macronizedWord.present) {
      map['macronizedWord'] = i0.Variable<String>(macronizedWord.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProvidedMacronizationsCompanion(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('macronizedWord: $macronizedWord')
          ..write(')'))
        .toString();
  }
}

class AuthorsAndWorks extends i0.Table
    with i0.TableInfo<AuthorsAndWorks, i1.AuthorsAndWork> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  AuthorsAndWorks(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _authorIdMeta = const i0.VerificationMeta(
    'authorId',
  );
  late final i0.GeneratedColumn<String> authorId = i0.GeneratedColumn<String>(
    'authorId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
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
  @override
  List<i0.GeneratedColumn> get $columns => [authorId, workId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'AuthorsAndWorks';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.AuthorsAndWork> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('authorId')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['authorId']!, _authorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('workId')) {
      context.handle(
        _workIdMeta,
        workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {authorId, workId};
  @override
  i1.AuthorsAndWork map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.AuthorsAndWork(
      authorId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}authorId'],
      )!,
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
    );
  }

  @override
  AuthorsAndWorks createAlias(String alias) {
    return AuthorsAndWorks(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(authorId, workId)',
    'FOREIGN KEY(authorId)REFERENCES Authors(id)',
    'FOREIGN KEY(workId)REFERENCES Works(id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class AuthorsAndWork extends i0.DataClass
    implements i0.Insertable<i1.AuthorsAndWork> {
  final String authorId;
  final String workId;
  const AuthorsAndWork({required this.authorId, required this.workId});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['authorId'] = i0.Variable<String>(authorId);
    map['workId'] = i0.Variable<String>(workId);
    return map;
  }

  i1.AuthorsAndWorksCompanion toCompanion(bool nullToAbsent) {
    return i1.AuthorsAndWorksCompanion(
      authorId: i0.Value(authorId),
      workId: i0.Value(workId),
    );
  }

  factory AuthorsAndWork.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return AuthorsAndWork(
      authorId: serializer.fromJson<String>(json['authorId']),
      workId: serializer.fromJson<String>(json['workId']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'authorId': serializer.toJson<String>(authorId),
      'workId': serializer.toJson<String>(workId),
    };
  }

  i1.AuthorsAndWork copyWith({String? authorId, String? workId}) =>
      i1.AuthorsAndWork(
        authorId: authorId ?? this.authorId,
        workId: workId ?? this.workId,
      );
  AuthorsAndWork copyWithCompanion(i1.AuthorsAndWorksCompanion data) {
    return AuthorsAndWork(
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      workId: data.workId.present ? data.workId.value : this.workId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsAndWork(')
          ..write('authorId: $authorId, ')
          ..write('workId: $workId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(authorId, workId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.AuthorsAndWork &&
          other.authorId == this.authorId &&
          other.workId == this.workId);
}

class AuthorsAndWorksCompanion extends i0.UpdateCompanion<i1.AuthorsAndWork> {
  final i0.Value<String> authorId;
  final i0.Value<String> workId;
  const AuthorsAndWorksCompanion({
    this.authorId = const i0.Value.absent(),
    this.workId = const i0.Value.absent(),
  });
  AuthorsAndWorksCompanion.insert({
    required String authorId,
    required String workId,
  }) : authorId = i0.Value(authorId),
       workId = i0.Value(workId);
  static i0.Insertable<i1.AuthorsAndWork> custom({
    i0.Expression<String>? authorId,
    i0.Expression<String>? workId,
  }) {
    return i0.RawValuesInsertable({
      if (authorId != null) 'authorId': authorId,
      if (workId != null) 'workId': workId,
    });
  }

  i1.AuthorsAndWorksCompanion copyWith({
    i0.Value<String>? authorId,
    i0.Value<String>? workId,
  }) {
    return i1.AuthorsAndWorksCompanion(
      authorId: authorId ?? this.authorId,
      workId: workId ?? this.workId,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (authorId.present) {
      map['authorId'] = i0.Variable<String>(authorId.value);
    }
    if (workId.present) {
      map['workId'] = i0.Variable<String>(workId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsAndWorksCompanion(')
          ..write('authorId: $authorId, ')
          ..write('workId: $workId')
          ..write(')'))
        .toString();
  }
}

class WorkContentSubdivisionsHierarchyData extends i0.DataClass {
  final String workId;
  final String node;
  final String typ;
  final int cnt;
  final String name;
  final String? parent;
  final int fromIndex;
  final int toIndex;
  final int depth;
  const WorkContentSubdivisionsHierarchyData({
    required this.workId,
    required this.node,
    required this.typ,
    required this.cnt,
    required this.name,
    this.parent,
    required this.fromIndex,
    required this.toIndex,
    required this.depth,
  });
  factory WorkContentSubdivisionsHierarchyData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkContentSubdivisionsHierarchyData(
      workId: serializer.fromJson<String>(json['workId']),
      node: serializer.fromJson<String>(json['node']),
      typ: serializer.fromJson<String>(json['typ']),
      cnt: serializer.fromJson<int>(json['cnt']),
      name: serializer.fromJson<String>(json['name']),
      parent: serializer.fromJson<String?>(json['parent']),
      fromIndex: serializer.fromJson<int>(json['fromIndex']),
      toIndex: serializer.fromJson<int>(json['toIndex']),
      depth: serializer.fromJson<int>(json['depth']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'node': serializer.toJson<String>(node),
      'typ': serializer.toJson<String>(typ),
      'cnt': serializer.toJson<int>(cnt),
      'name': serializer.toJson<String>(name),
      'parent': serializer.toJson<String?>(parent),
      'fromIndex': serializer.toJson<int>(fromIndex),
      'toIndex': serializer.toJson<int>(toIndex),
      'depth': serializer.toJson<int>(depth),
    };
  }

  i1.WorkContentSubdivisionsHierarchyData copyWith({
    String? workId,
    String? node,
    String? typ,
    int? cnt,
    String? name,
    i0.Value<String?> parent = const i0.Value.absent(),
    int? fromIndex,
    int? toIndex,
    int? depth,
  }) => i1.WorkContentSubdivisionsHierarchyData(
    workId: workId ?? this.workId,
    node: node ?? this.node,
    typ: typ ?? this.typ,
    cnt: cnt ?? this.cnt,
    name: name ?? this.name,
    parent: parent.present ? parent.value : this.parent,
    fromIndex: fromIndex ?? this.fromIndex,
    toIndex: toIndex ?? this.toIndex,
    depth: depth ?? this.depth,
  );
  @override
  String toString() {
    return (StringBuffer('WorkContentSubdivisionsHierarchyData(')
          ..write('workId: $workId, ')
          ..write('node: $node, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('name: $name, ')
          ..write('parent: $parent, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workId,
    node,
    typ,
    cnt,
    name,
    parent,
    fromIndex,
    toIndex,
    depth,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkContentSubdivisionsHierarchyData &&
          other.workId == this.workId &&
          other.node == this.node &&
          other.typ == this.typ &&
          other.cnt == this.cnt &&
          other.name == this.name &&
          other.parent == this.parent &&
          other.fromIndex == this.fromIndex &&
          other.toIndex == this.toIndex &&
          other.depth == this.depth);
}

class WorkContentSubdivisionsHierarchy
    extends
        i0.ViewInfo<
          i1.WorkContentSubdivisionsHierarchy,
          i1.WorkContentSubdivisionsHierarchyData
        >
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  WorkContentSubdivisionsHierarchy(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    node,
    typ,
    cnt,
    name,
    parent,
    fromIndex,
    toIndex,
    depth,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'WorkContentSubdivisionsHierarchy';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW WorkContentSubdivisionsHierarchy AS WITH RECURSIVE Subsets AS (SELECT *, 0 AS depth FROM WorkContentSubdivisions WHERE parent IS NULL UNION ALL SELECT s.*, Subsets.depth + 1 FROM WorkContentSubdivisions AS s INNER JOIN Subsets ON s.parent = Subsets.node) SELECT * FROM Subsets ORDER BY fromindex, depth, toindex',
  };
  @override
  WorkContentSubdivisionsHierarchy get asDslTable => this;
  @override
  i1.WorkContentSubdivisionsHierarchyData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkContentSubdivisionsHierarchyData(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      node: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}node'],
      )!,
      typ: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}typ'],
      )!,
      cnt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}cnt'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      parent: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}parent'],
      ),
      fromIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}fromIndex'],
      )!,
      toIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}toIndex'],
      )!,
      depth: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
    );
  }

  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> node = i0.GeneratedColumn<String>(
    'node',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> typ = i0.GeneratedColumn<String>(
    'typ',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
    'cnt',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> parent = i0.GeneratedColumn<String>(
    'parent',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> fromIndex = i0.GeneratedColumn<int>(
    'fromIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<int> toIndex = i0.GeneratedColumn<int>(
    'toIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<int> depth = i0.GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  @override
  WorkContentSubdivisionsHierarchy createAlias(String alias) {
    return WorkContentSubdivisionsHierarchy(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {'WorkContentSubdivisions'};
}

class LibraryAuthor extends i0.DataClass {
  final String id;
  final String name;
  final String about;
  final i2.Uint8List image;
  final int numberOfWorks;
  const LibraryAuthor({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.numberOfWorks,
  });
  factory LibraryAuthor.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LibraryAuthor(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String>(json['about']),
      image: serializer.fromJson<i2.Uint8List>(json['image']),
      numberOfWorks: serializer.fromJson<int>(json['numberOfWorks']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String>(about),
      'image': serializer.toJson<i2.Uint8List>(image),
      'numberOfWorks': serializer.toJson<int>(numberOfWorks),
    };
  }

  i1.LibraryAuthor copyWith({
    String? id,
    String? name,
    String? about,
    i2.Uint8List? image,
    int? numberOfWorks,
  }) => i1.LibraryAuthor(
    id: id ?? this.id,
    name: name ?? this.name,
    about: about ?? this.about,
    image: image ?? this.image,
    numberOfWorks: numberOfWorks ?? this.numberOfWorks,
  );
  @override
  String toString() {
    return (StringBuffer('LibraryAuthor(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about, ')
          ..write('image: $image, ')
          ..write('numberOfWorks: $numberOfWorks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    about,
    i0.$driftBlobEquality.hash(image),
    numberOfWorks,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryAuthor &&
          other.id == this.id &&
          other.name == this.name &&
          other.about == this.about &&
          i0.$driftBlobEquality.equals(other.image, this.image) &&
          other.numberOfWorks == this.numberOfWorks);
}

class LibraryAuthors extends i0.ViewInfo<i1.LibraryAuthors, i1.LibraryAuthor>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LibraryAuthors(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    name,
    about,
    image,
    numberOfWorks,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'library.Authors';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "library.Authors" AS SELECT Authors.id, Authors.name, Authors.about, Authors.image, COUNT(*)OVER (PARTITION BY AuthorsAndWorks.workId RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS numberOfWorks FROM Authors LEFT JOIN AuthorsAndWorks ON Authors.id = AuthorsAndWorks.authorId',
  };
  @override
  LibraryAuthors get asDslTable => this;
  @override
  i1.LibraryAuthor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryAuthor(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      about: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}about'],
      )!,
      image: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.blob,
        data['${effectivePrefix}image'],
      )!,
      numberOfWorks: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}numberOfWorks'],
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
  late final i0.GeneratedColumn<String> about = i0.GeneratedColumn<String>(
    'about',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<i2.Uint8List> image =
      i0.GeneratedColumn<i2.Uint8List>(
        'image',
        aliasedName,
        false,
        type: i0.DriftSqlType.blob,
      );
  late final i0.GeneratedColumn<int> numberOfWorks = i0.GeneratedColumn<int>(
    'numberOfWorks',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  @override
  LibraryAuthors createAlias(String alias) {
    return LibraryAuthors(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {'Authors', 'AuthorsAndWorks'};
}

class LibraryAuthorDetail extends i0.DataClass {
  final String id;
  final String name;
  final String about;
  final i2.Uint8List image;
  final String workId;
  final String workName;
  final int numberOfWords;
  const LibraryAuthorDetail({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.workId,
    required this.workName,
    required this.numberOfWords,
  });
  factory LibraryAuthorDetail.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LibraryAuthorDetail(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String>(json['about']),
      image: serializer.fromJson<i2.Uint8List>(json['image']),
      workId: serializer.fromJson<String>(json['workId']),
      workName: serializer.fromJson<String>(json['workName']),
      numberOfWords: serializer.fromJson<int>(json['numberOfWords']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String>(about),
      'image': serializer.toJson<i2.Uint8List>(image),
      'workId': serializer.toJson<String>(workId),
      'workName': serializer.toJson<String>(workName),
      'numberOfWords': serializer.toJson<int>(numberOfWords),
    };
  }

  i1.LibraryAuthorDetail copyWith({
    String? id,
    String? name,
    String? about,
    i2.Uint8List? image,
    String? workId,
    String? workName,
    int? numberOfWords,
  }) => i1.LibraryAuthorDetail(
    id: id ?? this.id,
    name: name ?? this.name,
    about: about ?? this.about,
    image: image ?? this.image,
    workId: workId ?? this.workId,
    workName: workName ?? this.workName,
    numberOfWords: numberOfWords ?? this.numberOfWords,
  );
  @override
  String toString() {
    return (StringBuffer('LibraryAuthorDetail(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about, ')
          ..write('image: $image, ')
          ..write('workId: $workId, ')
          ..write('workName: $workName, ')
          ..write('numberOfWords: $numberOfWords')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    about,
    i0.$driftBlobEquality.hash(image),
    workId,
    workName,
    numberOfWords,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryAuthorDetail &&
          other.id == this.id &&
          other.name == this.name &&
          other.about == this.about &&
          i0.$driftBlobEquality.equals(other.image, this.image) &&
          other.workId == this.workId &&
          other.workName == this.workName &&
          other.numberOfWords == this.numberOfWords);
}

class LibraryAuthorDetails
    extends i0.ViewInfo<i1.LibraryAuthorDetails, i1.LibraryAuthorDetail>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LibraryAuthorDetails(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    name,
    about,
    image,
    workId,
    workName,
    numberOfWords,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'library.AuthorDetails';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "library.AuthorDetails" AS WITH Aux AS (SELECT Authors.id, Authors.name, Authors.about, Authors.image, AuthorsAndWorks.workId, Works.name AS workName FROM Authors INNER JOIN AuthorsAndWorks ON Authors.id = AuthorsAndWorks.authorId INNER JOIN Works ON AuthorsAndWorks.workId = Works.id), WorksContents AS (SELECT WorkContents.workId, COUNT(*) AS numberOfWords FROM Aux INNER JOIN WorkContents ON Aux.workId = WorkContents.workId WHERE WorkContents.word NOT IN (\'!\', \'"\', \'(\', \')\', \',\', \'.\', \':\', \'?\', \'-\') GROUP BY WorkContents.workId) SELECT Aux.*, WorksContents.numberOfWords FROM Aux INNER JOIN WorksContents ON Aux.workId = WorksContents.workId',
  };
  @override
  LibraryAuthorDetails get asDslTable => this;
  @override
  i1.LibraryAuthorDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryAuthorDetail(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      about: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}about'],
      )!,
      image: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.blob,
        data['${effectivePrefix}image'],
      )!,
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      workName: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workName'],
      )!,
      numberOfWords: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}numberOfWords'],
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
  late final i0.GeneratedColumn<String> about = i0.GeneratedColumn<String>(
    'about',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<i2.Uint8List> image =
      i0.GeneratedColumn<i2.Uint8List>(
        'image',
        aliasedName,
        false,
        type: i0.DriftSqlType.blob,
      );
  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> workName = i0.GeneratedColumn<String>(
    'workName',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> numberOfWords = i0.GeneratedColumn<int>(
    'numberOfWords',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  @override
  LibraryAuthorDetails createAlias(String alias) {
    return LibraryAuthorDetails(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {
    'Authors',
    'AuthorsAndWorks',
    'Works',
    'WorkContents',
  };
}

class LibraryWorkDetail extends i0.DataClass {
  final String id;
  final String name;
  final String about;
  final int numberOfWords;
  final String? authorId;
  final String? authorName;
  const LibraryWorkDetail({
    required this.id,
    required this.name,
    required this.about,
    required this.numberOfWords,
    this.authorId,
    this.authorName,
  });
  factory LibraryWorkDetail.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LibraryWorkDetail(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String>(json['about']),
      numberOfWords: serializer.fromJson<int>(json['numberOfWords']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      authorName: serializer.fromJson<String?>(json['authorName']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String>(about),
      'numberOfWords': serializer.toJson<int>(numberOfWords),
      'authorId': serializer.toJson<String?>(authorId),
      'authorName': serializer.toJson<String?>(authorName),
    };
  }

  i1.LibraryWorkDetail copyWith({
    String? id,
    String? name,
    String? about,
    int? numberOfWords,
    i0.Value<String?> authorId = const i0.Value.absent(),
    i0.Value<String?> authorName = const i0.Value.absent(),
  }) => i1.LibraryWorkDetail(
    id: id ?? this.id,
    name: name ?? this.name,
    about: about ?? this.about,
    numberOfWords: numberOfWords ?? this.numberOfWords,
    authorId: authorId.present ? authorId.value : this.authorId,
    authorName: authorName.present ? authorName.value : this.authorName,
  );
  @override
  String toString() {
    return (StringBuffer('LibraryWorkDetail(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about, ')
          ..write('numberOfWords: $numberOfWords, ')
          ..write('authorId: $authorId, ')
          ..write('authorName: $authorName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, about, numberOfWords, authorId, authorName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryWorkDetail &&
          other.id == this.id &&
          other.name == this.name &&
          other.about == this.about &&
          other.numberOfWords == this.numberOfWords &&
          other.authorId == this.authorId &&
          other.authorName == this.authorName);
}

class LibraryWorkDetails
    extends i0.ViewInfo<i1.LibraryWorkDetails, i1.LibraryWorkDetail>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LibraryWorkDetails(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    name,
    about,
    numberOfWords,
    authorId,
    authorName,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'library.WorkDetails';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "library.WorkDetails" AS WITH Aux AS (SELECT id, name, about FROM Works), WorksContents AS (SELECT WorkContents.workId, COUNT(*) AS numberOfWords FROM Aux INNER JOIN WorkContents ON Aux.id = WorkContents.workId WHERE word NOT IN (\'!\', \'"\', \'(\', \')\', \',\', \'.\', \':\', \'?\', \'-\') GROUP BY WorkContents.workId) SELECT Aux.*, WorksContents.numberOfWords, AuthorsAndWorks.authorId, Authors.name AS authorName FROM Aux INNER JOIN WorksContents ON Aux.id = WorksContents.workId LEFT OUTER JOIN AuthorsAndWorks ON Aux.id = AuthorsAndWorks.workId LEFT OUTER JOIN Authors ON AuthorsAndWorks.authorId = Authors.id',
  };
  @override
  LibraryWorkDetails get asDslTable => this;
  @override
  i1.LibraryWorkDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryWorkDetail(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      about: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}about'],
      )!,
      numberOfWords: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}numberOfWords'],
      )!,
      authorId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}authorId'],
      ),
      authorName: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}authorName'],
      ),
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
  late final i0.GeneratedColumn<String> about = i0.GeneratedColumn<String>(
    'about',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> numberOfWords = i0.GeneratedColumn<int>(
    'numberOfWords',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<String> authorId = i0.GeneratedColumn<String>(
    'authorId',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> authorName = i0.GeneratedColumn<String>(
    'authorName',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  @override
  LibraryWorkDetails createAlias(String alias) {
    return LibraryWorkDetails(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {
    'Works',
    'WorkContents',
    'AuthorsAndWorks',
    'Authors',
  };
}

class LibraryWorkContent extends i0.DataClass {
  final String workId;
  final String? parent;
  final String node;
  final int idx;
  final String word;
  final String typ;
  final int depth;
  final String sourceReference;
  const LibraryWorkContent({
    required this.workId,
    this.parent,
    required this.node,
    required this.idx,
    required this.word,
    required this.typ,
    required this.depth,
    required this.sourceReference,
  });
  factory LibraryWorkContent.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LibraryWorkContent(
      workId: serializer.fromJson<String>(json['workId']),
      parent: serializer.fromJson<String?>(json['parent']),
      node: serializer.fromJson<String>(json['node']),
      idx: serializer.fromJson<int>(json['idx']),
      word: serializer.fromJson<String>(json['word']),
      typ: serializer.fromJson<String>(json['typ']),
      depth: serializer.fromJson<int>(json['depth']),
      sourceReference: serializer.fromJson<String>(json['sourceReference']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'parent': serializer.toJson<String?>(parent),
      'node': serializer.toJson<String>(node),
      'idx': serializer.toJson<int>(idx),
      'word': serializer.toJson<String>(word),
      'typ': serializer.toJson<String>(typ),
      'depth': serializer.toJson<int>(depth),
      'sourceReference': serializer.toJson<String>(sourceReference),
    };
  }

  i1.LibraryWorkContent copyWith({
    String? workId,
    i0.Value<String?> parent = const i0.Value.absent(),
    String? node,
    int? idx,
    String? word,
    String? typ,
    int? depth,
    String? sourceReference,
  }) => i1.LibraryWorkContent(
    workId: workId ?? this.workId,
    parent: parent.present ? parent.value : this.parent,
    node: node ?? this.node,
    idx: idx ?? this.idx,
    word: word ?? this.word,
    typ: typ ?? this.typ,
    depth: depth ?? this.depth,
    sourceReference: sourceReference ?? this.sourceReference,
  );
  @override
  String toString() {
    return (StringBuffer('LibraryWorkContent(')
          ..write('workId: $workId, ')
          ..write('parent: $parent, ')
          ..write('node: $node, ')
          ..write('idx: $idx, ')
          ..write('word: $word, ')
          ..write('typ: $typ, ')
          ..write('depth: $depth, ')
          ..write('sourceReference: $sourceReference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(workId, parent, node, idx, word, typ, depth, sourceReference);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryWorkContent &&
          other.workId == this.workId &&
          other.parent == this.parent &&
          other.node == this.node &&
          other.idx == this.idx &&
          other.word == this.word &&
          other.typ == this.typ &&
          other.depth == this.depth &&
          other.sourceReference == this.sourceReference);
}

class LibraryWorkContents
    extends i0.ViewInfo<i1.LibraryWorkContents, i1.LibraryWorkContent>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LibraryWorkContents(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    parent,
    node,
    idx,
    word,
    typ,
    depth,
    sourceReference,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'library.WorkContents';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "library.WorkContents" AS WITH ClosestSubdivision AS (SELECT WorkContents.workId, WorkContents.idx, WorkContents.word, WorkContents.sourceReference, SubdivsHierarchy.node, SubdivsHierarchy.typ, SubdivsHierarchy.parent, SubdivsHierarchy.depth, ROW_NUMBER()OVER (PARTITION BY WorkContents.workId, WorkContents.idx ORDER BY SubdivsHierarchy.fromIndex DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS rn FROM WorkContents INNER JOIN WorkContentSubdivisionsHierarchy AS SubdivsHierarchy ON WorkContents.workId = SubdivsHierarchy.workId AND WorkContents.idx BETWEEN SubdivsHierarchy.fromIndex AND SubdivsHierarchy.toIndex AND SubdivsHierarchy.typ <> \'TITL\') SELECT workId, parent, node, idx, word, typ, depth, sourceReference FROM ClosestSubdivision WHERE rn = 1 ORDER BY idx',
  };
  @override
  LibraryWorkContents get asDslTable => this;
  @override
  i1.LibraryWorkContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryWorkContent(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      parent: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}parent'],
      ),
      node: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}node'],
      )!,
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}idx'],
      )!,
      word: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      typ: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}typ'],
      )!,
      depth: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
      sourceReference: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}sourceReference'],
      )!,
    );
  }

  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> parent = i0.GeneratedColumn<String>(
    'parent',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> node = i0.GeneratedColumn<String>(
    'node',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> idx = i0.GeneratedColumn<int>(
    'idx',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<String> word = i0.GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> typ = i0.GeneratedColumn<String>(
    'typ',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> depth = i0.GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<String> sourceReference =
      i0.GeneratedColumn<String>(
        'sourceReference',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
      );
  @override
  LibraryWorkContents createAlias(String alias) {
    return LibraryWorkContents(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {
    'WorkContents',
    'WorkContentSubdivisions',
  };
}

class LibraryWorkIndexe extends i0.DataClass {
  final String? parent;
  final String node;
  final int depth;
  final String typ;
  final int cnt;
  final int fromIndex;
  final int toIndex;
  final String name;
  const LibraryWorkIndexe({
    this.parent,
    required this.node,
    required this.depth,
    required this.typ,
    required this.cnt,
    required this.fromIndex,
    required this.toIndex,
    required this.name,
  });
  factory LibraryWorkIndexe.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LibraryWorkIndexe(
      parent: serializer.fromJson<String?>(json['parent']),
      node: serializer.fromJson<String>(json['node']),
      depth: serializer.fromJson<int>(json['depth']),
      typ: serializer.fromJson<String>(json['typ']),
      cnt: serializer.fromJson<int>(json['cnt']),
      fromIndex: serializer.fromJson<int>(json['fromIndex']),
      toIndex: serializer.fromJson<int>(json['toIndex']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'parent': serializer.toJson<String?>(parent),
      'node': serializer.toJson<String>(node),
      'depth': serializer.toJson<int>(depth),
      'typ': serializer.toJson<String>(typ),
      'cnt': serializer.toJson<int>(cnt),
      'fromIndex': serializer.toJson<int>(fromIndex),
      'toIndex': serializer.toJson<int>(toIndex),
      'name': serializer.toJson<String>(name),
    };
  }

  i1.LibraryWorkIndexe copyWith({
    i0.Value<String?> parent = const i0.Value.absent(),
    String? node,
    int? depth,
    String? typ,
    int? cnt,
    int? fromIndex,
    int? toIndex,
    String? name,
  }) => i1.LibraryWorkIndexe(
    parent: parent.present ? parent.value : this.parent,
    node: node ?? this.node,
    depth: depth ?? this.depth,
    typ: typ ?? this.typ,
    cnt: cnt ?? this.cnt,
    fromIndex: fromIndex ?? this.fromIndex,
    toIndex: toIndex ?? this.toIndex,
    name: name ?? this.name,
  );
  @override
  String toString() {
    return (StringBuffer('LibraryWorkIndexe(')
          ..write('parent: $parent, ')
          ..write('node: $node, ')
          ..write('depth: $depth, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(parent, node, depth, typ, cnt, fromIndex, toIndex, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryWorkIndexe &&
          other.parent == this.parent &&
          other.node == this.node &&
          other.depth == this.depth &&
          other.typ == this.typ &&
          other.cnt == this.cnt &&
          other.fromIndex == this.fromIndex &&
          other.toIndex == this.toIndex &&
          other.name == this.name);
}

class LibraryWorkIndexes
    extends i0.ViewInfo<i1.LibraryWorkIndexes, i1.LibraryWorkIndexe>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LibraryWorkIndexes(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    parent,
    node,
    depth,
    typ,
    cnt,
    fromIndex,
    toIndex,
    name,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'library.WorkIndexes';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "library.WorkIndexes" AS SELECT SubdivsHierarchy.parent, SubdivsHierarchy.node, SubdivsHierarchy.depth, SubdivsHierarchy.typ, SubdivsHierarchy.cnt, SubdivsHierarchy.fromIndex, SubdivsHierarchy.toIndex, Titles.name FROM WorkContentSubdivisionsHierarchy AS SubdivsHierarchy INNER JOIN WorkContentSubdivisionsHierarchy AS Titles ON SubdivsHierarchy.node = Titles.parent AND \'TITL\' = Titles.typ ORDER BY SubdivsHierarchy.fromindex',
  };
  @override
  LibraryWorkIndexes get asDslTable => this;
  @override
  i1.LibraryWorkIndexe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryWorkIndexe(
      parent: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}parent'],
      ),
      node: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}node'],
      )!,
      depth: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
      typ: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}typ'],
      )!,
      cnt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}cnt'],
      )!,
      fromIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}fromIndex'],
      )!,
      toIndex: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}toIndex'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  late final i0.GeneratedColumn<String> parent = i0.GeneratedColumn<String>(
    'parent',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<String> node = i0.GeneratedColumn<String>(
    'node',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> depth = i0.GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<String> typ = i0.GeneratedColumn<String>(
    'typ',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
    'cnt',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<int> fromIndex = i0.GeneratedColumn<int>(
    'fromIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<int> toIndex = i0.GeneratedColumn<int>(
    'toIndex',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
  );
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
  );
  @override
  LibraryWorkIndexes createAlias(String alias) {
    return LibraryWorkIndexes(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {'WorkContentSubdivisions'};
}

class LibraryDrift extends i3.ModularAccessor {
  LibraryDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i4.Author> getLibraryAuthors() {
    return customSelect(
      'SELECT * FROM "library.Authors"',
      variables: [],
      readsFrom: {authors, authorsAndWorks},
    ).map(
      (i0.QueryRow row) => i4.Author(
        id: row.read<String>('id'),
        name: row.read<String>('name'),
        about: row.read<String>('about'),
        image: row.read<i2.Uint8List>('image'),
        numberOfWorks: row.read<int>('numberOfWorks'),
      ),
    );
  }

  i0.Selectable<i1.LibraryAuthorDetail> getLibraryAuthorDetails(String var1) {
    return customSelect(
      'SELECT * FROM "library.AuthorDetails" WHERE id = ?1',
      variables: [i0.Variable<String>(var1)],
      readsFrom: {authors, authorsAndWorks, works, workContents},
    ).asyncMap(libraryAuthorDetails.mapFromRow);
  }

  i0.Selectable<i5.WorkDetails> getLibraryWorkDetails(String var1) {
    return customSelect(
      'SELECT * FROM "library.WorkDetails" WHERE id = ?1',
      variables: [i0.Variable<String>(var1)],
      readsFrom: {works, workContents, authorsAndWorks, authors},
    ).map(
      (i0.QueryRow row) => i5.WorkDetails(
        id: row.read<String>('id'),
        name: row.read<String>('name'),
        about: row.read<String>('about'),
        numberOfWords: row.read<int>('numberOfWords'),
        authorId: row.readNullable<String>('authorId'),
        authorName: row.readNullable<String>('authorName'),
      ),
    );
  }

  i0.Selectable<i6.WorkContentsSegment> getLibraryWorkContentsPartial(
    String var1,
    int var2,
    int var3,
  ) {
    return customSelect(
      'SELECT * FROM "library.WorkContents" WHERE workId = ?1 AND idx BETWEEN ?2 AND ?3',
      variables: [
        i0.Variable<String>(var1),
        i0.Variable<int>(var2),
        i0.Variable<int>(var3),
      ],
      readsFrom: {workContents, workContentSubdivisions},
    ).map(
      (i0.QueryRow row) => i6.WorkContentsSegment(
        workId: row.read<String>('workId'),
        parent: row.readNullable<String>('parent'),
        node: row.read<String>('node'),
        idx: row.read<int>('idx'),
        word: row.read<String>('word'),
        typ: row.read<String>('typ'),
        depth: row.read<int>('depth'),
        sourceReference: row.read<String>('sourceReference'),
      ),
    );
  }

  i1.LibraryAuthors get libraryAuthors => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.LibraryAuthors>('library.Authors');
  i1.Authors get authors => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.Authors>('Authors');
  i1.AuthorsAndWorks get authorsAndWorks => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.AuthorsAndWorks>('AuthorsAndWorks');
  i1.LibraryAuthorDetails get libraryAuthorDetails => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.LibraryAuthorDetails>('library.AuthorDetails');
  i1.Works get works =>
      i3.ReadDatabaseContainer(attachedDatabase).resultSet<i1.Works>('Works');
  i1.WorkContents get workContents => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.WorkContents>('WorkContents');
  i1.LibraryWorkDetails get libraryWorkDetails => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.LibraryWorkDetails>('library.WorkDetails');
  i1.LibraryWorkContents get libraryWorkContents => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.LibraryWorkContents>('library.WorkContents');
  i1.WorkContentSubdivisions get workContentSubdivisions =>
      i3.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.WorkContentSubdivisions>('WorkContentSubdivisions');
}
