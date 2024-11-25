// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/external/data_version.drift.dart' as i1;

typedef $DataVersionCreateCompanionBuilder = i1.DataVersionCompanion Function({
  i0.Value<int> idx,
  i0.Value<String> createdAt,
});
typedef $DataVersionUpdateCompanionBuilder = i1.DataVersionCompanion Function({
  i0.Value<int> idx,
  i0.Value<String> createdAt,
});

class $DataVersionFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DataVersion> {
  $DataVersionFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get idx => $composableBuilder(
      column: $table.idx, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));
}

class $DataVersionOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DataVersion> {
  $DataVersionOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get idx => $composableBuilder(
      column: $table.idx, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));
}

class $DataVersionAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.DataVersion> {
  $DataVersionAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get idx =>
      $composableBuilder(column: $table.idx, builder: (column) => column);

  i0.GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $DataVersionTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.DataVersion,
    i1.DataVersionData,
    i1.$DataVersionFilterComposer,
    i1.$DataVersionOrderingComposer,
    i1.$DataVersionAnnotationComposer,
    $DataVersionCreateCompanionBuilder,
    $DataVersionUpdateCompanionBuilder,
    (
      i1.DataVersionData,
      i0
      .BaseReferences<i0.GeneratedDatabase, i1.DataVersion, i1.DataVersionData>
    ),
    i1.DataVersionData,
    i0.PrefetchHooks Function()> {
  $DataVersionTableManager(i0.GeneratedDatabase db, i1.DataVersion table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$DataVersionFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$DataVersionOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$DataVersionAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<int> idx = const i0.Value.absent(),
            i0.Value<String> createdAt = const i0.Value.absent(),
          }) =>
              i1.DataVersionCompanion(
            idx: idx,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            i0.Value<int> idx = const i0.Value.absent(),
            i0.Value<String> createdAt = const i0.Value.absent(),
          }) =>
              i1.DataVersionCompanion.insert(
            idx: idx,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $DataVersionProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.DataVersion,
    i1.DataVersionData,
    i1.$DataVersionFilterComposer,
    i1.$DataVersionOrderingComposer,
    i1.$DataVersionAnnotationComposer,
    $DataVersionCreateCompanionBuilder,
    $DataVersionUpdateCompanionBuilder,
    (
      i1.DataVersionData,
      i0
      .BaseReferences<i0.GeneratedDatabase, i1.DataVersion, i1.DataVersionData>
    ),
    i1.DataVersionData,
    i0.PrefetchHooks Function()>;

class DataVersion extends i0.Table
    with i0.TableInfo<DataVersion, i1.DataVersionData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  DataVersion(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idxMeta = const i0.VerificationMeta('idx');
  late final i0.GeneratedColumn<int> idx = i0.GeneratedColumn<int>(
      'idx', aliasedName, false,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL');
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  late final i0.GeneratedColumn<String> createdAt = i0.GeneratedColumn<String>(
      'createdAt', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
      defaultValue: const i0.CustomExpression('CURRENT_TIMESTAMP'));
  @override
  List<i0.GeneratedColumn> get $columns => [idx, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'DataVersion';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.DataVersionData> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('idx')) {
      context.handle(
          _idxMeta, idx.isAcceptableOrUnknown(data['idx']!, _idxMeta));
    }
    if (data.containsKey('createdAt')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['createdAt']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {idx};
  @override
  i1.DataVersionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.DataVersionData(
      idx: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}idx'])!,
      createdAt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}createdAt'])!,
    );
  }

  @override
  DataVersion createAlias(String alias) {
    return DataVersion(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['PRIMARY KEY(idx)'];
  @override
  bool get dontWriteConstraints => true;
}

class DataVersionData extends i0.DataClass
    implements i0.Insertable<i1.DataVersionData> {
  final int idx;
  final String createdAt;
  const DataVersionData({required this.idx, required this.createdAt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['idx'] = i0.Variable<int>(idx);
    map['createdAt'] = i0.Variable<String>(createdAt);
    return map;
  }

  i1.DataVersionCompanion toCompanion(bool nullToAbsent) {
    return i1.DataVersionCompanion(
      idx: i0.Value(idx),
      createdAt: i0.Value(createdAt),
    );
  }

  factory DataVersionData.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return DataVersionData(
      idx: serializer.fromJson<int>(json['idx']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idx': serializer.toJson<int>(idx),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  i1.DataVersionData copyWith({int? idx, String? createdAt}) =>
      i1.DataVersionData(
        idx: idx ?? this.idx,
        createdAt: createdAt ?? this.createdAt,
      );
  DataVersionData copyWithCompanion(i1.DataVersionCompanion data) {
    return DataVersionData(
      idx: data.idx.present ? data.idx.value : this.idx,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DataVersionData(')
          ..write('idx: $idx, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idx, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.DataVersionData &&
          other.idx == this.idx &&
          other.createdAt == this.createdAt);
}

class DataVersionCompanion extends i0.UpdateCompanion<i1.DataVersionData> {
  final i0.Value<int> idx;
  final i0.Value<String> createdAt;
  const DataVersionCompanion({
    this.idx = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  DataVersionCompanion.insert({
    this.idx = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  static i0.Insertable<i1.DataVersionData> custom({
    i0.Expression<int>? idx,
    i0.Expression<String>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (idx != null) 'idx': idx,
      if (createdAt != null) 'createdAt': createdAt,
    });
  }

  i1.DataVersionCompanion copyWith(
      {i0.Value<int>? idx, i0.Value<String>? createdAt}) {
    return i1.DataVersionCompanion(
      idx: idx ?? this.idx,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (idx.present) {
      map['idx'] = i0.Variable<int>(idx.value);
    }
    if (createdAt.present) {
      map['createdAt'] = i0.Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataVersionCompanion(')
          ..write('idx: $idx, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class LatestDataVersionData extends i0.DataClass {
  final int idx;
  final String createdAt;
  const LatestDataVersionData({required this.idx, required this.createdAt});
  factory LatestDataVersionData.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return LatestDataVersionData(
      idx: serializer.fromJson<int>(json['idx']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idx': serializer.toJson<int>(idx),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  i1.LatestDataVersionData copyWith({int? idx, String? createdAt}) =>
      i1.LatestDataVersionData(
        idx: idx ?? this.idx,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('LatestDataVersionData(')
          ..write('idx: $idx, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idx, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.LatestDataVersionData &&
          other.idx == this.idx &&
          other.createdAt == this.createdAt);
}

class LatestDataVersion
    extends i0.ViewInfo<i1.LatestDataVersion, i1.LatestDataVersionData>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  LatestDataVersion(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [idx, createdAt];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'LatestDataVersion';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
        i0.SqlDialect.sqlite:
            'CREATE VIEW LatestDataVersion AS SELECT * FROM DataVersion ORDER BY idx DESC LIMIT 1',
      };
  @override
  LatestDataVersion get asDslTable => this;
  @override
  i1.LatestDataVersionData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.LatestDataVersionData(
      idx: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}idx'])!,
      createdAt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}createdAt'])!,
    );
  }

  late final i0.GeneratedColumn<int> idx = i0.GeneratedColumn<int>(
      'idx', aliasedName, false,
      type: i0.DriftSqlType.int);
  late final i0.GeneratedColumn<String> createdAt = i0.GeneratedColumn<String>(
      'createdAt', aliasedName, false,
      type: i0.DriftSqlType.string);
  @override
  LatestDataVersion createAlias(String alias) {
    return LatestDataVersion(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {'DataVersion'};
}
