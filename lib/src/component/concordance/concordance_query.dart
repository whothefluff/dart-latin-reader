import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../core/value_list.dart';
import '../word_frequency/library_selection_api.dart' show LibrarySelection;

//domain

/// What the concordance looks for: up to [maxSlots] words, each one after the
/// previous in the same sentence, within the selected works
@immutable
class ConcordanceQuery {
  ConcordanceQuery({
    required Iterable<ConcordanceCriterion> slots,
    Iterable<int?> distances = const [],
    this.matchMacrons = false,
    this.selection = const LibrarySelection.empty(),
    this.part,
    this.titles = ConcordanceTitles.included,
    this.sort = ConcordanceSort.textOrder,
  }) : slots = ValueList(slots),
       distances = ValueList(distances);

  /// Reads a query written by [toJson]
  factory ConcordanceQuery.fromJson(String source) {
    final map = jsonDecode(source) as Map<String, Object?>;
    final part = map['part'] as Map<String, Object?>?;
    return ConcordanceQuery(
      slots: (map['slots']! as List).map(
        (slot) => ConcordanceCriterion.fromJsonMap(slot as Map<String, Object?>),
      ),
      distances: (map['distances']! as List).cast<int?>(),
      matchMacrons: map['macrons'] == true,
      selection: LibrarySelection.fromJsonMap(map['works']! as Map<String, Object?>),
      part: part == null ? null : WorkPart.fromJsonMap(part),
      titles: ConcordanceTitles.values.byName(map['titles']! as String),
      sort: ConcordanceSort.values.byName(map['sort']! as String),
    );
  }

  static const maxSlots = 3;

  /// The words of the phrase, in order
  final ValueList<ConcordanceCriterion> slots;

  /// How far each slot after the first may come after the previous one, in
  /// words: 1 is right after it, and null anywhere later in the same sentence.
  /// See [distanceBefore]
  final ValueList<int?> distances;

  /// Whether form criteria must also match the macrons they were typed with
  final bool matchMacrons;

  /// Works to search. Empty for the whole library
  final LibrarySelection selection;

  /// When set, only this part of one of the [selection]'s works is searched
  final WorkPart? part;

  final ConcordanceTitles titles;

  final ConcordanceSort sort;

  /// Whether it can be searched: one to [maxSlots] slots, none of them blank
  bool get isComplete =>
      slots.isNotEmpty && slots.length <= maxSlots && slots.every((slot) => slot.isComplete);

  /// How far [slot] may come after the previous one: its entry in
  /// [distances], or right after it when there's none. The first slot has no
  /// previous one
  int? distanceBefore(int slot) {
    assert(slot > 0, 'The first slot has nothing before it');
    return slot - 1 < distances.length ? distances[slot - 1] : 1;
  }

  /// Returns a copy that orders hits by [sort]
  ConcordanceQuery withSort(ConcordanceSort sort) => ConcordanceQuery(
    slots: slots,
    distances: distances,
    matchMacrons: matchMacrons,
    selection: selection,
    part: part,
    titles: titles,
    sort: sort,
  );

  /// Compact JSON, fit for a route parameter
  String toJson() => jsonEncode({
    'slots': slots.map((slot) => slot.toJsonMap()).toList(),
    'distances': distances.toList(),
    'macrons': matchMacrons,
    'works': selection.toJsonMap(),
    'part': part?.toJsonMap(),
    'titles': titles.name,
    'sort': sort.name,
  });

  @override
  String toString() =>
      'ConcordanceQuery{slots: $slots, distances: $distances, macrons: $matchMacrons, '
      'selection: $selection, part: $part, titles: ${titles.name}, sort: ${sort.name}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConcordanceQuery &&
          other.slots == slots &&
          other.distances == distances &&
          other.matchMacrons == matchMacrons &&
          other.selection == selection &&
          other.part == part &&
          other.titles == titles &&
          other.sort == sort);

  @override
  int get hashCode =>
      Object.hash(slots, distances, matchMacrons, selection, part, titles, sort);
  //
}

