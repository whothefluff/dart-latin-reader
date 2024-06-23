import 'package:latin_reader/src/component/library/authors.dart';
import 'package:latin_reader/src/component/library/usecase/entity/abbreviations.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work_contents.dart';

abstract interface class Work {
  Work({
    required this.id,
    required this.name,
    required this.abbreviations,
    required this.about,
    required this.authors,
    required this.contents,
  });

  final String id;
  final String name;
  final Abbreviations abbreviations;
  final String about;
  final Authors authors;
  final WorkContents contents;

  @override
  String toString() {
    return 'Work{name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Work && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
