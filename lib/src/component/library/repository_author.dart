import 'dart:collection';
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_author_details.dart';

abstract interface class AuthorRepository {
//
  Future<UnmodifiableListView<AuthorView>> getLibraryAuthors();
  
  Future<AuthorDetailsView> getLibraryAuthorDetails(String id);
//
}
