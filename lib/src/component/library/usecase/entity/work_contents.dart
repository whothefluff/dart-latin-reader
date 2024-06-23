import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work_contents_segment.dart';

abstract interface class WorkContents {
  WorkContents({
    required this.segments,
  });

  final UnmodifiableListView<WorkContentsSegment> segments;

  @override
  String toString() {
    return 'WorkContentsSegments{${segments.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WorkContents) return false;
    return _defaultListEquality().equals(segments, other.segments);
  }

  @override
  int get hashCode => _defaultListEquality().hash(segments);

  ListEquality<WorkContentsSegment> _defaultListEquality() {
    const listEquality = ListEquality<WorkContentsSegment>(DefaultEquality());
    return listEquality;
  }
//
}
