import 'package:collection/collection.dart';
import 'package:latin_reader/src/component/library/usecase/entity/author.dart';

abstract interface class Authors {
  Authors({
    required this.authors,
  });

  final UnmodifiableListView<Author> authors;

  @override
  String toString() {
    return 'Authors{${authors.join(',')}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Authors) return false;
    return _defaultListEquality().equals(authors, other.authors);
  }

  @override
  int get hashCode => _defaultListEquality().hash(authors);

  ListEquality<Author> _defaultListEquality() {
    const listEquality = ListEquality<Author>(DefaultEquality());
    return listEquality;
  }
//
}
