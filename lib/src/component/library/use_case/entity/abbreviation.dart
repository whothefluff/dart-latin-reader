import 'package:flutter/foundation.dart';

@immutable
class Abbreviation {
  const Abbreviation({
    required this.value,
  });

  final String value;

  @override
  String toString() => 'Abbreviation{value: $value}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Abbreviation && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
//
}
