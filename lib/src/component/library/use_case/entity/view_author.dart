import 'package:flutter/foundation.dart';

/// Represents an author as seen from the library page
@immutable
class AuthorView {
  const AuthorView({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.numberOfWorks,
  });

  final String id;
  final String name;
  final String about;
  final Uint8List image;
  final int numberOfWorks;

  @override
  String toString() => 'Author{name: $name}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthorView && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
