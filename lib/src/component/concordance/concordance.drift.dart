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
import 'package:latin_reader/src/component/morph_analysis/morph_analysis.drift.dart'
    as i5;
import 'package:latin_reader/src/component/dictionary/dictionary.drift.dart'
    as i6;
import 'package:latin_reader/src/component/library/library.drift.dart' as i7;

class ConcordanceAnalyse extends i0.DataClass {
  final String form;
  final String capitalizedForm;
  final int item;
  final String dictionaryRef;
  final String? partOfSpeech;
  final String? gramCase;
  final String? number;
  final String? gender;
  final String? person;
  final String? verbForm;
  final String? tense;
  final String? voice;
  const ConcordanceAnalyse({
    required this.form,
    required this.capitalizedForm,
    required this.item,
    required this.dictionaryRef,
    this.partOfSpeech,
    this.gramCase,
    this.number,
    this.gender,
    this.person,
    this.verbForm,
    this.tense,
    this.voice,
  });
  factory ConcordanceAnalyse.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ConcordanceAnalyse(
      form: serializer.fromJson<String>(json['form']),
      capitalizedForm: serializer.fromJson<String>(json['capitalizedForm']),
      item: serializer.fromJson<int>(json['item']),
      dictionaryRef: serializer.fromJson<String>(json['dictionaryRef']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      gramCase: serializer.fromJson<String?>(json['gramCase']),
      number: serializer.fromJson<String?>(json['number']),
      gender: serializer.fromJson<String?>(json['gender']),
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
      'capitalizedForm': serializer.toJson<String>(capitalizedForm),
      'item': serializer.toJson<int>(item),
      'dictionaryRef': serializer.toJson<String>(dictionaryRef),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'gramCase': serializer.toJson<String?>(gramCase),
      'number': serializer.toJson<String?>(number),
      'gender': serializer.toJson<String?>(gender),
      'person': serializer.toJson<String?>(person),
      'verbForm': serializer.toJson<String?>(verbForm),
      'tense': serializer.toJson<String?>(tense),
      'voice': serializer.toJson<String?>(voice),
    };
  }

