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
      i0.Value<int?> properNounState,
      required int tokenType,
      required int sentenceIdx,
      i0.Value<int?> wordIdx,
      i0.Value<String?> enclitic,
      i0.Value<String?> expansion,
      required String macronizedWord,
      required int uncertaintyBitMask,
    });
typedef $WorkContentsUpdateCompanionBuilder =
    i1.WorkContentsCompanion Function({
      i0.Value<String> workId,
      i0.Value<int> idx,
      i0.Value<String> word,
      i0.Value<String> sourceReference,
      i0.Value<int?> properNounState,
      i0.Value<int> tokenType,
      i0.Value<int> sentenceIdx,
      i0.Value<int?> wordIdx,
      i0.Value<String?> enclitic,
      i0.Value<String?> expansion,
      i0.Value<String> macronizedWord,
      i0.Value<int> uncertaintyBitMask,
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

  i0.ColumnFilters<int> get properNounState => $composableBuilder(
    column: $table.properNounState,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get tokenType => $composableBuilder(
    column: $table.tokenType,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get sentenceIdx => $composableBuilder(
    column: $table.sentenceIdx,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get wordIdx => $composableBuilder(
    column: $table.wordIdx,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get enclitic => $composableBuilder(
    column: $table.enclitic,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get expansion => $composableBuilder(
    column: $table.expansion,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get uncertaintyBitMask => $composableBuilder(
    column: $table.uncertaintyBitMask,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get auxExpansionNoMacrons => $composableBuilder(
    column: $table.auxExpansionNoMacrons,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get auxMacronBase => $composableBuilder(
    column: $table.auxMacronBase,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get auxMacronWordLower => $composableBuilder(
    column: $table.auxMacronWordLower,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get auxMacronBaseLower => $composableBuilder(
    column: $table.auxMacronBaseLower,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get normForm => $composableBuilder(
    column: $table.normForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronNormForm => $composableBuilder(
    column: $table.macronNormForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get baseNormForm => $composableBuilder(
    column: $table.baseNormForm,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronBaseNormForm => $composableBuilder(
    column: $table.macronBaseNormForm,
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

  i0.ColumnOrderings<int> get properNounState => $composableBuilder(
    column: $table.properNounState,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get tokenType => $composableBuilder(
    column: $table.tokenType,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get sentenceIdx => $composableBuilder(
    column: $table.sentenceIdx,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get wordIdx => $composableBuilder(
    column: $table.wordIdx,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get enclitic => $composableBuilder(
    column: $table.enclitic,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get expansion => $composableBuilder(
    column: $table.expansion,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get uncertaintyBitMask => $composableBuilder(
    column: $table.uncertaintyBitMask,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get auxExpansionNoMacrons => $composableBuilder(
    column: $table.auxExpansionNoMacrons,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get auxMacronBase => $composableBuilder(
    column: $table.auxMacronBase,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get auxMacronWordLower => $composableBuilder(
    column: $table.auxMacronWordLower,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get auxMacronBaseLower => $composableBuilder(
    column: $table.auxMacronBaseLower,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get normForm => $composableBuilder(
    column: $table.normForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronNormForm => $composableBuilder(
    column: $table.macronNormForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get baseNormForm => $composableBuilder(
    column: $table.baseNormForm,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronBaseNormForm => $composableBuilder(
    column: $table.macronBaseNormForm,
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

  i0.GeneratedColumn<int> get properNounState => $composableBuilder(
    column: $table.properNounState,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get tokenType =>
      $composableBuilder(column: $table.tokenType, builder: (column) => column);

  i0.GeneratedColumn<int> get sentenceIdx => $composableBuilder(
    column: $table.sentenceIdx,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get wordIdx =>
      $composableBuilder(column: $table.wordIdx, builder: (column) => column);

  i0.GeneratedColumn<String> get enclitic =>
      $composableBuilder(column: $table.enclitic, builder: (column) => column);

  i0.GeneratedColumn<String> get expansion =>
      $composableBuilder(column: $table.expansion, builder: (column) => column);

  i0.GeneratedColumn<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get uncertaintyBitMask => $composableBuilder(
    column: $table.uncertaintyBitMask,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get auxExpansionNoMacrons => $composableBuilder(
    column: $table.auxExpansionNoMacrons,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get auxMacronBase => $composableBuilder(
    column: $table.auxMacronBase,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get auxMacronWordLower => $composableBuilder(
    column: $table.auxMacronWordLower,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get auxMacronBaseLower => $composableBuilder(
    column: $table.auxMacronBaseLower,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get normForm =>
      $composableBuilder(column: $table.normForm, builder: (column) => column);

  i0.GeneratedColumn<String> get macronNormForm => $composableBuilder(
    column: $table.macronNormForm,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get baseNormForm => $composableBuilder(
    column: $table.baseNormForm,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get macronBaseNormForm => $composableBuilder(
    column: $table.macronBaseNormForm,
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
                i0.Value<int?> properNounState = const i0.Value.absent(),
                i0.Value<int> tokenType = const i0.Value.absent(),
                i0.Value<int> sentenceIdx = const i0.Value.absent(),
                i0.Value<int?> wordIdx = const i0.Value.absent(),
                i0.Value<String?> enclitic = const i0.Value.absent(),
                i0.Value<String?> expansion = const i0.Value.absent(),
                i0.Value<String> macronizedWord = const i0.Value.absent(),
                i0.Value<int> uncertaintyBitMask = const i0.Value.absent(),
              }) => i1.WorkContentsCompanion(
                workId: workId,
                idx: idx,
                word: word,
                sourceReference: sourceReference,
                properNounState: properNounState,
                tokenType: tokenType,
                sentenceIdx: sentenceIdx,
                wordIdx: wordIdx,
                enclitic: enclitic,
                expansion: expansion,
                macronizedWord: macronizedWord,
                uncertaintyBitMask: uncertaintyBitMask,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required int idx,
                required String word,
                required String sourceReference,
                i0.Value<int?> properNounState = const i0.Value.absent(),
                required int tokenType,
                required int sentenceIdx,
                i0.Value<int?> wordIdx = const i0.Value.absent(),
                i0.Value<String?> enclitic = const i0.Value.absent(),
                i0.Value<String?> expansion = const i0.Value.absent(),
                required String macronizedWord,
                required int uncertaintyBitMask,
              }) => i1.WorkContentsCompanion.insert(
                workId: workId,
                idx: idx,
                word: word,
                sourceReference: sourceReference,
                properNounState: properNounState,
                tokenType: tokenType,
                sentenceIdx: sentenceIdx,
                wordIdx: wordIdx,
                enclitic: enclitic,
                expansion: expansion,
                macronizedWord: macronizedWord,
                uncertaintyBitMask: uncertaintyBitMask,
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
typedef $UnambiguousMacronizationsCreateCompanionBuilder =
    i1.UnambiguousMacronizationsCompanion Function({
      required String word,
      required String macronizedWord,
    });
typedef $UnambiguousMacronizationsUpdateCompanionBuilder =
    i1.UnambiguousMacronizationsCompanion Function({
      i0.Value<String> word,
      i0.Value<String> macronizedWord,
    });

class $UnambiguousMacronizationsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.UnambiguousMacronizations> {
  $UnambiguousMacronizationsFilterComposer({
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
}

class $UnambiguousMacronizationsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.UnambiguousMacronizations> {
  $UnambiguousMacronizationsOrderingComposer({
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
}

class $UnambiguousMacronizationsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.UnambiguousMacronizations> {
  $UnambiguousMacronizationsAnnotationComposer({
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
}

class $UnambiguousMacronizationsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.UnambiguousMacronizations,
          i1.UnambiguousMacronization,
          i1.$UnambiguousMacronizationsFilterComposer,
          i1.$UnambiguousMacronizationsOrderingComposer,
          i1.$UnambiguousMacronizationsAnnotationComposer,
          $UnambiguousMacronizationsCreateCompanionBuilder,
          $UnambiguousMacronizationsUpdateCompanionBuilder,
          (
            i1.UnambiguousMacronization,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.UnambiguousMacronizations,
              i1.UnambiguousMacronization
            >,
          ),
          i1.UnambiguousMacronization,
          i0.PrefetchHooks Function()
        > {
  $UnambiguousMacronizationsTableManager(
    i0.GeneratedDatabase db,
    i1.UnambiguousMacronizations table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => i1
              .$UnambiguousMacronizationsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$UnambiguousMacronizationsOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$UnambiguousMacronizationsAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<String> word = const i0.Value.absent(),
                i0.Value<String> macronizedWord = const i0.Value.absent(),
              }) => i1.UnambiguousMacronizationsCompanion(
                word: word,
                macronizedWord: macronizedWord,
              ),
          createCompanionCallback:
              ({required String word, required String macronizedWord}) =>
                  i1.UnambiguousMacronizationsCompanion.insert(
                    word: word,
                    macronizedWord: macronizedWord,
                  ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $UnambiguousMacronizationsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.UnambiguousMacronizations,
      i1.UnambiguousMacronization,
      i1.$UnambiguousMacronizationsFilterComposer,
      i1.$UnambiguousMacronizationsOrderingComposer,
      i1.$UnambiguousMacronizationsAnnotationComposer,
      $UnambiguousMacronizationsCreateCompanionBuilder,
      $UnambiguousMacronizationsUpdateCompanionBuilder,
      (
        i1.UnambiguousMacronization,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.UnambiguousMacronizations,
          i1.UnambiguousMacronization
        >,
      ),
      i1.UnambiguousMacronization,
      i0.PrefetchHooks Function()
    >;
typedef $WorkMacronizationsCreateCompanionBuilder =
    i1.WorkMacronizationsCompanion Function({
      required String workId,
      required int idx,
      required String macronizedWord,
      required int uncertaintyBitMask,
    });
typedef $WorkMacronizationsUpdateCompanionBuilder =
    i1.WorkMacronizationsCompanion Function({
      i0.Value<String> workId,
      i0.Value<int> idx,
      i0.Value<String> macronizedWord,
      i0.Value<int> uncertaintyBitMask,
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

  i0.ColumnFilters<int> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get uncertaintyBitMask => $composableBuilder(
    column: $table.uncertaintyBitMask,
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

  i0.ColumnOrderings<int> get idx => $composableBuilder(
    column: $table.idx,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get uncertaintyBitMask => $composableBuilder(
    column: $table.uncertaintyBitMask,
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

  i0.GeneratedColumn<int> get idx =>
      $composableBuilder(column: $table.idx, builder: (column) => column);

  i0.GeneratedColumn<String> get macronizedWord => $composableBuilder(
    column: $table.macronizedWord,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get uncertaintyBitMask => $composableBuilder(
    column: $table.uncertaintyBitMask,
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
                i0.Value<int> idx = const i0.Value.absent(),
                i0.Value<String> macronizedWord = const i0.Value.absent(),
                i0.Value<int> uncertaintyBitMask = const i0.Value.absent(),
              }) => i1.WorkMacronizationsCompanion(
                workId: workId,
                idx: idx,
                macronizedWord: macronizedWord,
                uncertaintyBitMask: uncertaintyBitMask,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required int idx,
                required String macronizedWord,
                required int uncertaintyBitMask,
              }) => i1.WorkMacronizationsCompanion.insert(
                workId: workId,
                idx: idx,
                macronizedWord: macronizedWord,
                uncertaintyBitMask: uncertaintyBitMask,
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
  static const i0.VerificationMeta _properNounStateMeta =
      const i0.VerificationMeta('properNounState');
  late final i0.GeneratedColumn<int> properNounState = i0.GeneratedColumn<int>(
    'properNounState',
    aliasedName,
    true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (properNounState IN (0, 1, 2))',
  );
  static const i0.VerificationMeta _tokenTypeMeta = const i0.VerificationMeta(
    'tokenType',
  );
  late final i0.GeneratedColumn<int> tokenType = i0.GeneratedColumn<int>(
    'tokenType',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (tokenType BETWEEN 1 AND 6)',
  );
  static const i0.VerificationMeta _sentenceIdxMeta = const i0.VerificationMeta(
    'sentenceIdx',
  );
  late final i0.GeneratedColumn<int> sentenceIdx = i0.GeneratedColumn<int>(
    'sentenceIdx',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const i0.VerificationMeta _wordIdxMeta = const i0.VerificationMeta(
    'wordIdx',
  );
  late final i0.GeneratedColumn<int> wordIdx = i0.GeneratedColumn<int>(
    'wordIdx',
    aliasedName,
    true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _encliticMeta = const i0.VerificationMeta(
    'enclitic',
  );
  late final i0.GeneratedColumn<String> enclitic = i0.GeneratedColumn<String>(
    'enclitic',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const i0.VerificationMeta _expansionMeta = const i0.VerificationMeta(
    'expansion',
  );
  late final i0.GeneratedColumn<String> expansion = i0.GeneratedColumn<String>(
    'expansion',
    aliasedName,
    true,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
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
  static const i0.VerificationMeta _uncertaintyBitMaskMeta =
      const i0.VerificationMeta('uncertaintyBitMask');
  late final i0.GeneratedColumn<int> uncertaintyBitMask =
      i0.GeneratedColumn<int>(
        'uncertaintyBitMask',
        aliasedName,
        false,
        type: i0.DriftSqlType.int,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const i0.VerificationMeta _auxExpansionNoMacronsMeta =
      const i0.VerificationMeta('auxExpansionNoMacrons');
  late final i0.GeneratedColumn<String>
  auxExpansionNoMacrons = i0.GeneratedColumn<String>(
    'aux_expansionNoMacrons',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        '"REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(expansion, \'ā\', \'a\'), \'ē\', \'e\'), \'ī\', \'i\'), \'ō\', \'o\'), \'ū\', \'u\'), \'ȳ\', \'y\'), \'Ā\', \'A\'), \'Ē\', \'E\'), \'Ī\', \'I\'), \'Ō\', \'O\'), \'Ū\', \'U\'), \'Ȳ\', \'Y\')',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS ("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(expansion, \'ā\', \'a\'), \'ē\', \'e\'), \'ī\', \'i\'), \'ō\', \'o\'), \'ū\', \'u\'), \'ȳ\', \'y\'), \'Ā\', \'A\'), \'Ē\', \'E\'), \'Ī\', \'I\'), \'Ō\', \'O\'), \'Ū\', \'U\'), \'Ȳ\', \'Y\')) VIRTUAL',
  );
  static const i0.VerificationMeta _auxMacronBaseMeta =
      const i0.VerificationMeta('auxMacronBase');
  late final i0.GeneratedColumn<String>
  auxMacronBase = i0.GeneratedColumn<String>(
    'aux_macronBase',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        'COALESCE(expansion, CASE WHEN enclitic IS NOT NULL THEN SUBSTR(macronizedWord, 1, LENGTH(macronizedWord) - LENGTH(enclitic)) ELSE macronizedWord END)',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS (COALESCE(expansion, CASE WHEN enclitic IS NOT NULL THEN SUBSTR(macronizedWord, 1, LENGTH(macronizedWord) - LENGTH(enclitic)) ELSE macronizedWord END)) VIRTUAL',
  );
  static const i0.VerificationMeta _auxMacronWordLowerMeta =
      const i0.VerificationMeta('auxMacronWordLower');
  late final i0.GeneratedColumn<String>
  auxMacronWordLower = i0.GeneratedColumn<String>(
    'aux_macronWordLower',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        '"REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(LOWER(macronizedWord), \'Ā\', \'ā\'), \'Ē\', \'ē\'), \'Ī\', \'ī\'), \'Ō\', \'ō\'), \'Ū\', \'ū\'), \'Ȳ\', \'ȳ\')',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS ("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(LOWER(macronizedWord), \'Ā\', \'ā\'), \'Ē\', \'ē\'), \'Ī\', \'ī\'), \'Ō\', \'ō\'), \'Ū\', \'ū\'), \'Ȳ\', \'ȳ\')) VIRTUAL',
  );
  static const i0.VerificationMeta _auxMacronBaseLowerMeta =
      const i0.VerificationMeta('auxMacronBaseLower');
  late final i0.GeneratedColumn<String>
  auxMacronBaseLower = i0.GeneratedColumn<String>(
    'aux_macronBaseLower',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        '"REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(LOWER(aux_macronBase), \'Ā\', \'ā\'), \'Ē\', \'ē\'), \'Ī\', \'ī\'), \'Ō\', \'ō\'), \'Ū\', \'ū\'), \'Ȳ\', \'ȳ\')',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS ("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(LOWER(aux_macronBase), \'Ā\', \'ā\'), \'Ē\', \'ē\'), \'Ī\', \'ī\'), \'Ō\', \'ō\'), \'Ū\', \'ū\'), \'Ȳ\', \'ȳ\')) VIRTUAL',
  );
  static const i0.VerificationMeta _normFormMeta = const i0.VerificationMeta(
    'normForm',
  );
  late final i0.GeneratedColumn<String> normForm = i0.GeneratedColumn<String>(
    'normForm',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        'CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(word, 1, 1)) || LOWER(SUBSTR(word, 2)) ELSE LOWER(word) END',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS (CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(word, 1, 1)) || LOWER(SUBSTR(word, 2)) ELSE LOWER(word) END) VIRTUAL',
  );
  static const i0.VerificationMeta _macronNormFormMeta =
      const i0.VerificationMeta('macronNormForm');
  late final i0.GeneratedColumn<String>
  macronNormForm = i0.GeneratedColumn<String>(
    'macronNormForm',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        'CASE WHEN properNounState IN (1, 2) THEN CASE SUBSTR(macronizedWord, 1, 1) WHEN \'ā\' THEN \'Ā\' WHEN \'ē\' THEN \'Ē\' WHEN \'ī\' THEN \'Ī\' WHEN \'ō\' THEN \'Ō\' WHEN \'ū\' THEN \'Ū\' WHEN \'ȳ\' THEN \'Ȳ\' ELSE UPPER(SUBSTR(macronizedWord, 1, 1)) END || SUBSTR(aux_macronWordLower, 2) ELSE aux_macronWordLower END',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS (CASE WHEN properNounState IN (1, 2) THEN CASE SUBSTR(macronizedWord, 1, 1) WHEN \'ā\' THEN \'Ā\' WHEN \'ē\' THEN \'Ē\' WHEN \'ī\' THEN \'Ī\' WHEN \'ō\' THEN \'Ō\' WHEN \'ū\' THEN \'Ū\' WHEN \'ȳ\' THEN \'Ȳ\' ELSE UPPER(SUBSTR(macronizedWord, 1, 1)) END || SUBSTR(aux_macronWordLower, 2) ELSE aux_macronWordLower END) VIRTUAL',
  );
  static const i0.VerificationMeta _baseNormFormMeta =
      const i0.VerificationMeta('baseNormForm');
  late final i0.GeneratedColumn<String>
  baseNormForm = i0.GeneratedColumn<String>(
    'baseNormForm',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        'CASE WHEN aux_expansionNoMacrons IS NOT NULL THEN CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(aux_expansionNoMacrons, 1, 1)) || LOWER(SUBSTR(aux_expansionNoMacrons, 2)) ELSE LOWER(aux_expansionNoMacrons) END WHEN enclitic IS NOT NULL THEN CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(word, 1, 1)) || LOWER(SUBSTR(word, 2, LENGTH(word) - LENGTH(enclitic) - 1)) ELSE LOWER(SUBSTR(word, 1, LENGTH(word) - LENGTH(enclitic))) END ELSE CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(word, 1, 1)) || LOWER(SUBSTR(word, 2)) ELSE LOWER(word) END END',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS (CASE WHEN aux_expansionNoMacrons IS NOT NULL THEN CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(aux_expansionNoMacrons, 1, 1)) || LOWER(SUBSTR(aux_expansionNoMacrons, 2)) ELSE LOWER(aux_expansionNoMacrons) END WHEN enclitic IS NOT NULL THEN CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(word, 1, 1)) || LOWER(SUBSTR(word, 2, LENGTH(word) - LENGTH(enclitic) - 1)) ELSE LOWER(SUBSTR(word, 1, LENGTH(word) - LENGTH(enclitic))) END ELSE CASE WHEN properNounState IN (1, 2) THEN UPPER(SUBSTR(word, 1, 1)) || LOWER(SUBSTR(word, 2)) ELSE LOWER(word) END END) VIRTUAL',
  );
  static const i0.VerificationMeta _macronBaseNormFormMeta =
      const i0.VerificationMeta('macronBaseNormForm');
  late final i0.GeneratedColumn<String>
  macronBaseNormForm = i0.GeneratedColumn<String>(
    'macronBaseNormForm',
    aliasedName,
    true,
    generatedAs: i0.GeneratedAs(
      const i0.CustomExpression(
        'CASE WHEN properNounState IN (1, 2) THEN CASE SUBSTR(aux_macronBase, 1, 1) WHEN \'ā\' THEN \'Ā\' WHEN \'ē\' THEN \'Ē\' WHEN \'ī\' THEN \'Ī\' WHEN \'ō\' THEN \'Ō\' WHEN \'ū\' THEN \'Ū\' WHEN \'ȳ\' THEN \'Ȳ\' ELSE UPPER(SUBSTR(aux_macronBase, 1, 1)) END || SUBSTR(aux_macronBaseLower, 2) ELSE aux_macronBaseLower END',
      ),
      false,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'GENERATED ALWAYS AS (CASE WHEN properNounState IN (1, 2) THEN CASE SUBSTR(aux_macronBase, 1, 1) WHEN \'ā\' THEN \'Ā\' WHEN \'ē\' THEN \'Ē\' WHEN \'ī\' THEN \'Ī\' WHEN \'ō\' THEN \'Ō\' WHEN \'ū\' THEN \'Ū\' WHEN \'ȳ\' THEN \'Ȳ\' ELSE UPPER(SUBSTR(aux_macronBase, 1, 1)) END || SUBSTR(aux_macronBaseLower, 2) ELSE aux_macronBaseLower END) VIRTUAL',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    idx,
    word,
    sourceReference,
    properNounState,
    tokenType,
    sentenceIdx,
    wordIdx,
    enclitic,
    expansion,
    macronizedWord,
    uncertaintyBitMask,
    auxExpansionNoMacrons,
    auxMacronBase,
    auxMacronWordLower,
    auxMacronBaseLower,
    normForm,
    macronNormForm,
    baseNormForm,
    macronBaseNormForm,
  ];
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
    if (data.containsKey('properNounState')) {
      context.handle(
        _properNounStateMeta,
        properNounState.isAcceptableOrUnknown(
          data['properNounState']!,
          _properNounStateMeta,
        ),
      );
    }
    if (data.containsKey('tokenType')) {
      context.handle(
        _tokenTypeMeta,
        tokenType.isAcceptableOrUnknown(data['tokenType']!, _tokenTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenTypeMeta);
    }
    if (data.containsKey('sentenceIdx')) {
      context.handle(
        _sentenceIdxMeta,
        sentenceIdx.isAcceptableOrUnknown(
          data['sentenceIdx']!,
          _sentenceIdxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sentenceIdxMeta);
    }
    if (data.containsKey('wordIdx')) {
      context.handle(
        _wordIdxMeta,
        wordIdx.isAcceptableOrUnknown(data['wordIdx']!, _wordIdxMeta),
      );
    }
    if (data.containsKey('enclitic')) {
      context.handle(
        _encliticMeta,
        enclitic.isAcceptableOrUnknown(data['enclitic']!, _encliticMeta),
      );
    }
    if (data.containsKey('expansion')) {
      context.handle(
        _expansionMeta,
        expansion.isAcceptableOrUnknown(data['expansion']!, _expansionMeta),
      );
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
    if (data.containsKey('uncertaintyBitMask')) {
      context.handle(
        _uncertaintyBitMaskMeta,
        uncertaintyBitMask.isAcceptableOrUnknown(
          data['uncertaintyBitMask']!,
          _uncertaintyBitMaskMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uncertaintyBitMaskMeta);
    }
    if (data.containsKey('aux_expansionNoMacrons')) {
      context.handle(
        _auxExpansionNoMacronsMeta,
        auxExpansionNoMacrons.isAcceptableOrUnknown(
          data['aux_expansionNoMacrons']!,
          _auxExpansionNoMacronsMeta,
        ),
      );
    }
    if (data.containsKey('aux_macronBase')) {
      context.handle(
        _auxMacronBaseMeta,
        auxMacronBase.isAcceptableOrUnknown(
          data['aux_macronBase']!,
          _auxMacronBaseMeta,
        ),
      );
    }
    if (data.containsKey('aux_macronWordLower')) {
      context.handle(
        _auxMacronWordLowerMeta,
        auxMacronWordLower.isAcceptableOrUnknown(
          data['aux_macronWordLower']!,
          _auxMacronWordLowerMeta,
        ),
      );
    }
    if (data.containsKey('aux_macronBaseLower')) {
      context.handle(
        _auxMacronBaseLowerMeta,
        auxMacronBaseLower.isAcceptableOrUnknown(
          data['aux_macronBaseLower']!,
          _auxMacronBaseLowerMeta,
        ),
      );
    }
    if (data.containsKey('normForm')) {
      context.handle(
        _normFormMeta,
        normForm.isAcceptableOrUnknown(data['normForm']!, _normFormMeta),
      );
    }
    if (data.containsKey('macronNormForm')) {
      context.handle(
        _macronNormFormMeta,
        macronNormForm.isAcceptableOrUnknown(
          data['macronNormForm']!,
          _macronNormFormMeta,
        ),
      );
    }
    if (data.containsKey('baseNormForm')) {
      context.handle(
        _baseNormFormMeta,
        baseNormForm.isAcceptableOrUnknown(
          data['baseNormForm']!,
          _baseNormFormMeta,
        ),
      );
    }
    if (data.containsKey('macronBaseNormForm')) {
      context.handle(
        _macronBaseNormFormMeta,
        macronBaseNormForm.isAcceptableOrUnknown(
          data['macronBaseNormForm']!,
          _macronBaseNormFormMeta,
        ),
      );
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
      properNounState: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}properNounState'],
      ),
      tokenType: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}tokenType'],
      )!,
      sentenceIdx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}sentenceIdx'],
      )!,
      wordIdx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}wordIdx'],
      ),
      enclitic: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}enclitic'],
      ),
      expansion: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}expansion'],
      ),
      macronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronizedWord'],
      )!,
      uncertaintyBitMask: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}uncertaintyBitMask'],
      )!,
      auxExpansionNoMacrons: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}aux_expansionNoMacrons'],
      ),
      auxMacronBase: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}aux_macronBase'],
      ),
      auxMacronWordLower: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}aux_macronWordLower'],
      ),
      auxMacronBaseLower: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}aux_macronBaseLower'],
      ),
      normForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}normForm'],
      ),
      macronNormForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronNormForm'],
      ),
      baseNormForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}baseNormForm'],
      ),
      macronBaseNormForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronBaseNormForm'],
      ),
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
    'CHECK((wordIdx IS NULL)=(tokenType >= 4))',
    'CHECK(expansion IS NULL OR enclitic IS NULL)',
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
  final int? properNounState;

  ///NULL = unknown, 0 = no, 1 = yes, 2 = either/both
  final int tokenType;

  /// 1 word, 2 abbrev, 3 roman numeral, 4 punct, 5 editorial, 6 other
  final int sentenceIdx;
  final int? wordIdx;

  /// Increments only for tokenType <= 3
  final String? enclitic;
  final String? expansion;
  final String macronizedWord;
  final int uncertaintyBitMask;

  /// aux (internal use only)
  final String? auxExpansionNoMacrons;
  final String? auxMacronBase;
  final String? auxMacronWordLower;
  final String? auxMacronBaseLower;

  /// 2×2 grid
  final String? normForm;
  final String? macronNormForm;
  final String? baseNormForm;
  final String? macronBaseNormForm;
  const WorkContent({
    required this.workId,
    required this.idx,
    required this.word,
    required this.sourceReference,
    this.properNounState,
    required this.tokenType,
    required this.sentenceIdx,
    this.wordIdx,
    this.enclitic,
    this.expansion,
    required this.macronizedWord,
    required this.uncertaintyBitMask,
    this.auxExpansionNoMacrons,
    this.auxMacronBase,
    this.auxMacronWordLower,
    this.auxMacronBaseLower,
    this.normForm,
    this.macronNormForm,
    this.baseNormForm,
    this.macronBaseNormForm,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['idx'] = i0.Variable<int>(idx);
    map['word'] = i0.Variable<String>(word);
    map['sourceReference'] = i0.Variable<String>(sourceReference);
    if (!nullToAbsent || properNounState != null) {
      map['properNounState'] = i0.Variable<int>(properNounState);
    }
    map['tokenType'] = i0.Variable<int>(tokenType);
    map['sentenceIdx'] = i0.Variable<int>(sentenceIdx);
    if (!nullToAbsent || wordIdx != null) {
      map['wordIdx'] = i0.Variable<int>(wordIdx);
    }
    if (!nullToAbsent || enclitic != null) {
      map['enclitic'] = i0.Variable<String>(enclitic);
    }
    if (!nullToAbsent || expansion != null) {
      map['expansion'] = i0.Variable<String>(expansion);
    }
    map['macronizedWord'] = i0.Variable<String>(macronizedWord);
    map['uncertaintyBitMask'] = i0.Variable<int>(uncertaintyBitMask);
    return map;
  }

  i1.WorkContentsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkContentsCompanion(
      workId: i0.Value(workId),
      idx: i0.Value(idx),
      word: i0.Value(word),
      sourceReference: i0.Value(sourceReference),
      properNounState: properNounState == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(properNounState),
      tokenType: i0.Value(tokenType),
      sentenceIdx: i0.Value(sentenceIdx),
      wordIdx: wordIdx == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(wordIdx),
      enclitic: enclitic == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(enclitic),
      expansion: expansion == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(expansion),
      macronizedWord: i0.Value(macronizedWord),
      uncertaintyBitMask: i0.Value(uncertaintyBitMask),
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
      properNounState: serializer.fromJson<int?>(json['properNounState']),
      tokenType: serializer.fromJson<int>(json['tokenType']),
      sentenceIdx: serializer.fromJson<int>(json['sentenceIdx']),
      wordIdx: serializer.fromJson<int?>(json['wordIdx']),
      enclitic: serializer.fromJson<String?>(json['enclitic']),
      expansion: serializer.fromJson<String?>(json['expansion']),
      macronizedWord: serializer.fromJson<String>(json['macronizedWord']),
      uncertaintyBitMask: serializer.fromJson<int>(json['uncertaintyBitMask']),
      auxExpansionNoMacrons: serializer.fromJson<String?>(
        json['aux_expansionNoMacrons'],
      ),
      auxMacronBase: serializer.fromJson<String?>(json['aux_macronBase']),
      auxMacronWordLower: serializer.fromJson<String?>(
        json['aux_macronWordLower'],
      ),
      auxMacronBaseLower: serializer.fromJson<String?>(
        json['aux_macronBaseLower'],
      ),
      normForm: serializer.fromJson<String?>(json['normForm']),
      macronNormForm: serializer.fromJson<String?>(json['macronNormForm']),
      baseNormForm: serializer.fromJson<String?>(json['baseNormForm']),
      macronBaseNormForm: serializer.fromJson<String?>(
        json['macronBaseNormForm'],
      ),
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
      'properNounState': serializer.toJson<int?>(properNounState),
      'tokenType': serializer.toJson<int>(tokenType),
      'sentenceIdx': serializer.toJson<int>(sentenceIdx),
      'wordIdx': serializer.toJson<int?>(wordIdx),
      'enclitic': serializer.toJson<String?>(enclitic),
      'expansion': serializer.toJson<String?>(expansion),
      'macronizedWord': serializer.toJson<String>(macronizedWord),
      'uncertaintyBitMask': serializer.toJson<int>(uncertaintyBitMask),
      'aux_expansionNoMacrons': serializer.toJson<String?>(
        auxExpansionNoMacrons,
      ),
      'aux_macronBase': serializer.toJson<String?>(auxMacronBase),
      'aux_macronWordLower': serializer.toJson<String?>(auxMacronWordLower),
      'aux_macronBaseLower': serializer.toJson<String?>(auxMacronBaseLower),
      'normForm': serializer.toJson<String?>(normForm),
      'macronNormForm': serializer.toJson<String?>(macronNormForm),
      'baseNormForm': serializer.toJson<String?>(baseNormForm),
      'macronBaseNormForm': serializer.toJson<String?>(macronBaseNormForm),
    };
  }

  i1.WorkContent copyWith({
    String? workId,
    int? idx,
    String? word,
    String? sourceReference,
    i0.Value<int?> properNounState = const i0.Value.absent(),
    int? tokenType,
    int? sentenceIdx,
    i0.Value<int?> wordIdx = const i0.Value.absent(),
    i0.Value<String?> enclitic = const i0.Value.absent(),
    i0.Value<String?> expansion = const i0.Value.absent(),
    String? macronizedWord,
    int? uncertaintyBitMask,
    i0.Value<String?> auxExpansionNoMacrons = const i0.Value.absent(),
    i0.Value<String?> auxMacronBase = const i0.Value.absent(),
    i0.Value<String?> auxMacronWordLower = const i0.Value.absent(),
    i0.Value<String?> auxMacronBaseLower = const i0.Value.absent(),
    i0.Value<String?> normForm = const i0.Value.absent(),
    i0.Value<String?> macronNormForm = const i0.Value.absent(),
    i0.Value<String?> baseNormForm = const i0.Value.absent(),
    i0.Value<String?> macronBaseNormForm = const i0.Value.absent(),
  }) => i1.WorkContent(
    workId: workId ?? this.workId,
    idx: idx ?? this.idx,
    word: word ?? this.word,
    sourceReference: sourceReference ?? this.sourceReference,
    properNounState: properNounState.present
        ? properNounState.value
        : this.properNounState,
    tokenType: tokenType ?? this.tokenType,
    sentenceIdx: sentenceIdx ?? this.sentenceIdx,
    wordIdx: wordIdx.present ? wordIdx.value : this.wordIdx,
    enclitic: enclitic.present ? enclitic.value : this.enclitic,
    expansion: expansion.present ? expansion.value : this.expansion,
    macronizedWord: macronizedWord ?? this.macronizedWord,
    uncertaintyBitMask: uncertaintyBitMask ?? this.uncertaintyBitMask,
    auxExpansionNoMacrons: auxExpansionNoMacrons.present
        ? auxExpansionNoMacrons.value
        : this.auxExpansionNoMacrons,
    auxMacronBase: auxMacronBase.present
        ? auxMacronBase.value
        : this.auxMacronBase,
    auxMacronWordLower: auxMacronWordLower.present
        ? auxMacronWordLower.value
        : this.auxMacronWordLower,
    auxMacronBaseLower: auxMacronBaseLower.present
        ? auxMacronBaseLower.value
        : this.auxMacronBaseLower,
    normForm: normForm.present ? normForm.value : this.normForm,
    macronNormForm: macronNormForm.present
        ? macronNormForm.value
        : this.macronNormForm,
    baseNormForm: baseNormForm.present ? baseNormForm.value : this.baseNormForm,
    macronBaseNormForm: macronBaseNormForm.present
        ? macronBaseNormForm.value
        : this.macronBaseNormForm,
  );
  @override
  String toString() {
    return (StringBuffer('WorkContent(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('word: $word, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('properNounState: $properNounState, ')
          ..write('tokenType: $tokenType, ')
          ..write('sentenceIdx: $sentenceIdx, ')
          ..write('wordIdx: $wordIdx, ')
          ..write('enclitic: $enclitic, ')
          ..write('expansion: $expansion, ')
          ..write('macronizedWord: $macronizedWord, ')
          ..write('uncertaintyBitMask: $uncertaintyBitMask, ')
          ..write('auxExpansionNoMacrons: $auxExpansionNoMacrons, ')
          ..write('auxMacronBase: $auxMacronBase, ')
          ..write('auxMacronWordLower: $auxMacronWordLower, ')
          ..write('auxMacronBaseLower: $auxMacronBaseLower, ')
          ..write('normForm: $normForm, ')
          ..write('macronNormForm: $macronNormForm, ')
          ..write('baseNormForm: $baseNormForm, ')
          ..write('macronBaseNormForm: $macronBaseNormForm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workId,
    idx,
    word,
    sourceReference,
    properNounState,
    tokenType,
    sentenceIdx,
    wordIdx,
    enclitic,
    expansion,
    macronizedWord,
    uncertaintyBitMask,
    auxExpansionNoMacrons,
    auxMacronBase,
    auxMacronWordLower,
    auxMacronBaseLower,
    normForm,
    macronNormForm,
    baseNormForm,
    macronBaseNormForm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkContent &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.word == this.word &&
          other.sourceReference == this.sourceReference &&
          other.properNounState == this.properNounState &&
          other.tokenType == this.tokenType &&
          other.sentenceIdx == this.sentenceIdx &&
          other.wordIdx == this.wordIdx &&
          other.enclitic == this.enclitic &&
          other.expansion == this.expansion &&
          other.macronizedWord == this.macronizedWord &&
          other.uncertaintyBitMask == this.uncertaintyBitMask &&
          other.auxExpansionNoMacrons == this.auxExpansionNoMacrons &&
          other.auxMacronBase == this.auxMacronBase &&
          other.auxMacronWordLower == this.auxMacronWordLower &&
          other.auxMacronBaseLower == this.auxMacronBaseLower &&
          other.normForm == this.normForm &&
          other.macronNormForm == this.macronNormForm &&
          other.baseNormForm == this.baseNormForm &&
          other.macronBaseNormForm == this.macronBaseNormForm);
}

class WorkContentsCompanion extends i0.UpdateCompanion<i1.WorkContent> {
  final i0.Value<String> workId;
  final i0.Value<int> idx;
  final i0.Value<String> word;
  final i0.Value<String> sourceReference;
  final i0.Value<int?> properNounState;
  final i0.Value<int> tokenType;
  final i0.Value<int> sentenceIdx;
  final i0.Value<int?> wordIdx;
  final i0.Value<String?> enclitic;
  final i0.Value<String?> expansion;
  final i0.Value<String> macronizedWord;
  final i0.Value<int> uncertaintyBitMask;
  const WorkContentsCompanion({
    this.workId = const i0.Value.absent(),
    this.idx = const i0.Value.absent(),
    this.word = const i0.Value.absent(),
    this.sourceReference = const i0.Value.absent(),
    this.properNounState = const i0.Value.absent(),
    this.tokenType = const i0.Value.absent(),
    this.sentenceIdx = const i0.Value.absent(),
    this.wordIdx = const i0.Value.absent(),
    this.enclitic = const i0.Value.absent(),
    this.expansion = const i0.Value.absent(),
    this.macronizedWord = const i0.Value.absent(),
    this.uncertaintyBitMask = const i0.Value.absent(),
  });
  WorkContentsCompanion.insert({
    required String workId,
    required int idx,
    required String word,
    required String sourceReference,
    this.properNounState = const i0.Value.absent(),
    required int tokenType,
    required int sentenceIdx,
    this.wordIdx = const i0.Value.absent(),
    this.enclitic = const i0.Value.absent(),
    this.expansion = const i0.Value.absent(),
    required String macronizedWord,
    required int uncertaintyBitMask,
  }) : workId = i0.Value(workId),
       idx = i0.Value(idx),
       word = i0.Value(word),
       sourceReference = i0.Value(sourceReference),
       tokenType = i0.Value(tokenType),
       sentenceIdx = i0.Value(sentenceIdx),
       macronizedWord = i0.Value(macronizedWord),
       uncertaintyBitMask = i0.Value(uncertaintyBitMask);
  static i0.Insertable<i1.WorkContent> custom({
    i0.Expression<String>? workId,
    i0.Expression<int>? idx,
    i0.Expression<String>? word,
    i0.Expression<String>? sourceReference,
    i0.Expression<int>? properNounState,
    i0.Expression<int>? tokenType,
    i0.Expression<int>? sentenceIdx,
    i0.Expression<int>? wordIdx,
    i0.Expression<String>? enclitic,
    i0.Expression<String>? expansion,
    i0.Expression<String>? macronizedWord,
    i0.Expression<int>? uncertaintyBitMask,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (word != null) 'word': word,
      if (sourceReference != null) 'sourceReference': sourceReference,
      if (properNounState != null) 'properNounState': properNounState,
      if (tokenType != null) 'tokenType': tokenType,
      if (sentenceIdx != null) 'sentenceIdx': sentenceIdx,
      if (wordIdx != null) 'wordIdx': wordIdx,
      if (enclitic != null) 'enclitic': enclitic,
      if (expansion != null) 'expansion': expansion,
      if (macronizedWord != null) 'macronizedWord': macronizedWord,
      if (uncertaintyBitMask != null) 'uncertaintyBitMask': uncertaintyBitMask,
    });
  }

  i1.WorkContentsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<int>? idx,
    i0.Value<String>? word,
    i0.Value<String>? sourceReference,
    i0.Value<int?>? properNounState,
    i0.Value<int>? tokenType,
    i0.Value<int>? sentenceIdx,
    i0.Value<int?>? wordIdx,
    i0.Value<String?>? enclitic,
    i0.Value<String?>? expansion,
    i0.Value<String>? macronizedWord,
    i0.Value<int>? uncertaintyBitMask,
  }) {
    return i1.WorkContentsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      word: word ?? this.word,
      sourceReference: sourceReference ?? this.sourceReference,
      properNounState: properNounState ?? this.properNounState,
      tokenType: tokenType ?? this.tokenType,
      sentenceIdx: sentenceIdx ?? this.sentenceIdx,
      wordIdx: wordIdx ?? this.wordIdx,
      enclitic: enclitic ?? this.enclitic,
      expansion: expansion ?? this.expansion,
      macronizedWord: macronizedWord ?? this.macronizedWord,
      uncertaintyBitMask: uncertaintyBitMask ?? this.uncertaintyBitMask,
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
    if (properNounState.present) {
      map['properNounState'] = i0.Variable<int>(properNounState.value);
    }
    if (tokenType.present) {
      map['tokenType'] = i0.Variable<int>(tokenType.value);
    }
    if (sentenceIdx.present) {
      map['sentenceIdx'] = i0.Variable<int>(sentenceIdx.value);
    }
    if (wordIdx.present) {
      map['wordIdx'] = i0.Variable<int>(wordIdx.value);
    }
    if (enclitic.present) {
      map['enclitic'] = i0.Variable<String>(enclitic.value);
    }
    if (expansion.present) {
      map['expansion'] = i0.Variable<String>(expansion.value);
    }
    if (macronizedWord.present) {
      map['macronizedWord'] = i0.Variable<String>(macronizedWord.value);
    }
    if (uncertaintyBitMask.present) {
      map['uncertaintyBitMask'] = i0.Variable<int>(uncertaintyBitMask.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentsCompanion(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('word: $word, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('properNounState: $properNounState, ')
          ..write('tokenType: $tokenType, ')
          ..write('sentenceIdx: $sentenceIdx, ')
          ..write('wordIdx: $wordIdx, ')
          ..write('enclitic: $enclitic, ')
          ..write('expansion: $expansion, ')
          ..write('macronizedWord: $macronizedWord, ')
          ..write('uncertaintyBitMask: $uncertaintyBitMask')
          ..write(')'))
        .toString();
  }
}

i0.Index get workContentsBaseNormForm => i0.Index(
  'WorkContents_BaseNormForm',
  'CREATE INDEX WorkContents_BaseNormForm ON WorkContents (baseNormForm)',
);
i0.Index get workContentsWordPosition => i0.Index(
  'WorkContents_WordPosition',
  'CREATE INDEX WorkContents_WordPosition ON WorkContents (workId, sentenceIdx, wordIdx)',
);

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

class UnambiguousMacronizations extends i0.Table
    with i0.TableInfo<UnambiguousMacronizations, i1.UnambiguousMacronization> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  UnambiguousMacronizations(this.attachedDatabase, [this._alias]);
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
  @override
  List<i0.GeneratedColumn> get $columns => [word, macronizedWord];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'UnambiguousMacronizations';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.UnambiguousMacronization> instance, {
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
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {word};
  @override
  List<Set<i0.GeneratedColumn>> get uniqueKeys => [
    {word, macronizedWord},
  ];
  @override
  i1.UnambiguousMacronization map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.UnambiguousMacronization(
      word: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      macronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronizedWord'],
      )!,
    );
  }

  @override
  UnambiguousMacronizations createAlias(String alias) {
    return UnambiguousMacronizations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(word)',
    'UNIQUE(word, macronizedWord)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class UnambiguousMacronization extends i0.DataClass
    implements i0.Insertable<i1.UnambiguousMacronization> {
  final String word;
  final String macronizedWord;
  const UnambiguousMacronization({
    required this.word,
    required this.macronizedWord,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['word'] = i0.Variable<String>(word);
    map['macronizedWord'] = i0.Variable<String>(macronizedWord);
    return map;
  }

  i1.UnambiguousMacronizationsCompanion toCompanion(bool nullToAbsent) {
    return i1.UnambiguousMacronizationsCompanion(
      word: i0.Value(word),
      macronizedWord: i0.Value(macronizedWord),
    );
  }

  factory UnambiguousMacronization.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return UnambiguousMacronization(
      word: serializer.fromJson<String>(json['word']),
      macronizedWord: serializer.fromJson<String>(json['macronizedWord']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'word': serializer.toJson<String>(word),
      'macronizedWord': serializer.toJson<String>(macronizedWord),
    };
  }

  i1.UnambiguousMacronization copyWith({
    String? word,
    String? macronizedWord,
  }) => i1.UnambiguousMacronization(
    word: word ?? this.word,
    macronizedWord: macronizedWord ?? this.macronizedWord,
  );
  UnambiguousMacronization copyWithCompanion(
    i1.UnambiguousMacronizationsCompanion data,
  ) {
    return UnambiguousMacronization(
      word: data.word.present ? data.word.value : this.word,
      macronizedWord: data.macronizedWord.present
          ? data.macronizedWord.value
          : this.macronizedWord,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnambiguousMacronization(')
          ..write('word: $word, ')
          ..write('macronizedWord: $macronizedWord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(word, macronizedWord);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.UnambiguousMacronization &&
          other.word == this.word &&
          other.macronizedWord == this.macronizedWord);
}

class UnambiguousMacronizationsCompanion
    extends i0.UpdateCompanion<i1.UnambiguousMacronization> {
  final i0.Value<String> word;
  final i0.Value<String> macronizedWord;
  const UnambiguousMacronizationsCompanion({
    this.word = const i0.Value.absent(),
    this.macronizedWord = const i0.Value.absent(),
  });
  UnambiguousMacronizationsCompanion.insert({
    required String word,
    required String macronizedWord,
  }) : word = i0.Value(word),
       macronizedWord = i0.Value(macronizedWord);
  static i0.Insertable<i1.UnambiguousMacronization> custom({
    i0.Expression<String>? word,
    i0.Expression<String>? macronizedWord,
  }) {
    return i0.RawValuesInsertable({
      if (word != null) 'word': word,
      if (macronizedWord != null) 'macronizedWord': macronizedWord,
    });
  }

  i1.UnambiguousMacronizationsCompanion copyWith({
    i0.Value<String>? word,
    i0.Value<String>? macronizedWord,
  }) {
    return i1.UnambiguousMacronizationsCompanion(
      word: word ?? this.word,
      macronizedWord: macronizedWord ?? this.macronizedWord,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnambiguousMacronizationsCompanion(')
          ..write('word: $word, ')
          ..write('macronizedWord: $macronizedWord')
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
  late final i0.GeneratedColumn<int> idx = i0.GeneratedColumn<int>(
    'idx',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
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
  static const i0.VerificationMeta _uncertaintyBitMaskMeta =
      const i0.VerificationMeta('uncertaintyBitMask');
  late final i0.GeneratedColumn<int> uncertaintyBitMask =
      i0.GeneratedColumn<int>(
        'uncertaintyBitMask',
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
    macronizedWord,
    uncertaintyBitMask,
  ];
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
    if (data.containsKey('uncertaintyBitMask')) {
      context.handle(
        _uncertaintyBitMaskMeta,
        uncertaintyBitMask.isAcceptableOrUnknown(
          data['uncertaintyBitMask']!,
          _uncertaintyBitMaskMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uncertaintyBitMaskMeta);
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
        i0.DriftSqlType.int,
        data['${effectivePrefix}idx'],
      )!,
      macronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronizedWord'],
      )!,
      uncertaintyBitMask: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}uncertaintyBitMask'],
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
  final int idx;
  final String macronizedWord;
  final int uncertaintyBitMask;
  const WorkMacronization({
    required this.workId,
    required this.idx,
    required this.macronizedWord,
    required this.uncertaintyBitMask,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['idx'] = i0.Variable<int>(idx);
    map['macronizedWord'] = i0.Variable<String>(macronizedWord);
    map['uncertaintyBitMask'] = i0.Variable<int>(uncertaintyBitMask);
    return map;
  }

  i1.WorkMacronizationsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkMacronizationsCompanion(
      workId: i0.Value(workId),
      idx: i0.Value(idx),
      macronizedWord: i0.Value(macronizedWord),
      uncertaintyBitMask: i0.Value(uncertaintyBitMask),
    );
  }

  factory WorkMacronization.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkMacronization(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<int>(json['idx']),
      macronizedWord: serializer.fromJson<String>(json['macronizedWord']),
      uncertaintyBitMask: serializer.fromJson<int>(json['uncertaintyBitMask']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<int>(idx),
      'macronizedWord': serializer.toJson<String>(macronizedWord),
      'uncertaintyBitMask': serializer.toJson<int>(uncertaintyBitMask),
    };
  }

  i1.WorkMacronization copyWith({
    String? workId,
    int? idx,
    String? macronizedWord,
    int? uncertaintyBitMask,
  }) => i1.WorkMacronization(
    workId: workId ?? this.workId,
    idx: idx ?? this.idx,
    macronizedWord: macronizedWord ?? this.macronizedWord,
    uncertaintyBitMask: uncertaintyBitMask ?? this.uncertaintyBitMask,
  );
  WorkMacronization copyWithCompanion(i1.WorkMacronizationsCompanion data) {
    return WorkMacronization(
      workId: data.workId.present ? data.workId.value : this.workId,
      idx: data.idx.present ? data.idx.value : this.idx,
      macronizedWord: data.macronizedWord.present
          ? data.macronizedWord.value
          : this.macronizedWord,
      uncertaintyBitMask: data.uncertaintyBitMask.present
          ? data.uncertaintyBitMask.value
          : this.uncertaintyBitMask,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkMacronization(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('macronizedWord: $macronizedWord, ')
          ..write('uncertaintyBitMask: $uncertaintyBitMask')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(workId, idx, macronizedWord, uncertaintyBitMask);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkMacronization &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.macronizedWord == this.macronizedWord &&
          other.uncertaintyBitMask == this.uncertaintyBitMask);
}

class WorkMacronizationsCompanion
    extends i0.UpdateCompanion<i1.WorkMacronization> {
  final i0.Value<String> workId;
  final i0.Value<int> idx;
  final i0.Value<String> macronizedWord;
  final i0.Value<int> uncertaintyBitMask;
  const WorkMacronizationsCompanion({
    this.workId = const i0.Value.absent(),
    this.idx = const i0.Value.absent(),
    this.macronizedWord = const i0.Value.absent(),
    this.uncertaintyBitMask = const i0.Value.absent(),
  });
  WorkMacronizationsCompanion.insert({
    required String workId,
    required int idx,
    required String macronizedWord,
    required int uncertaintyBitMask,
  }) : workId = i0.Value(workId),
       idx = i0.Value(idx),
       macronizedWord = i0.Value(macronizedWord),
       uncertaintyBitMask = i0.Value(uncertaintyBitMask);
  static i0.Insertable<i1.WorkMacronization> custom({
    i0.Expression<String>? workId,
    i0.Expression<int>? idx,
    i0.Expression<String>? macronizedWord,
    i0.Expression<int>? uncertaintyBitMask,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (macronizedWord != null) 'macronizedWord': macronizedWord,
      if (uncertaintyBitMask != null) 'uncertaintyBitMask': uncertaintyBitMask,
    });
  }

  i1.WorkMacronizationsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<int>? idx,
    i0.Value<String>? macronizedWord,
    i0.Value<int>? uncertaintyBitMask,
  }) {
    return i1.WorkMacronizationsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      macronizedWord: macronizedWord ?? this.macronizedWord,
      uncertaintyBitMask: uncertaintyBitMask ?? this.uncertaintyBitMask,
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
    if (macronizedWord.present) {
      map['macronizedWord'] = i0.Variable<String>(macronizedWord.value);
    }
    if (uncertaintyBitMask.present) {
      map['uncertaintyBitMask'] = i0.Variable<int>(uncertaintyBitMask.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkMacronizationsCompanion(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('macronizedWord: $macronizedWord, ')
          ..write('uncertaintyBitMask: $uncertaintyBitMask')
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

class LibraryStagingResolvedMacronization extends i0.DataClass {
  final String workId;
  final int idx;
  final int? uncertaintyBitMask;
  final String finalMacronizedWord;
  const LibraryStagingResolvedMacronization({
    required this.workId,
    required this.idx,
    this.uncertaintyBitMask,
    required this.finalMacronizedWord,
  });
  factory LibraryStagingResolvedMacronization.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LibraryStagingResolvedMacronization(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<int>(json['idx']),
      uncertaintyBitMask: serializer.fromJson<int?>(json['uncertaintyBitMask']),
      finalMacronizedWord: serializer.fromJson<String>(
        json['finalMacronizedWord'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<int>(idx),
      'uncertaintyBitMask': serializer.toJson<int?>(uncertaintyBitMask),
      'finalMacronizedWord': serializer.toJson<String>(finalMacronizedWord),
    };
  }

  i1.LibraryStagingResolvedMacronization copyWith({
    String? workId,
    int? idx,
    i0.Value<int?> uncertaintyBitMask = const i0.Value.absent(),
    String? finalMacronizedWord,
  }) => i1.LibraryStagingResolvedMacronization(
    workId: workId ?? this.workId,
    idx: idx ?? this.idx,
    uncertaintyBitMask: uncertaintyBitMask.present
        ? uncertaintyBitMask.value
        : this.uncertaintyBitMask,
    finalMacronizedWord: finalMacronizedWord ?? this.finalMacronizedWord,
  );
  @override
  String toString() {
    return (StringBuffer('LibraryStagingResolvedMacronization(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('uncertaintyBitMask: $uncertaintyBitMask, ')
          ..write('finalMacronizedWord: $finalMacronizedWord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(workId, idx, uncertaintyBitMask, finalMacronizedWord);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryStagingResolvedMacronization &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.uncertaintyBitMask == this.uncertaintyBitMask &&
          other.finalMacronizedWord == this.finalMacronizedWord);
}

class LibraryStagingResolvedMacronizations
    extends
        i0.ViewInfo<
          i1.LibraryStagingResolvedMacronizations,
          i1.LibraryStagingResolvedMacronization
        >
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LibraryStagingResolvedMacronizations(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    workId,
    idx,
    uncertaintyBitMask,
    finalMacronizedWord,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'library.staging.ResolvedMacronizations';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "library.staging.ResolvedMacronizations" AS WITH RawResolution AS (SELECT WorkContents.workId, WorkContents.idx, WorkContents.word, WorkContents.tokenType, COALESCE(WorkMacronizations.macronizedWord, ExactMatches.macronizedWord, LowerCaseMatches.macronizedWord, WorkContents.word) AS rawMacron, CASE WHEN WorkMacronizations.macronizedWord IS NOT NULL THEN WorkMacronizations.uncertaintyBitMask WHEN ExactMatches.macronizedWord IS NOT NULL OR LowerCaseMatches.macronizedWord IS NOT NULL THEN 0 ELSE -1 END AS finalMask FROM WorkContents LEFT JOIN WorkMacronizations ON WorkContents.workId = WorkMacronizations.workId AND WorkContents.idx = WorkMacronizations.idx LEFT JOIN UnambiguousMacronizations AS ExactMatches ON(WorkContents.properNounState IN (1, 2) OR WorkContents.properNounState IS NULL)AND WorkContents.word = ExactMatches.word LEFT JOIN UnambiguousMacronizations AS LowerCaseMatches ON(WorkContents.properNounState IN (0, 2) OR WorkContents.properNounState IS NULL)AND LOWER(WorkContents.word) = LowerCaseMatches.word), Lowered AS (SELECT *, "REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(LOWER(rawMacron), \'Ā\', \'ā\'), \'Ē\', \'ē\'), \'Ī\', \'ī\'), \'Ō\', \'ō\'), \'Ū\', \'ū\'), \'Ȳ\', \'ȳ\') AS lowerCaseMacron FROM RawResolution) SELECT workId, idx, finalMask AS uncertaintyBitMask, CASE WHEN word = UPPER(word) AND LENGTH(word) > 1 THEN "REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"("REPLACE"(UPPER(lowerCaseMacron), \'ā\', \'Ā\'), \'ē\', \'Ē\'), \'ī\', \'Ī\'), \'ō\', \'Ō\'), \'ū\', \'Ū\'), \'ȳ\', \'Ȳ\') WHEN SUBSTR(word, 1, 1) = UPPER(SUBSTR(word, 1, 1)) AND SUBSTR(word, 1, 1) <> LOWER(SUBSTR(word, 1, 1)) THEN(CASE SUBSTR(lowerCaseMacron, 1, 1) WHEN \'ā\' THEN \'Ā\' WHEN \'ē\' THEN \'Ē\' WHEN \'ī\' THEN \'Ī\' WHEN \'ō\' THEN \'Ō\' WHEN \'ū\' THEN \'Ū\' WHEN \'ȳ\' THEN \'Ȳ\' ELSE UPPER(SUBSTR(lowerCaseMacron, 1, 1)) END)|| SUBSTR(lowerCaseMacron, 2) WHEN word = LOWER(word) THEN lowerCaseMacron ELSE rawMacron END AS finalMacronizedWord FROM Lowered',
  };
  @override
  LibraryStagingResolvedMacronizations get asDslTable => this;
  @override
  i1.LibraryStagingResolvedMacronization map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryStagingResolvedMacronization(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      idx: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}idx'],
      )!,
      uncertaintyBitMask: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}uncertaintyBitMask'],
      ),
      finalMacronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}finalMacronizedWord'],
      )!,
    );
  }

  late final i0.GeneratedColumn<String> workId = i0.GeneratedColumn<String>(
    'workId',
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
  late final i0.GeneratedColumn<int> uncertaintyBitMask =
      i0.GeneratedColumn<int>(
        'uncertaintyBitMask',
        aliasedName,
        true,
        type: i0.DriftSqlType.int,
      );
  late final i0.GeneratedColumn<String> finalMacronizedWord =
      i0.GeneratedColumn<String>(
        'finalMacronizedWord',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
      );
  @override
  LibraryStagingResolvedMacronizations createAlias(String alias) {
    return LibraryStagingResolvedMacronizations(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {
    'WorkContents',
    'WorkMacronizations',
    'UnambiguousMacronizations',
  };
}

class LibraryWorkContentSubdivisionsHierarchyData extends i0.DataClass {
  final String workId;
  final String node;
  final String typ;
  final int cnt;
  final String name;
  final String? parent;
  final int fromIndex;
  final int toIndex;
  final int depth;
  const LibraryWorkContentSubdivisionsHierarchyData({
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
  factory LibraryWorkContentSubdivisionsHierarchyData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LibraryWorkContentSubdivisionsHierarchyData(
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

  i1.LibraryWorkContentSubdivisionsHierarchyData copyWith({
    String? workId,
    String? node,
    String? typ,
    int? cnt,
    String? name,
    i0.Value<String?> parent = const i0.Value.absent(),
    int? fromIndex,
    int? toIndex,
    int? depth,
  }) => i1.LibraryWorkContentSubdivisionsHierarchyData(
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
    return (StringBuffer('LibraryWorkContentSubdivisionsHierarchyData(')
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
      (other is i1.LibraryWorkContentSubdivisionsHierarchyData &&
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

class LibraryWorkContentSubdivisionsHierarchy
    extends
        i0.ViewInfo<
          i1.LibraryWorkContentSubdivisionsHierarchy,
          i1.LibraryWorkContentSubdivisionsHierarchyData
        >
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LibraryWorkContentSubdivisionsHierarchy(this.attachedDatabase, [this._alias]);
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
  String get entityName => 'library.WorkContentSubdivisionsHierarchy';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "library.WorkContentSubdivisionsHierarchy" AS WITH RECURSIVE Subsets AS (SELECT *, 0 AS depth FROM WorkContentSubdivisions WHERE parent IS NULL UNION ALL SELECT s.*, Subsets.depth + 1 FROM WorkContentSubdivisions AS s INNER JOIN Subsets ON s.parent = Subsets.node) SELECT * FROM Subsets ORDER BY fromindex, depth, toindex',
  };
  @override
  LibraryWorkContentSubdivisionsHierarchy get asDslTable => this;
  @override
  i1.LibraryWorkContentSubdivisionsHierarchyData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryWorkContentSubdivisionsHierarchyData(
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
  LibraryWorkContentSubdivisionsHierarchy createAlias(String alias) {
    return LibraryWorkContentSubdivisionsHierarchy(attachedDatabase, alias);
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
        'CREATE VIEW "library.Authors" AS WITH AuthorWorks AS (SELECT authorId, COUNT(workId) AS numberOfWorks FROM AuthorsAndWorks GROUP BY authorId) SELECT Authors.id, Authors.name, Authors.about, Authors.image, COALESCE(AuthorWorks.numberOfWorks, 0) AS numberOfWorks FROM Authors LEFT JOIN AuthorWorks ON Authors.id = AuthorWorks.authorId',
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
  Set<String> get readTables => const {'AuthorsAndWorks', 'Authors'};
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
        'CREATE VIEW "library.AuthorDetails" AS WITH Aux AS (SELECT Authors.id, Authors.name, Authors.about, Authors.image, AuthorsAndWorks.workId, Works.name AS workName FROM Authors INNER JOIN AuthorsAndWorks ON Authors.id = AuthorsAndWorks.authorId INNER JOIN Works ON AuthorsAndWorks.workId = Works.id), WorksContents AS (SELECT WorkContents.workId, COUNT(*) AS numberOfWords FROM Aux INNER JOIN WorkContents ON Aux.workId = WorkContents.workId WHERE WorkContents.tokenType <= 3 GROUP BY WorkContents.workId) SELECT Aux.*, WorksContents.numberOfWords FROM Aux INNER JOIN WorksContents ON Aux.workId = WorksContents.workId',
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
        'CREATE VIEW "library.WorkDetails" AS WITH Aux AS (SELECT id, name, about FROM Works), WorksContents AS (SELECT WorkContents.workId, COUNT(*) AS numberOfWords FROM Aux INNER JOIN WorkContents ON Aux.id = WorkContents.workId WHERE WorkContents.tokenType <= 3 GROUP BY WorkContents.workId) SELECT Aux.*, WorksContents.numberOfWords, AuthorsAndWorks.authorId, Authors.name AS authorName FROM Aux INNER JOIN WorksContents ON Aux.id = WorksContents.workId LEFT OUTER JOIN AuthorsAndWorks ON Aux.id = AuthorsAndWorks.workId LEFT OUTER JOIN Authors ON AuthorsAndWorks.authorId = Authors.id',
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
  final String macronizedWord;
  final int uncertaintyBitMask;
  final String typ;
  final int depth;
  final String sourceReference;
  const LibraryWorkContent({
    required this.workId,
    this.parent,
    required this.node,
    required this.idx,
    required this.word,
    required this.macronizedWord,
    required this.uncertaintyBitMask,
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
      macronizedWord: serializer.fromJson<String>(json['macronizedWord']),
      uncertaintyBitMask: serializer.fromJson<int>(json['uncertaintyBitMask']),
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
      'macronizedWord': serializer.toJson<String>(macronizedWord),
      'uncertaintyBitMask': serializer.toJson<int>(uncertaintyBitMask),
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
    String? macronizedWord,
    int? uncertaintyBitMask,
    String? typ,
    int? depth,
    String? sourceReference,
  }) => i1.LibraryWorkContent(
    workId: workId ?? this.workId,
    parent: parent.present ? parent.value : this.parent,
    node: node ?? this.node,
    idx: idx ?? this.idx,
    word: word ?? this.word,
    macronizedWord: macronizedWord ?? this.macronizedWord,
    uncertaintyBitMask: uncertaintyBitMask ?? this.uncertaintyBitMask,
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
          ..write('macronizedWord: $macronizedWord, ')
          ..write('uncertaintyBitMask: $uncertaintyBitMask, ')
          ..write('typ: $typ, ')
          ..write('depth: $depth, ')
          ..write('sourceReference: $sourceReference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    workId,
    parent,
    node,
    idx,
    word,
    macronizedWord,
    uncertaintyBitMask,
    typ,
    depth,
    sourceReference,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryWorkContent &&
          other.workId == this.workId &&
          other.parent == this.parent &&
          other.node == this.node &&
          other.idx == this.idx &&
          other.word == this.word &&
          other.macronizedWord == this.macronizedWord &&
          other.uncertaintyBitMask == this.uncertaintyBitMask &&
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
    macronizedWord,
    uncertaintyBitMask,
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
        'CREATE VIEW "library.WorkContents" AS WITH ClosestSubdivision AS (SELECT WorkContents.workId, WorkContents.idx, WorkContents.word, WorkContents.macronizedWord, WorkContents.uncertaintyBitMask, WorkContents.sourceReference, SubdivsHierarchy.node, SubdivsHierarchy.typ, SubdivsHierarchy.parent, SubdivsHierarchy.depth, ROW_NUMBER()OVER (PARTITION BY WorkContents.workId, WorkContents.idx ORDER BY SubdivsHierarchy.fromIndex DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS rn FROM WorkContents INNER JOIN "library.WorkContentSubdivisionsHierarchy" AS SubdivsHierarchy ON WorkContents.workId = SubdivsHierarchy.workId AND WorkContents.idx BETWEEN SubdivsHierarchy.fromIndex AND SubdivsHierarchy.toIndex AND SubdivsHierarchy.typ <> \'TITL\') SELECT workId, parent, node, idx, word, macronizedWord, uncertaintyBitMask, typ, depth, sourceReference FROM ClosestSubdivision WHERE rn = 1 ORDER BY idx',
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
      macronizedWord: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}macronizedWord'],
      )!,
      uncertaintyBitMask: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}uncertaintyBitMask'],
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
  late final i0.GeneratedColumn<String> macronizedWord =
      i0.GeneratedColumn<String>(
        'macronizedWord',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
      );
  late final i0.GeneratedColumn<int> uncertaintyBitMask =
      i0.GeneratedColumn<int>(
        'uncertaintyBitMask',
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
  final String workId;
  final String? parent;
  final String node;
  final int depth;
  final String typ;
  final int cnt;
  final int fromIndex;
  final int toIndex;
  final String name;
  const LibraryWorkIndexe({
    required this.workId,
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
      workId: serializer.fromJson<String>(json['workId']),
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
      'workId': serializer.toJson<String>(workId),
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
    String? workId,
    i0.Value<String?> parent = const i0.Value.absent(),
    String? node,
    int? depth,
    String? typ,
    int? cnt,
    int? fromIndex,
    int? toIndex,
    String? name,
  }) => i1.LibraryWorkIndexe(
    workId: workId ?? this.workId,
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
          ..write('workId: $workId, ')
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
  int get hashCode => Object.hash(
    workId,
    parent,
    node,
    depth,
    typ,
    cnt,
    fromIndex,
    toIndex,
    name,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LibraryWorkIndexe &&
          other.workId == this.workId &&
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
    workId,
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
        'CREATE VIEW "library.WorkIndexes" AS SELECT SubdivsHierarchy.workId, SubdivsHierarchy.parent, SubdivsHierarchy.node, SubdivsHierarchy.depth, SubdivsHierarchy.typ, SubdivsHierarchy.cnt, SubdivsHierarchy.fromIndex, SubdivsHierarchy.toIndex, Titles.name FROM "library.WorkContentSubdivisionsHierarchy" AS SubdivsHierarchy INNER JOIN "library.WorkContentSubdivisionsHierarchy" AS Titles ON SubdivsHierarchy.node = Titles.parent AND \'TITL\' = Titles.typ ORDER BY SubdivsHierarchy.fromindex',
  };
  @override
  LibraryWorkIndexes get asDslTable => this;
  @override
  i1.LibraryWorkIndexe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LibraryWorkIndexe(
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
      readsFrom: {authorsAndWorks, authors},
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

  i0.Selectable<i1.LibraryWorkIndexe> getLibraryWorkIndexes(String var1) {
    return customSelect(
      'SELECT * FROM "library.WorkIndexes" WHERE workId = ?1',
      variables: [i0.Variable<String>(var1)],
      readsFrom: {workContentSubdivisions},
    ).asyncMap(libraryWorkIndexes.mapFromRow);
  }

  i1.LibraryAuthors get libraryAuthors => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.LibraryAuthors>('library.Authors');
  i1.AuthorsAndWorks get authorsAndWorks => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.AuthorsAndWorks>('AuthorsAndWorks');
  i1.Authors get authors => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.Authors>('Authors');
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
  i1.LibraryWorkIndexes get libraryWorkIndexes => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.LibraryWorkIndexes>('library.WorkIndexes');
}
