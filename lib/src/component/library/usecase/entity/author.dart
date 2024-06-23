import 'dart:typed_data';
import 'package:latin_reader/src/component/library/usecase/entity/abbreviations.dart';
import 'package:latin_reader/src/component/library/usecase/entity/works.dart';

abstract interface class Author {
  Author({
    required this.id,
    required this.name,
    required this.abbreviations,
    required this.about,
    required this.image,
    required this.works,
  });

  final String id;
  final String name;
  final Abbreviations abbreviations;
  final String about;
  final Uint8List image;
  final Works works;

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
