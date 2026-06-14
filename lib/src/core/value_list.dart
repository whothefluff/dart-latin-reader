import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/// A **read-only** list view that compares its contents by value
@immutable
class ValueList<T> extends UnmodifiableListView<T> {
  ValueList(
    Iterable<T> source,
  ) : super(source.toList(growable: false));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ValueList<T> && const ListEquality<Object?>().equals(this, other));

  @override
  int get hashCode => const ListEquality<Object?>().hash(this);
  //
}
