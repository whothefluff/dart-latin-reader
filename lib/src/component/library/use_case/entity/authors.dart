import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/use_case/entity/author.dart';

class Authors {
  Authors({
    required List<Author> list,
  }) : _list = UnmodifiableListView(list);

  final UnmodifiableListView<Author> _list;

  UnmodifiableListView<Author> list() => _list;

  @override
  String toString() {
    return 'Authors{${list().join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Authors) return false;
    return _defaultListEquality().equals(list(), other.list());
  }

  @override
  int get hashCode => _defaultListEquality().hash(list());

  ListEquality<Author> _defaultListEquality() {
    const listEquality = ListEquality<Author>(DefaultEquality());
    return listEquality;
  }
//
}
