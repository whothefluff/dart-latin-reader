import 'package:flutter/foundation.dart';

@immutable
class SemivowelSearchRules {
  const SemivowelSearchRules({
    required this.iFindsJ,
    required this.uFindsV,
  });

  final bool iFindsJ;
  final bool uFindsV;

  /// Whether [stored] matches [typed] under these semivowel search rules.
  bool allows(String typed, String stored) =>
      typed.length == stored.length &&
      Iterable<int>.generate(typed.length).every((i) => _allowsLetter(typed[i], stored[i]));

  bool _allowsLetter(String typed, String stored) =>
      typed == stored ||
      (iFindsJ && ((typed == 'i' && stored == 'j') || (typed == 'I' && stored == 'J'))) ||
      (uFindsV && ((typed == 'u' && stored == 'v') || (typed == 'U' && stored == 'V')));

  SemivowelSearchRules copyWith({
    bool? iFindsJ,
    bool? uFindsV,
  }) => SemivowelSearchRules(
    iFindsJ: iFindsJ ?? this.iFindsJ,
    uFindsV: uFindsV ?? this.uFindsV,
  );

  @override
  String toString() => 'SemivowelSearch{iFindsJ: $iFindsJ, uFindsV: $uFindsV}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemivowelSearchRules && other.iFindsJ == iFindsJ && other.uFindsV == uFindsV);

  @override
  int get hashCode => Object.hash(iFindsJ, uFindsV);
  //
}

/// Returns [text] with `j` written as `i` and `v` written as `u`.
String toVowelLetters(String text) =>
    text.replaceAll('j', 'i').replaceAll('J', 'I').replaceAll('v', 'u').replaceAll('V', 'U');
