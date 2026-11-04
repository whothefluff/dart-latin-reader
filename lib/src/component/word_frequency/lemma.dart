import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';

/// A lemma as frequency counts it, by dictionaryRef and sublemma ('' for the entry's own lemma).
typedef Lemma = ({String dictionaryRef, String sublemma});

@immutable
extension type const Lemmas._(UnmodifiableListView<Lemma> unm)
    implements UnmodifiableListView<Lemma> {
  Lemmas(
    Iterable<Lemma> iter,
  ) : this._(UnmodifiableListView(iter));

  /// Reads a JSON array of `[dictionaryRef, sublemma]` pairs.
  Lemmas.fromSql(
    String column,
  ) : this((jsonDecode(column) as List).map(_lemmaOf));

  static Lemma _lemmaOf(Object? pair) => switch (pair) {
    [final String dictionaryRef, final String sublemma] => (
      dictionaryRef: dictionaryRef,
      sublemma: sublemma,
    ),
    _ => throw FormatException('Not a dictionaryRef and a sublemma: $pair'),
  };
}
