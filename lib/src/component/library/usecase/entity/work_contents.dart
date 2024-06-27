import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work_contents_segment.dart';

class WorkContents {
  WorkContents({
    required List<WorkContentsSegment> list,
  }) : _list = UnmodifiableListView(list);

  final UnmodifiableListView<WorkContentsSegment> _list;

  UnmodifiableListView<WorkContentsSegment> list() => _list;

  @override
  String toString() {
    return 'WorkContentsSegments{${_list.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WorkContents) return false;
    return _defaultListEquality().equals(_list, other._list);
  }

  @override
  int get hashCode => _defaultListEquality().hash(_list);

  ListEquality<WorkContentsSegment> _defaultListEquality() {
    const listEquality = ListEquality<WorkContentsSegment>(DefaultEquality());
    return listEquality;
  }
//
}
