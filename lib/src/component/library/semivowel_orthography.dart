import 'package:drift/drift.dart' show TypeConverter;
import 'package:flutter/foundation.dart' show immutable;

//infrastructure

class SemivowelsConverter extends TypeConverter<SemivowelForm, String> {
  const SemivowelsConverter(
    this._vocalicGrapheme,
    this._consonantalGrapheme,
  );

  final String _vocalicGrapheme;
  final String _consonantalGrapheme;

  @override
  SemivowelForm fromSql(String fromDb) => SemivowelForm.fromIndicator(fromDb);

  @override
  String toSql(SemivowelForm value) => switch (value) {
    SemivowelForm.vocalicConsonantal => '$_vocalicGrapheme$_consonantalGrapheme',
    SemivowelForm.vocalic => _vocalicGrapheme,
    SemivowelForm.consonantal => _consonantalGrapheme,
  };
  //
}

//domain

enum SemivowelForm {
  vocalicConsonantal,
  vocalic,
  consonantal;

  factory SemivowelForm.fromIndicator(String graphemes) => switch (graphemes.toLowerCase()) {
    'uv' || 'ij' => vocalicConsonantal,
    'u' || 'i' => vocalic,
    'v' || 'j' => consonantal,
    _ => throw StateError('Not semivowel letters: "$graphemes"'),
  };
}

@immutable
class SemivowelOrthography {
  const SemivowelOrthography({
    required this.uvLowercase,
    required this.uvCapitals,
    required this.ijLowercase,
    required this.ijCapitals,
  });

  static const allVocalicConsonantal = SemivowelOrthography(
    uvLowercase: SemivowelForm.vocalicConsonantal,
    uvCapitals: SemivowelForm.vocalicConsonantal,
    ijLowercase: SemivowelForm.vocalicConsonantal,
    ijCapitals: SemivowelForm.vocalicConsonantal,
  );

  final SemivowelForm uvLowercase;
  final SemivowelForm uvCapitals;
  final SemivowelForm ijLowercase;
  final SemivowelForm ijCapitals;

  /// Respells [text] from the [allVocalicConsonantal] spelling into this one.
  String respell(String text) => respellEach(text).join();

  /// Respells each Unicode code point of [text] from the [allVocalicConsonantal] spelling into this one.
  List<String> respellEach(String text) =>
      text.runes.map((rune) => _respelled(String.fromCharCode(rune))).toList();

  String _respelled(String letter) => switch (letter) {
    'v' when uvLowercase == SemivowelForm.vocalic => 'u',
    'u' when uvLowercase == SemivowelForm.consonantal => 'v',
    'ū' when uvLowercase == SemivowelForm.consonantal => 'v̄',
    'V' when uvCapitals == SemivowelForm.vocalic => 'U',
    'U' when uvCapitals == SemivowelForm.consonantal => 'V',
    'Ū' when uvCapitals == SemivowelForm.consonantal => 'V̄',
    'j' when ijLowercase == SemivowelForm.vocalic => 'i',
    'i' when ijLowercase == SemivowelForm.consonantal => 'j',
    'ī' when ijLowercase == SemivowelForm.consonantal => 'j̄',
    'J' when ijCapitals == SemivowelForm.vocalic => 'I',
    'I' when ijCapitals == SemivowelForm.consonantal => 'J',
    'Ī' when ijCapitals == SemivowelForm.consonantal => 'J̄',
    _ => letter,
  };

  @override
  String toString() =>
      'SemivowelOrthography{'
      'uvLowercase: $uvLowercase, '
      'uvCapitals: $uvCapitals, '
      'ijLowercase: $ijLowercase, '
      'ijCapitals: $ijCapitals}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemivowelOrthography &&
          other.uvLowercase == uvLowercase &&
          other.uvCapitals == uvCapitals &&
          other.ijLowercase == ijLowercase &&
          other.ijCapitals == ijCapitals);

  @override
  int get hashCode => Object.hash(uvLowercase, uvCapitals, ijLowercase, ijCapitals);
  //
}
