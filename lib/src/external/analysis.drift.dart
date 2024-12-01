// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:latin_reader/src/external/analysis.drift.dart' as i1;

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
  required String term,
  required String partOfSpeech,
  required String stem,
  required String suffix,
  i0.Value<String?> gender,
  i0.Value<String?> number,
  i0.Value<String?> declension,
  i0.Value<String?> grammCase,
  i0.Value<String?> mood,
  i0.Value<String?> tense,
  i0.Value<String?> voice,
  i0.Value<String?> person,
});
typedef $MorphologicalDetailInflectionsUpdateCompanionBuilder
    = i1.MorphologicalDetailInflectionsCompanion Function({
  i0.Value<String> form,
  i0.Value<int> item,
  i0.Value<int> cnt,
  i0.Value<String> term,
  i0.Value<String> partOfSpeech,
  i0.Value<String> stem,
  i0.Value<String> suffix,
  i0.Value<String?> gender,
  i0.Value<String?> number,
  i0.Value<String?> declension,
  i0.Value<String?> grammCase,
  i0.Value<String?> mood,
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

  i0.ColumnFilters<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get stem => $composableBuilder(
      column: $table.stem, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get suffix => $composableBuilder(
      column: $table.suffix, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get declension => $composableBuilder(
      column: $table.declension, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get grammCase => $composableBuilder(
      column: $table.grammCase, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => i0.ColumnFilters(column));

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

  i0.ColumnOrderings<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get stem => $composableBuilder(
      column: $table.stem, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get suffix => $composableBuilder(
      column: $table.suffix, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get declension => $composableBuilder(
      column: $table.declension,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get grammCase => $composableBuilder(
      column: $table.grammCase,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => i0.ColumnOrderings(column));

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

  i0.GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  i0.GeneratedColumn<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech, builder: (column) => column);

  i0.GeneratedColumn<String> get stem =>
      $composableBuilder(column: $table.stem, builder: (column) => column);

  i0.GeneratedColumn<String> get suffix =>
      $composableBuilder(column: $table.suffix, builder: (column) => column);

  i0.GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  i0.GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  i0.GeneratedColumn<String> get declension => $composableBuilder(
      column: $table.declension, builder: (column) => column);

  i0.GeneratedColumn<String> get grammCase =>
      $composableBuilder(column: $table.grammCase, builder: (column) => column);

  i0.GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

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
            i0.Value<String> term = const i0.Value.absent(),
            i0.Value<String> partOfSpeech = const i0.Value.absent(),
            i0.Value<String> stem = const i0.Value.absent(),
            i0.Value<String> suffix = const i0.Value.absent(),
            i0.Value<String?> gender = const i0.Value.absent(),
            i0.Value<String?> number = const i0.Value.absent(),
            i0.Value<String?> declension = const i0.Value.absent(),
            i0.Value<String?> grammCase = const i0.Value.absent(),
            i0.Value<String?> mood = const i0.Value.absent(),
            i0.Value<String?> tense = const i0.Value.absent(),
            i0.Value<String?> voice = const i0.Value.absent(),
            i0.Value<String?> person = const i0.Value.absent(),
          }) =>
              i1.MorphologicalDetailInflectionsCompanion(
            form: form,
            item: item,
            cnt: cnt,
            term: term,
            partOfSpeech: partOfSpeech,
            stem: stem,
            suffix: suffix,
            gender: gender,
            number: number,
            declension: declension,
            grammCase: grammCase,
            mood: mood,
            tense: tense,
            voice: voice,
            person: person,
          ),
          createCompanionCallback: ({
            required String form,
            required int item,
            required int cnt,
            required String term,
            required String partOfSpeech,
            required String stem,
            required String suffix,
            i0.Value<String?> gender = const i0.Value.absent(),
            i0.Value<String?> number = const i0.Value.absent(),
            i0.Value<String?> declension = const i0.Value.absent(),
            i0.Value<String?> grammCase = const i0.Value.absent(),
            i0.Value<String?> mood = const i0.Value.absent(),
            i0.Value<String?> tense = const i0.Value.absent(),
            i0.Value<String?> voice = const i0.Value.absent(),
            i0.Value<String?> person = const i0.Value.absent(),
          }) =>
              i1.MorphologicalDetailInflectionsCompanion.insert(
            form: form,
            item: item,
            cnt: cnt,
            term: term,
            partOfSpeech: partOfSpeech,
            stem: stem,
            suffix: suffix,
            gender: gender,
            number: number,
            declension: declension,
            grammCase: grammCase,
            mood: mood,
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
  static const i0.VerificationMeta _termMeta =
      const i0.VerificationMeta('term');
  late final i0.GeneratedColumn<String> term = i0.GeneratedColumn<String>(
      'term', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
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
      'suffix', aliasedName, false,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
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
  static const i0.VerificationMeta _grammCaseMeta =
      const i0.VerificationMeta('grammCase');
  late final i0.GeneratedColumn<String> grammCase = i0.GeneratedColumn<String>(
      'gramm_case', aliasedName, true,
      type: i0.DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const i0.VerificationMeta _moodMeta =
      const i0.VerificationMeta('mood');
  late final i0.GeneratedColumn<String> mood = i0.GeneratedColumn<String>(
      'mood', aliasedName, true,
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
        term,
        partOfSpeech,
        stem,
        suffix,
        gender,
        number,
        declension,
        grammCase,
        mood,
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
    if (data.containsKey('term')) {
      context.handle(
          _termMeta, term.isAcceptableOrUnknown(data['term']!, _termMeta));
    } else if (isInserting) {
      context.missing(_termMeta);
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
    } else if (isInserting) {
      context.missing(_suffixMeta);
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
    if (data.containsKey('gramm_case')) {
      context.handle(_grammCaseMeta,
          grammCase.isAcceptableOrUnknown(data['gramm_case']!, _grammCaseMeta));
    }
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
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
      term: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}term'])!,
      partOfSpeech: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}partOfSpeech'])!,
      stem: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}stem'])!,
      suffix: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}suffix'])!,
      gender: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}gender']),
      number: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}number']),
      declension: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}declension']),
      grammCase: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}gramm_case']),
      mood: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}mood']),
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
  final String term;
  final String partOfSpeech;
  final String stem;
  final String suffix;
  final String? gender;
  final String? number;
  final String? declension;
  final String? grammCase;
  final String? mood;
  final String? tense;
  final String? voice;
  final String? person;
  const MorphologicalDetailInflection(
      {required this.form,
      required this.item,
      required this.cnt,
      required this.term,
      required this.partOfSpeech,
      required this.stem,
      required this.suffix,
      this.gender,
      this.number,
      this.declension,
      this.grammCase,
      this.mood,
      this.tense,
      this.voice,
      this.person});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['form'] = i0.Variable<String>(form);
    map['item'] = i0.Variable<int>(item);
    map['cnt'] = i0.Variable<int>(cnt);
    map['term'] = i0.Variable<String>(term);
    map['partOfSpeech'] = i0.Variable<String>(partOfSpeech);
    map['stem'] = i0.Variable<String>(stem);
    map['suffix'] = i0.Variable<String>(suffix);
    if (!nullToAbsent || gender != null) {
      map['gender'] = i0.Variable<String>(gender);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = i0.Variable<String>(number);
    }
    if (!nullToAbsent || declension != null) {
      map['declension'] = i0.Variable<String>(declension);
    }
    if (!nullToAbsent || grammCase != null) {
      map['gramm_case'] = i0.Variable<String>(grammCase);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = i0.Variable<String>(mood);
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
      term: i0.Value(term),
      partOfSpeech: i0.Value(partOfSpeech),
      stem: i0.Value(stem),
      suffix: i0.Value(suffix),
      gender: gender == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(gender),
      number: number == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(number),
      declension: declension == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(declension),
      grammCase: grammCase == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(grammCase),
      mood: mood == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(mood),
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
      term: serializer.fromJson<String>(json['term']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      stem: serializer.fromJson<String>(json['stem']),
      suffix: serializer.fromJson<String>(json['suffix']),
      gender: serializer.fromJson<String?>(json['gender']),
      number: serializer.fromJson<String?>(json['number']),
      declension: serializer.fromJson<String?>(json['declension']),
      grammCase: serializer.fromJson<String?>(json['gramm_case']),
      mood: serializer.fromJson<String?>(json['mood']),
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
      'term': serializer.toJson<String>(term),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'stem': serializer.toJson<String>(stem),
      'suffix': serializer.toJson<String>(suffix),
      'gender': serializer.toJson<String?>(gender),
      'number': serializer.toJson<String?>(number),
      'declension': serializer.toJson<String?>(declension),
      'gramm_case': serializer.toJson<String?>(grammCase),
      'mood': serializer.toJson<String?>(mood),
      'tense': serializer.toJson<String?>(tense),
      'voice': serializer.toJson<String?>(voice),
      'person': serializer.toJson<String?>(person),
    };
  }

  i1.MorphologicalDetailInflection copyWith(
          {String? form,
          int? item,
          int? cnt,
          String? term,
          String? partOfSpeech,
          String? stem,
          String? suffix,
          i0.Value<String?> gender = const i0.Value.absent(),
          i0.Value<String?> number = const i0.Value.absent(),
          i0.Value<String?> declension = const i0.Value.absent(),
          i0.Value<String?> grammCase = const i0.Value.absent(),
          i0.Value<String?> mood = const i0.Value.absent(),
          i0.Value<String?> tense = const i0.Value.absent(),
          i0.Value<String?> voice = const i0.Value.absent(),
          i0.Value<String?> person = const i0.Value.absent()}) =>
      i1.MorphologicalDetailInflection(
        form: form ?? this.form,
        item: item ?? this.item,
        cnt: cnt ?? this.cnt,
        term: term ?? this.term,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        stem: stem ?? this.stem,
        suffix: suffix ?? this.suffix,
        gender: gender.present ? gender.value : this.gender,
        number: number.present ? number.value : this.number,
        declension: declension.present ? declension.value : this.declension,
        grammCase: grammCase.present ? grammCase.value : this.grammCase,
        mood: mood.present ? mood.value : this.mood,
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
      term: data.term.present ? data.term.value : this.term,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      stem: data.stem.present ? data.stem.value : this.stem,
      suffix: data.suffix.present ? data.suffix.value : this.suffix,
      gender: data.gender.present ? data.gender.value : this.gender,
      number: data.number.present ? data.number.value : this.number,
      declension:
          data.declension.present ? data.declension.value : this.declension,
      grammCase: data.grammCase.present ? data.grammCase.value : this.grammCase,
      mood: data.mood.present ? data.mood.value : this.mood,
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
          ..write('term: $term, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('stem: $stem, ')
          ..write('suffix: $suffix, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('declension: $declension, ')
          ..write('grammCase: $grammCase, ')
          ..write('mood: $mood, ')
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
      term,
      partOfSpeech,
      stem,
      suffix,
      gender,
      number,
      declension,
      grammCase,
      mood,
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
          other.term == this.term &&
          other.partOfSpeech == this.partOfSpeech &&
          other.stem == this.stem &&
          other.suffix == this.suffix &&
          other.gender == this.gender &&
          other.number == this.number &&
          other.declension == this.declension &&
          other.grammCase == this.grammCase &&
          other.mood == this.mood &&
          other.tense == this.tense &&
          other.voice == this.voice &&
          other.person == this.person);
}

class MorphologicalDetailInflectionsCompanion
    extends i0.UpdateCompanion<i1.MorphologicalDetailInflection> {
  final i0.Value<String> form;
  final i0.Value<int> item;
  final i0.Value<int> cnt;
  final i0.Value<String> term;
  final i0.Value<String> partOfSpeech;
  final i0.Value<String> stem;
  final i0.Value<String> suffix;
  final i0.Value<String?> gender;
  final i0.Value<String?> number;
  final i0.Value<String?> declension;
  final i0.Value<String?> grammCase;
  final i0.Value<String?> mood;
  final i0.Value<String?> tense;
  final i0.Value<String?> voice;
  final i0.Value<String?> person;
  const MorphologicalDetailInflectionsCompanion({
    this.form = const i0.Value.absent(),
    this.item = const i0.Value.absent(),
    this.cnt = const i0.Value.absent(),
    this.term = const i0.Value.absent(),
    this.partOfSpeech = const i0.Value.absent(),
    this.stem = const i0.Value.absent(),
    this.suffix = const i0.Value.absent(),
    this.gender = const i0.Value.absent(),
    this.number = const i0.Value.absent(),
    this.declension = const i0.Value.absent(),
    this.grammCase = const i0.Value.absent(),
    this.mood = const i0.Value.absent(),
    this.tense = const i0.Value.absent(),
    this.voice = const i0.Value.absent(),
    this.person = const i0.Value.absent(),
  });
  MorphologicalDetailInflectionsCompanion.insert({
    required String form,
    required int item,
    required int cnt,
    required String term,
    required String partOfSpeech,
    required String stem,
    required String suffix,
    this.gender = const i0.Value.absent(),
    this.number = const i0.Value.absent(),
    this.declension = const i0.Value.absent(),
    this.grammCase = const i0.Value.absent(),
    this.mood = const i0.Value.absent(),
    this.tense = const i0.Value.absent(),
    this.voice = const i0.Value.absent(),
    this.person = const i0.Value.absent(),
  })  : form = i0.Value(form),
        item = i0.Value(item),
        cnt = i0.Value(cnt),
        term = i0.Value(term),
        partOfSpeech = i0.Value(partOfSpeech),
        stem = i0.Value(stem),
        suffix = i0.Value(suffix);
  static i0.Insertable<i1.MorphologicalDetailInflection> custom({
    i0.Expression<String>? form,
    i0.Expression<int>? item,
    i0.Expression<int>? cnt,
    i0.Expression<String>? term,
    i0.Expression<String>? partOfSpeech,
    i0.Expression<String>? stem,
    i0.Expression<String>? suffix,
    i0.Expression<String>? gender,
    i0.Expression<String>? number,
    i0.Expression<String>? declension,
    i0.Expression<String>? grammCase,
    i0.Expression<String>? mood,
    i0.Expression<String>? tense,
    i0.Expression<String>? voice,
    i0.Expression<String>? person,
  }) {
    return i0.RawValuesInsertable({
      if (form != null) 'form': form,
      if (item != null) 'item': item,
      if (cnt != null) 'cnt': cnt,
      if (term != null) 'term': term,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      if (stem != null) 'stem': stem,
      if (suffix != null) 'suffix': suffix,
      if (gender != null) 'gender': gender,
      if (number != null) 'number': number,
      if (declension != null) 'declension': declension,
      if (grammCase != null) 'gramm_case': grammCase,
      if (mood != null) 'mood': mood,
      if (tense != null) 'tense': tense,
      if (voice != null) 'voice': voice,
      if (person != null) 'person': person,
    });
  }

  i1.MorphologicalDetailInflectionsCompanion copyWith(
      {i0.Value<String>? form,
      i0.Value<int>? item,
      i0.Value<int>? cnt,
      i0.Value<String>? term,
      i0.Value<String>? partOfSpeech,
      i0.Value<String>? stem,
      i0.Value<String>? suffix,
      i0.Value<String?>? gender,
      i0.Value<String?>? number,
      i0.Value<String?>? declension,
      i0.Value<String?>? grammCase,
      i0.Value<String?>? mood,
      i0.Value<String?>? tense,
      i0.Value<String?>? voice,
      i0.Value<String?>? person}) {
    return i1.MorphologicalDetailInflectionsCompanion(
      form: form ?? this.form,
      item: item ?? this.item,
      cnt: cnt ?? this.cnt,
      term: term ?? this.term,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      stem: stem ?? this.stem,
      suffix: suffix ?? this.suffix,
      gender: gender ?? this.gender,
      number: number ?? this.number,
      declension: declension ?? this.declension,
      grammCase: grammCase ?? this.grammCase,
      mood: mood ?? this.mood,
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
    if (term.present) {
      map['term'] = i0.Variable<String>(term.value);
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
    if (gender.present) {
      map['gender'] = i0.Variable<String>(gender.value);
    }
    if (number.present) {
      map['number'] = i0.Variable<String>(number.value);
    }
    if (declension.present) {
      map['declension'] = i0.Variable<String>(declension.value);
    }
    if (grammCase.present) {
      map['gramm_case'] = i0.Variable<String>(grammCase.value);
    }
    if (mood.present) {
      map['mood'] = i0.Variable<String>(mood.value);
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
          ..write('term: $term, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('stem: $stem, ')
          ..write('suffix: $suffix, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('declension: $declension, ')
          ..write('grammCase: $grammCase, ')
          ..write('mood: $mood, ')
          ..write('tense: $tense, ')
          ..write('voice: $voice, ')
          ..write('person: $person')
          ..write(')'))
        .toString();
  }
}
