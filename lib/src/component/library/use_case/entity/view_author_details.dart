import 'dart:collection';

import 'package:flutter/foundation.dart';

/// Represents an author details as seen from the library page
@immutable
class AuthorDetailsView {
  const AuthorDetailsView({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.works,
  });

  final String id;
  final String name;
  final String about;
  final Uint8List image;
  final UnmodifiableListView<({String id, String name, int numberOfWords})>
      works;

  @override
  String toString() => 'AuthorDetails{name: $name}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthorDetailsView && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
