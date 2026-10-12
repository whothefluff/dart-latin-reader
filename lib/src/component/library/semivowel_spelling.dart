import 'package:drift/drift.dart' show TypeConverter;
import 'package:flutter/foundation.dart' show immutable;

//infrastructure

class SemivowelLettersConverter extends TypeConverter<SemivowelLetters, String> {
  const SemivowelLettersConverter(
    this._vowelLetter,
    this._semivowelLetter,
  );

  final String _vowelLetter;
  final String _semivowelLetter;

  @override
  SemivowelLetters fromSql(String fromDb) => SemivowelLetters.fromLetters(fromDb);

  @override
  String toSql(SemivowelLetters value) => switch (value) {
    SemivowelLetters.both => '$_vowelLetter$_semivowelLetter',
    SemivowelLetters.vowelLetterOnly => _vowelLetter,
    SemivowelLetters.semivowelLetterOnly => _semivowelLetter,
  };
  //
}

//domain

enum SemivowelLetters {
  both,
  vowelLetterOnly,
  semivowelLetterOnly;

  factory SemivowelLetters.fromLetters(String letters) => switch (letters.toLowerCase()) {
    'uv' || 'ij' => both,
    'u' || 'i' => vowelLetterOnly,
    'v' || 'j' => semivowelLetterOnly,
    _ => throw StateError('Not semivowel letters: "$letters"'),
  };
}

@immutable
class SemivowelSpelling {
  const SemivowelSpelling({
    required this.uvLowercase,
    required this.uvCapitals,
    required this.ijLowercase,
    required this.ijCapitals,
  });

  static const stored = SemivowelSpelling(
    uvLowercase: SemivowelLetters.both,
    uvCapitals: SemivowelLetters.both,
    ijLowercase: SemivowelLetters.both,
    ijCapitals: SemivowelLetters.both,
  );

  final SemivowelLetters uvLowercase;
  final SemivowelLetters uvCapitals;
  final SemivowelLetters ijLowercase;
  final SemivowelLetters ijCapitals;

  /// Respells [text] from the [stored] spelling into this one.
  String respell(String text) => respellEach(text).join();

  /// Respells each character of [text] from the [stored] spelling into this one.
  ///
  /// A long vowel written with a semivowel letter takes a combining macron: `ū` becomes `v̄`.
  List<String> respellEach(String text) =>
      text.runes.map((rune) => _respelled(String.fromCharCode(rune))).toList();

  String _respelled(String letter) => switch (letter) {
    'v' when uvLowercase == SemivowelLetters.vowelLetterOnly => 'u',
    'u' when uvLowercase == SemivowelLetters.semivowelLetterOnly => 'v',
    'ū' when uvLowercase == SemivowelLetters.semivowelLetterOnly => 'v̄',
    'V' when uvCapitals == SemivowelLetters.vowelLetterOnly => 'U',
    'U' when uvCapitals == SemivowelLetters.semivowelLetterOnly => 'V',
    'Ū' when uvCapitals == SemivowelLetters.semivowelLetterOnly => 'V̄',
    'j' when ijLowercase == SemivowelLetters.vowelLetterOnly => 'i',
    'i' when ijLowercase == SemivowelLetters.semivowelLetterOnly => 'j',
    'ī' when ijLowercase == SemivowelLetters.semivowelLetterOnly => 'j̄',
    'J' when ijCapitals == SemivowelLetters.vowelLetterOnly => 'I',
    'I' when ijCapitals == SemivowelLetters.semivowelLetterOnly => 'J',
    'Ī' when ijCapitals == SemivowelLetters.semivowelLetterOnly => 'J̄',
    _ => letter,
  };

  @override
  String toString() =>
      'SemivowelSpelling{uvLowercase: $uvLowercase, uvCapitals: $uvCapitals, '
      'ijLowercase: $ijLowercase, ijCapitals: $ijCapitals}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemivowelSpelling &&
          other.uvLowercase == uvLowercase &&
          other.uvCapitals == uvCapitals &&
          other.ijLowercase == ijLowercase &&
          other.ijCapitals == ijCapitals);

  @override
  int get hashCode => Object.hash(uvLowercase, uvCapitals, ijLowercase, ijCapitals);
  //
}
