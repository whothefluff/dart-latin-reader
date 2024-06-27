import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/abbreviation.dart';

class Abbreviations {
  Abbreviations({
    required List<Abbreviation> list,
  }) : _list = UnmodifiableListView(list);

  final UnmodifiableListView<Abbreviation> _list;

  UnmodifiableListView<Abbreviation> list() => _list;

  @override
  String toString() {
    return 'Abbreviations{${_list.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Abbreviations) return false;
    return _defaultListEquality().equals(_list, other._list);
  }

  @override
  int get hashCode => _defaultListEquality().hash(_list);

  ListEquality<Abbreviation> _defaultListEquality() {
    const listEquality = ListEquality<Abbreviation>(DefaultEquality());
    return listEquality;
  }
//
}
