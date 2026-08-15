// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/component/word_frequency/word_frequency.drift.dart'
    as i1;
import 'package:drift/internal/modular.dart' as i2;

typedef $WorkFormCountsCreateCompanionBuilder =
    i1.WorkFormCountsCompanion Function({
      required String workId,
      required String form,
      required String macronForm,
      required int cnt,
    });
typedef $WorkFormCountsUpdateCompanionBuilder =
    i1.WorkFormCountsCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> form,
      i0.Value<String> macronForm,
      i0.Value<int> cnt,
    });

class $WorkFormCountsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkFormCounts> {
  $WorkFormCountsFilterComposer({
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

  i0.ColumnFilters<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorkFormCountsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkFormCounts> {
  $WorkFormCountsOrderingComposer({
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

  i0.ColumnOrderings<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorkFormCountsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkFormCounts> {
  $WorkFormCountsAnnotationComposer({
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

  i0.GeneratedColumn<int> get cnt =>
      $composableBuilder(column: $table.cnt, builder: (column) => column);
}

class $WorkFormCountsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.WorkFormCounts,
          i1.WorkFormCount,
          i1.$WorkFormCountsFilterComposer,
          i1.$WorkFormCountsOrderingComposer,
          i1.$WorkFormCountsAnnotationComposer,
          $WorkFormCountsCreateCompanionBuilder,
          $WorkFormCountsUpdateCompanionBuilder,
          (
            i1.WorkFormCount,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.WorkFormCounts,
              i1.WorkFormCount
            >,
          ),
          i1.WorkFormCount,
          i0.PrefetchHooks Function()
        > {
  $WorkFormCountsTableManager(i0.GeneratedDatabase db, i1.WorkFormCounts table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$WorkFormCountsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$WorkFormCountsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$WorkFormCountsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> form = const i0.Value.absent(),
                i0.Value<String> macronForm = const i0.Value.absent(),
                i0.Value<int> cnt = const i0.Value.absent(),
              }) => i1.WorkFormCountsCompanion(
                workId: workId,
                form: form,
                macronForm: macronForm,
                cnt: cnt,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String form,
                required String macronForm,
                required int cnt,
              }) => i1.WorkFormCountsCompanion.insert(
                workId: workId,
                form: form,
                macronForm: macronForm,
                cnt: cnt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorkFormCountsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.WorkFormCounts,
      i1.WorkFormCount,
      i1.$WorkFormCountsFilterComposer,
      i1.$WorkFormCountsOrderingComposer,
      i1.$WorkFormCountsAnnotationComposer,
      $WorkFormCountsCreateCompanionBuilder,
      $WorkFormCountsUpdateCompanionBuilder,
      (
        i1.WorkFormCount,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.WorkFormCounts,
          i1.WorkFormCount
        >,
      ),
      i1.WorkFormCount,
      i0.PrefetchHooks Function()
    >;
typedef $WorkLemmaCountsCreateCompanionBuilder =
    i1.WorkLemmaCountsCompanion Function({
      required String workId,
      required String dictionaryRef,
      required int cnt,
    });
typedef $WorkLemmaCountsUpdateCompanionBuilder =
    i1.WorkLemmaCountsCompanion Function({
      i0.Value<String> workId,
      i0.Value<String> dictionaryRef,
      i0.Value<int> cnt,
    });

class $WorkLemmaCountsFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkLemmaCounts> {
  $WorkLemmaCountsFilterComposer({
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

  i0.ColumnFilters<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $WorkLemmaCountsOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkLemmaCounts> {
  $WorkLemmaCountsOrderingComposer({
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

  i0.ColumnOrderings<int> get cnt => $composableBuilder(
    column: $table.cnt,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $WorkLemmaCountsAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.WorkLemmaCounts> {
  $WorkLemmaCountsAnnotationComposer({
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

  i0.GeneratedColumn<int> get cnt =>
      $composableBuilder(column: $table.cnt, builder: (column) => column);
}

class $WorkLemmaCountsTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.WorkLemmaCounts,
          i1.WorkLemmaCount,
          i1.$WorkLemmaCountsFilterComposer,
          i1.$WorkLemmaCountsOrderingComposer,
          i1.$WorkLemmaCountsAnnotationComposer,
          $WorkLemmaCountsCreateCompanionBuilder,
          $WorkLemmaCountsUpdateCompanionBuilder,
          (
            i1.WorkLemmaCount,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.WorkLemmaCounts,
              i1.WorkLemmaCount
            >,
          ),
          i1.WorkLemmaCount,
          i0.PrefetchHooks Function()
        > {
  $WorkLemmaCountsTableManager(
    i0.GeneratedDatabase db,
    i1.WorkLemmaCounts table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$WorkLemmaCountsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$WorkLemmaCountsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$WorkLemmaCountsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<String> workId = const i0.Value.absent(),
                i0.Value<String> dictionaryRef = const i0.Value.absent(),
                i0.Value<int> cnt = const i0.Value.absent(),
              }) => i1.WorkLemmaCountsCompanion(
                workId: workId,
                dictionaryRef: dictionaryRef,
                cnt: cnt,
              ),
          createCompanionCallback:
              ({
                required String workId,
                required String dictionaryRef,
                required int cnt,
              }) => i1.WorkLemmaCountsCompanion.insert(
                workId: workId,
                dictionaryRef: dictionaryRef,
                cnt: cnt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $WorkLemmaCountsProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.WorkLemmaCounts,
      i1.WorkLemmaCount,
      i1.$WorkLemmaCountsFilterComposer,
      i1.$WorkLemmaCountsOrderingComposer,
      i1.$WorkLemmaCountsAnnotationComposer,
      $WorkLemmaCountsCreateCompanionBuilder,
      $WorkLemmaCountsUpdateCompanionBuilder,
      (
        i1.WorkLemmaCount,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.WorkLemmaCounts,
          i1.WorkLemmaCount
        >,
      ),
      i1.WorkLemmaCount,
      i0.PrefetchHooks Function()
    >;

class WorkFormCounts extends i0.Table
    with i0.TableInfo<WorkFormCounts, i1.WorkFormCount> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkFormCounts(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _cntMeta = const i0.VerificationMeta('cnt');
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
    'cnt',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (cnt > 0)',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [workId, form, macronForm, cnt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkFormCounts';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.WorkFormCount> instance, {
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
    if (data.containsKey('cnt')) {
      context.handle(
        _cntMeta,
        cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta),
      );
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, form, macronForm};
  @override
  i1.WorkFormCount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkFormCount(
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
      cnt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}cnt'],
      )!,
    );
  }

  @override
  WorkFormCounts createAlias(String alias) {
    return WorkFormCounts(attachedDatabase, alias);
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

class WorkFormCount extends i0.DataClass
    implements i0.Insertable<i1.WorkFormCount> {
  final String workId;
  final String form;
  final String macronForm;
  final int cnt;
  const WorkFormCount({
    required this.workId,
    required this.form,
    required this.macronForm,
    required this.cnt,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['form'] = i0.Variable<String>(form);
    map['macronForm'] = i0.Variable<String>(macronForm);
    map['cnt'] = i0.Variable<int>(cnt);
    return map;
  }

  i1.WorkFormCountsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkFormCountsCompanion(
      workId: i0.Value(workId),
      form: i0.Value(form),
      macronForm: i0.Value(macronForm),
      cnt: i0.Value(cnt),
    );
  }

  factory WorkFormCount.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkFormCount(
      workId: serializer.fromJson<String>(json['workId']),
      form: serializer.fromJson<String>(json['form']),
      macronForm: serializer.fromJson<String>(json['macronForm']),
      cnt: serializer.fromJson<int>(json['cnt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'form': serializer.toJson<String>(form),
      'macronForm': serializer.toJson<String>(macronForm),
      'cnt': serializer.toJson<int>(cnt),
    };
  }

  i1.WorkFormCount copyWith({
    String? workId,
    String? form,
    String? macronForm,
    int? cnt,
  }) => i1.WorkFormCount(
    workId: workId ?? this.workId,
    form: form ?? this.form,
    macronForm: macronForm ?? this.macronForm,
    cnt: cnt ?? this.cnt,
  );
  WorkFormCount copyWithCompanion(i1.WorkFormCountsCompanion data) {
    return WorkFormCount(
      workId: data.workId.present ? data.workId.value : this.workId,
      form: data.form.present ? data.form.value : this.form,
      macronForm: data.macronForm.present
          ? data.macronForm.value
          : this.macronForm,
      cnt: data.cnt.present ? data.cnt.value : this.cnt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkFormCount(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('cnt: $cnt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, form, macronForm, cnt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkFormCount &&
          other.workId == this.workId &&
          other.form == this.form &&
          other.macronForm == this.macronForm &&
          other.cnt == this.cnt);
}

class WorkFormCountsCompanion extends i0.UpdateCompanion<i1.WorkFormCount> {
  final i0.Value<String> workId;
  final i0.Value<String> form;
  final i0.Value<String> macronForm;
  final i0.Value<int> cnt;
  const WorkFormCountsCompanion({
    this.workId = const i0.Value.absent(),
    this.form = const i0.Value.absent(),
    this.macronForm = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
  });
  WorkFormCountsCompanion.insert({
    required String workId,
    required String form,
    required String macronForm,
    required int cnt,
  }) : workId = i0.Value(workId),
       form = i0.Value(form),
       macronForm = i0.Value(macronForm),
       cnt = i0.Value(cnt);
  static i0.Insertable<i1.WorkFormCount> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? form,
    i0.Expression<String>? macronForm,
    i0.Expression<int>? cnt,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (form != null) 'form': form,
      if (macronForm != null) 'macronForm': macronForm,
      if (cnt != null) 'cnt': cnt,
    });
  }

  i1.WorkFormCountsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? form,
    i0.Value<String>? macronForm,
    i0.Value<int>? cnt,
  }) {
    return i1.WorkFormCountsCompanion(
      workId: workId ?? this.workId,
      form: form ?? this.form,
      macronForm: macronForm ?? this.macronForm,
      cnt: cnt ?? this.cnt,
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
    if (cnt.present) {
      map['cnt'] = i0.Variable<int>(cnt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkFormCountsCompanion(')
          ..write('workId: $workId, ')
          ..write('form: $form, ')
          ..write('macronForm: $macronForm, ')
          ..write('cnt: $cnt')
          ..write(')'))
        .toString();
  }
}

class WorkLemmaCounts extends i0.Table
    with i0.TableInfo<WorkLemmaCounts, i1.WorkLemmaCount> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkLemmaCounts(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _cntMeta = const i0.VerificationMeta('cnt');
  late final i0.GeneratedColumn<int> cnt = i0.GeneratedColumn<int>(
    'cnt',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (cnt > 0)',
  );
  @override
  List<i0.GeneratedColumn> get $columns => [workId, dictionaryRef, cnt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkLemmaCounts';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.WorkLemmaCount> instance, {
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
    if (data.containsKey('cnt')) {
      context.handle(
        _cntMeta,
        cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta),
      );
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {workId, dictionaryRef};
  @override
  i1.WorkLemmaCount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.WorkLemmaCount(
      workId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}workId'],
      )!,
      dictionaryRef: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}dictionaryRef'],
      )!,
      cnt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}cnt'],
      )!,
    );
  }

  @override
  WorkLemmaCounts createAlias(String alias) {
    return WorkLemmaCounts(attachedDatabase, alias);
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

class WorkLemmaCount extends i0.DataClass
    implements i0.Insertable<i1.WorkLemmaCount> {
  final String workId;
  final String dictionaryRef;
  final int cnt;
  const WorkLemmaCount({
    required this.workId,
    required this.dictionaryRef,
    required this.cnt,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['workId'] = i0.Variable<String>(workId);
    map['dictionaryRef'] = i0.Variable<String>(dictionaryRef);
    map['cnt'] = i0.Variable<int>(cnt);
    return map;
  }

  i1.WorkLemmaCountsCompanion toCompanion(bool nullToAbsent) {
    return i1.WorkLemmaCountsCompanion(
      workId: i0.Value(workId),
      dictionaryRef: i0.Value(dictionaryRef),
      cnt: i0.Value(cnt),
    );
  }

  factory WorkLemmaCount.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return WorkLemmaCount(
      workId: serializer.fromJson<String>(json['workId']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      cnt: serializer.fromJson<int>(json['cnt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'cnt': serializer.toJson<int>(cnt),
    };
  }

  i1.WorkLemmaCount copyWith({
    String? workId,
    String? dictionaryRef,
    int? cnt,
  }) => i1.WorkLemmaCount(
    workId: workId ?? this.workId,
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    cnt: cnt ?? this.cnt,
  );
  WorkLemmaCount copyWithCompanion(i1.WorkLemmaCountsCompanion data) {
    return WorkLemmaCount(
      workId: data.workId.present ? data.workId.value : this.workId,
      dictionaryRef: data.dictionaryRef.present
          ? data.dictionaryRef.value
          : this.dictionaryRef,
      cnt: data.cnt.present ? data.cnt.value : this.cnt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkLemmaCount(')
          ..write('workId: $workId, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('cnt: $cnt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, dictionaryRef, cnt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.WorkLemmaCount &&
          other.workId == this.workId &&
          other.dictionaryRef == this.dictionaryRef &&
          other.cnt == this.cnt);
}

class WorkLemmaCountsCompanion extends i0.UpdateCompanion<i1.WorkLemmaCount> {
  final i0.Value<String> workId;
  final i0.Value<String> dictionaryRef;
  final i0.Value<int> cnt;
  const WorkLemmaCountsCompanion({
    this.workId = const i0.Value.absent(),
    this.dictionaryRef = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
  });
  WorkLemmaCountsCompanion.insert({
    required String workId,
    required String dictionaryRef,
    required int cnt,
  }) : workId = i0.Value(workId),
       dictionaryRef = i0.Value(dictionaryRef),
       cnt = i0.Value(cnt);
  static i0.Insertable<i1.WorkLemmaCount> custom({
    i0.Expression<String>? workId,
    i0.Expression<String>? dictionaryRef,
    i0.Expression<int>? cnt,
  }) {
    return i0.RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (dictionaryRef != null) 'dictionaryRef': dictionaryRef,
      if (cnt != null) 'cnt': cnt,
    });
  }

  i1.WorkLemmaCountsCompanion copyWith({
    i0.Value<String>? workId,
    i0.Value<String>? dictionaryRef,
    i0.Value<int>? cnt,
  }) {
    return i1.WorkLemmaCountsCompanion(
      workId: workId ?? this.workId,
      dictionaryRef: dictionaryRef ?? this.dictionaryRef,
      cnt: cnt ?? this.cnt,
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
    if (cnt.present) {
      map['cnt'] = i0.Variable<int>(cnt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkLemmaCountsCompanion(')
          ..write('workId: $workId, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('cnt: $cnt')
          ..write(')'))
        .toString();
  }
}

class WordFrequencyDrift extends i2.ModularAccessor {
  WordFrequencyDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<GetFormFrequenciesResult> getFormFrequencies(
    List<String> var1, {
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT form, MIN(macronForm) AS macronForm, SUM(cnt) AS occurrences, COUNT(*)OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalForms, SUM(SUM(cnt))OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalTokens FROM WorkFormCounts WHERE workId IN ($expandedvar1) GROUP BY form ORDER BY occurrences DESC LIMIT ?1 OFFSET ?2',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in var1) i0.Variable<String>($),
      ],
      readsFrom: {workFormCounts},
    ).map(
      (i0.QueryRow row) => GetFormFrequenciesResult(
        form: row.read<String>('form'),
        macronForm: row.readNullable<String>('macronForm'),
        occurrences: row.readNullable<int>('occurrences'),
        totalForms: row.read<int>('totalForms'),
        totalTokens: row.readNullable<int>('totalTokens'),
      ),
    );
  }

  i0.Selectable<GetMacronFormFrequenciesResult> getMacronFormFrequencies(
    List<String> var1, {
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT macronForm, MIN(form) AS form, SUM(cnt) AS occurrences, COUNT(*)OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalForms, SUM(SUM(cnt))OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalTokens FROM WorkFormCounts WHERE workId IN ($expandedvar1) GROUP BY macronForm ORDER BY occurrences DESC LIMIT ?1 OFFSET ?2',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in var1) i0.Variable<String>($),
      ],
      readsFrom: {workFormCounts},
    ).map(
      (i0.QueryRow row) => GetMacronFormFrequenciesResult(
        macronForm: row.read<String>('macronForm'),
        form: row.readNullable<String>('form'),
        occurrences: row.readNullable<int>('occurrences'),
        totalForms: row.read<int>('totalForms'),
        totalTokens: row.readNullable<int>('totalTokens'),
      ),
    );
  }

  i0.Selectable<GetLemmaFrequenciesResult> getLemmaFrequencies(
    List<String> var1, {
    required int limit,
    required int offset,
  }) {
    var $arrayStartIndex = 3;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT dictionaryRef, SUM(cnt) AS occurrences, COUNT(*)OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalLemmas, SUM(SUM(cnt))OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalTokens FROM WorkLemmaCounts WHERE workId IN ($expandedvar1) GROUP BY dictionaryRef ORDER BY occurrences DESC LIMIT ?1 OFFSET ?2',
      variables: [
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
        for (var $ in var1) i0.Variable<String>($),
      ],
      readsFrom: {workLemmaCounts},
    ).map(
      (i0.QueryRow row) => GetLemmaFrequenciesResult(
        dictionaryRef: row.read<String>('dictionaryRef'),
        occurrences: row.readNullable<int>('occurrences'),
        totalLemmas: row.read<int>('totalLemmas'),
        totalTokens: row.readNullable<int>('totalTokens'),
      ),
    );
  }

  i0.Selectable<int> getTotalLemmasInScope(List<String> var1) {
    var $arrayStartIndex = 1;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
      'SELECT COUNT(DISTINCT dictionaryRef) AS cnt FROM WorkLemmaCounts WHERE workId IN ($expandedvar1)',
      variables: [for (var $ in var1) i0.Variable<String>($)],
      readsFrom: {workLemmaCounts},
    ).map((i0.QueryRow row) => row.read<int>('cnt'));
  }

  i1.WorkFormCounts get workFormCounts => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.WorkFormCounts>('WorkFormCounts');
  i1.WorkLemmaCounts get workLemmaCounts => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.WorkLemmaCounts>('WorkLemmaCounts');
}

class GetFormFrequenciesResult {
  final String form;
  final String? macronForm;
  final int? occurrences;
  final int totalForms;
  final int? totalTokens;
  GetFormFrequenciesResult({
    required this.form,
    this.macronForm,
    this.occurrences,
    required this.totalForms,
    this.totalTokens,
  });
}

class GetMacronFormFrequenciesResult {
  final String macronForm;
  final String? form;
  final int? occurrences;
  final int totalForms;
  final int? totalTokens;
  GetMacronFormFrequenciesResult({
    required this.macronForm,
    this.form,
    this.occurrences,
    required this.totalForms,
    this.totalTokens,
  });
}

class GetLemmaFrequenciesResult {
  final String dictionaryRef;
  final int? occurrences;
  final int totalLemmas;
  final int? totalTokens;
  GetLemmaFrequenciesResult({
    required this.dictionaryRef,
    this.occurrences,
    required this.totalLemmas,
    this.totalTokens,
  });
}