  i1.ConcordanceAnalyse copyWith({
    String? form,
    String? capitalizedForm,
    int? item,
    String? dictionaryRef,
    i0.Value<String?> partOfSpeech = const i0.Value.absent(),
    i0.Value<String?> gramCase = const i0.Value.absent(),
    i0.Value<String?> number = const i0.Value.absent(),
    i0.Value<String?> gender = const i0.Value.absent(),
    i0.Value<String?> person = const i0.Value.absent(),
    i0.Value<String?> verbForm = const i0.Value.absent(),
    i0.Value<String?> tense = const i0.Value.absent(),
    i0.Value<String?> voice = const i0.Value.absent(),
  }) => i1.ConcordanceAnalyse(
    form: form ?? this.form,
    capitalizedForm: capitalizedForm ?? this.capitalizedForm,
    item: item ?? this.item,
    dictionaryRef: dictionaryRef ?? this.dictionaryRef,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    gramCase: gramCase.present ? gramCase.value : this.gramCase,
    number: number.present ? number.value : this.number,
    gender: gender.present ? gender.value : this.gender,
    person: person.present ? person.value : this.person,
    verbForm: verbForm.present ? verbForm.value : this.verbForm,
    tense: tense.present ? tense.value : this.tense,
    voice: voice.present ? voice.value : this.voice,
  );
  @override
  String toString() {
    return (StringBuffer('ConcordanceAnalyse(')
          ..write('form: $form, ')
          ..write('capitalizedForm: $capitalizedForm, ')
          ..write('item: $item, ')
          ..write('dictionaryRef: $dictionaryRef, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('gramCase: $gramCase, ')
          ..write('number: $number, ')
          ..write('gender: $gender, ')
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
    capitalizedForm,
    item,
    dictionaryRef,
    partOfSpeech,
    gramCase,
    number,
    gender,
    person,
    verbForm,
    tense,
    voice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ConcordanceAnalyse &&
          other.form == this.form &&
          other.capitalizedForm == this.capitalizedForm &&
          other.item == this.item &&
          other.dictionaryRef == this.dictionaryRef &&
          other.partOfSpeech == this.partOfSpeech &&
          other.gramCase == this.gramCase &&
          other.number == this.number &&
          other.gender == this.gender &&
          other.person == this.person &&
          other.verbForm == this.verbForm &&
          other.tense == this.tense &&
          other.voice == this.voice);
}

class ConcordanceAnalyses
    extends i0.ViewInfo<i1.ConcordanceAnalyses, i1.ConcordanceAnalyse>
    implements i0.HasResultSet {
  final String? _alias;
  @override
  final i0.GeneratedDatabase attachedDatabase;
  ConcordanceAnalyses(this.attachedDatabase, [this._alias]);
  @override
  List<i0.GeneratedColumn> get $columns => [
    form,
    capitalizedForm,
    item,
    dictionaryRef,
    partOfSpeech,
    gramCase,
    number,
    gender,
    person,
    verbForm,
    tense,
    voice,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'concordance.Analyses';
  @override
  Map<i0.SqlDialect, String> get createViewStatements => {
    i0.SqlDialect.sqlite:
        'CREATE VIEW "concordance.Analyses" AS SELECT Details.form, CASE WHEN Details.form = LOWER(Details.form) THEN UPPER(SUBSTR(Details.form, 1, 1)) || SUBSTR(Details.form, 2) END AS capitalizedForm, Details.item, Details.dictionaryRef, Infl.partOfSpeech, Infl.gramCase, Infl.number, Infl.gender, Infl.person, Infl.verbForm, Infl.tense, Infl.voice FROM MorphologicalDetails AS Details LEFT OUTER JOIN MorphologicalDetailInflections AS Infl ON Infl.form = Details.form AND Infl.item = Details.item',
  };
  @override
  ConcordanceAnalyses get asDslTable => this;
  @override
  i1.ConcordanceAnalyse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ConcordanceAnalyse(
      form: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}form'],
      )!,
      capitalizedForm: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}capitalizedForm'],
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
  late final i0.GeneratedColumn<String> capitalizedForm =
      i0.GeneratedColumn<String>(
        'capitalizedForm',
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
  ConcordanceAnalyses createAlias(String alias) {
    return ConcordanceAnalyses(attachedDatabase, alias);
  }

  @override
  i0.Query? get query => null;
  @override
  Set<String> get readTables => const {
    'MorphologicalDetails',
    'MorphologicalDetailInflections',
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
        'CREATE VIEW "concordance.Lemmas" AS SELECT DISTINCT Details.dictionaryRef, Resolved.lemma AS lnsLemma, Resolved.partOfSpeech AS lnsPartOfSpeech, Resolved.inflection AS lnsInflection FROM MorphologicalDetails AS Details LEFT OUTER JOIN "dictionary.ResolvedLnsRefs" AS Resolved ON Resolved.dictionaryRef = Details.dictionaryRef',
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
    'MorphologicalDetails',
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
        'CREATE VIEW "concordance.GrammarValues" AS SELECT partOfSpeech, \'partOfSpeech\' AS feature, partOfSpeech AS value FROM MorphologicalDetailInflections UNION SELECT partOfSpeech, \'gramCase\', gramCase FROM MorphologicalDetailInflections WHERE gramCase IS NOT NULL UNION SELECT partOfSpeech, \'number\', number FROM MorphologicalDetailInflections WHERE number IS NOT NULL UNION SELECT partOfSpeech, \'gender\', gender FROM MorphologicalDetailInflections WHERE gender IS NOT NULL UNION SELECT partOfSpeech, \'person\', person FROM MorphologicalDetailInflections WHERE person IS NOT NULL UNION SELECT partOfSpeech, \'verbForm\', verbForm FROM MorphologicalDetailInflections WHERE verbForm IS NOT NULL UNION SELECT partOfSpeech, \'tense\', tense FROM MorphologicalDetailInflections WHERE tense IS NOT NULL UNION SELECT partOfSpeech, \'voice\', voice FROM MorphologicalDetailInflections WHERE voice IS NOT NULL',
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
  Set<String> get readTables => const {'MorphologicalDetailInflections'};
}

class ConcordanceDrift extends i2.ModularAccessor {
  ConcordanceDrift(i0.GeneratedDatabase db) : super(db);
  i0.Selectable<i3.LemmaChoice> searchConcordanceLemmas({
    required String prefix,
    required int limit,
  }) {
    return customSelect(
      'SELECT COALESCE(lnsLemma, dictionaryRef) AS label, GROUP_CONCAT(dictionaryRef) AS dictionaryRefs, MIN(lnsPartOfSpeech) AS partOfSpeech, MIN(lnsInflection) AS inflection FROM "concordance.Lemmas" WHERE dictionaryRef LIKE ?1 || \'%\' OR lnsLemma LIKE ?1 || \'%\' GROUP BY COALESCE(lnsLemma, dictionaryRef) ORDER BY COALESCE(lnsLemma, dictionaryRef) <> ?1, LENGTH(COALESCE(lnsLemma, dictionaryRef)), COALESCE(lnsLemma, dictionaryRef) LIMIT ?2',
      variables: [i0.Variable<String>(prefix), i0.Variable<int>(limit)],
      readsFrom: {
        morphologicalDetails,
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
      readsFrom: {morphologicalDetailInflections},
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
    required String titles,
    required String sort,
    required int limit,
    required int offset,
  }) {
    return customSelect(
      'WITH WorkOrder AS (SELECT CAST(Work."key" AS INTEGER) AS position, Work.value AS workId FROM json_each(?1)AS Work), Criteria AS MATERIALIZED (SELECT CAST(Word."key" AS INTEGER) + 1 AS slot, IFNULL(json_extract(Word.value, \'\$.distance\'), 1000000) AS distance, CAST(json_extract(Word.value, \'\$.spellings\') AS TEXT) AS spellings, CAST(json_extract(Word.value, \'\$.macronSpellings\') AS TEXT) AS macronSpellings, CAST(json_extract(Word.value, \'\$.lemma\') AS TEXT) AS lemma, CAST(json_extract(Word.value, \'\$.partOfSpeech\') AS TEXT) AS partOfSpeech, CAST(json_extract(Word.value, \'\$.gramCase\') AS TEXT) AS gramCase, CAST(json_extract(Word.value, \'\$.number\') AS TEXT) AS number, CAST(json_extract(Word.value, \'\$.gender\') AS TEXT) AS gender, CAST(json_extract(Word.value, \'\$.person\') AS TEXT) AS person, CAST(json_extract(Word.value, \'\$.verbForm\') AS TEXT) AS verbForm, CAST(json_extract(Word.value, \'\$.tense\') AS TEXT) AS tense, CAST(json_extract(Word.value, \'\$.voice\') AS TEXT) AS voice FROM json_each(?2)AS Word), Spellings AS MATERIALIZED (SELECT Criteria.slot, Spelling.value AS form FROM Criteria,json_each(Criteria.spellings)AS Spelling), MacronSpellings AS MATERIALIZED (SELECT Criteria.slot, Spelling.value AS form FROM Criteria,json_each(Criteria.macronSpellings)AS Spelling), LemmaRefs AS MATERIALIZED (SELECT Criteria.slot, Ref.value AS dictionaryRef FROM Criteria,json_each(Criteria.lemma)AS Ref), Analysed AS MATERIALIZED (SELECT Criteria.slot, Analyses.form, Analyses.capitalizedForm FROM Criteria CROSS JOIN "concordance.Analyses" AS Analyses WHERE Criteria.spellings IS NULL AND(Criteria.lemma IS NULL OR Analyses.dictionaryRef IN (SELECT dictionaryRef FROM LemmaRefs WHERE LemmaRefs.slot = Criteria.slot))AND(Criteria.partOfSpeech IS NULL OR Analyses.partOfSpeech = Criteria.partOfSpeech)AND(Criteria.gramCase IS NULL OR instr(\'/\' || Analyses.gramCase || \'/\', \'/\' || Criteria.gramCase || \'/\') > 0)AND(Criteria.number IS NULL OR instr(\'/\' || Analyses.number || \'/\', \'/\' || Criteria.number || \'/\') > 0)AND(Criteria.gender IS NULL OR instr(\'/\' || Analyses.gender || \'/\', \'/\' || Criteria.gender || \'/\') > 0)AND(Criteria.person IS NULL OR instr(\'/\' || Analyses.person || \'/\', \'/\' || Criteria.person || \'/\') > 0)AND(Criteria.verbForm IS NULL OR instr(\'/\' || Analyses.verbForm || \'/\', \'/\' || Criteria.verbForm || \'/\') > 0)AND(Criteria.tense IS NULL OR instr(\'/\' || Analyses.tense || \'/\', \'/\' || Criteria.tense || \'/\') > 0)AND(Criteria.voice IS NULL OR instr(\'/\' || Analyses.voice || \'/\', \'/\' || Criteria.voice || \'/\') > 0)), Forms AS MATERIALIZED (SELECT slot, form FROM Spellings UNION ALL SELECT slot, form FROM Analysed), Hits AS (SELECT WorkOrder.position, t1.workId, t1.sentenceIdx, t1.sourceReference AS reference, t1.isTitle, t1.idx AS firstIdx, COALESCE(t3.idx, t2.idx, t1.idx) AS lastIdx, t1.wordIdx AS firstWordIdx, COALESCE(t3.wordIdx, t2.wordIdx, t1.wordIdx) AS lastWordIdx, t1.idx AS slot1Idx, t2.idx AS slot2Idx, t3.idx AS slot3Idx FROM WorkOrder CROSS JOIN WorkContents AS t1 LEFT OUTER JOIN WorkContents AS t2 ON EXISTS (SELECT * FROM Criteria WHERE slot = 2) AND t2.workId = t1.workId AND t2.sentenceIdx = t1.sentenceIdx AND t2.isTitle = t1.isTitle AND t2.wordIdx BETWEEN t1.wordIdx + 1 AND t1.wordIdx + (SELECT distance FROM Criteria WHERE slot = 2) AND t2.idx BETWEEN ?3 AND ?4 AND(t2.lookupForm IN (SELECT form FROM Forms WHERE slot = 2) OR t2.enclitic IN (SELECT form FROM Forms WHERE slot = 2) OR(t2.enclitic IS NOT NULL AND t2.baseNormForm IN (SELECT form FROM Spellings WHERE slot = 2))OR(t2.properNounState = 2 AND t2.lookupForm IN (SELECT capitalizedForm FROM Analysed WHERE slot = 2)))AND(NOT EXISTS (SELECT * FROM MacronSpellings WHERE slot = 2) OR t2.macronLookupForm IN (SELECT form FROM MacronSpellings WHERE slot = 2) OR t2.enclitic IN (SELECT form FROM MacronSpellings WHERE slot = 2) OR(t2.enclitic IS NOT NULL AND t2.macronBaseNormForm IN (SELECT form FROM MacronSpellings WHERE slot = 2)))LEFT OUTER JOIN WorkContents AS t3 ON EXISTS (SELECT * FROM Criteria WHERE slot = 3) AND t3.workId = t2.workId AND t3.sentenceIdx = t2.sentenceIdx AND t3.isTitle = t2.isTitle AND t3.wordIdx BETWEEN t2.wordIdx + 1 AND t2.wordIdx + (SELECT distance FROM Criteria WHERE slot = 3) AND t3.idx BETWEEN ?3 AND ?4 AND(t3.lookupForm IN (SELECT form FROM Forms WHERE slot = 3) OR t3.enclitic IN (SELECT form FROM Forms WHERE slot = 3) OR(t3.enclitic IS NOT NULL AND t3.baseNormForm IN (SELECT form FROM Spellings WHERE slot = 3))OR(t3.properNounState = 2 AND t3.lookupForm IN (SELECT capitalizedForm FROM Analysed WHERE slot = 3)))AND(NOT EXISTS (SELECT * FROM MacronSpellings WHERE slot = 3) OR t3.macronLookupForm IN (SELECT form FROM MacronSpellings WHERE slot = 3) OR t3.enclitic IN (SELECT form FROM MacronSpellings WHERE slot = 3) OR(t3.enclitic IS NOT NULL AND t3.macronBaseNormForm IN (SELECT form FROM MacronSpellings WHERE slot = 3)))WHERE t1.workId = WorkOrder.workId AND +t1.idx BETWEEN ?3 AND ?4 AND CASE ?5 WHEN \'only\' THEN t1.isTitle WHEN \'excluded\' THEN NOT t1.isTitle ELSE TRUE END AND(t1.lookupForm IN (SELECT form FROM Forms WHERE slot = 1) OR t1.enclitic IN (SELECT form FROM Forms WHERE slot = 1) OR(t1.enclitic IS NOT NULL AND t1.baseNormForm IN (SELECT form FROM Spellings WHERE slot = 1))OR(t1.properNounState = 2 AND t1.lookupForm IN (SELECT capitalizedForm FROM Analysed WHERE slot = 1)))AND(NOT EXISTS (SELECT * FROM MacronSpellings WHERE slot = 1) OR t1.macronLookupForm IN (SELECT form FROM MacronSpellings WHERE slot = 1) OR t1.enclitic IN (SELECT form FROM MacronSpellings WHERE slot = 1) OR(t1.enclitic IS NOT NULL AND t1.macronBaseNormForm IN (SELECT form FROM MacronSpellings WHERE slot = 1)))AND(t2.idx IS NOT NULL OR NOT EXISTS (SELECT * FROM Criteria WHERE slot = 2))AND(t3.idx IS NOT NULL OR NOT EXISTS (SELECT * FROM Criteria WHERE slot = 3))), Sorted AS (SELECT Hits.*, CASE ?6 WHEN \'followingWord\' THEN (SELECT LOWER(Neighbour.normForm) FROM WorkContents AS Neighbour WHERE Neighbour.workId = Hits.workId AND Neighbour.sentenceIdx = Hits.sentenceIdx AND Neighbour.isTitle = Hits.isTitle AND Neighbour.wordIdx = Hits.lastWordIdx + 1) WHEN \'precedingWord\' THEN (SELECT LOWER(Neighbour.normForm) FROM WorkContents AS Neighbour WHERE Neighbour.workId = Hits.workId AND Neighbour.sentenceIdx = Hits.sentenceIdx AND Neighbour.isTitle = Hits.isTitle AND Neighbour.wordIdx = Hits.firstWordIdx - 1) END AS sortKey FROM Hits), Page AS (SELECT Sorted.*, COUNT(*)OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS totalHits FROM Sorted ORDER BY Sorted.sortKey IS NULL, Sorted.sortKey, Sorted.position, Sorted.firstIdx, Sorted.lastIdx, Sorted.slot2Idx, Sorted.slot3Idx LIMIT ?7 OFFSET ?8) SELECT Page.*, Context.idx AS contextIdx, Context.word AS contextWord, Context.macronizedWord AS contextMacronizedWord, Context.sourceReference AS contextReference FROM Page CROSS JOIN WorkContents AS Context WHERE Context.workId = Page.workId AND Context.idx BETWEEN Page.firstIdx - 12 AND Page.lastIdx + 12 ORDER BY Page.sortKey IS NULL, Page.sortKey, Page.position, Page.firstIdx, Page.lastIdx, Page.slot2Idx, Page.slot3Idx, Context.idx',
      variables: [
        i0.Variable<String>(works),
        i0.Variable<String>(phrase),
        i0.Variable<int>(fromIdx),
        i0.Variable<int>(toIdx),
        i0.Variable<String>(titles),
        i0.Variable<String>(sort),
        i0.Variable<int>(limit),
        i0.Variable<int>(offset),
      ],
      readsFrom: {
        workContents,
        morphologicalDetails,
        morphologicalDetailInflections,
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
  i5.MorphologicalDetails get morphologicalDetails => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i5.MorphologicalDetails>('MorphologicalDetails');
  i6.LnsRefResolutions get lnsRefResolutions => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i6.LnsRefResolutions>('LnsRefResolutions');
  i6.DictionaryEntries get dictionaryEntries => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i6.DictionaryEntries>('DictionaryEntries');
  i6.Dictionaries get dictionaries => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i6.Dictionaries>('Dictionaries');
  i1.ConcordanceGrammarValues get concordanceGrammarValues =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i1.ConcordanceGrammarValues>('concordance.GrammarValues');
  i5.MorphologicalDetailInflections get morphologicalDetailInflections =>
      i2.ReadDatabaseContainer(
        attachedDatabase,
      ).resultSet<i5.MorphologicalDetailInflections>(
        'MorphologicalDetailInflections',
      );
  i1.ConcordanceAnalyses get concordanceAnalyses => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i1.ConcordanceAnalyses>('concordance.Analyses');
  i7.WorkContents get workContents => i2.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i7.WorkContents>('WorkContents');
  i7.LibraryDrift get libraryDrift => this.accessor(i7.LibraryDrift.new);
  i5.MorphAnalysisDrift get morphAnalysisDrift =>
      this.accessor(i5.MorphAnalysisDrift.new);
  i6.DictionaryDrift get dictionaryDrift =>
      this.accessor(i6.DictionaryDrift.new);
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
