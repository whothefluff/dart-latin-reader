// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class DataVersion extends Table with TableInfo<DataVersion, DataVersionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DataVersion(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idxMeta = const VerificationMeta('idx');
  late final GeneratedColumn<int> idx = GeneratedColumn<int>(
      'idx', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'createdAt', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
      defaultValue: const CustomExpression('CURRENT_TIMESTAMP'));
  @override
  List<GeneratedColumn> get $columns => [idx, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'DataVersion';
  @override
  VerificationContext validateIntegrity(Insertable<DataVersionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {idx};
  @override
  DataVersionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataVersionData(
      idx: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}idx'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}createdAt'])!,
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

class DataVersionData extends DataClass implements Insertable<DataVersionData> {
  final int idx;
  final int createdAt;
  const DataVersionData({required this.idx, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['idx'] = Variable<int>(idx);
    map['createdAt'] = Variable<int>(createdAt);
    return map;
  }

  DataVersionCompanion toCompanion(bool nullToAbsent) {
    return DataVersionCompanion(
      idx: Value(idx),
      createdAt: Value(createdAt),
    );
  }

  factory DataVersionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataVersionData(
      idx: serializer.fromJson<int>(json['idx']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idx': serializer.toJson<int>(idx),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  DataVersionData copyWith({int? idx, int? createdAt}) => DataVersionData(
        idx: idx ?? this.idx,
        createdAt: createdAt ?? this.createdAt,
      );
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
      (other is DataVersionData &&
          other.idx == this.idx &&
          other.createdAt == this.createdAt);
}

class DataVersionCompanion extends UpdateCompanion<DataVersionData> {
  final Value<int> idx;
  final Value<int> createdAt;
  const DataVersionCompanion({
    this.idx = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DataVersionCompanion.insert({
    this.idx = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<DataVersionData> custom({
    Expression<int>? idx,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idx != null) 'idx': idx,
      if (createdAt != null) 'createdAt': createdAt,
    });
  }

  DataVersionCompanion copyWith({Value<int>? idx, Value<int>? createdAt}) {
    return DataVersionCompanion(
      idx: idx ?? this.idx,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idx.present) {
      map['idx'] = Variable<int>(idx.value);
    }
    if (createdAt.present) {
      map['createdAt'] = Variable<int>(createdAt.value);
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

class MorphologicalDetails extends Table
    with TableInfo<MorphologicalDetails, MorphologicalDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MorphologicalDetails(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
      'form', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  late final GeneratedColumn<int> item = GeneratedColumn<int>(
      'item', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (item > 0)');
  static const VerificationMeta _dictionaryRefMeta =
      const VerificationMeta('dictionaryRef');
  late final GeneratedColumn<String> dictionaryRef = GeneratedColumn<String>(
      'dictionaryRef', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [form, item, dictionaryRef];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'MorphologicalDetails';
  @override
  VerificationContext validateIntegrity(
      Insertable<MorphologicalDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {form, item};
  @override
  MorphologicalDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MorphologicalDetail(
      form: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form'])!,
      item: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item'])!,
      dictionaryRef: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dictionaryRef'])!,
    );
  }

  @override
  MorphologicalDetails createAlias(String alias) {
    return MorphologicalDetails(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const ['PRIMARY KEY(form, item)'];
  @override
  bool get dontWriteConstraints => true;
}

class MorphologicalDetail extends DataClass
    implements Insertable<MorphologicalDetail> {
  final String form;
  final int item;
  final String dictionaryRef;
  const MorphologicalDetail(
      {required this.form, required this.item, required this.dictionaryRef});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['form'] = Variable<String>(form);
    map['item'] = Variable<int>(item);
    map['dictionaryRef'] = Variable<String>(dictionaryRef);
    return map;
  }

  MorphologicalDetailsCompanion toCompanion(bool nullToAbsent) {
    return MorphologicalDetailsCompanion(
      form: Value(form),
      item: Value(item),
      dictionaryRef: Value(dictionaryRef),
    );
  }

  factory MorphologicalDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MorphologicalDetail(
      form: serializer.fromJson<String>(json['form']),
      item: serializer.fromJson<int>(json['item']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String>(form),
      'item': serializer.toJson<int>(item),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
    };
  }

  MorphologicalDetail copyWith(
          {String? form, int? item, String? dictionaryRef}) =>
      MorphologicalDetail(
        form: form ?? this.form,
        item: item ?? this.item,
        dictionaryRef: dictionaryRef ?? this.dictionaryRef,
      );
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
      (other is MorphologicalDetail &&
          other.form == this.form &&
          other.item == this.item &&
          other.dictionaryRef == this.dictionaryRef);
}

class MorphologicalDetailsCompanion
    extends UpdateCompanion<MorphologicalDetail> {
  final Value<String> form;
  final Value<int> item;
  final Value<String> dictionaryRef;
  const MorphologicalDetailsCompanion({
    this.form = const Value.absent(),
    this.item = const Value.absent(),
    this.dictionaryRef = const Value.absent(),
  });
  MorphologicalDetailsCompanion.insert({
    required String form,
    required int item,
    required String dictionaryRef,
  })  : form = Value(form),
        item = Value(item),
        dictionaryRef = Value(dictionaryRef);
  static Insertable<MorphologicalDetail> custom({
    Expression<String>? form,
    Expression<int>? item,
    Expression<String>? dictionaryRef,
  }) {
    return RawValuesInsertable({
      if (form != null) 'form': form,
      if (item != null) 'item': item,
      if (dictionaryRef != null) 'dictionaryRef': dictionaryRef,
    });
  }

  MorphologicalDetailsCompanion copyWith(
      {Value<String>? form, Value<int>? item, Value<String>? dictionaryRef}) {
    return MorphologicalDetailsCompanion(
      form: form ?? this.form,
      item: item ?? this.item,
      dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (dictionaryRef.present) {
      map['dictionaryRef'] = Variable<String>(dictionaryRef.value);
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

class MorphologicalDetailInflections extends Table
    with
        TableInfo<MorphologicalDetailInflections,
            MorphologicalDetailInflection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MorphologicalDetailInflections(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
      'form', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  late final GeneratedColumn<int> item = GeneratedColumn<int>(
      'item', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _cntMeta = const VerificationMeta('cnt');
  late final GeneratedColumn<int> cnt = GeneratedColumn<int>(
      'cnt', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (cnt > 0)');
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
      'term', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _partOfSpeechMeta =
      const VerificationMeta('partOfSpeech');
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
      'partOfSpeech', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _stemMeta = const VerificationMeta('stem');
  late final GeneratedColumn<String> stem = GeneratedColumn<String>(
      'stem', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _suffixMeta = const VerificationMeta('suffix');
  late final GeneratedColumn<String> suffix = GeneratedColumn<String>(
      'suffix', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _declensionMeta =
      const VerificationMeta('declension');
  late final GeneratedColumn<String> declension = GeneratedColumn<String>(
      'declension', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _grammCaseMeta =
      const VerificationMeta('grammCase');
  late final GeneratedColumn<String> grammCase = GeneratedColumn<String>(
      'gramm_case', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
      'mood', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tenseMeta = const VerificationMeta('tense');
  late final GeneratedColumn<String> tense = GeneratedColumn<String>(
      'tense', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _voiceMeta = const VerificationMeta('voice');
  late final GeneratedColumn<String> voice = GeneratedColumn<String>(
      'voice', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
      'person', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
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
  VerificationContext validateIntegrity(
      Insertable<MorphologicalDetailInflection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {form, item, cnt};
  @override
  MorphologicalDetailInflection map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MorphologicalDetailInflection(
      form: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form'])!,
      item: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item'])!,
      cnt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cnt'])!,
      term: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}term'])!,
      partOfSpeech: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}partOfSpeech'])!,
      stem: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stem'])!,
      suffix: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}suffix'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number']),
      declension: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}declension']),
      grammCase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gramm_case']),
      mood: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood']),
      tense: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tense']),
      voice: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}voice']),
      person: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person']),
    );
  }

  @override
  MorphologicalDetailInflections createAlias(String alias) {
    return MorphologicalDetailInflections(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(form, item, cnt)',
        'FOREIGN KEY(form, item)REFERENCES MorphologicalDetails(form, item)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class MorphologicalDetailInflection extends DataClass
    implements Insertable<MorphologicalDetailInflection> {
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['form'] = Variable<String>(form);
    map['item'] = Variable<int>(item);
    map['cnt'] = Variable<int>(cnt);
    map['term'] = Variable<String>(term);
    map['partOfSpeech'] = Variable<String>(partOfSpeech);
    map['stem'] = Variable<String>(stem);
    map['suffix'] = Variable<String>(suffix);
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    if (!nullToAbsent || declension != null) {
      map['declension'] = Variable<String>(declension);
    }
    if (!nullToAbsent || grammCase != null) {
      map['gramm_case'] = Variable<String>(grammCase);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    if (!nullToAbsent || tense != null) {
      map['tense'] = Variable<String>(tense);
    }
    if (!nullToAbsent || voice != null) {
      map['voice'] = Variable<String>(voice);
    }
    if (!nullToAbsent || person != null) {
      map['person'] = Variable<String>(person);
    }
    return map;
  }

  MorphologicalDetailInflectionsCompanion toCompanion(bool nullToAbsent) {
    return MorphologicalDetailInflectionsCompanion(
      form: Value(form),
      item: Value(item),
      cnt: Value(cnt),
      term: Value(term),
      partOfSpeech: Value(partOfSpeech),
      stem: Value(stem),
      suffix: Value(suffix),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      number:
          number == null && nullToAbsent ? const Value.absent() : Value(number),
      declension: declension == null && nullToAbsent
          ? const Value.absent()
          : Value(declension),
      grammCase: grammCase == null && nullToAbsent
          ? const Value.absent()
          : Value(grammCase),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      tense:
          tense == null && nullToAbsent ? const Value.absent() : Value(tense),
      voice:
          voice == null && nullToAbsent ? const Value.absent() : Value(voice),
      person:
          person == null && nullToAbsent ? const Value.absent() : Value(person),
    );
  }

  factory MorphologicalDetailInflection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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

  MorphologicalDetailInflection copyWith(
          {String? form,
          int? item,
          int? cnt,
          String? term,
          String? partOfSpeech,
          String? stem,
          String? suffix,
          Value<String?> gender = const Value.absent(),
          Value<String?> number = const Value.absent(),
          Value<String?> declension = const Value.absent(),
          Value<String?> grammCase = const Value.absent(),
          Value<String?> mood = const Value.absent(),
          Value<String?> tense = const Value.absent(),
          Value<String?> voice = const Value.absent(),
          Value<String?> person = const Value.absent()}) =>
      MorphologicalDetailInflection(
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
      (other is MorphologicalDetailInflection &&
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
    extends UpdateCompanion<MorphologicalDetailInflection> {
  final Value<String> form;
  final Value<int> item;
  final Value<int> cnt;
  final Value<String> term;
  final Value<String> partOfSpeech;
  final Value<String> stem;
  final Value<String> suffix;
  final Value<String?> gender;
  final Value<String?> number;
  final Value<String?> declension;
  final Value<String?> grammCase;
  final Value<String?> mood;
  final Value<String?> tense;
  final Value<String?> voice;
  final Value<String?> person;
  const MorphologicalDetailInflectionsCompanion({
    this.form = const Value.absent(),
    this.item = const Value.absent(),
    this.cnt = const Value.absent(),
    this.term = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.stem = const Value.absent(),
    this.suffix = const Value.absent(),
    this.gender = const Value.absent(),
    this.number = const Value.absent(),
    this.declension = const Value.absent(),
    this.grammCase = const Value.absent(),
    this.mood = const Value.absent(),
    this.tense = const Value.absent(),
    this.voice = const Value.absent(),
    this.person = const Value.absent(),
  });
  MorphologicalDetailInflectionsCompanion.insert({
    required String form,
    required int item,
    required int cnt,
    required String term,
    required String partOfSpeech,
    required String stem,
    required String suffix,
    this.gender = const Value.absent(),
    this.number = const Value.absent(),
    this.declension = const Value.absent(),
    this.grammCase = const Value.absent(),
    this.mood = const Value.absent(),
    this.tense = const Value.absent(),
    this.voice = const Value.absent(),
    this.person = const Value.absent(),
  })  : form = Value(form),
        item = Value(item),
        cnt = Value(cnt),
        term = Value(term),
        partOfSpeech = Value(partOfSpeech),
        stem = Value(stem),
        suffix = Value(suffix);
  static Insertable<MorphologicalDetailInflection> custom({
    Expression<String>? form,
    Expression<int>? item,
    Expression<int>? cnt,
    Expression<String>? term,
    Expression<String>? partOfSpeech,
    Expression<String>? stem,
    Expression<String>? suffix,
    Expression<String>? gender,
    Expression<String>? number,
    Expression<String>? declension,
    Expression<String>? grammCase,
    Expression<String>? mood,
    Expression<String>? tense,
    Expression<String>? voice,
    Expression<String>? person,
  }) {
    return RawValuesInsertable({
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

  MorphologicalDetailInflectionsCompanion copyWith(
      {Value<String>? form,
      Value<int>? item,
      Value<int>? cnt,
      Value<String>? term,
      Value<String>? partOfSpeech,
      Value<String>? stem,
      Value<String>? suffix,
      Value<String?>? gender,
      Value<String?>? number,
      Value<String?>? declension,
      Value<String?>? grammCase,
      Value<String?>? mood,
      Value<String?>? tense,
      Value<String?>? voice,
      Value<String?>? person}) {
    return MorphologicalDetailInflectionsCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (cnt.present) {
      map['cnt'] = Variable<int>(cnt.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (partOfSpeech.present) {
      map['partOfSpeech'] = Variable<String>(partOfSpeech.value);
    }
    if (stem.present) {
      map['stem'] = Variable<String>(stem.value);
    }
    if (suffix.present) {
      map['suffix'] = Variable<String>(suffix.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (declension.present) {
      map['declension'] = Variable<String>(declension.value);
    }
    if (grammCase.present) {
      map['gramm_case'] = Variable<String>(grammCase.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (tense.present) {
      map['tense'] = Variable<String>(tense.value);
    }
    if (voice.present) {
      map['voice'] = Variable<String>(voice.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
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

class Macronizations extends Table
    with TableInfo<Macronizations, Macronization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Macronizations(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
      'form', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _syllableNumberMeta =
      const VerificationMeta('syllableNumber');
  late final GeneratedColumn<int> syllableNumber = GeneratedColumn<int>(
      'syllableNumber', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (syllableNumber > 0)');
  static const VerificationMeta _macronizedSyllableMeta =
      const VerificationMeta('macronizedSyllable');
  late final GeneratedColumn<String> macronizedSyllable =
      GeneratedColumn<String>('macronizedSyllable', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const VerificationMeta _isUncertainMeta =
      const VerificationMeta('isUncertain');
  late final GeneratedColumn<int> isUncertain = GeneratedColumn<int>(
      'isUncertain', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (isUncertain IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [form, syllableNumber, macronizedSyllable, isUncertain];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Macronizations';
  @override
  VerificationContext validateIntegrity(Insertable<Macronization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('syllableNumber')) {
      context.handle(
          _syllableNumberMeta,
          syllableNumber.isAcceptableOrUnknown(
              data['syllableNumber']!, _syllableNumberMeta));
    } else if (isInserting) {
      context.missing(_syllableNumberMeta);
    }
    if (data.containsKey('macronizedSyllable')) {
      context.handle(
          _macronizedSyllableMeta,
          macronizedSyllable.isAcceptableOrUnknown(
              data['macronizedSyllable']!, _macronizedSyllableMeta));
    } else if (isInserting) {
      context.missing(_macronizedSyllableMeta);
    }
    if (data.containsKey('isUncertain')) {
      context.handle(
          _isUncertainMeta,
          isUncertain.isAcceptableOrUnknown(
              data['isUncertain']!, _isUncertainMeta));
    } else if (isInserting) {
      context.missing(_isUncertainMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {form, syllableNumber};
  @override
  Macronization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Macronization(
      form: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form'])!,
      syllableNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}syllableNumber'])!,
      macronizedSyllable: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}macronizedSyllable'])!,
      isUncertain: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}isUncertain'])!,
    );
  }

  @override
  Macronizations createAlias(String alias) {
    return Macronizations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints =>
      const ['PRIMARY KEY(form, syllableNumber)'];
  @override
  bool get dontWriteConstraints => true;
}

class Macronization extends DataClass implements Insertable<Macronization> {
  final String form;
  final int syllableNumber;
  final String macronizedSyllable;
  final int isUncertain;
  const Macronization(
      {required this.form,
      required this.syllableNumber,
      required this.macronizedSyllable,
      required this.isUncertain});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['form'] = Variable<String>(form);
    map['syllableNumber'] = Variable<int>(syllableNumber);
    map['macronizedSyllable'] = Variable<String>(macronizedSyllable);
    map['isUncertain'] = Variable<int>(isUncertain);
    return map;
  }

  MacronizationsCompanion toCompanion(bool nullToAbsent) {
    return MacronizationsCompanion(
      form: Value(form),
      syllableNumber: Value(syllableNumber),
      macronizedSyllable: Value(macronizedSyllable),
      isUncertain: Value(isUncertain),
    );
  }

  factory Macronization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Macronization(
      form: serializer.fromJson<String>(json['form']),
      syllableNumber: serializer.fromJson<int>(json['syllableNumber']),
      macronizedSyllable:
          serializer.fromJson<String>(json['macronizedSyllable']),
      isUncertain: serializer.fromJson<int>(json['isUncertain']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'form': serializer.toJson<String>(form),
      'syllableNumber': serializer.toJson<int>(syllableNumber),
      'macronizedSyllable': serializer.toJson<String>(macronizedSyllable),
      'isUncertain': serializer.toJson<int>(isUncertain),
    };
  }

  Macronization copyWith(
          {String? form,
          int? syllableNumber,
          String? macronizedSyllable,
          int? isUncertain}) =>
      Macronization(
        form: form ?? this.form,
        syllableNumber: syllableNumber ?? this.syllableNumber,
        macronizedSyllable: macronizedSyllable ?? this.macronizedSyllable,
        isUncertain: isUncertain ?? this.isUncertain,
      );
  @override
  String toString() {
    return (StringBuffer('Macronization(')
          ..write('form: $form, ')
          ..write('syllableNumber: $syllableNumber, ')
          ..write('macronizedSyllable: $macronizedSyllable, ')
          ..write('isUncertain: $isUncertain')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(form, syllableNumber, macronizedSyllable, isUncertain);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Macronization &&
          other.form == this.form &&
          other.syllableNumber == this.syllableNumber &&
          other.macronizedSyllable == this.macronizedSyllable &&
          other.isUncertain == this.isUncertain);
}

class MacronizationsCompanion extends UpdateCompanion<Macronization> {
  final Value<String> form;
  final Value<int> syllableNumber;
  final Value<String> macronizedSyllable;
  final Value<int> isUncertain;
  const MacronizationsCompanion({
    this.form = const Value.absent(),
    this.syllableNumber = const Value.absent(),
    this.macronizedSyllable = const Value.absent(),
    this.isUncertain = const Value.absent(),
  });
  MacronizationsCompanion.insert({
    required String form,
    required int syllableNumber,
    required String macronizedSyllable,
    required int isUncertain,
  })  : form = Value(form),
        syllableNumber = Value(syllableNumber),
        macronizedSyllable = Value(macronizedSyllable),
        isUncertain = Value(isUncertain);
  static Insertable<Macronization> custom({
    Expression<String>? form,
    Expression<int>? syllableNumber,
    Expression<String>? macronizedSyllable,
    Expression<int>? isUncertain,
  }) {
    return RawValuesInsertable({
      if (form != null) 'form': form,
      if (syllableNumber != null) 'syllableNumber': syllableNumber,
      if (macronizedSyllable != null) 'macronizedSyllable': macronizedSyllable,
      if (isUncertain != null) 'isUncertain': isUncertain,
    });
  }

  MacronizationsCompanion copyWith(
      {Value<String>? form,
      Value<int>? syllableNumber,
      Value<String>? macronizedSyllable,
      Value<int>? isUncertain}) {
    return MacronizationsCompanion(
      form: form ?? this.form,
      syllableNumber: syllableNumber ?? this.syllableNumber,
      macronizedSyllable: macronizedSyllable ?? this.macronizedSyllable,
      isUncertain: isUncertain ?? this.isUncertain,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (syllableNumber.present) {
      map['syllableNumber'] = Variable<int>(syllableNumber.value);
    }
    if (macronizedSyllable.present) {
      map['macronizedSyllable'] = Variable<String>(macronizedSyllable.value);
    }
    if (isUncertain.present) {
      map['isUncertain'] = Variable<int>(isUncertain.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MacronizationsCompanion(')
          ..write('form: $form, ')
          ..write('syllableNumber: $syllableNumber, ')
          ..write('macronizedSyllable: $macronizedSyllable, ')
          ..write('isUncertain: $isUncertain')
          ..write(')'))
        .toString();
  }
}

class Authors extends Table with TableInfo<Authors, Author> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Authors(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (id LIKE \'________-____-____-____-____________\')');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
      'about', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, true,
      type: DriftSqlType.blob,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, name, about, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Authors';
  @override
  VerificationContext validateIntegrity(Insertable<Author> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('about')) {
      context.handle(
          _aboutMeta, about.isAcceptableOrUnknown(data['about']!, _aboutMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Author map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Author(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      about: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}about']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image']),
    );
  }

  @override
  Authors createAlias(String alias) {
    return Authors(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class Author extends DataClass implements Insertable<Author> {
  final String id;
  final String name;
  final String? about;
  final Uint8List? image;
  const Author({required this.id, required this.name, this.about, this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<Uint8List>(image);
    }
    return map;
  }

  AuthorsCompanion toCompanion(bool nullToAbsent) {
    return AuthorsCompanion(
      id: Value(id),
      name: Value(name),
      about:
          about == null && nullToAbsent ? const Value.absent() : Value(about),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory Author.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Author(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String?>(json['about']),
      image: serializer.fromJson<Uint8List?>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String?>(about),
      'image': serializer.toJson<Uint8List?>(image),
    };
  }

  Author copyWith(
          {String? id,
          String? name,
          Value<String?> about = const Value.absent(),
          Value<Uint8List?> image = const Value.absent()}) =>
      Author(
        id: id ?? this.id,
        name: name ?? this.name,
        about: about.present ? about.value : this.about,
        image: image.present ? image.value : this.image,
      );
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
      Object.hash(id, name, about, $driftBlobEquality.hash(image));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Author &&
          other.id == this.id &&
          other.name == this.name &&
          other.about == this.about &&
          $driftBlobEquality.equals(other.image, this.image));
}

class AuthorsCompanion extends UpdateCompanion<Author> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> about;
  final Value<Uint8List?> image;
  const AuthorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.about = const Value.absent(),
    this.image = const Value.absent(),
  });
  AuthorsCompanion.insert({
    required String id,
    required String name,
    this.about = const Value.absent(),
    this.image = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Author> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? about,
    Expression<Uint8List>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
      if (image != null) 'image': image,
    });
  }

  AuthorsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? about,
      Value<Uint8List?>? image}) {
    return AuthorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
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

class AuthorAbbreviations extends Table
    with TableInfo<AuthorAbbreviations, AuthorAbbreviation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AuthorAbbreviations(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'authorId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (id > 0)');
  static const VerificationMeta _valMeta = const VerificationMeta('val');
  late final GeneratedColumn<String> val = GeneratedColumn<String>(
      'val', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [authorId, id, val];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'AuthorAbbreviations';
  @override
  VerificationContext validateIntegrity(Insertable<AuthorAbbreviation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('authorId')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['authorId']!, _authorIdMeta));
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
          _valMeta, val.isAcceptableOrUnknown(data['val']!, _valMeta));
    } else if (isInserting) {
      context.missing(_valMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {authorId, id};
  @override
  AuthorAbbreviation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthorAbbreviation(
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}authorId'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      val: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}val'])!,
    );
  }

  @override
  AuthorAbbreviations createAlias(String alias) {
    return AuthorAbbreviations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(authorId, id)',
        'FOREIGN KEY(authorId)REFERENCES Authors(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class AuthorAbbreviation extends DataClass
    implements Insertable<AuthorAbbreviation> {
  final String authorId;
  final int id;
  final String val;
  const AuthorAbbreviation(
      {required this.authorId, required this.id, required this.val});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['authorId'] = Variable<String>(authorId);
    map['id'] = Variable<int>(id);
    map['val'] = Variable<String>(val);
    return map;
  }

  AuthorAbbreviationsCompanion toCompanion(bool nullToAbsent) {
    return AuthorAbbreviationsCompanion(
      authorId: Value(authorId),
      id: Value(id),
      val: Value(val),
    );
  }

  factory AuthorAbbreviation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthorAbbreviation(
      authorId: serializer.fromJson<String>(json['authorId']),
      id: serializer.fromJson<int>(json['id']),
      val: serializer.fromJson<String>(json['val']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'authorId': serializer.toJson<String>(authorId),
      'id': serializer.toJson<int>(id),
      'val': serializer.toJson<String>(val),
    };
  }

  AuthorAbbreviation copyWith({String? authorId, int? id, String? val}) =>
      AuthorAbbreviation(
        authorId: authorId ?? this.authorId,
        id: id ?? this.id,
        val: val ?? this.val,
      );
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
      (other is AuthorAbbreviation &&
          other.authorId == this.authorId &&
          other.id == this.id &&
          other.val == this.val);
}

class AuthorAbbreviationsCompanion extends UpdateCompanion<AuthorAbbreviation> {
  final Value<String> authorId;
  final Value<int> id;
  final Value<String> val;
  const AuthorAbbreviationsCompanion({
    this.authorId = const Value.absent(),
    this.id = const Value.absent(),
    this.val = const Value.absent(),
  });
  AuthorAbbreviationsCompanion.insert({
    required String authorId,
    required int id,
    required String val,
  })  : authorId = Value(authorId),
        id = Value(id),
        val = Value(val);
  static Insertable<AuthorAbbreviation> custom({
    Expression<String>? authorId,
    Expression<int>? id,
    Expression<String>? val,
  }) {
    return RawValuesInsertable({
      if (authorId != null) 'authorId': authorId,
      if (id != null) 'id': id,
      if (val != null) 'val': val,
    });
  }

  AuthorAbbreviationsCompanion copyWith(
      {Value<String>? authorId, Value<int>? id, Value<String>? val}) {
    return AuthorAbbreviationsCompanion(
      authorId: authorId ?? this.authorId,
      id: id ?? this.id,
      val: val ?? this.val,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (authorId.present) {
      map['authorId'] = Variable<String>(authorId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (val.present) {
      map['val'] = Variable<String>(val.value);
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

class Works extends Table with TableInfo<Works, Work> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Works(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (id LIKE \'________-____-____-____-____________\')');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
      'about', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, name, about];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Works';
  @override
  VerificationContext validateIntegrity(Insertable<Work> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('about')) {
      context.handle(
          _aboutMeta, about.isAcceptableOrUnknown(data['about']!, _aboutMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Work map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Work(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      about: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}about']),
    );
  }

  @override
  Works createAlias(String alias) {
    return Works(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const ['PRIMARY KEY(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class Work extends DataClass implements Insertable<Work> {
  final String id;
  final String name;
  final String? about;
  const Work({required this.id, required this.name, this.about});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    return map;
  }

  WorksCompanion toCompanion(bool nullToAbsent) {
    return WorksCompanion(
      id: Value(id),
      name: Value(name),
      about:
          about == null && nullToAbsent ? const Value.absent() : Value(about),
    );
  }

  factory Work.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Work(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String?>(json['about']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String?>(about),
    };
  }

  Work copyWith(
          {String? id,
          String? name,
          Value<String?> about = const Value.absent()}) =>
      Work(
        id: id ?? this.id,
        name: name ?? this.name,
        about: about.present ? about.value : this.about,
      );
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
      (other is Work &&
          other.id == this.id &&
          other.name == this.name &&
          other.about == this.about);
}

class WorksCompanion extends UpdateCompanion<Work> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> about;
  const WorksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.about = const Value.absent(),
  });
  WorksCompanion.insert({
    required String id,
    required String name,
    this.about = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Work> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? about,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
    });
  }

  WorksCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<String?>? about}) {
    return WorksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
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

class WorkAbbreviations extends Table
    with TableInfo<WorkAbbreviations, WorkAbbreviation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkAbbreviations(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'workId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (id > 0)');
  static const VerificationMeta _valMeta = const VerificationMeta('val');
  late final GeneratedColumn<String> val = GeneratedColumn<String>(
      'val', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [workId, id, val];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkAbbreviations';
  @override
  VerificationContext validateIntegrity(Insertable<WorkAbbreviation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta));
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
          _valMeta, val.isAcceptableOrUnknown(data['val']!, _valMeta));
    } else if (isInserting) {
      context.missing(_valMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workId, id};
  @override
  WorkAbbreviation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkAbbreviation(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      val: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}val'])!,
    );
  }

  @override
  WorkAbbreviations createAlias(String alias) {
    return WorkAbbreviations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(workId, id)',
        'FOREIGN KEY(workId)REFERENCES Works(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkAbbreviation extends DataClass
    implements Insertable<WorkAbbreviation> {
  final String workId;
  final int id;
  final String val;
  const WorkAbbreviation(
      {required this.workId, required this.id, required this.val});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['workId'] = Variable<String>(workId);
    map['id'] = Variable<int>(id);
    map['val'] = Variable<String>(val);
    return map;
  }

  WorkAbbreviationsCompanion toCompanion(bool nullToAbsent) {
    return WorkAbbreviationsCompanion(
      workId: Value(workId),
      id: Value(id),
      val: Value(val),
    );
  }

  factory WorkAbbreviation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkAbbreviation(
      workId: serializer.fromJson<String>(json['workId']),
      id: serializer.fromJson<int>(json['id']),
      val: serializer.fromJson<String>(json['val']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'id': serializer.toJson<int>(id),
      'val': serializer.toJson<String>(val),
    };
  }

  WorkAbbreviation copyWith({String? workId, int? id, String? val}) =>
      WorkAbbreviation(
        workId: workId ?? this.workId,
        id: id ?? this.id,
        val: val ?? this.val,
      );
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
      (other is WorkAbbreviation &&
          other.workId == this.workId &&
          other.id == this.id &&
          other.val == this.val);
}

class WorkAbbreviationsCompanion extends UpdateCompanion<WorkAbbreviation> {
  final Value<String> workId;
  final Value<int> id;
  final Value<String> val;
  const WorkAbbreviationsCompanion({
    this.workId = const Value.absent(),
    this.id = const Value.absent(),
    this.val = const Value.absent(),
  });
  WorkAbbreviationsCompanion.insert({
    required String workId,
    required int id,
    required String val,
  })  : workId = Value(workId),
        id = Value(id),
        val = Value(val);
  static Insertable<WorkAbbreviation> custom({
    Expression<String>? workId,
    Expression<int>? id,
    Expression<String>? val,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (id != null) 'id': id,
      if (val != null) 'val': val,
    });
  }

  WorkAbbreviationsCompanion copyWith(
      {Value<String>? workId, Value<int>? id, Value<String>? val}) {
    return WorkAbbreviationsCompanion(
      workId: workId ?? this.workId,
      id: id ?? this.id,
      val: val ?? this.val,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workId.present) {
      map['workId'] = Variable<String>(workId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (val.present) {
      map['val'] = Variable<String>(val.value);
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

class WorkContents extends Table with TableInfo<WorkContents, WorkContent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkContents(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'workId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _idxMeta = const VerificationMeta('idx');
  late final GeneratedColumn<int> idx = GeneratedColumn<int>(
      'idx', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (idx > 0)');
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _sourceReferenceMeta =
      const VerificationMeta('sourceReference');
  late final GeneratedColumn<String> sourceReference = GeneratedColumn<String>(
      'sourceReference', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [workId, idx, word, sourceReference];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkContents';
  @override
  VerificationContext validateIntegrity(Insertable<WorkContent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('idx')) {
      context.handle(
          _idxMeta, idx.isAcceptableOrUnknown(data['idx']!, _idxMeta));
    } else if (isInserting) {
      context.missing(_idxMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('sourceReference')) {
      context.handle(
          _sourceReferenceMeta,
          sourceReference.isAcceptableOrUnknown(
              data['sourceReference']!, _sourceReferenceMeta));
    } else if (isInserting) {
      context.missing(_sourceReferenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workId, idx};
  @override
  WorkContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkContent(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
      idx: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}idx'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      sourceReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sourceReference'])!,
    );
  }

  @override
  WorkContents createAlias(String alias) {
    return WorkContents(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(workId, idx)',
        'FOREIGN KEY(workId)REFERENCES Works(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkContent extends DataClass implements Insertable<WorkContent> {
  final String workId;
  final int idx;
  final String word;
  final String sourceReference;
  const WorkContent(
      {required this.workId,
      required this.idx,
      required this.word,
      required this.sourceReference});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['workId'] = Variable<String>(workId);
    map['idx'] = Variable<int>(idx);
    map['word'] = Variable<String>(word);
    map['sourceReference'] = Variable<String>(sourceReference);
    return map;
  }

  WorkContentsCompanion toCompanion(bool nullToAbsent) {
    return WorkContentsCompanion(
      workId: Value(workId),
      idx: Value(idx),
      word: Value(word),
      sourceReference: Value(sourceReference),
    );
  }

  factory WorkContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkContent(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<int>(json['idx']),
      word: serializer.fromJson<String>(json['word']),
      sourceReference: serializer.fromJson<String>(json['sourceReference']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<int>(idx),
      'word': serializer.toJson<String>(word),
      'sourceReference': serializer.toJson<String>(sourceReference),
    };
  }

  WorkContent copyWith(
          {String? workId, int? idx, String? word, String? sourceReference}) =>
      WorkContent(
        workId: workId ?? this.workId,
        idx: idx ?? this.idx,
        word: word ?? this.word,
        sourceReference: sourceReference ?? this.sourceReference,
      );
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
      (other is WorkContent &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.word == this.word &&
          other.sourceReference == this.sourceReference);
}

class WorkContentsCompanion extends UpdateCompanion<WorkContent> {
  final Value<String> workId;
  final Value<int> idx;
  final Value<String> word;
  final Value<String> sourceReference;
  const WorkContentsCompanion({
    this.workId = const Value.absent(),
    this.idx = const Value.absent(),
    this.word = const Value.absent(),
    this.sourceReference = const Value.absent(),
  });
  WorkContentsCompanion.insert({
    required String workId,
    required int idx,
    required String word,
    required String sourceReference,
  })  : workId = Value(workId),
        idx = Value(idx),
        word = Value(word),
        sourceReference = Value(sourceReference);
  static Insertable<WorkContent> custom({
    Expression<String>? workId,
    Expression<int>? idx,
    Expression<String>? word,
    Expression<String>? sourceReference,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (word != null) 'word': word,
      if (sourceReference != null) 'sourceReference': sourceReference,
    });
  }

  WorkContentsCompanion copyWith(
      {Value<String>? workId,
      Value<int>? idx,
      Value<String>? word,
      Value<String>? sourceReference}) {
    return WorkContentsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      word: word ?? this.word,
      sourceReference: sourceReference ?? this.sourceReference,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workId.present) {
      map['workId'] = Variable<String>(workId.value);
    }
    if (idx.present) {
      map['idx'] = Variable<int>(idx.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (sourceReference.present) {
      map['sourceReference'] = Variable<String>(sourceReference.value);
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

class UserProvidedMacronizations extends Table
    with TableInfo<UserProvidedMacronizations, UserProvidedMacronization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  UserProvidedMacronizations(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'workId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _idxMeta = const VerificationMeta('idx');
  late final GeneratedColumn<int> idx = GeneratedColumn<int>(
      'idx', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _syllableNumberMeta =
      const VerificationMeta('syllableNumber');
  late final GeneratedColumn<int> syllableNumber = GeneratedColumn<int>(
      'syllableNumber', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _macronizedSyllableMeta =
      const VerificationMeta('macronizedSyllable');
  late final GeneratedColumn<String> macronizedSyllable =
      GeneratedColumn<String>('macronizedSyllable', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [workId, idx, syllableNumber, macronizedSyllable];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'UserProvidedMacronizations';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserProvidedMacronization> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('idx')) {
      context.handle(
          _idxMeta, idx.isAcceptableOrUnknown(data['idx']!, _idxMeta));
    } else if (isInserting) {
      context.missing(_idxMeta);
    }
    if (data.containsKey('syllableNumber')) {
      context.handle(
          _syllableNumberMeta,
          syllableNumber.isAcceptableOrUnknown(
              data['syllableNumber']!, _syllableNumberMeta));
    } else if (isInserting) {
      context.missing(_syllableNumberMeta);
    }
    if (data.containsKey('macronizedSyllable')) {
      context.handle(
          _macronizedSyllableMeta,
          macronizedSyllable.isAcceptableOrUnknown(
              data['macronizedSyllable']!, _macronizedSyllableMeta));
    } else if (isInserting) {
      context.missing(_macronizedSyllableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workId, idx, syllableNumber};
  @override
  UserProvidedMacronization map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProvidedMacronization(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
      idx: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}idx'])!,
      syllableNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}syllableNumber'])!,
      macronizedSyllable: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}macronizedSyllable'])!,
    );
  }

  @override
  UserProvidedMacronizations createAlias(String alias) {
    return UserProvidedMacronizations(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(workId, idx, syllableNumber)',
        'FOREIGN KEY(workId, idx)REFERENCES WorkContents(workId, idx)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class UserProvidedMacronization extends DataClass
    implements Insertable<UserProvidedMacronization> {
  final String workId;
  final int idx;
  final int syllableNumber;
  final String macronizedSyllable;
  const UserProvidedMacronization(
      {required this.workId,
      required this.idx,
      required this.syllableNumber,
      required this.macronizedSyllable});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['workId'] = Variable<String>(workId);
    map['idx'] = Variable<int>(idx);
    map['syllableNumber'] = Variable<int>(syllableNumber);
    map['macronizedSyllable'] = Variable<String>(macronizedSyllable);
    return map;
  }

  UserProvidedMacronizationsCompanion toCompanion(bool nullToAbsent) {
    return UserProvidedMacronizationsCompanion(
      workId: Value(workId),
      idx: Value(idx),
      syllableNumber: Value(syllableNumber),
      macronizedSyllable: Value(macronizedSyllable),
    );
  }

  factory UserProvidedMacronization.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProvidedMacronization(
      workId: serializer.fromJson<String>(json['workId']),
      idx: serializer.fromJson<int>(json['idx']),
      syllableNumber: serializer.fromJson<int>(json['syllableNumber']),
      macronizedSyllable:
          serializer.fromJson<String>(json['macronizedSyllable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'idx': serializer.toJson<int>(idx),
      'syllableNumber': serializer.toJson<int>(syllableNumber),
      'macronizedSyllable': serializer.toJson<String>(macronizedSyllable),
    };
  }

  UserProvidedMacronization copyWith(
          {String? workId,
          int? idx,
          int? syllableNumber,
          String? macronizedSyllable}) =>
      UserProvidedMacronization(
        workId: workId ?? this.workId,
        idx: idx ?? this.idx,
        syllableNumber: syllableNumber ?? this.syllableNumber,
        macronizedSyllable: macronizedSyllable ?? this.macronizedSyllable,
      );
  @override
  String toString() {
    return (StringBuffer('UserProvidedMacronization(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('syllableNumber: $syllableNumber, ')
          ..write('macronizedSyllable: $macronizedSyllable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(workId, idx, syllableNumber, macronizedSyllable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProvidedMacronization &&
          other.workId == this.workId &&
          other.idx == this.idx &&
          other.syllableNumber == this.syllableNumber &&
          other.macronizedSyllable == this.macronizedSyllable);
}

class UserProvidedMacronizationsCompanion
    extends UpdateCompanion<UserProvidedMacronization> {
  final Value<String> workId;
  final Value<int> idx;
  final Value<int> syllableNumber;
  final Value<String> macronizedSyllable;
  const UserProvidedMacronizationsCompanion({
    this.workId = const Value.absent(),
    this.idx = const Value.absent(),
    this.syllableNumber = const Value.absent(),
    this.macronizedSyllable = const Value.absent(),
  });
  UserProvidedMacronizationsCompanion.insert({
    required String workId,
    required int idx,
    required int syllableNumber,
    required String macronizedSyllable,
  })  : workId = Value(workId),
        idx = Value(idx),
        syllableNumber = Value(syllableNumber),
        macronizedSyllable = Value(macronizedSyllable);
  static Insertable<UserProvidedMacronization> custom({
    Expression<String>? workId,
    Expression<int>? idx,
    Expression<int>? syllableNumber,
    Expression<String>? macronizedSyllable,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (syllableNumber != null) 'syllableNumber': syllableNumber,
      if (macronizedSyllable != null) 'macronizedSyllable': macronizedSyllable,
    });
  }

  UserProvidedMacronizationsCompanion copyWith(
      {Value<String>? workId,
      Value<int>? idx,
      Value<int>? syllableNumber,
      Value<String>? macronizedSyllable}) {
    return UserProvidedMacronizationsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      syllableNumber: syllableNumber ?? this.syllableNumber,
      macronizedSyllable: macronizedSyllable ?? this.macronizedSyllable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workId.present) {
      map['workId'] = Variable<String>(workId.value);
    }
    if (idx.present) {
      map['idx'] = Variable<int>(idx.value);
    }
    if (syllableNumber.present) {
      map['syllableNumber'] = Variable<int>(syllableNumber.value);
    }
    if (macronizedSyllable.present) {
      map['macronizedSyllable'] = Variable<String>(macronizedSyllable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProvidedMacronizationsCompanion(')
          ..write('workId: $workId, ')
          ..write('idx: $idx, ')
          ..write('syllableNumber: $syllableNumber, ')
          ..write('macronizedSyllable: $macronizedSyllable')
          ..write(')'))
        .toString();
  }
}

class WorkContentSubdivisions extends Table
    with TableInfo<WorkContentSubdivisions, WorkContentSubdivision> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkContentSubdivisions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'workId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _typMeta = const VerificationMeta('typ');
  late final GeneratedColumn<String> typ = GeneratedColumn<String>(
      'typ', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (typ IN (\'VERS\', \'BOOK\', \'POEM\', \'PROL\', \'EPIL\', \'TITL\', \'PARA\'))');
  static const VerificationMeta _cntMeta = const VerificationMeta('cnt');
  late final GeneratedColumn<int> cnt = GeneratedColumn<int>(
      'cnt', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (cnt > 0)');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _nodeMeta = const VerificationMeta('node');
  late final GeneratedColumn<String> node = GeneratedColumn<String>(
      'node', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL UNIQUE CHECK (node LIKE \'________-____-____-____-____________\')');
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  late final GeneratedColumn<String> parent = GeneratedColumn<String>(
      'parent', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'CHECK (parent LIKE \'________-____-____-____-____________\')');
  static const VerificationMeta _fromIndexMeta =
      const VerificationMeta('fromIndex');
  late final GeneratedColumn<int> fromIndex = GeneratedColumn<int>(
      'fromIndex', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (fromIndex > 0)');
  static const VerificationMeta _toIndexMeta =
      const VerificationMeta('toIndex');
  late final GeneratedColumn<int> toIndex = GeneratedColumn<int>(
      'toIndex', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (toIndex > 0)');
  @override
  List<GeneratedColumn> get $columns =>
      [workId, typ, cnt, name, node, parent, fromIndex, toIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkContentSubdivisions';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkContentSubdivision> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('typ')) {
      context.handle(
          _typMeta, typ.isAcceptableOrUnknown(data['typ']!, _typMeta));
    } else if (isInserting) {
      context.missing(_typMeta);
    }
    if (data.containsKey('cnt')) {
      context.handle(
          _cntMeta, cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta));
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('node')) {
      context.handle(
          _nodeMeta, node.isAcceptableOrUnknown(data['node']!, _nodeMeta));
    } else if (isInserting) {
      context.missing(_nodeMeta);
    }
    if (data.containsKey('parent')) {
      context.handle(_parentMeta,
          parent.isAcceptableOrUnknown(data['parent']!, _parentMeta));
    }
    if (data.containsKey('fromIndex')) {
      context.handle(_fromIndexMeta,
          fromIndex.isAcceptableOrUnknown(data['fromIndex']!, _fromIndexMeta));
    } else if (isInserting) {
      context.missing(_fromIndexMeta);
    }
    if (data.containsKey('toIndex')) {
      context.handle(_toIndexMeta,
          toIndex.isAcceptableOrUnknown(data['toIndex']!, _toIndexMeta));
    } else if (isInserting) {
      context.missing(_toIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workId, typ, cnt};
  @override
  WorkContentSubdivision map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkContentSubdivision(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
      typ: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}typ'])!,
      cnt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cnt'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      node: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}node'])!,
      parent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent']),
      fromIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fromIndex'])!,
      toIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}toIndex'])!,
    );
  }

  @override
  WorkContentSubdivisions createAlias(String alias) {
    return WorkContentSubdivisions(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(workId, typ, cnt)',
        'FOREIGN KEY(workId, fromIndex)REFERENCES WorkContents(workId, idx)',
        'FOREIGN KEY(workId, toIndex)REFERENCES WorkContents(workId, idx)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkContentSubdivision extends DataClass
    implements Insertable<WorkContentSubdivision> {
  final String workId;
  final String typ;

  ///add more as needed
  final int cnt;
  final String name;
  final String node;
  final String? parent;
  final int fromIndex;
  final int toIndex;
  const WorkContentSubdivision(
      {required this.workId,
      required this.typ,
      required this.cnt,
      required this.name,
      required this.node,
      this.parent,
      required this.fromIndex,
      required this.toIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['workId'] = Variable<String>(workId);
    map['typ'] = Variable<String>(typ);
    map['cnt'] = Variable<int>(cnt);
    map['name'] = Variable<String>(name);
    map['node'] = Variable<String>(node);
    if (!nullToAbsent || parent != null) {
      map['parent'] = Variable<String>(parent);
    }
    map['fromIndex'] = Variable<int>(fromIndex);
    map['toIndex'] = Variable<int>(toIndex);
    return map;
  }

  WorkContentSubdivisionsCompanion toCompanion(bool nullToAbsent) {
    return WorkContentSubdivisionsCompanion(
      workId: Value(workId),
      typ: Value(typ),
      cnt: Value(cnt),
      name: Value(name),
      node: Value(node),
      parent:
          parent == null && nullToAbsent ? const Value.absent() : Value(parent),
      fromIndex: Value(fromIndex),
      toIndex: Value(toIndex),
    );
  }

  factory WorkContentSubdivision.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkContentSubdivision(
      workId: serializer.fromJson<String>(json['workId']),
      typ: serializer.fromJson<String>(json['typ']),
      cnt: serializer.fromJson<int>(json['cnt']),
      name: serializer.fromJson<String>(json['name']),
      node: serializer.fromJson<String>(json['node']),
      parent: serializer.fromJson<String?>(json['parent']),
      fromIndex: serializer.fromJson<int>(json['fromIndex']),
      toIndex: serializer.fromJson<int>(json['toIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'typ': serializer.toJson<String>(typ),
      'cnt': serializer.toJson<int>(cnt),
      'name': serializer.toJson<String>(name),
      'node': serializer.toJson<String>(node),
      'parent': serializer.toJson<String?>(parent),
      'fromIndex': serializer.toJson<int>(fromIndex),
      'toIndex': serializer.toJson<int>(toIndex),
    };
  }

  WorkContentSubdivision copyWith(
          {String? workId,
          String? typ,
          int? cnt,
          String? name,
          String? node,
          Value<String?> parent = const Value.absent(),
          int? fromIndex,
          int? toIndex}) =>
      WorkContentSubdivision(
        workId: workId ?? this.workId,
        typ: typ ?? this.typ,
        cnt: cnt ?? this.cnt,
        name: name ?? this.name,
        node: node ?? this.node,
        parent: parent.present ? parent.value : this.parent,
        fromIndex: fromIndex ?? this.fromIndex,
        toIndex: toIndex ?? this.toIndex,
      );
  @override
  String toString() {
    return (StringBuffer('WorkContentSubdivision(')
          ..write('workId: $workId, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('name: $name, ')
          ..write('node: $node, ')
          ..write('parent: $parent, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(workId, typ, cnt, name, node, parent, fromIndex, toIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkContentSubdivision &&
          other.workId == this.workId &&
          other.typ == this.typ &&
          other.cnt == this.cnt &&
          other.name == this.name &&
          other.node == this.node &&
          other.parent == this.parent &&
          other.fromIndex == this.fromIndex &&
          other.toIndex == this.toIndex);
}

class WorkContentSubdivisionsCompanion
    extends UpdateCompanion<WorkContentSubdivision> {
  final Value<String> workId;
  final Value<String> typ;
  final Value<int> cnt;
  final Value<String> name;
  final Value<String> node;
  final Value<String?> parent;
  final Value<int> fromIndex;
  final Value<int> toIndex;
  const WorkContentSubdivisionsCompanion({
    this.workId = const Value.absent(),
    this.typ = const Value.absent(),
    this.cnt = const Value.absent(),
    this.name = const Value.absent(),
    this.node = const Value.absent(),
    this.parent = const Value.absent(),
    this.fromIndex = const Value.absent(),
    this.toIndex = const Value.absent(),
  });
  WorkContentSubdivisionsCompanion.insert({
    required String workId,
    required String typ,
    required int cnt,
    required String name,
    required String node,
    this.parent = const Value.absent(),
    required int fromIndex,
    required int toIndex,
  })  : workId = Value(workId),
        typ = Value(typ),
        cnt = Value(cnt),
        name = Value(name),
        node = Value(node),
        fromIndex = Value(fromIndex),
        toIndex = Value(toIndex);
  static Insertable<WorkContentSubdivision> custom({
    Expression<String>? workId,
    Expression<String>? typ,
    Expression<int>? cnt,
    Expression<String>? name,
    Expression<String>? node,
    Expression<String>? parent,
    Expression<int>? fromIndex,
    Expression<int>? toIndex,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (typ != null) 'typ': typ,
      if (cnt != null) 'cnt': cnt,
      if (name != null) 'name': name,
      if (node != null) 'node': node,
      if (parent != null) 'parent': parent,
      if (fromIndex != null) 'fromIndex': fromIndex,
      if (toIndex != null) 'toIndex': toIndex,
    });
  }

  WorkContentSubdivisionsCompanion copyWith(
      {Value<String>? workId,
      Value<String>? typ,
      Value<int>? cnt,
      Value<String>? name,
      Value<String>? node,
      Value<String?>? parent,
      Value<int>? fromIndex,
      Value<int>? toIndex}) {
    return WorkContentSubdivisionsCompanion(
      workId: workId ?? this.workId,
      typ: typ ?? this.typ,
      cnt: cnt ?? this.cnt,
      name: name ?? this.name,
      node: node ?? this.node,
      parent: parent ?? this.parent,
      fromIndex: fromIndex ?? this.fromIndex,
      toIndex: toIndex ?? this.toIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workId.present) {
      map['workId'] = Variable<String>(workId.value);
    }
    if (typ.present) {
      map['typ'] = Variable<String>(typ.value);
    }
    if (cnt.present) {
      map['cnt'] = Variable<int>(cnt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (node.present) {
      map['node'] = Variable<String>(node.value);
    }
    if (parent.present) {
      map['parent'] = Variable<String>(parent.value);
    }
    if (fromIndex.present) {
      map['fromIndex'] = Variable<int>(fromIndex.value);
    }
    if (toIndex.present) {
      map['toIndex'] = Variable<int>(toIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentSubdivisionsCompanion(')
          ..write('workId: $workId, ')
          ..write('typ: $typ, ')
          ..write('cnt: $cnt, ')
          ..write('name: $name, ')
          ..write('node: $node, ')
          ..write('parent: $parent, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex')
          ..write(')'))
        .toString();
  }
}

class WorkContentSupplementary extends Table
    with TableInfo<WorkContentSupplementary, WorkContentSupplementaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkContentSupplementary(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'workId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _typMeta = const VerificationMeta('typ');
  late final GeneratedColumn<String> typ = GeneratedColumn<String>(
      'typ', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (typ IN (\'NOTE\', \'GAP\', \'ABBR\'))');
  static const VerificationMeta _cntMeta = const VerificationMeta('cnt');
  late final GeneratedColumn<int> cnt = GeneratedColumn<int>(
      'cnt', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (cnt > 0)');
  static const VerificationMeta _fromIndexMeta =
      const VerificationMeta('fromIndex');
  late final GeneratedColumn<int> fromIndex = GeneratedColumn<int>(
      'fromIndex', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _toIndexMeta =
      const VerificationMeta('toIndex');
  late final GeneratedColumn<int> toIndex = GeneratedColumn<int>(
      'toIndex', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _valMeta = const VerificationMeta('val');
  late final GeneratedColumn<String> val = GeneratedColumn<String>(
      'val', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [workId, typ, cnt, fromIndex, toIndex, val];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkContentSupplementary';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkContentSupplementaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('workId')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('typ')) {
      context.handle(
          _typMeta, typ.isAcceptableOrUnknown(data['typ']!, _typMeta));
    } else if (isInserting) {
      context.missing(_typMeta);
    }
    if (data.containsKey('cnt')) {
      context.handle(
          _cntMeta, cnt.isAcceptableOrUnknown(data['cnt']!, _cntMeta));
    } else if (isInserting) {
      context.missing(_cntMeta);
    }
    if (data.containsKey('fromIndex')) {
      context.handle(_fromIndexMeta,
          fromIndex.isAcceptableOrUnknown(data['fromIndex']!, _fromIndexMeta));
    } else if (isInserting) {
      context.missing(_fromIndexMeta);
    }
    if (data.containsKey('toIndex')) {
      context.handle(_toIndexMeta,
          toIndex.isAcceptableOrUnknown(data['toIndex']!, _toIndexMeta));
    } else if (isInserting) {
      context.missing(_toIndexMeta);
    }
    if (data.containsKey('val')) {
      context.handle(
          _valMeta, val.isAcceptableOrUnknown(data['val']!, _valMeta));
    } else if (isInserting) {
      context.missing(_valMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workId, typ, cnt};
  @override
  WorkContentSupplementaryData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkContentSupplementaryData(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
      typ: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}typ'])!,
      cnt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cnt'])!,
      fromIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fromIndex'])!,
      toIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}toIndex'])!,
      val: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}val'])!,
    );
  }

  @override
  WorkContentSupplementary createAlias(String alias) {
    return WorkContentSupplementary(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(workId, typ, cnt)',
        'FOREIGN KEY(workId)REFERENCES Works(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkContentSupplementaryData extends DataClass
    implements Insertable<WorkContentSupplementaryData> {
  final String workId;
  final String typ;
  final int cnt;
  final int fromIndex;
  final int toIndex;
  final String val;
  const WorkContentSupplementaryData(
      {required this.workId,
      required this.typ,
      required this.cnt,
      required this.fromIndex,
      required this.toIndex,
      required this.val});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['workId'] = Variable<String>(workId);
    map['typ'] = Variable<String>(typ);
    map['cnt'] = Variable<int>(cnt);
    map['fromIndex'] = Variable<int>(fromIndex);
    map['toIndex'] = Variable<int>(toIndex);
    map['val'] = Variable<String>(val);
    return map;
  }

  WorkContentSupplementaryCompanion toCompanion(bool nullToAbsent) {
    return WorkContentSupplementaryCompanion(
      workId: Value(workId),
      typ: Value(typ),
      cnt: Value(cnt),
      fromIndex: Value(fromIndex),
      toIndex: Value(toIndex),
      val: Value(val),
    );
  }

  factory WorkContentSupplementaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workId': serializer.toJson<String>(workId),
      'typ': serializer.toJson<String>(typ),
      'cnt': serializer.toJson<int>(cnt),
      'fromIndex': serializer.toJson<int>(fromIndex),
      'toIndex': serializer.toJson<int>(toIndex),
      'val': serializer.toJson<String>(val),
    };
  }

  WorkContentSupplementaryData copyWith(
          {String? workId,
          String? typ,
          int? cnt,
          int? fromIndex,
          int? toIndex,
          String? val}) =>
      WorkContentSupplementaryData(
        workId: workId ?? this.workId,
        typ: typ ?? this.typ,
        cnt: cnt ?? this.cnt,
        fromIndex: fromIndex ?? this.fromIndex,
        toIndex: toIndex ?? this.toIndex,
        val: val ?? this.val,
      );
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
      (other is WorkContentSupplementaryData &&
          other.workId == this.workId &&
          other.typ == this.typ &&
          other.cnt == this.cnt &&
          other.fromIndex == this.fromIndex &&
          other.toIndex == this.toIndex &&
          other.val == this.val);
}

class WorkContentSupplementaryCompanion
    extends UpdateCompanion<WorkContentSupplementaryData> {
  final Value<String> workId;
  final Value<String> typ;
  final Value<int> cnt;
  final Value<int> fromIndex;
  final Value<int> toIndex;
  final Value<String> val;
  const WorkContentSupplementaryCompanion({
    this.workId = const Value.absent(),
    this.typ = const Value.absent(),
    this.cnt = const Value.absent(),
    this.fromIndex = const Value.absent(),
    this.toIndex = const Value.absent(),
    this.val = const Value.absent(),
  });
  WorkContentSupplementaryCompanion.insert({
    required String workId,
    required String typ,
    required int cnt,
    required int fromIndex,
    required int toIndex,
    required String val,
  })  : workId = Value(workId),
        typ = Value(typ),
        cnt = Value(cnt),
        fromIndex = Value(fromIndex),
        toIndex = Value(toIndex),
        val = Value(val);
  static Insertable<WorkContentSupplementaryData> custom({
    Expression<String>? workId,
    Expression<String>? typ,
    Expression<int>? cnt,
    Expression<int>? fromIndex,
    Expression<int>? toIndex,
    Expression<String>? val,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (typ != null) 'typ': typ,
      if (cnt != null) 'cnt': cnt,
      if (fromIndex != null) 'fromIndex': fromIndex,
      if (toIndex != null) 'toIndex': toIndex,
      if (val != null) 'val': val,
    });
  }

  WorkContentSupplementaryCompanion copyWith(
      {Value<String>? workId,
      Value<String>? typ,
      Value<int>? cnt,
      Value<int>? fromIndex,
      Value<int>? toIndex,
      Value<String>? val}) {
    return WorkContentSupplementaryCompanion(
      workId: workId ?? this.workId,
      typ: typ ?? this.typ,
      cnt: cnt ?? this.cnt,
      fromIndex: fromIndex ?? this.fromIndex,
      toIndex: toIndex ?? this.toIndex,
      val: val ?? this.val,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workId.present) {
      map['workId'] = Variable<String>(workId.value);
    }
    if (typ.present) {
      map['typ'] = Variable<String>(typ.value);
    }
    if (cnt.present) {
      map['cnt'] = Variable<int>(cnt.value);
    }
    if (fromIndex.present) {
      map['fromIndex'] = Variable<int>(fromIndex.value);
    }
    if (toIndex.present) {
      map['toIndex'] = Variable<int>(toIndex.value);
    }
    if (val.present) {
      map['val'] = Variable<String>(val.value);
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

class AuthorsAndWorks extends Table
    with TableInfo<AuthorsAndWorks, AuthorsAndWork> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AuthorsAndWorks(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'authorId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'workId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [authorId, workId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'AuthorsAndWorks';
  @override
  VerificationContext validateIntegrity(Insertable<AuthorsAndWork> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('authorId')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['authorId']!, _authorIdMeta));
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('workId')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['workId']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {authorId, workId};
  @override
  AuthorsAndWork map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthorsAndWork(
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}authorId'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
    );
  }

  @override
  AuthorsAndWorks createAlias(String alias) {
    return AuthorsAndWorks(attachedDatabase, alias);
  }

  @override
  bool get withoutRowId => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(authorId, workId)',
        'FOREIGN KEY(authorId)REFERENCES Authors(id)',
        'FOREIGN KEY(workId)REFERENCES Works(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class AuthorsAndWork extends DataClass implements Insertable<AuthorsAndWork> {
  final String authorId;
  final String workId;
  const AuthorsAndWork({required this.authorId, required this.workId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['authorId'] = Variable<String>(authorId);
    map['workId'] = Variable<String>(workId);
    return map;
  }

  AuthorsAndWorksCompanion toCompanion(bool nullToAbsent) {
    return AuthorsAndWorksCompanion(
      authorId: Value(authorId),
      workId: Value(workId),
    );
  }

  factory AuthorsAndWork.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthorsAndWork(
      authorId: serializer.fromJson<String>(json['authorId']),
      workId: serializer.fromJson<String>(json['workId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'authorId': serializer.toJson<String>(authorId),
      'workId': serializer.toJson<String>(workId),
    };
  }

  AuthorsAndWork copyWith({String? authorId, String? workId}) => AuthorsAndWork(
        authorId: authorId ?? this.authorId,
        workId: workId ?? this.workId,
      );
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
      (other is AuthorsAndWork &&
          other.authorId == this.authorId &&
          other.workId == this.workId);
}

class AuthorsAndWorksCompanion extends UpdateCompanion<AuthorsAndWork> {
  final Value<String> authorId;
  final Value<String> workId;
  const AuthorsAndWorksCompanion({
    this.authorId = const Value.absent(),
    this.workId = const Value.absent(),
  });
  AuthorsAndWorksCompanion.insert({
    required String authorId,
    required String workId,
  })  : authorId = Value(authorId),
        workId = Value(workId);
  static Insertable<AuthorsAndWork> custom({
    Expression<String>? authorId,
    Expression<String>? workId,
  }) {
    return RawValuesInsertable({
      if (authorId != null) 'authorId': authorId,
      if (workId != null) 'workId': workId,
    });
  }

  AuthorsAndWorksCompanion copyWith(
      {Value<String>? authorId, Value<String>? workId}) {
    return AuthorsAndWorksCompanion(
      authorId: authorId ?? this.authorId,
      workId: workId ?? this.workId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (authorId.present) {
      map['authorId'] = Variable<String>(authorId.value);
    }
    if (workId.present) {
      map['workId'] = Variable<String>(workId.value);
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

class LatestDataVersionData extends DataClass {
  final int idx;
  final int createdAt;
  const LatestDataVersionData({required this.idx, required this.createdAt});
  factory LatestDataVersionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LatestDataVersionData(
      idx: serializer.fromJson<int>(json['idx']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idx': serializer.toJson<int>(idx),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  LatestDataVersionData copyWith({int? idx, int? createdAt}) =>
      LatestDataVersionData(
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
      (other is LatestDataVersionData &&
          other.idx == this.idx &&
          other.createdAt == this.createdAt);
}

class LatestDataVersion
    extends ViewInfo<LatestDataVersion, LatestDataVersionData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDb attachedDatabase;
  LatestDataVersion(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [idx, createdAt];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'LatestDataVersion';
  @override
  Map<SqlDialect, String> get createViewStatements => {
        SqlDialect.sqlite:
            'CREATE VIEW LatestDataVersion AS SELECT * FROM DataVersion ORDER BY idx DESC LIMIT 1',
      };
  @override
  LatestDataVersion get asDslTable => this;
  @override
  LatestDataVersionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LatestDataVersionData(
      idx: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}idx'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}createdAt'])!,
    );
  }

  late final GeneratedColumn<int> idx =
      GeneratedColumn<int>('idx', aliasedName, false, type: DriftSqlType.int);
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'createdAt', aliasedName, false,
      type: DriftSqlType.int);
  @override
  LatestDataVersion createAlias(String alias) {
    return LatestDataVersion(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {'DataVersion'};
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  _$AppDbManager get managers => _$AppDbManager(this);
  late final DataVersion dataVersion = DataVersion(this);
  late final MorphologicalDetails morphologicalDetails =
      MorphologicalDetails(this);
  late final MorphologicalDetailInflections morphologicalDetailInflections =
      MorphologicalDetailInflections(this);
  late final Macronizations macronizations = Macronizations(this);
  late final Authors authors = Authors(this);
  late final AuthorAbbreviations authorAbbreviations =
      AuthorAbbreviations(this);
  late final Works works = Works(this);
  late final WorkAbbreviations workAbbreviations = WorkAbbreviations(this);
  late final WorkContents workContents = WorkContents(this);
  late final UserProvidedMacronizations userProvidedMacronizations =
      UserProvidedMacronizations(this);
  late final WorkContentSubdivisions workContentSubdivisions =
      WorkContentSubdivisions(this);
  late final WorkContentSupplementary workContentSupplementary =
      WorkContentSupplementary(this);
  late final AuthorsAndWorks authorsAndWorks = AuthorsAndWorks(this);
  late final LatestDataVersion latestDataVersion = LatestDataVersion(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        dataVersion,
        morphologicalDetails,
        morphologicalDetailInflections,
        macronizations,
        authors,
        authorAbbreviations,
        works,
        workAbbreviations,
        workContents,
        userProvidedMacronizations,
        workContentSubdivisions,
        workContentSupplementary,
        authorsAndWorks,
        latestDataVersion
      ];
}

typedef $DataVersionInsertCompanionBuilder = DataVersionCompanion Function({
  Value<int> idx,
  Value<int> createdAt,
});
typedef $DataVersionUpdateCompanionBuilder = DataVersionCompanion Function({
  Value<int> idx,
  Value<int> createdAt,
});

class $DataVersionTableManager extends RootTableManager<
    _$AppDb,
    DataVersion,
    DataVersionData,
    $DataVersionFilterComposer,
    $DataVersionOrderingComposer,
    $DataVersionProcessedTableManager,
    $DataVersionInsertCompanionBuilder,
    $DataVersionUpdateCompanionBuilder> {
  $DataVersionTableManager(_$AppDb db, DataVersion table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $DataVersionFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $DataVersionOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $DataVersionProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> idx = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
          }) =>
              DataVersionCompanion(
            idx: idx,
            createdAt: createdAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> idx = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
          }) =>
              DataVersionCompanion.insert(
            idx: idx,
            createdAt: createdAt,
          ),
        ));
}

class $DataVersionProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    DataVersion,
    DataVersionData,
    $DataVersionFilterComposer,
    $DataVersionOrderingComposer,
    $DataVersionProcessedTableManager,
    $DataVersionInsertCompanionBuilder,
    $DataVersionUpdateCompanionBuilder> {
  $DataVersionProcessedTableManager(super.$state);
}

class $DataVersionFilterComposer extends FilterComposer<_$AppDb, DataVersion> {
  $DataVersionFilterComposer(super.$state);
  ColumnFilters<int> get idx => $state.composableBuilder(
      column: $state.table.idx,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $DataVersionOrderingComposer
    extends OrderingComposer<_$AppDb, DataVersion> {
  $DataVersionOrderingComposer(super.$state);
  ColumnOrderings<int> get idx => $state.composableBuilder(
      column: $state.table.idx,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $MorphologicalDetailsInsertCompanionBuilder
    = MorphologicalDetailsCompanion Function({
  required String form,
  required int item,
  required String dictionaryRef,
});
typedef $MorphologicalDetailsUpdateCompanionBuilder
    = MorphologicalDetailsCompanion Function({
  Value<String> form,
  Value<int> item,
  Value<String> dictionaryRef,
});

class $MorphologicalDetailsTableManager extends RootTableManager<
    _$AppDb,
    MorphologicalDetails,
    MorphologicalDetail,
    $MorphologicalDetailsFilterComposer,
    $MorphologicalDetailsOrderingComposer,
    $MorphologicalDetailsProcessedTableManager,
    $MorphologicalDetailsInsertCompanionBuilder,
    $MorphologicalDetailsUpdateCompanionBuilder> {
  $MorphologicalDetailsTableManager(_$AppDb db, MorphologicalDetails table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $MorphologicalDetailsFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $MorphologicalDetailsOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $MorphologicalDetailsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> form = const Value.absent(),
            Value<int> item = const Value.absent(),
            Value<String> dictionaryRef = const Value.absent(),
          }) =>
              MorphologicalDetailsCompanion(
            form: form,
            item: item,
            dictionaryRef: dictionaryRef,
          ),
          getInsertCompanionBuilder: ({
            required String form,
            required int item,
            required String dictionaryRef,
          }) =>
              MorphologicalDetailsCompanion.insert(
            form: form,
            item: item,
            dictionaryRef: dictionaryRef,
          ),
        ));
}

class $MorphologicalDetailsProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    MorphologicalDetails,
    MorphologicalDetail,
    $MorphologicalDetailsFilterComposer,
    $MorphologicalDetailsOrderingComposer,
    $MorphologicalDetailsProcessedTableManager,
    $MorphologicalDetailsInsertCompanionBuilder,
    $MorphologicalDetailsUpdateCompanionBuilder> {
  $MorphologicalDetailsProcessedTableManager(super.$state);
}

class $MorphologicalDetailsFilterComposer
    extends FilterComposer<_$AppDb, MorphologicalDetails> {
  $MorphologicalDetailsFilterComposer(super.$state);
  ColumnFilters<String> get form => $state.composableBuilder(
      column: $state.table.form,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get item => $state.composableBuilder(
      column: $state.table.item,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get dictionaryRef => $state.composableBuilder(
      column: $state.table.dictionaryRef,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $MorphologicalDetailsOrderingComposer
    extends OrderingComposer<_$AppDb, MorphologicalDetails> {
  $MorphologicalDetailsOrderingComposer(super.$state);
  ColumnOrderings<String> get form => $state.composableBuilder(
      column: $state.table.form,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get item => $state.composableBuilder(
      column: $state.table.item,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get dictionaryRef => $state.composableBuilder(
      column: $state.table.dictionaryRef,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $MorphologicalDetailInflectionsInsertCompanionBuilder
    = MorphologicalDetailInflectionsCompanion Function({
  required String form,
  required int item,
  required int cnt,
  required String term,
  required String partOfSpeech,
  required String stem,
  required String suffix,
  Value<String?> gender,
  Value<String?> number,
  Value<String?> declension,
  Value<String?> grammCase,
  Value<String?> mood,
  Value<String?> tense,
  Value<String?> voice,
  Value<String?> person,
});
typedef $MorphologicalDetailInflectionsUpdateCompanionBuilder
    = MorphologicalDetailInflectionsCompanion Function({
  Value<String> form,
  Value<int> item,
  Value<int> cnt,
  Value<String> term,
  Value<String> partOfSpeech,
  Value<String> stem,
  Value<String> suffix,
  Value<String?> gender,
  Value<String?> number,
  Value<String?> declension,
  Value<String?> grammCase,
  Value<String?> mood,
  Value<String?> tense,
  Value<String?> voice,
  Value<String?> person,
});

class $MorphologicalDetailInflectionsTableManager extends RootTableManager<
    _$AppDb,
    MorphologicalDetailInflections,
    MorphologicalDetailInflection,
    $MorphologicalDetailInflectionsFilterComposer,
    $MorphologicalDetailInflectionsOrderingComposer,
    $MorphologicalDetailInflectionsProcessedTableManager,
    $MorphologicalDetailInflectionsInsertCompanionBuilder,
    $MorphologicalDetailInflectionsUpdateCompanionBuilder> {
  $MorphologicalDetailInflectionsTableManager(
      _$AppDb db, MorphologicalDetailInflections table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $MorphologicalDetailInflectionsFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $MorphologicalDetailInflectionsOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $MorphologicalDetailInflectionsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> form = const Value.absent(),
            Value<int> item = const Value.absent(),
            Value<int> cnt = const Value.absent(),
            Value<String> term = const Value.absent(),
            Value<String> partOfSpeech = const Value.absent(),
            Value<String> stem = const Value.absent(),
            Value<String> suffix = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> number = const Value.absent(),
            Value<String?> declension = const Value.absent(),
            Value<String?> grammCase = const Value.absent(),
            Value<String?> mood = const Value.absent(),
            Value<String?> tense = const Value.absent(),
            Value<String?> voice = const Value.absent(),
            Value<String?> person = const Value.absent(),
          }) =>
              MorphologicalDetailInflectionsCompanion(
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
          getInsertCompanionBuilder: ({
            required String form,
            required int item,
            required int cnt,
            required String term,
            required String partOfSpeech,
            required String stem,
            required String suffix,
            Value<String?> gender = const Value.absent(),
            Value<String?> number = const Value.absent(),
            Value<String?> declension = const Value.absent(),
            Value<String?> grammCase = const Value.absent(),
            Value<String?> mood = const Value.absent(),
            Value<String?> tense = const Value.absent(),
            Value<String?> voice = const Value.absent(),
            Value<String?> person = const Value.absent(),
          }) =>
              MorphologicalDetailInflectionsCompanion.insert(
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
        ));
}

class $MorphologicalDetailInflectionsProcessedTableManager
    extends ProcessedTableManager<
        _$AppDb,
        MorphologicalDetailInflections,
        MorphologicalDetailInflection,
        $MorphologicalDetailInflectionsFilterComposer,
        $MorphologicalDetailInflectionsOrderingComposer,
        $MorphologicalDetailInflectionsProcessedTableManager,
        $MorphologicalDetailInflectionsInsertCompanionBuilder,
        $MorphologicalDetailInflectionsUpdateCompanionBuilder> {
  $MorphologicalDetailInflectionsProcessedTableManager(super.$state);
}

class $MorphologicalDetailInflectionsFilterComposer
    extends FilterComposer<_$AppDb, MorphologicalDetailInflections> {
  $MorphologicalDetailInflectionsFilterComposer(super.$state);
  ColumnFilters<String> get form => $state.composableBuilder(
      column: $state.table.form,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get item => $state.composableBuilder(
      column: $state.table.item,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get cnt => $state.composableBuilder(
      column: $state.table.cnt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get term => $state.composableBuilder(
      column: $state.table.term,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get partOfSpeech => $state.composableBuilder(
      column: $state.table.partOfSpeech,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get stem => $state.composableBuilder(
      column: $state.table.stem,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get suffix => $state.composableBuilder(
      column: $state.table.suffix,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get gender => $state.composableBuilder(
      column: $state.table.gender,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get declension => $state.composableBuilder(
      column: $state.table.declension,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get grammCase => $state.composableBuilder(
      column: $state.table.grammCase,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mood => $state.composableBuilder(
      column: $state.table.mood,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tense => $state.composableBuilder(
      column: $state.table.tense,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get voice => $state.composableBuilder(
      column: $state.table.voice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get person => $state.composableBuilder(
      column: $state.table.person,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $MorphologicalDetailInflectionsOrderingComposer
    extends OrderingComposer<_$AppDb, MorphologicalDetailInflections> {
  $MorphologicalDetailInflectionsOrderingComposer(super.$state);
  ColumnOrderings<String> get form => $state.composableBuilder(
      column: $state.table.form,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get item => $state.composableBuilder(
      column: $state.table.item,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get cnt => $state.composableBuilder(
      column: $state.table.cnt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get term => $state.composableBuilder(
      column: $state.table.term,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get partOfSpeech => $state.composableBuilder(
      column: $state.table.partOfSpeech,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get stem => $state.composableBuilder(
      column: $state.table.stem,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get suffix => $state.composableBuilder(
      column: $state.table.suffix,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get gender => $state.composableBuilder(
      column: $state.table.gender,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get declension => $state.composableBuilder(
      column: $state.table.declension,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get grammCase => $state.composableBuilder(
      column: $state.table.grammCase,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mood => $state.composableBuilder(
      column: $state.table.mood,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tense => $state.composableBuilder(
      column: $state.table.tense,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get voice => $state.composableBuilder(
      column: $state.table.voice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get person => $state.composableBuilder(
      column: $state.table.person,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $MacronizationsInsertCompanionBuilder = MacronizationsCompanion
    Function({
  required String form,
  required int syllableNumber,
  required String macronizedSyllable,
  required int isUncertain,
});
typedef $MacronizationsUpdateCompanionBuilder = MacronizationsCompanion
    Function({
  Value<String> form,
  Value<int> syllableNumber,
  Value<String> macronizedSyllable,
  Value<int> isUncertain,
});

class $MacronizationsTableManager extends RootTableManager<
    _$AppDb,
    Macronizations,
    Macronization,
    $MacronizationsFilterComposer,
    $MacronizationsOrderingComposer,
    $MacronizationsProcessedTableManager,
    $MacronizationsInsertCompanionBuilder,
    $MacronizationsUpdateCompanionBuilder> {
  $MacronizationsTableManager(_$AppDb db, Macronizations table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $MacronizationsFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $MacronizationsOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $MacronizationsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> form = const Value.absent(),
            Value<int> syllableNumber = const Value.absent(),
            Value<String> macronizedSyllable = const Value.absent(),
            Value<int> isUncertain = const Value.absent(),
          }) =>
              MacronizationsCompanion(
            form: form,
            syllableNumber: syllableNumber,
            macronizedSyllable: macronizedSyllable,
            isUncertain: isUncertain,
          ),
          getInsertCompanionBuilder: ({
            required String form,
            required int syllableNumber,
            required String macronizedSyllable,
            required int isUncertain,
          }) =>
              MacronizationsCompanion.insert(
            form: form,
            syllableNumber: syllableNumber,
            macronizedSyllable: macronizedSyllable,
            isUncertain: isUncertain,
          ),
        ));
}

class $MacronizationsProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    Macronizations,
    Macronization,
    $MacronizationsFilterComposer,
    $MacronizationsOrderingComposer,
    $MacronizationsProcessedTableManager,
    $MacronizationsInsertCompanionBuilder,
    $MacronizationsUpdateCompanionBuilder> {
  $MacronizationsProcessedTableManager(super.$state);
}

class $MacronizationsFilterComposer
    extends FilterComposer<_$AppDb, Macronizations> {
  $MacronizationsFilterComposer(super.$state);
  ColumnFilters<String> get form => $state.composableBuilder(
      column: $state.table.form,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get syllableNumber => $state.composableBuilder(
      column: $state.table.syllableNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get macronizedSyllable => $state.composableBuilder(
      column: $state.table.macronizedSyllable,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get isUncertain => $state.composableBuilder(
      column: $state.table.isUncertain,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $MacronizationsOrderingComposer
    extends OrderingComposer<_$AppDb, Macronizations> {
  $MacronizationsOrderingComposer(super.$state);
  ColumnOrderings<String> get form => $state.composableBuilder(
      column: $state.table.form,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get syllableNumber => $state.composableBuilder(
      column: $state.table.syllableNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get macronizedSyllable => $state.composableBuilder(
      column: $state.table.macronizedSyllable,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get isUncertain => $state.composableBuilder(
      column: $state.table.isUncertain,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $AuthorsInsertCompanionBuilder = AuthorsCompanion Function({
  required String id,
  required String name,
  Value<String?> about,
  Value<Uint8List?> image,
});
typedef $AuthorsUpdateCompanionBuilder = AuthorsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> about,
  Value<Uint8List?> image,
});

class $AuthorsTableManager extends RootTableManager<
    _$AppDb,
    Authors,
    Author,
    $AuthorsFilterComposer,
    $AuthorsOrderingComposer,
    $AuthorsProcessedTableManager,
    $AuthorsInsertCompanionBuilder,
    $AuthorsUpdateCompanionBuilder> {
  $AuthorsTableManager(_$AppDb db, Authors table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $AuthorsFilterComposer(ComposerState(db, table)),
          orderingComposer: $AuthorsOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $AuthorsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> about = const Value.absent(),
            Value<Uint8List?> image = const Value.absent(),
          }) =>
              AuthorsCompanion(
            id: id,
            name: name,
            about: about,
            image: image,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String name,
            Value<String?> about = const Value.absent(),
            Value<Uint8List?> image = const Value.absent(),
          }) =>
              AuthorsCompanion.insert(
            id: id,
            name: name,
            about: about,
            image: image,
          ),
        ));
}

class $AuthorsProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    Authors,
    Author,
    $AuthorsFilterComposer,
    $AuthorsOrderingComposer,
    $AuthorsProcessedTableManager,
    $AuthorsInsertCompanionBuilder,
    $AuthorsUpdateCompanionBuilder> {
  $AuthorsProcessedTableManager(super.$state);
}

class $AuthorsFilterComposer extends FilterComposer<_$AppDb, Authors> {
  $AuthorsFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get about => $state.composableBuilder(
      column: $state.table.about,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<Uint8List> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $AuthorsOrderingComposer extends OrderingComposer<_$AppDb, Authors> {
  $AuthorsOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get about => $state.composableBuilder(
      column: $state.table.about,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<Uint8List> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $AuthorAbbreviationsInsertCompanionBuilder
    = AuthorAbbreviationsCompanion Function({
  required String authorId,
  required int id,
  required String val,
});
typedef $AuthorAbbreviationsUpdateCompanionBuilder
    = AuthorAbbreviationsCompanion Function({
  Value<String> authorId,
  Value<int> id,
  Value<String> val,
});

class $AuthorAbbreviationsTableManager extends RootTableManager<
    _$AppDb,
    AuthorAbbreviations,
    AuthorAbbreviation,
    $AuthorAbbreviationsFilterComposer,
    $AuthorAbbreviationsOrderingComposer,
    $AuthorAbbreviationsProcessedTableManager,
    $AuthorAbbreviationsInsertCompanionBuilder,
    $AuthorAbbreviationsUpdateCompanionBuilder> {
  $AuthorAbbreviationsTableManager(_$AppDb db, AuthorAbbreviations table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $AuthorAbbreviationsFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $AuthorAbbreviationsOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $AuthorAbbreviationsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> authorId = const Value.absent(),
            Value<int> id = const Value.absent(),
            Value<String> val = const Value.absent(),
          }) =>
              AuthorAbbreviationsCompanion(
            authorId: authorId,
            id: id,
            val: val,
          ),
          getInsertCompanionBuilder: ({
            required String authorId,
            required int id,
            required String val,
          }) =>
              AuthorAbbreviationsCompanion.insert(
            authorId: authorId,
            id: id,
            val: val,
          ),
        ));
}

class $AuthorAbbreviationsProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    AuthorAbbreviations,
    AuthorAbbreviation,
    $AuthorAbbreviationsFilterComposer,
    $AuthorAbbreviationsOrderingComposer,
    $AuthorAbbreviationsProcessedTableManager,
    $AuthorAbbreviationsInsertCompanionBuilder,
    $AuthorAbbreviationsUpdateCompanionBuilder> {
  $AuthorAbbreviationsProcessedTableManager(super.$state);
}

class $AuthorAbbreviationsFilterComposer
    extends FilterComposer<_$AppDb, AuthorAbbreviations> {
  $AuthorAbbreviationsFilterComposer(super.$state);
  ColumnFilters<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get val => $state.composableBuilder(
      column: $state.table.val,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $AuthorAbbreviationsOrderingComposer
    extends OrderingComposer<_$AppDb, AuthorAbbreviations> {
  $AuthorAbbreviationsOrderingComposer(super.$state);
  ColumnOrderings<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get val => $state.composableBuilder(
      column: $state.table.val,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $WorksInsertCompanionBuilder = WorksCompanion Function({
  required String id,
  required String name,
  Value<String?> about,
});
typedef $WorksUpdateCompanionBuilder = WorksCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> about,
});

class $WorksTableManager extends RootTableManager<
    _$AppDb,
    Works,
    Work,
    $WorksFilterComposer,
    $WorksOrderingComposer,
    $WorksProcessedTableManager,
    $WorksInsertCompanionBuilder,
    $WorksUpdateCompanionBuilder> {
  $WorksTableManager(_$AppDb db, Works table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $WorksFilterComposer(ComposerState(db, table)),
          orderingComposer: $WorksOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $WorksProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> about = const Value.absent(),
          }) =>
              WorksCompanion(
            id: id,
            name: name,
            about: about,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String name,
            Value<String?> about = const Value.absent(),
          }) =>
              WorksCompanion.insert(
            id: id,
            name: name,
            about: about,
          ),
        ));
}

class $WorksProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    Works,
    Work,
    $WorksFilterComposer,
    $WorksOrderingComposer,
    $WorksProcessedTableManager,
    $WorksInsertCompanionBuilder,
    $WorksUpdateCompanionBuilder> {
  $WorksProcessedTableManager(super.$state);
}

class $WorksFilterComposer extends FilterComposer<_$AppDb, Works> {
  $WorksFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get about => $state.composableBuilder(
      column: $state.table.about,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $WorksOrderingComposer extends OrderingComposer<_$AppDb, Works> {
  $WorksOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get about => $state.composableBuilder(
      column: $state.table.about,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $WorkAbbreviationsInsertCompanionBuilder = WorkAbbreviationsCompanion
    Function({
  required String workId,
  required int id,
  required String val,
});
typedef $WorkAbbreviationsUpdateCompanionBuilder = WorkAbbreviationsCompanion
    Function({
  Value<String> workId,
  Value<int> id,
  Value<String> val,
});

class $WorkAbbreviationsTableManager extends RootTableManager<
    _$AppDb,
    WorkAbbreviations,
    WorkAbbreviation,
    $WorkAbbreviationsFilterComposer,
    $WorkAbbreviationsOrderingComposer,
    $WorkAbbreviationsProcessedTableManager,
    $WorkAbbreviationsInsertCompanionBuilder,
    $WorkAbbreviationsUpdateCompanionBuilder> {
  $WorkAbbreviationsTableManager(_$AppDb db, WorkAbbreviations table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $WorkAbbreviationsFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $WorkAbbreviationsOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $WorkAbbreviationsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> workId = const Value.absent(),
            Value<int> id = const Value.absent(),
            Value<String> val = const Value.absent(),
          }) =>
              WorkAbbreviationsCompanion(
            workId: workId,
            id: id,
            val: val,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required int id,
            required String val,
          }) =>
              WorkAbbreviationsCompanion.insert(
            workId: workId,
            id: id,
            val: val,
          ),
        ));
}

class $WorkAbbreviationsProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    WorkAbbreviations,
    WorkAbbreviation,
    $WorkAbbreviationsFilterComposer,
    $WorkAbbreviationsOrderingComposer,
    $WorkAbbreviationsProcessedTableManager,
    $WorkAbbreviationsInsertCompanionBuilder,
    $WorkAbbreviationsUpdateCompanionBuilder> {
  $WorkAbbreviationsProcessedTableManager(super.$state);
}

class $WorkAbbreviationsFilterComposer
    extends FilterComposer<_$AppDb, WorkAbbreviations> {
  $WorkAbbreviationsFilterComposer(super.$state);
  ColumnFilters<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get val => $state.composableBuilder(
      column: $state.table.val,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $WorkAbbreviationsOrderingComposer
    extends OrderingComposer<_$AppDb, WorkAbbreviations> {
  $WorkAbbreviationsOrderingComposer(super.$state);
  ColumnOrderings<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get val => $state.composableBuilder(
      column: $state.table.val,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $WorkContentsInsertCompanionBuilder = WorkContentsCompanion Function({
  required String workId,
  required int idx,
  required String word,
  required String sourceReference,
});
typedef $WorkContentsUpdateCompanionBuilder = WorkContentsCompanion Function({
  Value<String> workId,
  Value<int> idx,
  Value<String> word,
  Value<String> sourceReference,
});

class $WorkContentsTableManager extends RootTableManager<
    _$AppDb,
    WorkContents,
    WorkContent,
    $WorkContentsFilterComposer,
    $WorkContentsOrderingComposer,
    $WorkContentsProcessedTableManager,
    $WorkContentsInsertCompanionBuilder,
    $WorkContentsUpdateCompanionBuilder> {
  $WorkContentsTableManager(_$AppDb db, WorkContents table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $WorkContentsFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $WorkContentsOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $WorkContentsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> workId = const Value.absent(),
            Value<int> idx = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String> sourceReference = const Value.absent(),
          }) =>
              WorkContentsCompanion(
            workId: workId,
            idx: idx,
            word: word,
            sourceReference: sourceReference,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required int idx,
            required String word,
            required String sourceReference,
          }) =>
              WorkContentsCompanion.insert(
            workId: workId,
            idx: idx,
            word: word,
            sourceReference: sourceReference,
          ),
        ));
}

class $WorkContentsProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    WorkContents,
    WorkContent,
    $WorkContentsFilterComposer,
    $WorkContentsOrderingComposer,
    $WorkContentsProcessedTableManager,
    $WorkContentsInsertCompanionBuilder,
    $WorkContentsUpdateCompanionBuilder> {
  $WorkContentsProcessedTableManager(super.$state);
}

class $WorkContentsFilterComposer
    extends FilterComposer<_$AppDb, WorkContents> {
  $WorkContentsFilterComposer(super.$state);
  ColumnFilters<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get idx => $state.composableBuilder(
      column: $state.table.idx,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get word => $state.composableBuilder(
      column: $state.table.word,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceReference => $state.composableBuilder(
      column: $state.table.sourceReference,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $WorkContentsOrderingComposer
    extends OrderingComposer<_$AppDb, WorkContents> {
  $WorkContentsOrderingComposer(super.$state);
  ColumnOrderings<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get idx => $state.composableBuilder(
      column: $state.table.idx,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get word => $state.composableBuilder(
      column: $state.table.word,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceReference => $state.composableBuilder(
      column: $state.table.sourceReference,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $UserProvidedMacronizationsInsertCompanionBuilder
    = UserProvidedMacronizationsCompanion Function({
  required String workId,
  required int idx,
  required int syllableNumber,
  required String macronizedSyllable,
});
typedef $UserProvidedMacronizationsUpdateCompanionBuilder
    = UserProvidedMacronizationsCompanion Function({
  Value<String> workId,
  Value<int> idx,
  Value<int> syllableNumber,
  Value<String> macronizedSyllable,
});

class $UserProvidedMacronizationsTableManager extends RootTableManager<
    _$AppDb,
    UserProvidedMacronizations,
    UserProvidedMacronization,
    $UserProvidedMacronizationsFilterComposer,
    $UserProvidedMacronizationsOrderingComposer,
    $UserProvidedMacronizationsProcessedTableManager,
    $UserProvidedMacronizationsInsertCompanionBuilder,
    $UserProvidedMacronizationsUpdateCompanionBuilder> {
  $UserProvidedMacronizationsTableManager(
      _$AppDb db, UserProvidedMacronizations table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $UserProvidedMacronizationsFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $UserProvidedMacronizationsOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $UserProvidedMacronizationsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> workId = const Value.absent(),
            Value<int> idx = const Value.absent(),
            Value<int> syllableNumber = const Value.absent(),
            Value<String> macronizedSyllable = const Value.absent(),
          }) =>
              UserProvidedMacronizationsCompanion(
            workId: workId,
            idx: idx,
            syllableNumber: syllableNumber,
            macronizedSyllable: macronizedSyllable,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required int idx,
            required int syllableNumber,
            required String macronizedSyllable,
          }) =>
              UserProvidedMacronizationsCompanion.insert(
            workId: workId,
            idx: idx,
            syllableNumber: syllableNumber,
            macronizedSyllable: macronizedSyllable,
          ),
        ));
}

class $UserProvidedMacronizationsProcessedTableManager
    extends ProcessedTableManager<
        _$AppDb,
        UserProvidedMacronizations,
        UserProvidedMacronization,
        $UserProvidedMacronizationsFilterComposer,
        $UserProvidedMacronizationsOrderingComposer,
        $UserProvidedMacronizationsProcessedTableManager,
        $UserProvidedMacronizationsInsertCompanionBuilder,
        $UserProvidedMacronizationsUpdateCompanionBuilder> {
  $UserProvidedMacronizationsProcessedTableManager(super.$state);
}

class $UserProvidedMacronizationsFilterComposer
    extends FilterComposer<_$AppDb, UserProvidedMacronizations> {
  $UserProvidedMacronizationsFilterComposer(super.$state);
  ColumnFilters<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get idx => $state.composableBuilder(
      column: $state.table.idx,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get syllableNumber => $state.composableBuilder(
      column: $state.table.syllableNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get macronizedSyllable => $state.composableBuilder(
      column: $state.table.macronizedSyllable,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $UserProvidedMacronizationsOrderingComposer
    extends OrderingComposer<_$AppDb, UserProvidedMacronizations> {
  $UserProvidedMacronizationsOrderingComposer(super.$state);
  ColumnOrderings<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get idx => $state.composableBuilder(
      column: $state.table.idx,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get syllableNumber => $state.composableBuilder(
      column: $state.table.syllableNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get macronizedSyllable => $state.composableBuilder(
      column: $state.table.macronizedSyllable,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $WorkContentSubdivisionsInsertCompanionBuilder
    = WorkContentSubdivisionsCompanion Function({
  required String workId,
  required String typ,
  required int cnt,
  required String name,
  required String node,
  Value<String?> parent,
  required int fromIndex,
  required int toIndex,
});
typedef $WorkContentSubdivisionsUpdateCompanionBuilder
    = WorkContentSubdivisionsCompanion Function({
  Value<String> workId,
  Value<String> typ,
  Value<int> cnt,
  Value<String> name,
  Value<String> node,
  Value<String?> parent,
  Value<int> fromIndex,
  Value<int> toIndex,
});

class $WorkContentSubdivisionsTableManager extends RootTableManager<
    _$AppDb,
    WorkContentSubdivisions,
    WorkContentSubdivision,
    $WorkContentSubdivisionsFilterComposer,
    $WorkContentSubdivisionsOrderingComposer,
    $WorkContentSubdivisionsProcessedTableManager,
    $WorkContentSubdivisionsInsertCompanionBuilder,
    $WorkContentSubdivisionsUpdateCompanionBuilder> {
  $WorkContentSubdivisionsTableManager(
      _$AppDb db, WorkContentSubdivisions table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $WorkContentSubdivisionsFilterComposer(ComposerState(db, table)),
          orderingComposer: $WorkContentSubdivisionsOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $WorkContentSubdivisionsProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> workId = const Value.absent(),
            Value<String> typ = const Value.absent(),
            Value<int> cnt = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> node = const Value.absent(),
            Value<String?> parent = const Value.absent(),
            Value<int> fromIndex = const Value.absent(),
            Value<int> toIndex = const Value.absent(),
          }) =>
              WorkContentSubdivisionsCompanion(
            workId: workId,
            typ: typ,
            cnt: cnt,
            name: name,
            node: node,
            parent: parent,
            fromIndex: fromIndex,
            toIndex: toIndex,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required String typ,
            required int cnt,
            required String name,
            required String node,
            Value<String?> parent = const Value.absent(),
            required int fromIndex,
            required int toIndex,
          }) =>
              WorkContentSubdivisionsCompanion.insert(
            workId: workId,
            typ: typ,
            cnt: cnt,
            name: name,
            node: node,
            parent: parent,
            fromIndex: fromIndex,
            toIndex: toIndex,
          ),
        ));
}

class $WorkContentSubdivisionsProcessedTableManager
    extends ProcessedTableManager<
        _$AppDb,
        WorkContentSubdivisions,
        WorkContentSubdivision,
        $WorkContentSubdivisionsFilterComposer,
        $WorkContentSubdivisionsOrderingComposer,
        $WorkContentSubdivisionsProcessedTableManager,
        $WorkContentSubdivisionsInsertCompanionBuilder,
        $WorkContentSubdivisionsUpdateCompanionBuilder> {
  $WorkContentSubdivisionsProcessedTableManager(super.$state);
}

class $WorkContentSubdivisionsFilterComposer
    extends FilterComposer<_$AppDb, WorkContentSubdivisions> {
  $WorkContentSubdivisionsFilterComposer(super.$state);
  ColumnFilters<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get typ => $state.composableBuilder(
      column: $state.table.typ,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get cnt => $state.composableBuilder(
      column: $state.table.cnt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get node => $state.composableBuilder(
      column: $state.table.node,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get parent => $state.composableBuilder(
      column: $state.table.parent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get fromIndex => $state.composableBuilder(
      column: $state.table.fromIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get toIndex => $state.composableBuilder(
      column: $state.table.toIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $WorkContentSubdivisionsOrderingComposer
    extends OrderingComposer<_$AppDb, WorkContentSubdivisions> {
  $WorkContentSubdivisionsOrderingComposer(super.$state);
  ColumnOrderings<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get typ => $state.composableBuilder(
      column: $state.table.typ,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get cnt => $state.composableBuilder(
      column: $state.table.cnt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get node => $state.composableBuilder(
      column: $state.table.node,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get parent => $state.composableBuilder(
      column: $state.table.parent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get fromIndex => $state.composableBuilder(
      column: $state.table.fromIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get toIndex => $state.composableBuilder(
      column: $state.table.toIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $WorkContentSupplementaryInsertCompanionBuilder
    = WorkContentSupplementaryCompanion Function({
  required String workId,
  required String typ,
  required int cnt,
  required int fromIndex,
  required int toIndex,
  required String val,
});
typedef $WorkContentSupplementaryUpdateCompanionBuilder
    = WorkContentSupplementaryCompanion Function({
  Value<String> workId,
  Value<String> typ,
  Value<int> cnt,
  Value<int> fromIndex,
  Value<int> toIndex,
  Value<String> val,
});

class $WorkContentSupplementaryTableManager extends RootTableManager<
    _$AppDb,
    WorkContentSupplementary,
    WorkContentSupplementaryData,
    $WorkContentSupplementaryFilterComposer,
    $WorkContentSupplementaryOrderingComposer,
    $WorkContentSupplementaryProcessedTableManager,
    $WorkContentSupplementaryInsertCompanionBuilder,
    $WorkContentSupplementaryUpdateCompanionBuilder> {
  $WorkContentSupplementaryTableManager(
      _$AppDb db, WorkContentSupplementary table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $WorkContentSupplementaryFilterComposer(ComposerState(db, table)),
          orderingComposer: $WorkContentSupplementaryOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $WorkContentSupplementaryProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> workId = const Value.absent(),
            Value<String> typ = const Value.absent(),
            Value<int> cnt = const Value.absent(),
            Value<int> fromIndex = const Value.absent(),
            Value<int> toIndex = const Value.absent(),
            Value<String> val = const Value.absent(),
          }) =>
              WorkContentSupplementaryCompanion(
            workId: workId,
            typ: typ,
            cnt: cnt,
            fromIndex: fromIndex,
            toIndex: toIndex,
            val: val,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required String typ,
            required int cnt,
            required int fromIndex,
            required int toIndex,
            required String val,
          }) =>
              WorkContentSupplementaryCompanion.insert(
            workId: workId,
            typ: typ,
            cnt: cnt,
            fromIndex: fromIndex,
            toIndex: toIndex,
            val: val,
          ),
        ));
}

class $WorkContentSupplementaryProcessedTableManager
    extends ProcessedTableManager<
        _$AppDb,
        WorkContentSupplementary,
        WorkContentSupplementaryData,
        $WorkContentSupplementaryFilterComposer,
        $WorkContentSupplementaryOrderingComposer,
        $WorkContentSupplementaryProcessedTableManager,
        $WorkContentSupplementaryInsertCompanionBuilder,
        $WorkContentSupplementaryUpdateCompanionBuilder> {
  $WorkContentSupplementaryProcessedTableManager(super.$state);
}

class $WorkContentSupplementaryFilterComposer
    extends FilterComposer<_$AppDb, WorkContentSupplementary> {
  $WorkContentSupplementaryFilterComposer(super.$state);
  ColumnFilters<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get typ => $state.composableBuilder(
      column: $state.table.typ,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get cnt => $state.composableBuilder(
      column: $state.table.cnt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get fromIndex => $state.composableBuilder(
      column: $state.table.fromIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get toIndex => $state.composableBuilder(
      column: $state.table.toIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get val => $state.composableBuilder(
      column: $state.table.val,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $WorkContentSupplementaryOrderingComposer
    extends OrderingComposer<_$AppDb, WorkContentSupplementary> {
  $WorkContentSupplementaryOrderingComposer(super.$state);
  ColumnOrderings<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get typ => $state.composableBuilder(
      column: $state.table.typ,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get cnt => $state.composableBuilder(
      column: $state.table.cnt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get fromIndex => $state.composableBuilder(
      column: $state.table.fromIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get toIndex => $state.composableBuilder(
      column: $state.table.toIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get val => $state.composableBuilder(
      column: $state.table.val,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $AuthorsAndWorksInsertCompanionBuilder = AuthorsAndWorksCompanion
    Function({
  required String authorId,
  required String workId,
});
typedef $AuthorsAndWorksUpdateCompanionBuilder = AuthorsAndWorksCompanion
    Function({
  Value<String> authorId,
  Value<String> workId,
});

class $AuthorsAndWorksTableManager extends RootTableManager<
    _$AppDb,
    AuthorsAndWorks,
    AuthorsAndWork,
    $AuthorsAndWorksFilterComposer,
    $AuthorsAndWorksOrderingComposer,
    $AuthorsAndWorksProcessedTableManager,
    $AuthorsAndWorksInsertCompanionBuilder,
    $AuthorsAndWorksUpdateCompanionBuilder> {
  $AuthorsAndWorksTableManager(_$AppDb db, AuthorsAndWorks table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $AuthorsAndWorksFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $AuthorsAndWorksOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $AuthorsAndWorksProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> authorId = const Value.absent(),
            Value<String> workId = const Value.absent(),
          }) =>
              AuthorsAndWorksCompanion(
            authorId: authorId,
            workId: workId,
          ),
          getInsertCompanionBuilder: ({
            required String authorId,
            required String workId,
          }) =>
              AuthorsAndWorksCompanion.insert(
            authorId: authorId,
            workId: workId,
          ),
        ));
}

class $AuthorsAndWorksProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    AuthorsAndWorks,
    AuthorsAndWork,
    $AuthorsAndWorksFilterComposer,
    $AuthorsAndWorksOrderingComposer,
    $AuthorsAndWorksProcessedTableManager,
    $AuthorsAndWorksInsertCompanionBuilder,
    $AuthorsAndWorksUpdateCompanionBuilder> {
  $AuthorsAndWorksProcessedTableManager(super.$state);
}

class $AuthorsAndWorksFilterComposer
    extends FilterComposer<_$AppDb, AuthorsAndWorks> {
  $AuthorsAndWorksFilterComposer(super.$state);
  ColumnFilters<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $AuthorsAndWorksOrderingComposer
    extends OrderingComposer<_$AppDb, AuthorsAndWorks> {
  $AuthorsAndWorksOrderingComposer(super.$state);
  ColumnOrderings<String> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDbManager {
  final _$AppDb _db;
  _$AppDbManager(this._db);
  $DataVersionTableManager get dataVersion =>
      $DataVersionTableManager(_db, _db.dataVersion);
  $MorphologicalDetailsTableManager get morphologicalDetails =>
      $MorphologicalDetailsTableManager(_db, _db.morphologicalDetails);
  $MorphologicalDetailInflectionsTableManager
      get morphologicalDetailInflections =>
          $MorphologicalDetailInflectionsTableManager(
              _db, _db.morphologicalDetailInflections);
  $MacronizationsTableManager get macronizations =>
      $MacronizationsTableManager(_db, _db.macronizations);
  $AuthorsTableManager get authors => $AuthorsTableManager(_db, _db.authors);
  $AuthorAbbreviationsTableManager get authorAbbreviations =>
      $AuthorAbbreviationsTableManager(_db, _db.authorAbbreviations);
  $WorksTableManager get works => $WorksTableManager(_db, _db.works);
  $WorkAbbreviationsTableManager get workAbbreviations =>
      $WorkAbbreviationsTableManager(_db, _db.workAbbreviations);
  $WorkContentsTableManager get workContents =>
      $WorkContentsTableManager(_db, _db.workContents);
  $UserProvidedMacronizationsTableManager get userProvidedMacronizations =>
      $UserProvidedMacronizationsTableManager(
          _db, _db.userProvidedMacronizations);
  $WorkContentSubdivisionsTableManager get workContentSubdivisions =>
      $WorkContentSubdivisionsTableManager(_db, _db.workContentSubdivisions);
  $WorkContentSupplementaryTableManager get workContentSupplementary =>
      $WorkContentSupplementaryTableManager(_db, _db.workContentSupplementary);
  $AuthorsAndWorksTableManager get authorsAndWorks =>
      $AuthorsAndWorksTableManager(_db, _db.authorsAndWorks);
}