/// Whether titles (TITL subdivisions) are searched
enum ConcordanceTitles {
  /// Like the rest of the text, which is also how frequency counts them
  included,

  /// Only the text
  excluded,

  /// Only titles
  only,
}

enum ConcordanceSort {
  /// By work, then position in the work
  textOrder,

  /// Alphabetically by the word after the last slot
  followingWord,

  /// Alphabetically by the word before the first slot
  precedingWord,
}

/// What a single word of the phrase has to be
@immutable
sealed class ConcordanceCriterion {
  const ConcordanceCriterion();

  factory ConcordanceCriterion.fromJsonMap(Map<String, Object?> map) => switch (map) {
    {'form': final String text} => FormCriterion(text, exactCase: map['exactCase'] == true),
    {'grammar': final Map<String, Object?> grammar} => GrammarCriterion(
      GrammarFilter.fromJsonMap(grammar),
      lemma: switch (map['lemma']) {
        final Map<String, Object?> lemma => LemmaChoice.fromJsonMap(lemma),
        _ => null,
      },
    ),
    {'lemma': final Map<String, Object?> lemma} => LemmaCriterion(LemmaChoice.fromJsonMap(lemma)),
    _ => throw FormatException('Not a concordance criterion: $map'),
  };

  /// Whether there is something to search for
  bool get isComplete;

  Map<String, Object?> toJsonMap();
  //
}

/// A spelling, matched the way frequency counts words: as the word itself
/// (`populus` in populusque, `Marcus` for M.), as an enclitic (`que`), or as
/// written (`populusque`)
final class FormCriterion extends ConcordanceCriterion {
  const FormCriterion(
    this.text, {
    this.exactCase = false,
  });

  final String text;

  /// When false, a word matches whether it's capitalized (a proper noun) or
  /// not. When true, only the capitalization of [text] does
  final bool exactCase;

  @override
  bool get isComplete => text.trim().isNotEmpty;

  @override
  Map<String, Object?> toJsonMap() => {'form': text, if (exactCase) 'exactCase': true};

  @override
  String toString() => 'FormCriterion{text: $text, exactCase: $exactCase}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormCriterion && other.text == text && other.exactCase == exactCase);

  @override
  int get hashCode => Object.hash(text, exactCase);
  //
}

/// Any form one of whose analyses belongs to [lemma]
final class LemmaCriterion extends ConcordanceCriterion {
  const LemmaCriterion(
    this.lemma,
  );

  final LemmaChoice lemma;

  @override
  bool get isComplete => true;

  @override
  Map<String, Object?> toJsonMap() => {'lemma': lemma.toJsonMap()};

  @override
  String toString() => 'LemmaCriterion{lemma: $lemma}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LemmaCriterion && other.lemma == lemma);

  @override
  int get hashCode => lemma.hashCode;
  //
}

/// Any form with an analysis that has every value in [grammar] (and belongs
/// to [lemma], when given)
final class GrammarCriterion extends ConcordanceCriterion {
  const GrammarCriterion(
    this.grammar, {
    this.lemma,
  });

  final GrammarFilter grammar;
  final LemmaChoice? lemma;

  @override
  bool get isComplete => !grammar.isEmpty || lemma != null;

  @override
  Map<String, Object?> toJsonMap() => {
    'grammar': grammar.toJsonMap(),
    'lemma': ?lemma?.toJsonMap(),
  };

  @override
  String toString() => 'GrammarCriterion{grammar: $grammar, lemma: $lemma}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrammarCriterion && other.grammar == grammar && other.lemma == lemma);

  @override
  int get hashCode => Object.hash(grammar, lemma);
  //
}

/// A lemma as the user picks it: one dictionary entry, which may stand for
/// several dictionaryRefs of the analyses (ad-tingo and attingo are attingo)
@immutable
class LemmaChoice {
  LemmaChoice({
    required this.label,
    required Iterable<String> dictionaryRefs,
    this.partOfSpeech,
    this.inflection,
  }) : dictionaryRefs = ValueList(dictionaryRefs.toSet().sorted((a, b) => a.compareTo(b)));

