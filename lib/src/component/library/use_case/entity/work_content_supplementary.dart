import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:latin_reader/src/component/library/use_case/entity/work_content_supplementary_entry.dart';

@immutable
class WorkContentSupplementary {
  WorkContentSupplementary({
    required List<WorkContentSupplementaryEntry> list,
  }) : _list = UnmodifiableListView(list);

  final UnmodifiableListView<WorkContentSupplementaryEntry> _list;

  UnmodifiableListView<WorkContentSupplementaryEntry> list() => _list;

  @override
  String toString() => 'WorkNotes{${list().join(',')}}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WorkContentSupplementary) return false;
    return _defaultListEquality().equals(list(), other.list());
  }

  @override
  int get hashCode => _defaultListEquality().hash(list());

  ListEquality<WorkContentSupplementaryEntry> _defaultListEquality() {
    const listEquality =
        ListEquality<WorkContentSupplementaryEntry>(DefaultEquality());
    return listEquality;
  }
//
}
