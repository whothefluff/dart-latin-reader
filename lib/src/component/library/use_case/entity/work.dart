import 'package:flutter/foundation.dart';
import 'package:latin_reader/src/component/library/use_case/entity/abbreviations.dart';
import 'package:latin_reader/src/component/library/use_case/entity/authors.dart';
import 'package:latin_reader/src/component/library/use_case/entity/work_contents.dart';
import 'package:latin_reader/src/component/library/use_case/entity/works.dart';

@immutable
class Work {
  Work({
    required this.id,
    required this.name,
    required this.about,
    Abbreviations? abbreviations,
    Authors? authors,
    WorkContents? contents,
  })  : _abbreviations = abbreviations ?? Abbreviations(list: const []),
        _authors = authors ?? Authors(list: const []),
        _contents = contents ?? WorkContents(list: const []);

  final String id;
  final String name;
  final String about;
  late final Abbreviations _abbreviations;
  late final Authors _authors;
  late final WorkContents _contents;

  Abbreviations get abbreviations => _abbreviations;

  set abbreviations(Abbreviations abbreviations) {
    if (_abbreviations.list().isEmpty) {
      _abbreviations = abbreviations;
    } else {
      throw Exception('Authors already set');
    }
  }

  Authors get authors => _authors;

  set authors(Authors authors) {
    if (_authors.list().isEmpty) {
      _authors = authors;
      authors.list().map((a) => a.works = Works(list: [this]));
    } else {
      throw Exception('Authors already set');
    }
  }

  WorkContents get contents => _contents;

  set contents(WorkContents contents) {
    if (_contents.list().isEmpty) {
      _contents = contents;
    } else {
      throw Exception('Contents already set');
    }
  }

  @override
  String toString() => 'Work{name: $name}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Work && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
