import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../component/library/semivowel_orthography.dart';
import '../../../component/library/subdivision_type.dart';
import '../../../component/library/work_contents_api.dart';

SemivowelOrthography semivowelOrthographyOf(
  WorkContentsSegment segment,
  SemivowelOrthography orthography,
) => segment.isNumeral ? SemivowelOrthography.allVocalicConsonantal : orthography;

/// The acute that marks the ictus, written after the letter that it goes on.
const _ictusMark = '\u0301';

/// Returns one string for each stored character of [segment], as the text shows it: with or
/// without macrons, in [orthography], and with the acute of the ictus where the edition prints
/// one, when [showIctus] is set.
List<String> shownLetters(
  WorkContentsSegment segment,
  SemivowelOrthography orthography, {
  required bool showMacrons,
  required bool showIctus,
}) {
  final word = showMacrons ? segment.macronizedWord : segment.word;
  final ictusBitMask = showIctus ? segment.ictusBitMask : 0;
  return semivowelOrthographyOf(segment, orthography)
      .respellEach(word)
      .mapIndexed((i, letter) => ((ictusBitMask >> i) & 1) != 0 ? '$letter$_ictusMark' : letter)
      .toList();
}

/// Returns how many line breaks go before [segment], which comes after [previous].
///
/// The next word of a verse or title stays on the same line, and the next verse starts a new line.
/// Where one kind of block follows another, as the verses after a title do, the new kind decides
int lineBreaksBefore(WorkContentsSegment? previous, WorkContentsSegment segment) {
  final lineBreaks = previous != null && segment.typ != previous.typ
      ? _lineBreaksBefore(segment.typ)
      : (segment.node != previous?.node ? 1 : 0);
  final pieceLineBreaks = _lineBreaksBefore(SubdivisionType.poem);
  return _belongsToAnotherPiece(previous, segment) ? max(lineBreaks, pieceLineBreaks) : lineBreaks;
}

/// Returns how many line breaks go before a block of [type] when the block before it is of
/// another kind.
int _lineBreaksBefore(SubdivisionType type) => switch (type) {
  SubdivisionType.book => 3,
  SubdivisionType.act => 3,
  SubdivisionType.prologue => 2,
  SubdivisionType.epilogue => 2,
  SubdivisionType.poem => 2,
  SubdivisionType.chapter => 2,
  SubdivisionType.scene => 2,
  SubdivisionType.section => 1,
  SubdivisionType.lineGroup => 1,
  SubdivisionType.speech => 1,
  SubdivisionType.title => 1,
  SubdivisionType.verse => 1,
  SubdivisionType.paragraph => 1,
};

/// True when [segment] belongs to another poem, prologue, epilogue, chapter or scene than
/// [previous].
bool _belongsToAnotherPiece(WorkContentsSegment? previous, WorkContentsSegment segment) =>
    switch (previous?.piece) {
      final piece? => piece != segment.piece,
      null => false,
    };

/// A page's rendered text and its source segments.
@immutable
class PageSegments {
  /// [spans] and [segments] must have the same length and order.
  /// Each span's [TextSpan.text] contains only preceding line breaks;
  /// its children contain the segment's text.
  PageSegments(
    List<TextSpan> spans,
    Iterable<WorkContentsSegment> segments, {
    required bool showMacrons,
    required bool showIctus,
    required SemivowelOrthography semivowelOrthography,
  }) : this._(
         TextSpan(children: spans),
         Map.unmodifiable(Map.fromIterables(_textStartsOf(spans), segments)),
         showMacrons: showMacrons,
         showIctus: showIctus,
         semivowelOrthography: semivowelOrthography,
       );

  PageSegments._(
    this.text,
    this._byTextStart, {
    required this.showMacrons,
    required this.showIctus,
    required this.semivowelOrthography,
  }) : _plainText = text.toPlainText();

  const PageSegments.empty()
    : text = const TextSpan(text: ''),
      _plainText = '',
      _byTextStart = const {},
      showMacrons = false,
      showIctus = false,
      semivowelOrthography = SemivowelOrthography.allVocalicConsonantal;

  /// The page's styled text.
  final TextSpan text;
  final String _plainText;
  final Map<int, WorkContentsSegment> _byTextStart;
  final bool showMacrons;
  final bool showIctus;
  final SemivowelOrthography semivowelOrthography;

  /// Returns the segment whose full text is selected, or `null` if there is no exact match.
  /// Ignores surrounding whitespace.
  WorkContentsSegment? selectedSegment(TextSelection selection) {
    final selected = selection.isValid && selection.end <= _plainText.length
        ? selection.textInside(_plainText).trim()
        : '';
    final segment = selected.isEmpty
        ? null
        : _byTextStart[_plainText.indexOf(selected, selection.start)];
    return segment != null && shownText(segment) == selected ? segment : null;
  }

  String shownText(WorkContentsSegment segment) => shownLetters(
    segment,
    semivowelOrthography,
    showMacrons: showMacrons,
    showIctus: showIctus,
  ).join();

  static Iterable<int> _textStartsOf(List<TextSpan> spans) {
    final spanStarts = spans.fold(
      <int>[0],
      (starts, span) => starts..add(starts.last + span.toPlainText().length),
    );
    return spans.mapIndexed((i, span) => spanStarts[i] + (span.text?.length ?? 0));
  }

  //
}
