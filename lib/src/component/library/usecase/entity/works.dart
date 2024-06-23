import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work.dart';

abstract interface class Works {
  Works({
    required this.works,
  });

  final UnmodifiableListView<Work> works;

  @override
  String toString() {
    return 'Works{${works.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Works) return false;
    return _defaultListEquality().equals(works, other.works);
  }

  @override
  int get hashCode => _defaultListEquality().hash(works);

  ListEquality<Work> _defaultListEquality() {
    const listEquality = ListEquality<Work>(DefaultEquality());
    return listEquality;
  }
//
}
