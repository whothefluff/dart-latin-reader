import 'package:flutter/foundation.dart';

/// Represents a part of the contents of a work as seen from the library page
@immutable
class WorkContentsElementView {
  const WorkContentsElementView({
    required this.id,
    required this.parent,
    required this.node,
    required this.idx,
    required this.word,
    required this.typ,
    required this.depth,
    required this.sourceReference,
  });

  final String id;
  final String? parent;
  final String node;
  final int idx;
  final String word;
  final String typ;
  final int depth;
  final String sourceReference;

  @override
  String toString() => 'WorkContentsElementView{work: $word, index: $idx}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkContentsElementView && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