  LemmaChoice.fromSql({
    required String? label,
    required String? dictionaryRefs,
    String? partOfSpeech,
    String? inflection,
  }) : this(
         label: label ?? '',
         // same separator as GROUP_CONCAT's default
         dictionaryRefs: (dictionaryRefs ?? '').split(',').where((ref) => ref.isNotEmpty),
         partOfSpeech: partOfSpeech,
         inflection: inflection,
       );

  LemmaChoice.fromJsonMap(
    Map<String, Object?> map,
  ) : this(
        label: map['label']! as String,
        dictionaryRefs: (map['refs']! as List).cast<String>(),
        partOfSpeech: map['pos'] as String?,
        inflection: map['inflection'] as String?,
      );

  /// The Lewis & Short lemma, or the analyses' dictionaryRef when there's no
  /// entry for it. Homograph digits included (sum1)
  final String label;

  final ValueList<String> dictionaryRefs;

  /// From the dictionary entry, to tell homographs apart
  final String? partOfSpeech;
  final String? inflection;

  Map<String, Object?> toJsonMap() => {
    'label': label,
    'refs': dictionaryRefs.toList(),
    'pos': ?partOfSpeech,
    'inflection': ?inflection,
  };

  @override
  String toString() => 'LemmaChoice{label: $label, refs: $dictionaryRefs}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LemmaChoice && other.dictionaryRefs == dictionaryRefs);

  @override
  int get hashCode => dictionaryRefs.hashCode;
  //
}

/// A grammatical feature of an analysis. The name is its column in
/// "concordance.Analyses"
enum GrammarFeature {
  partOfSpeech,
  gramCase,
  number,
  gender,
  person,
  verbForm,
  tense,
  voice,
}

/// Required values of grammatical features. A feature without a value can be
/// anything
@immutable
class GrammarFilter {
  GrammarFilter(
    Map<GrammarFeature, String> values,
  ) : values = UnmodifiableMapView(
        Map.fromEntries(values.entries.where((entry) => entry.value.isNotEmpty)),
      );

  const GrammarFilter.empty() : values = const {};

  GrammarFilter.fromJsonMap(
    Map<String, Object?> map,
  ) : this(
        map.map((name, value) => MapEntry(GrammarFeature.values.byName(name), value! as String)),
      );

  final Map<GrammarFeature, String> values;

  static const _equality = MapEquality<GrammarFeature, String>();

  bool get isEmpty => values.isEmpty;

  /// Returns a copy that requires [value] for [feature], or anything when null
  GrammarFilter withValue(GrammarFeature feature, String? value) =>
      GrammarFilter({...values, feature: value ?? ''});

  Map<String, Object?> toJsonMap() => values.map((feature, value) => MapEntry(feature.name, value));

  @override
  String toString() => 'GrammarFilter{${values.entries.map((e) => '${e.key.name}: ${e.value}')}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is GrammarFilter && _equality.equals(other.values, values));

  @override
  int get hashCode => _equality.hash(values);
  //
}

/// A titled subdivision of a work (a book, a poem...)
@immutable
class WorkPart {
  const WorkPart({
    required this.workId,
    required this.fromIndex,
    required this.toIndex,
    required this.label,
  });

  WorkPart.fromJsonMap(
    Map<String, Object?> map,
  ) : this(
        workId: map['work']! as String,
        fromIndex: map['from']! as int,
        toIndex: map['to']! as int,
        label: map['label']! as String,
      );

  final String workId;

  /// First token. Inclusive
  final int fromIndex;

  /// Last token. Inclusive
  final int toIndex;

  final String label;

  Map<String, Object?> toJsonMap() => {
    'work': workId,
    'from': fromIndex,
    'to': toIndex,
    'label': label,
  };

  @override
  String toString() => 'WorkPart{label: $label, $fromIndex–$toIndex}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkPart &&
          other.workId == workId &&
          other.fromIndex == fromIndex &&
          other.toIndex == toIndex);

  @override
  int get hashCode => Object.hash(workId, fromIndex, toIndex);
  //
}
