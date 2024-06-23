abstract interface class Abbreviation {
  Abbreviation({
    required this.value,
  });

  final String value;

  @override
  String toString() {
    return 'Abbreviation{value: $value}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Abbreviation && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
//
}
