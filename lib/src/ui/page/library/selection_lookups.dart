import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../logger.dart';
import '../../../component/library/proper_noun_state.dart';
import '../../../component/library/punctuation.dart';
import '../../../component/library/work_contents_api.dart';

/// A lookup option with a label and an action.
typedef LookupChoice = ({String label, Future<void> Function() open});

/// A context menu button that replaces the selection toolbar with lookup choices.
class LookupMenuButton extends ContextMenuButtonItem {
  LookupMenuButton({
    required String label,
    required List<LookupChoice> choices,
    required Offset anchor,
    required BuildContext pageContext,
  }) : super(
         label: '$label ›',
         onPressed: () => _open(choices, anchor, pageContext),
       );

  static Future<void> _open(
    List<LookupChoice> choices,
    Offset anchor,
    BuildContext pageContext,
  ) async {
    //closing the toolbar disposes its context, so the menu uses the page's context
    ContextMenuController.removeAny();
    final overlay = Navigator.of(pageContext).overlay!.context.findRenderObject()! as RenderBox;
    final chosen = await showMenu<Future<void> Function()>(
      context: pageContext,
      position: RelativeRect.fromRect(
        overlay.globalToLocal(anchor) & Size.zero,
        Offset.zero & overlay.size,
      ),
      items: choices
          .map((choice) => PopupMenuItem(value: choice.open, child: Text(choice.label)))
          .toList(),
    );
    if (pageContext.mounted && chosen != null) {
      await chosen();
    }
  }

  //
}

/// Calls [open] with the result of [lookUp], or shows a lookup error with a Retry action.
/// Does neither if [pageContext] has been unmounted.
Future<void> lookUpThenOpen<T>(
  BuildContext pageContext, {
  required Future<T> Function() lookUp,
  required Future<void> Function(T found) open,
}) async {
  final found = await AsyncValue.guard(lookUp);
  if (pageContext.mounted && found is AsyncData<T>) {
    await open(found.value);
  } else if (pageContext.mounted && found is AsyncError<T>) {
    log.catching(found.error, stackTrace: found.stackTrace); // callback can fail outside a provider
    ScaffoldMessenger.of(pageContext).showSnackBar(
      SnackBar(
        content: const Text('Lookup failed'),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => lookUpThenOpen(pageContext, lookUp: lookUp, open: open),
        ),
      ),
    );
  }
}

/// Whether [macronizedForm] matches [macronized], including macrons.
/// Ignores case and treats `j` and `i` as equivalent.
///
/// Restores any missing suffix, such as an enclitic, from [form] before comparing.
bool isMacronizedAs(String macronized, {required String form, required String macronizedForm}) {
  final restOfForm = form.length > macronizedForm.length
      ? form.substring(macronizedForm.length)
      : '';
  return _comparable('$macronizedForm$restOfForm') == _comparable(macronized);
}

String _comparable(String spelling) => spelling.toLowerCase().replaceAll('j', 'i');

/// Wiktionary page names for [segment], based on its proper-noun state.
///
/// Without a state, follows the word's capitalization in the text. Includes
/// lowercase too when the word's position could explain the capital letter.
Set<String> wiktionaryPagesOf(
  WorkContentsSegment segment,
  Iterable<WorkContentsSegment> segments,
) => switch ((segment.baseNormForm, segment.properNounState)) {
  (null, _) => const <String>{},
  (final baseNormForm?, null) when _isCapitalized(segment.word) => {
    _capitalized(baseNormForm),
    if (_isCapitalizedByPosition(segment, segments)) baseNormForm,
  },
  (final baseNormForm?, final state) => spellingsToLookUp(baseNormForm, state),
};

/// Whether [segment]'s position could explain its capitalization.
///
/// Matches the first word of a line, a word after `.`, `!`, `?`, `:` or `—`,
/// or a word directly following a capitalized word.
bool _isCapitalizedByPosition(WorkContentsSegment segment, Iterable<WorkContentsSegment> segments) {
  final earlierOnItsLine = segments
      .where((other) => other.node == segment.node && other.idx < segment.idx)
      .toList()
      .reversed;
  final sincePreviousWord = earlierOnItsLine.takeWhile((other) => !_hasLetters(other.word));
  final previousWord = earlierOnItsLine.skip(sincePreviousWord.length).firstOrNull;
  return previousWord == null ||
      sincePreviousWord.any((other) => _capitalizingPunctSigns.contains(other.word)) ||
      (sincePreviousWord.isEmpty && _isCapitalized(previousWord.word));
}

const List<String> _capitalizingPunctSigns = [...sentenceBreakPunctSigns, '—'];

bool _hasLetters(String text) => text.toLowerCase() != text.toUpperCase();

bool _isCapitalized(String word) => word.isNotEmpty && word[0] != word[0].toLowerCase();

String _capitalized(String word) => '${word[0].toUpperCase()}${word.substring(1)}';
