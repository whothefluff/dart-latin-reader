class WorkContentsSegment {
  WorkContentsSegment({
    required this.index,
    required this.value,
    required this.sourceReference,
  });

  final BigInt index;
  final String value;
  final String sourceReference;

  @override
  String toString() {
    return 'WorkContentsSegment{ref: $sourceReference, idx: $index}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkContentsSegment &&
        other.sourceReference == sourceReference &&
        other.index == index;
  }

  @override
  int get hashCode => sourceReference.hashCode ^ index.hashCode;
//
}
