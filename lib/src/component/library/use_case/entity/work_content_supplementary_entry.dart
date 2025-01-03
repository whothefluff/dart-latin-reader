import 'package:flutter/foundation.dart';

@immutable
class WorkContentSupplementaryEntry {
  const WorkContentSupplementaryEntry({
    required this.id,
    required this.fromIndex,
    required this.toIndex,
    required this.value,
  });

  final int id;
  final BigInt fromIndex;
  final BigInt toIndex;
  final String value;

  @override
  String toString() => 'WorkNote{value: $value}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkContentSupplementaryEntry &&
        other.id == id &&
        other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
//
}
