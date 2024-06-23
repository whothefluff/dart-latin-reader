import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/abbreviation.dart';

abstract interface class Abbreviations {
  Abbreviations({
    required this.abbreviations,
  });

  final UnmodifiableListView<Abbreviation> abbreviations;

  @override
  String toString() {
    return 'Abbreviations{${abbreviations.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Abbreviations) return false;
    return _defaultListEquality().equals(abbreviations, other.abbreviations);
  }

  @override
  int get hashCode => _defaultListEquality().hash(abbreviations);

  ListEquality<Abbreviation> _defaultListEquality() {
    const listEquality = ListEquality<Abbreviation>(DefaultEquality());
    return listEquality;
  }
//
}
