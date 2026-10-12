import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../component/library/semivowel_spelling.dart';
import '../../../component/library/work_contents_api.dart';

SemivowelSpelling semivowelSpellingOf(WorkContentsSegment segment, SemivowelSpelling spelling) =>
    segment.isNumeral ? SemivowelSpelling.stored : spelling;

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
    required SemivowelSpelling semivowelSpelling,
  }) : this._(
         TextSpan(children: spans),
         Map.unmodifiable(Map.fromIterables(_textStartsOf(spans), segments)),
         showMacrons: showMacrons,
         semivowelSpelling: semivowelSpelling,
       );

  PageSegments._(
    this.text,
    this._byTextStart, {
    required this.showMacrons,
    required this.semivowelSpelling,
  }) : _plainText = text.toPlainText();

  const PageSegments.empty()
    : text = const TextSpan(text: ''),
      _plainText = '',
      _byTextStart = const {},
      showMacrons = false,
      semivowelSpelling = SemivowelSpelling.stored;

  /// The page's styled text.
  final TextSpan text;
  final String _plainText;
  final Map<int, WorkContentsSegment> _byTextStart;
  final bool showMacrons;
  final SemivowelSpelling semivowelSpelling;

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

  String shownText(WorkContentsSegment segment) {
    final word = showMacrons ? segment.macronizedWord : segment.word;
    return semivowelSpellingOf(segment, semivowelSpelling).respell(word);
  }

  static Iterable<int> _textStartsOf(List<TextSpan> spans) {
    final spanStarts = spans.fold(
      <int>[0],
      (starts, span) => starts..add(starts.last + span.toPlainText().length),
    );
    return spans.mapIndexed((i, span) => spanStarts[i] + (span.text?.length ?? 0));
  }

  //
}
