import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'concordance_query.dart';

//infrastructure

/// Search parameters for a concordance query
///
/// The query only compares: typed text is normalized here, into every
/// spelling the match columns can have for it
@immutable
class ConcordanceParameters {
  /// [workIds] in the order of the hits, never empty
  factory ConcordanceParameters.of(ConcordanceQuery query, List<String> workIds) {
    assert(workIds.isNotEmpty, 'Nothing to search in');
    assert(query.isComplete, 'Incomplete query $query');
    final part = query.part;
    final phrase = query.slots.mapIndexed(
      (i, criterion) => _word(
        criterion,
        distance: i == 0 ? null : query.distanceBefore(i),
        matchMacrons: query.matchMacrons,
      ),
    );
    return ConcordanceParameters._(
      works: jsonEncode(workIds),
      phrase: jsonEncode(phrase.toList()),
      fromIdx: part?.fromIndex ?? 0,
      toIdx: part?.toIndex ?? _pastAnyToken,
      titles: query.titles.name,
      sort: query.sort.name,
      workCount: workIds.length,
    );
  }

  const ConcordanceParameters._({
    required this.works,
    required this.phrase,
    required this.fromIdx,
    required this.toIdx,
    required this.titles,
    required this.sort,
    required int workCount,
  }) : _workCount = workCount;

  /// JSON array of work IDs
  final String works;

  /// JSON array with an object per word
  final String phrase;

  final int fromIdx;
  final int toIdx;

  /// A [ConcordanceTitles] by name
  final String titles;

  /// A [ConcordanceSort] by name
  final String sort;

  final int _workCount;

  /// The whole work, when there's no part
  static const _pastAnyToken = 0x7FFFFFFF;

  /// For the log: the phrase in full, the rest in short
  @override
  String toString() =>
      'ConcordanceParameters{phrase: $phrase, $_workCount works, idx: $fromIdx-$toIdx, '
      'titles: $titles, sort: $sort}';
  //
}

/// One word of the phrase: how far after the previous one it may be, and
/// either how it can be spelled or what its analyses must have
Map<String, Object> _word(
  ConcordanceCriterion criterion, {
  required int? distance,
  required bool matchMacrons,
}) => {
  'distance': ?distance,
  ...switch (criterion) {
    FormCriterion(:final text, :final exactCase) => _spelled(
      _typed(text),
      exactCase: exactCase,
      matchMacrons: matchMacrons,
    ),
    LemmaCriterion(:final lemma) => _analysed(lemma, const GrammarFilter.empty()),
    GrammarCriterion(:final grammar, :final lemma) => _analysed(lemma, grammar),
  },
};

/// Every spelling [text] matches, without macrons, and with them too when
/// they have to match
Map<String, Object> _spelled(
  String text, {
  required bool exactCase,
  required bool matchMacrons,
}) => {
  'spellings': [..._spellings(_withoutMacrons(text), exactCase: exactCase)],
  if (matchMacrons) 'macronSpellings': [..._spellings(text, exactCase: exactCase)],
};

/// The lemma (any when null) and the values of [grammar], by feature name
Map<String, Object> _analysed(LemmaChoice? lemma, GrammarFilter grammar) => {
  if (lemma != null) 'lemma': [...lemma.dictionaryRefs],
  ...grammar.values.map((feature, value) => MapEntry(feature.name, value)),
};

/// The spellings [text] matches in the match columns, whose casing is either
/// all lowercase or capitalized (see WorkContents.normForm)
Set<String> _spellings(String text, {required bool exactCase}) {
  final head = text.isEmpty ? '' : text.substring(0, 1);
  final lowercase = text.toLowerCase();
  final capitalized = '${head.toUpperCase()}${text.substring(head.length).toLowerCase()}';
  final typedCapitalized = head != head.toLowerCase();
  return exactCase ? {if (typedCapitalized) capitalized else lowercase} : {lowercase, capitalized};
}

/// [text] as typed, in the alphabet of the match columns: macrons as single
/// characters, no breves, no ligatures
String _typed(String text) => text
    .trim()
    .replaceAllMapped(
      RegExp('([aeiouyAEIOUY])\u0304'),
      (match) => _macronized[match[1]]!,
    )
    .replaceAll('\u0306', '') // combining breve
    .replaceAllMapped(RegExp('[ăĕĭŏŭĂĔĬŎŬ]'), (match) => _unbreved[match[0]]!)
    .replaceAll('æ', 'ae')
    .replaceAll('Æ', 'Ae')
    .replaceAll('œ', 'oe')
    .replaceAll('Œ', 'Oe');

String _withoutMacrons(String text) =>
    text.replaceAllMapped(RegExp('[āēīōūȳĀĒĪŌŪȲ]'), (match) => _unmacronized[match[0]]!);

const Map<String, String> _macronized = {
  'a': 'ā', 'e': 'ē', 'i': 'ī', 'o': 'ō', 'u': 'ū', 'y': 'ȳ', //
  'A': 'Ā', 'E': 'Ē', 'I': 'Ī', 'O': 'Ō', 'U': 'Ū', 'Y': 'Ȳ',
};

const Map<String, String> _unmacronized = {
  'ā': 'a', 'ē': 'e', 'ī': 'i', 'ō': 'o', 'ū': 'u', 'ȳ': 'y', //
  'Ā': 'A', 'Ē': 'E', 'Ī': 'I', 'Ō': 'O', 'Ū': 'U', 'Ȳ': 'Y',
};

const Map<String, String> _unbreved = {
  'ă': 'a', 'ĕ': 'e', 'ĭ': 'i', 'ŏ': 'o', 'ŭ': 'u', //
  'Ă': 'A', 'Ĕ': 'E', 'Ĭ': 'I', 'Ŏ': 'O', 'Ŭ': 'U',
};
