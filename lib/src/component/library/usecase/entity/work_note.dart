abstract interface class WorkNote {
  WorkNote({
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
  String toString() {
    return 'WorkNote{value: $value}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkNote && other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
//
}
