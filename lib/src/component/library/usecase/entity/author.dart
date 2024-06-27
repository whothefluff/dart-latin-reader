import 'dart:typed_data';
import 'package:latin_reader/src/component/library/usecase/entity/abbreviations.dart';
import 'package:latin_reader/src/component/library/usecase/entity/authors.dart';
import 'package:latin_reader/src/component/library/usecase/entity/works.dart';

class Author {
  Author({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    Abbreviations? abbreviations,
    Works? works,
  })  : _abbreviations = abbreviations ?? Abbreviations(list: []),
        _works = works ?? Works(list: []);

  final String id;
  final String name;
  final String about;
  final Uint8List image;
  Abbreviations _abbreviations;
  Works _works;

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
  String toString() {
    return 'Author{name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Author && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
