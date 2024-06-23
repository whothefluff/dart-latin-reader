// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
      $customConstraints: 'NOT NULL');
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
  final Value<int> rowid;
  const AuthorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.about = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthorsCompanion.insert({
    required String id,
    required String name,
    this.about = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Author> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? about,
    Expression<Uint8List>? image,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
      if (image != null) 'image': image,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthorsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? about,
      Value<Uint8List?>? image,
      Value<int>? rowid}) {
    return AuthorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
      image: image ?? this.image,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about, ')
          ..write('image: $image, ')
          ..write('rowid: $rowid')
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
      $customConstraints: 'NOT NULL');
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
  final Value<int> rowid;
  const AuthorAbbreviationsCompanion({
    this.authorId = const Value.absent(),
    this.id = const Value.absent(),
    this.val = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthorAbbreviationsCompanion.insert({
    required String authorId,
    required int id,
    required String val,
    this.rowid = const Value.absent(),
  })  : authorId = Value(authorId),
        id = Value(id),
        val = Value(val);
  static Insertable<AuthorAbbreviation> custom({
    Expression<String>? authorId,
    Expression<int>? id,
    Expression<String>? val,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (authorId != null) 'authorId': authorId,
      if (id != null) 'id': id,
      if (val != null) 'val': val,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthorAbbreviationsCompanion copyWith(
      {Value<String>? authorId,
      Value<int>? id,
      Value<String>? val,
      Value<int>? rowid}) {
    return AuthorAbbreviationsCompanion(
      authorId: authorId ?? this.authorId,
      id: id ?? this.id,
      val: val ?? this.val,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorAbbreviationsCompanion(')
          ..write('authorId: $authorId, ')
          ..write('id: $id, ')
          ..write('val: $val, ')
          ..write('rowid: $rowid')
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
      $customConstraints: 'NOT NULL');
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
  final Value<int> rowid;
  const WorksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.about = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorksCompanion.insert({
    required String id,
    required String name,
    this.about = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Work> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? about,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorksCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? about,
      Value<int>? rowid}) {
    return WorksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('about: $about, ')
          ..write('rowid: $rowid')
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
      $customConstraints: 'NOT NULL');
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
  final Value<int> rowid;
  const WorkAbbreviationsCompanion({
    this.workId = const Value.absent(),
    this.id = const Value.absent(),
    this.val = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkAbbreviationsCompanion.insert({
    required String workId,
    required int id,
    required String val,
    this.rowid = const Value.absent(),
  })  : workId = Value(workId),
        id = Value(id),
        val = Value(val);
  static Insertable<WorkAbbreviation> custom({
    Expression<String>? workId,
    Expression<int>? id,
    Expression<String>? val,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (id != null) 'id': id,
      if (val != null) 'val': val,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkAbbreviationsCompanion copyWith(
      {Value<String>? workId,
      Value<int>? id,
      Value<String>? val,
      Value<int>? rowid}) {
    return WorkAbbreviationsCompanion(
      workId: workId ?? this.workId,
      id: id ?? this.id,
      val: val ?? this.val,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkAbbreviationsCompanion(')
          ..write('workId: $workId, ')
          ..write('id: $id, ')
          ..write('val: $val, ')
          ..write('rowid: $rowid')
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
      $customConstraints: 'NOT NULL');
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
  final Value<int> rowid;
  const WorkContentsCompanion({
    this.workId = const Value.absent(),
    this.idx = const Value.absent(),
    this.word = const Value.absent(),
    this.sourceReference = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkContentsCompanion.insert({
    required String workId,
    required int idx,
    required String word,
    required String sourceReference,
    this.rowid = const Value.absent(),
  })  : workId = Value(workId),
        idx = Value(idx),
        word = Value(word),
        sourceReference = Value(sourceReference);
  static Insertable<WorkContent> custom({
    Expression<String>? workId,
    Expression<int>? idx,
    Expression<String>? word,
    Expression<String>? sourceReference,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (idx != null) 'idx': idx,
      if (word != null) 'word': word,
      if (sourceReference != null) 'sourceReference': sourceReference,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkContentsCompanion copyWith(
      {Value<String>? workId,
      Value<int>? idx,
      Value<String>? word,
      Value<String>? sourceReference,
      Value<int>? rowid}) {
    return WorkContentsCompanion(
      workId: workId ?? this.workId,
      idx: idx ?? this.idx,
      word: word ?? this.word,
      sourceReference: sourceReference ?? this.sourceReference,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
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
          ..write('rowid: $rowid')
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
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
      'seq', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
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
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  late final GeneratedColumn<String> parent = GeneratedColumn<String>(
      'parent', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
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
  @override
  List<GeneratedColumn> get $columns =>
      [workId, typ, seq, name, node, parent, fromIndex, toIndex];
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
    if (data.containsKey('seq')) {
      context.handle(
          _seqMeta, seq.isAcceptableOrUnknown(data['seq']!, _seqMeta));
    } else if (isInserting) {
      context.missing(_seqMeta);
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
  Set<GeneratedColumn> get $primaryKey => {workId, typ, seq};
  @override
  WorkContentSubdivision map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkContentSubdivision(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
      typ: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}typ'])!,
      seq: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}seq'])!,
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
  List<String> get customConstraints => const [
        'PRIMARY KEY(workId, typ, seq)',
        'FOREIGN KEY(workId)REFERENCES Works(id)',
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
  final int seq;
  final String name;
  final String node;
  final String? parent;
  final int fromIndex;
  final int toIndex;
  const WorkContentSubdivision(
      {required this.workId,
      required this.typ,
      required this.seq,
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
    map['seq'] = Variable<int>(seq);
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
      seq: Value(seq),
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
      seq: serializer.fromJson<int>(json['seq']),
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
      'seq': serializer.toJson<int>(seq),
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
          int? seq,
          String? name,
          String? node,
          Value<String?> parent = const Value.absent(),
          int? fromIndex,
          int? toIndex}) =>
      WorkContentSubdivision(
        workId: workId ?? this.workId,
        typ: typ ?? this.typ,
        seq: seq ?? this.seq,
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
          ..write('seq: $seq, ')
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
      Object.hash(workId, typ, seq, name, node, parent, fromIndex, toIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkContentSubdivision &&
          other.workId == this.workId &&
          other.typ == this.typ &&
          other.seq == this.seq &&
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
  final Value<int> seq;
  final Value<String> name;
  final Value<String> node;
  final Value<String?> parent;
  final Value<int> fromIndex;
  final Value<int> toIndex;
  final Value<int> rowid;
  const WorkContentSubdivisionsCompanion({
    this.workId = const Value.absent(),
    this.typ = const Value.absent(),
    this.seq = const Value.absent(),
    this.name = const Value.absent(),
    this.node = const Value.absent(),
    this.parent = const Value.absent(),
    this.fromIndex = const Value.absent(),
    this.toIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkContentSubdivisionsCompanion.insert({
    required String workId,
    required String typ,
    required int seq,
    required String name,
    required String node,
    this.parent = const Value.absent(),
    required int fromIndex,
    required int toIndex,
    this.rowid = const Value.absent(),
  })  : workId = Value(workId),
        typ = Value(typ),
        seq = Value(seq),
        name = Value(name),
        node = Value(node),
        fromIndex = Value(fromIndex),
        toIndex = Value(toIndex);
  static Insertable<WorkContentSubdivision> custom({
    Expression<String>? workId,
    Expression<String>? typ,
    Expression<int>? seq,
    Expression<String>? name,
    Expression<String>? node,
    Expression<String>? parent,
    Expression<int>? fromIndex,
    Expression<int>? toIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (typ != null) 'typ': typ,
      if (seq != null) 'seq': seq,
      if (name != null) 'name': name,
      if (node != null) 'node': node,
      if (parent != null) 'parent': parent,
      if (fromIndex != null) 'fromIndex': fromIndex,
      if (toIndex != null) 'toIndex': toIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkContentSubdivisionsCompanion copyWith(
      {Value<String>? workId,
      Value<String>? typ,
      Value<int>? seq,
      Value<String>? name,
      Value<String>? node,
      Value<String?>? parent,
      Value<int>? fromIndex,
      Value<int>? toIndex,
      Value<int>? rowid}) {
    return WorkContentSubdivisionsCompanion(
      workId: workId ?? this.workId,
      typ: typ ?? this.typ,
      seq: seq ?? this.seq,
      name: name ?? this.name,
      node: node ?? this.node,
      parent: parent ?? this.parent,
      fromIndex: fromIndex ?? this.fromIndex,
      toIndex: toIndex ?? this.toIndex,
      rowid: rowid ?? this.rowid,
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
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkContentSubdivisionsCompanion(')
          ..write('workId: $workId, ')
          ..write('typ: $typ, ')
          ..write('seq: $seq, ')
          ..write('name: $name, ')
          ..write('node: $node, ')
          ..write('parent: $parent, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class WorkNotes extends Table with TableInfo<WorkNotes, WorkNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WorkNotes(this.attachedDatabase, [this._alias]);
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
      $customConstraints: 'NOT NULL');
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
  List<GeneratedColumn> get $columns => [workId, id, fromIndex, toIndex, val];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'WorkNotes';
  @override
  VerificationContext validateIntegrity(Insertable<WorkNote> instance,
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
  Set<GeneratedColumn> get $primaryKey => {workId, id};
  @override
  WorkNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkNote(
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workId'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fromIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fromIndex'])!,
      toIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}toIndex'])!,
      val: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}val'])!,
    );
  }

  @override
  WorkNotes createAlias(String alias) {
    return WorkNotes(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(workId, id)',
        'FOREIGN KEY(workId)REFERENCES Works(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class WorkNote extends DataClass implements Insertable<WorkNote> {
  final String workId;
  final int id;
  final int fromIndex;
  final int toIndex;
  final String val;
  const WorkNote(
      {required this.workId,
      required this.id,
      required this.fromIndex,
      required this.toIndex,
      required this.val});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['workId'] = Variable<String>(workId);
    map['id'] = Variable<int>(id);
    map['fromIndex'] = Variable<int>(fromIndex);
    map['toIndex'] = Variable<int>(toIndex);
    map['val'] = Variable<String>(val);
    return map;
  }

  WorkNotesCompanion toCompanion(bool nullToAbsent) {
    return WorkNotesCompanion(
      workId: Value(workId),
      id: Value(id),
      fromIndex: Value(fromIndex),
      toIndex: Value(toIndex),
      val: Value(val),
    );
  }

  factory WorkNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkNote(
      workId: serializer.fromJson<String>(json['workId']),
      id: serializer.fromJson<int>(json['id']),
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
      'id': serializer.toJson<int>(id),
      'fromIndex': serializer.toJson<int>(fromIndex),
      'toIndex': serializer.toJson<int>(toIndex),
      'val': serializer.toJson<String>(val),
    };
  }

  WorkNote copyWith(
          {String? workId,
          int? id,
          int? fromIndex,
          int? toIndex,
          String? val}) =>
      WorkNote(
        workId: workId ?? this.workId,
        id: id ?? this.id,
        fromIndex: fromIndex ?? this.fromIndex,
        toIndex: toIndex ?? this.toIndex,
        val: val ?? this.val,
      );
  @override
  String toString() {
    return (StringBuffer('WorkNote(')
          ..write('workId: $workId, ')
          ..write('id: $id, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex, ')
          ..write('val: $val')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workId, id, fromIndex, toIndex, val);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkNote &&
          other.workId == this.workId &&
          other.id == this.id &&
          other.fromIndex == this.fromIndex &&
          other.toIndex == this.toIndex &&
          other.val == this.val);
}

class WorkNotesCompanion extends UpdateCompanion<WorkNote> {
  final Value<String> workId;
  final Value<int> id;
  final Value<int> fromIndex;
  final Value<int> toIndex;
  final Value<String> val;
  final Value<int> rowid;
  const WorkNotesCompanion({
    this.workId = const Value.absent(),
    this.id = const Value.absent(),
    this.fromIndex = const Value.absent(),
    this.toIndex = const Value.absent(),
    this.val = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkNotesCompanion.insert({
    required String workId,
    required int id,
    required int fromIndex,
    required int toIndex,
    required String val,
    this.rowid = const Value.absent(),
  })  : workId = Value(workId),
        id = Value(id),
        fromIndex = Value(fromIndex),
        toIndex = Value(toIndex),
        val = Value(val);
  static Insertable<WorkNote> custom({
    Expression<String>? workId,
    Expression<int>? id,
    Expression<int>? fromIndex,
    Expression<int>? toIndex,
    Expression<String>? val,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workId != null) 'workId': workId,
      if (id != null) 'id': id,
      if (fromIndex != null) 'fromIndex': fromIndex,
      if (toIndex != null) 'toIndex': toIndex,
      if (val != null) 'val': val,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkNotesCompanion copyWith(
      {Value<String>? workId,
      Value<int>? id,
      Value<int>? fromIndex,
      Value<int>? toIndex,
      Value<String>? val,
      Value<int>? rowid}) {
    return WorkNotesCompanion(
      workId: workId ?? this.workId,
      id: id ?? this.id,
      fromIndex: fromIndex ?? this.fromIndex,
      toIndex: toIndex ?? this.toIndex,
      val: val ?? this.val,
      rowid: rowid ?? this.rowid,
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
    if (fromIndex.present) {
      map['fromIndex'] = Variable<int>(fromIndex.value);
    }
    if (toIndex.present) {
      map['toIndex'] = Variable<int>(toIndex.value);
    }
    if (val.present) {
      map['val'] = Variable<String>(val.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkNotesCompanion(')
          ..write('workId: $workId, ')
          ..write('id: $id, ')
          ..write('fromIndex: $fromIndex, ')
          ..write('toIndex: $toIndex, ')
          ..write('val: $val, ')
          ..write('rowid: $rowid')
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
  final Value<int> rowid;
  const AuthorsAndWorksCompanion({
    this.authorId = const Value.absent(),
    this.workId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthorsAndWorksCompanion.insert({
    required String authorId,
    required String workId,
    this.rowid = const Value.absent(),
  })  : authorId = Value(authorId),
        workId = Value(workId);
  static Insertable<AuthorsAndWork> custom({
    Expression<String>? authorId,
    Expression<String>? workId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (authorId != null) 'authorId': authorId,
      if (workId != null) 'workId': workId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthorsAndWorksCompanion copyWith(
      {Value<String>? authorId, Value<String>? workId, Value<int>? rowid}) {
    return AuthorsAndWorksCompanion(
      authorId: authorId ?? this.authorId,
      workId: workId ?? this.workId,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorsAndWorksCompanion(')
          ..write('authorId: $authorId, ')
          ..write('workId: $workId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  _$AppDbManager get managers => _$AppDbManager(this);
  late final Authors authors = Authors(this);
  late final AuthorAbbreviations authorAbbreviations =
      AuthorAbbreviations(this);
  late final Works works = Works(this);
  late final WorkAbbreviations workAbbreviations = WorkAbbreviations(this);
  late final WorkContents workContents = WorkContents(this);
  late final WorkContentSubdivisions workContentSubdivisions =
      WorkContentSubdivisions(this);
  late final WorkNotes workNotes = WorkNotes(this);
  late final AuthorsAndWorks authorsAndWorks = AuthorsAndWorks(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        authors,
        authorAbbreviations,
        works,
        workAbbreviations,
        workContents,
        workContentSubdivisions,
        workNotes,
        authorsAndWorks
      ];
}

typedef $AuthorsInsertCompanionBuilder = AuthorsCompanion Function({
  required String id,
  required String name,
  Value<String?> about,
  Value<Uint8List?> image,
  Value<int> rowid,
});
typedef $AuthorsUpdateCompanionBuilder = AuthorsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> about,
  Value<Uint8List?> image,
  Value<int> rowid,
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
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorsCompanion(
            id: id,
            name: name,
            about: about,
            image: image,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String name,
            Value<String?> about = const Value.absent(),
            Value<Uint8List?> image = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorsCompanion.insert(
            id: id,
            name: name,
            about: about,
            image: image,
            rowid: rowid,
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
  Value<int> rowid,
});
typedef $AuthorAbbreviationsUpdateCompanionBuilder
    = AuthorAbbreviationsCompanion Function({
  Value<String> authorId,
  Value<int> id,
  Value<String> val,
  Value<int> rowid,
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
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorAbbreviationsCompanion(
            authorId: authorId,
            id: id,
            val: val,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String authorId,
            required int id,
            required String val,
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorAbbreviationsCompanion.insert(
            authorId: authorId,
            id: id,
            val: val,
            rowid: rowid,
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
  Value<int> rowid,
});
typedef $WorksUpdateCompanionBuilder = WorksCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> about,
  Value<int> rowid,
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
            Value<int> rowid = const Value.absent(),
          }) =>
              WorksCompanion(
            id: id,
            name: name,
            about: about,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String name,
            Value<String?> about = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorksCompanion.insert(
            id: id,
            name: name,
            about: about,
            rowid: rowid,
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
  Value<int> rowid,
});
typedef $WorkAbbreviationsUpdateCompanionBuilder = WorkAbbreviationsCompanion
    Function({
  Value<String> workId,
  Value<int> id,
  Value<String> val,
  Value<int> rowid,
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
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkAbbreviationsCompanion(
            workId: workId,
            id: id,
            val: val,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required int id,
            required String val,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkAbbreviationsCompanion.insert(
            workId: workId,
            id: id,
            val: val,
            rowid: rowid,
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
  Value<int> rowid,
});
typedef $WorkContentsUpdateCompanionBuilder = WorkContentsCompanion Function({
  Value<String> workId,
  Value<int> idx,
  Value<String> word,
  Value<String> sourceReference,
  Value<int> rowid,
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
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkContentsCompanion(
            workId: workId,
            idx: idx,
            word: word,
            sourceReference: sourceReference,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required int idx,
            required String word,
            required String sourceReference,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkContentsCompanion.insert(
            workId: workId,
            idx: idx,
            word: word,
            sourceReference: sourceReference,
            rowid: rowid,
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

typedef $WorkContentSubdivisionsInsertCompanionBuilder
    = WorkContentSubdivisionsCompanion Function({
  required String workId,
  required String typ,
  required int seq,
  required String name,
  required String node,
  Value<String?> parent,
  required int fromIndex,
  required int toIndex,
  Value<int> rowid,
});
typedef $WorkContentSubdivisionsUpdateCompanionBuilder
    = WorkContentSubdivisionsCompanion Function({
  Value<String> workId,
  Value<String> typ,
  Value<int> seq,
  Value<String> name,
  Value<String> node,
  Value<String?> parent,
  Value<int> fromIndex,
  Value<int> toIndex,
  Value<int> rowid,
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
            Value<int> seq = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> node = const Value.absent(),
            Value<String?> parent = const Value.absent(),
            Value<int> fromIndex = const Value.absent(),
            Value<int> toIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkContentSubdivisionsCompanion(
            workId: workId,
            typ: typ,
            seq: seq,
            name: name,
            node: node,
            parent: parent,
            fromIndex: fromIndex,
            toIndex: toIndex,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required String typ,
            required int seq,
            required String name,
            required String node,
            Value<String?> parent = const Value.absent(),
            required int fromIndex,
            required int toIndex,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkContentSubdivisionsCompanion.insert(
            workId: workId,
            typ: typ,
            seq: seq,
            name: name,
            node: node,
            parent: parent,
            fromIndex: fromIndex,
            toIndex: toIndex,
            rowid: rowid,
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

  ColumnFilters<int> get seq => $state.composableBuilder(
      column: $state.table.seq,
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

  ColumnOrderings<int> get seq => $state.composableBuilder(
      column: $state.table.seq,
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

typedef $WorkNotesInsertCompanionBuilder = WorkNotesCompanion Function({
  required String workId,
  required int id,
  required int fromIndex,
  required int toIndex,
  required String val,
  Value<int> rowid,
});
typedef $WorkNotesUpdateCompanionBuilder = WorkNotesCompanion Function({
  Value<String> workId,
  Value<int> id,
  Value<int> fromIndex,
  Value<int> toIndex,
  Value<String> val,
  Value<int> rowid,
});

class $WorkNotesTableManager extends RootTableManager<
    _$AppDb,
    WorkNotes,
    WorkNote,
    $WorkNotesFilterComposer,
    $WorkNotesOrderingComposer,
    $WorkNotesProcessedTableManager,
    $WorkNotesInsertCompanionBuilder,
    $WorkNotesUpdateCompanionBuilder> {
  $WorkNotesTableManager(_$AppDb db, WorkNotes table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $WorkNotesFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $WorkNotesOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $WorkNotesProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> workId = const Value.absent(),
            Value<int> id = const Value.absent(),
            Value<int> fromIndex = const Value.absent(),
            Value<int> toIndex = const Value.absent(),
            Value<String> val = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkNotesCompanion(
            workId: workId,
            id: id,
            fromIndex: fromIndex,
            toIndex: toIndex,
            val: val,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String workId,
            required int id,
            required int fromIndex,
            required int toIndex,
            required String val,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkNotesCompanion.insert(
            workId: workId,
            id: id,
            fromIndex: fromIndex,
            toIndex: toIndex,
            val: val,
            rowid: rowid,
          ),
        ));
}

class $WorkNotesProcessedTableManager extends ProcessedTableManager<
    _$AppDb,
    WorkNotes,
    WorkNote,
    $WorkNotesFilterComposer,
    $WorkNotesOrderingComposer,
    $WorkNotesProcessedTableManager,
    $WorkNotesInsertCompanionBuilder,
    $WorkNotesUpdateCompanionBuilder> {
  $WorkNotesProcessedTableManager(super.$state);
}

class $WorkNotesFilterComposer extends FilterComposer<_$AppDb, WorkNotes> {
  $WorkNotesFilterComposer(super.$state);
  ColumnFilters<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
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

class $WorkNotesOrderingComposer extends OrderingComposer<_$AppDb, WorkNotes> {
  $WorkNotesOrderingComposer(super.$state);
  ColumnOrderings<String> get workId => $state.composableBuilder(
      column: $state.table.workId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
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
  Value<int> rowid,
});
typedef $AuthorsAndWorksUpdateCompanionBuilder = AuthorsAndWorksCompanion
    Function({
  Value<String> authorId,
  Value<String> workId,
  Value<int> rowid,
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
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorsAndWorksCompanion(
            authorId: authorId,
            workId: workId,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String authorId,
            required String workId,
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthorsAndWorksCompanion.insert(
            authorId: authorId,
            workId: workId,
            rowid: rowid,
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
  $AuthorsTableManager get authors => $AuthorsTableManager(_db, _db.authors);
  $AuthorAbbreviationsTableManager get authorAbbreviations =>
      $AuthorAbbreviationsTableManager(_db, _db.authorAbbreviations);
  $WorksTableManager get works => $WorksTableManager(_db, _db.works);
  $WorkAbbreviationsTableManager get workAbbreviations =>
      $WorkAbbreviationsTableManager(_db, _db.workAbbreviations);
  $WorkContentsTableManager get workContents =>
      $WorkContentsTableManager(_db, _db.workContents);
  $WorkContentSubdivisionsTableManager get workContentSubdivisions =>
      $WorkContentSubdivisionsTableManager(_db, _db.workContentSubdivisions);
  $WorkNotesTableManager get workNotes =>
      $WorkNotesTableManager(_db, _db.workNotes);
  $AuthorsAndWorksTableManager get authorsAndWorks =>
      $AuthorsAndWorksTableManager(_db, _db.authorsAndWorks);
}
