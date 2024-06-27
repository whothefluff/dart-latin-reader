import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work.dart';

class Works {
  Works({
    required List<Work> list,
  }) : _list = UnmodifiableListView(list);

  final UnmodifiableListView<Work> _list;

  UnmodifiableListView<Work> list() => _list;

  @override
  String toString() {
    return 'Works{${_list.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Works) return false;
    return _defaultListEquality().equals(_list, other._list);
  }

  @override
  int get hashCode => _defaultListEquality().hash(_list);

  ListEquality<Work> _defaultListEquality() {
    const listEquality = ListEquality<Work>(DefaultEquality());
    return listEquality;
  }
//
}
