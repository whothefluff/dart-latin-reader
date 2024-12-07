import 'package:flutter/foundation.dart';

/// Represents an author details as seen from the library page
@immutable
class WorkDetailsView {
  const WorkDetailsView({
    required this.id,
    required this.name,
    required this.about,
    required this.numberOfWords,
    required this.authorId,
    required this.authorName,
  });

  final String id;
  final String name;
  final String about;
  final int numberOfWords;
  final String? authorId;
  final String? authorName;

  @override
  String toString() => 'WorkDetails{name: $name}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkDetailsView && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
//
}
