import 'package:latin_reader/src/component/library/usecase/entity/authors.dart';
import 'package:latin_reader/src/component/library/usecase/entity/author.dart';

abstract interface class AuthorRepository {
//
  Future<Authors> getAllAuthors();
  Future<Author> getAuthor(String id);
  Future<Authors> getAuthorsByWork(String workId);
//
}
