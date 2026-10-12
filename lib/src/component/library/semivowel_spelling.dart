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
