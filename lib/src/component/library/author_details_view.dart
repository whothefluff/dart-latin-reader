import 'dart:typed_data';

/// Represents an author details as seen from the library page
class AuthorDetailsView {
  AuthorDetailsView({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.workId,
    required this.workName,
    required this.numberOfWords,
  });

  final String id;
  final String name;
  final String about;
  final Uint8List image;
  final String workId;
  final String workName;
  final int numberOfWords;

  @override
  String toString() {
    return 'AuthorDetails{name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthorDetailsView && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
