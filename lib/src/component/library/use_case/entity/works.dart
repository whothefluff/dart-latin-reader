import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:latin_reader/src/component/library/use_case/entity/work.dart';

@immutable
class Works {
  Works({
    required List<Work> list,
  }) : _list = UnmodifiableListView(list);

  final UnmodifiableListView<Work> _list;

  UnmodifiableListView<Work> list() => _list;

  @override
  String toString() => 'Works{${_list.join(',')}}';

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
