import 'package:flutter/foundation.dart';

/// The text typed in a search bar backed by an FTS5 index (morphology, dictionary entries), parsed
/// with the same rules for both:
///
/// - `*` or `%` matches any letters and `?` or `_` one letter; the rest must match exactly
/// - Text in quotes (`"sum"` or `'sum'`) must match exactly
/// - Text shorter than three characters must match exactly
/// - Any other text can appear anywhere in the value, punctuation and spaces included
/// - Where the values have macrons, typed ones must match, and text without macrons finds values
///   with or without them
///
/// The searches bind [query]. Searches without an index (library, dictionaries) find the text as
/// typed, anywhere, and don't use this
@immutable
class SearchTerm {
  factory SearchTerm(String text) {
    final trimmed = text.trim();
    final unquoted = _quoted.firstMatch(trimmed)?[2] ?? trimmed;
    final useLike = unquoted != trimmed || trimmed.contains(_wildcards) || trimmed.length < 3;
    return SearchTerm._(
      text: useLike ? unquoted.replaceAll('*', '%').replaceAll('?', '_') : trimmed,
      useLike: useLike,
      hasMacrons: trimmed.contains(_macrons),
    );
  }

  const SearchTerm._({
    required String text,
    required this.useLike,
    required this.hasMacrons,
  }) : _text = text;

  /// The `LIKE` pattern if [useLike], otherwise the text to find anywhere
  final String _text;

  /// Whether an FTS5 search must use `LIKE` instead of `MATCH`: wildcards, quotes, or fewer
  /// than three characters
  final bool useLike;

  /// Whether the text has macrons. If so, it's compared with the macronized values, macrons as
  /// typed; if not, with the values without their macrons. Where the values never have macrons,
  /// the typed ones are dropped ([withoutMacrons])
  final bool hasMacrons;

  /// The `LIKE` pattern if [useLike], otherwise the text in quotes for `MATCH`, so that FTS5
  /// doesn't read words like NOT as operators
  String get query => useLike ? _text : '"${_text.replaceAll('"', '""')}"';

  bool get isEmpty => _text.isEmpty;

  /// The same search with the macrons removed, for values that never have them
  SearchTerm get withoutMacrons => SearchTerm._(
    text: _text.replaceAllMapped(_macrons, (macron) => _plain[macron[0]]!),
    useLike: useLike,
    hasMacrons: false,
  );

  static final RegExp _quoted = RegExp(r'''^(["'])(.*)\1$''');
  static final RegExp _wildcards = RegExp('[*%?_]');
  static final RegExp _macrons = RegExp('[āēīōūȳĀĒĪŌŪȲ]');

  static const Map<String, String> _plain = {
    'ā': 'a', 'ē': 'e', 'ī': 'i', 'ō': 'o', 'ū': 'u', 'ȳ': 'y', //
    'Ā': 'A', 'Ē': 'E', 'Ī': 'I', 'Ō': 'O', 'Ū': 'U', 'Ȳ': 'Y',
  };

  @override
  String toString() => 'SearchTerm{text: $_text, useLike: $useLike}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchTerm &&
          other._text == _text &&
          other.useLike == useLike &&
          other.hasMacrons == hasMacrons);

  @override
  int get hashCode => Object.hash(_text, useLike, hasMacrons);
  //
}
