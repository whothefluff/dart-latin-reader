import 'dart:collection';
import 'package:latin_reader/src/component/library/author_details_view.dart';
import 'package:latin_reader/src/component/library/usecase/entity/authors.dart';
import 'package:latin_reader/src/component/library/usecase/entity/author.dart';
import 'package:latin_reader/src/component/library/author_view.dart';

abstract interface class AuthorRepository {
//
  Future<Authors> getAllAuthors();
  Future<Author> getAuthor(String id);
  Future<Authors> getAuthorsByWork(String workId);
  Future<UnmodifiableListView<AuthorView>> getLibraryAuthors();
  Future<AuthorDetailsView> getLibraryAuthorDetails(String id);
//
}
