import 'package:flutter/foundation.dart';
import 'package:latin_reader/src/component/library/use_case/entity/abbreviations.dart';
import 'package:latin_reader/src/component/library/use_case/entity/authors.dart';
import 'package:latin_reader/src/component/library/use_case/entity/works.dart';

@immutable
class Author {
  Author({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    Abbreviations? abbreviations,
    Works? works,
  })  : _abbreviations = abbreviations ?? Abbreviations(list: const []),
        _works = works ?? Works(list: const []);

  final String id;
  final String name;
  final String about;
  final Uint8List image;
  late final Abbreviations _abbreviations;
  late final Works _works;

  Abbreviations get abbreviations => _abbreviations;

  set abbreviations(Abbreviations abbreviations) {
    if (_abbreviations.list().isEmpty) {
      _abbreviations = abbreviations;
    } else {
      throw Exception('Works already set');
    }
  }

  Works get works => _works;

  set works(Works works) {
    if (_works.list().isEmpty) {
      _works = works;
      works.list().map((w) => w.authors = Authors(list: [this]));
    } else {
      throw Exception('Works already set');
    }
  }

  @override
  String toString() => 'Author{name: $name}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Author && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
