import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/subdivision_type.dart';
import 'package:latin_reader/src/component/library/work_contents_api.dart';
import 'package:latin_reader/src/ui/page/library/page_segments.dart';

WorkContentsSegment _segment(int idx, String word, {String? macronized}) => WorkContentsSegment(
  workId: 'fables',
  parent: null,
  node: 'verse',
  idx: idx,
  word: word,
  macronizedWord: macronized ?? word,
  uncertaintyBitMask: 0,
  typ: SubdivisionType.verse,
  depth: 1,
  lookupForm: word,
  macronLookupForm: macronized ?? word,
  baseNormForm: word,
  properNounState: null,
  sourceReference: '1',
);

/// A page with two verses, each preceded by a line break, and no spaces before punctuation.
PageSegments _page({required bool showMacrons}) {
  final laidOut = [
    (_segment(10, 'Lupus'), before: '\n', after: ' '),
    (_segment(11, 'et'), before: '', after: ' '),
    (_segment(12, 'agnus'), before: '', after: ''),
    (_segment(13, ','), before: '', after: ' '),
    (_segment(14, 'et'), before: '\n', after: ' '),
    (_segment(15, 'venerunt', macronized: 'vēnērunt'), before: '', after: ''),
    (_segment(16, '.'), before: '', after: ''),
  ];
  return PageSegments(
    laidOut
        .map(
          (entry) => TextSpan(
            text: entry.before,
            children: [
              TextSpan(text: showMacrons ? entry.$1.macronizedWord : entry.$1.word),
              TextSpan(text: entry.after),
            ],
          ),
        )
        .toList(),
    laidOut.map((entry) => entry.$1),
    showMacrons: showMacrons,
  );
}

/// A selection covering occurrence [occurrence] of [text] on [page], counting from zero.
TextSelection _select(PageSegments page, String text, {int occurrence = 0}) {
  final match = text.allMatches(page.text.toPlainText()).elementAt(occurrence);
  return TextSelection(baseOffset: match.start, extentOffset: match.end);
}

void main() {
  group('PageSegments.selectedSegment', () {
    final page = _page(showMacrons: false);

    test('a word is found where it was selected, not where its text first appears', () {
      expect(page.selectedSegment(_select(page, 'et'))?.idx, 11);
      expect(page.selectedSegment(_select(page, 'et', occurrence: 1))?.idx, 14);
    });

    test('the first word after the page-start break is found', () {
      expect(page.selectedSegment(_select(page, 'Lupus'))?.idx, 10);
    });

    test('spaces around the word are ignored', () {
      expect(page.selectedSegment(_select(page, ' et '))?.idx, 11);
    });

    test('part of a word, two words or a word with its punctuation select no segment', () {
      expect(page.selectedSegment(_select(page, 'gnus')), isNull);
      expect(page.selectedSegment(_select(page, 'et agnus')), isNull);
      expect(page.selectedSegment(_select(page, 'agnus,')), isNull);
    });

    test('an empty selection or one past the page selects no segment', () {
      expect(page.selectedSegment(const TextSelection.collapsed(offset: 2)), isNull);
      expect(page.selectedSegment(const TextSelection(baseOffset: 40, extentOffset: 45)), isNull);
    });

    test('a word is found by the text shown, with or without macrons', () {
      final withMacrons = _page(showMacrons: true);

      expect(withMacrons.selectedSegment(_select(withMacrons, 'vēnērunt'))?.idx, 15);
      expect(page.selectedSegment(_select(page, 'venerunt'))?.idx, 15);
      expect(withMacrons.selectedSegment(_select(withMacrons, 'et', occurrence: 1))?.idx, 14);
    });
  });
}
