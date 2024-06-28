import 'dart:collection';

import 'package:latin_reader/src/component/library/author_details_view.dart';
import 'package:latin_reader/src/external/repository.dart';
import 'package:latin_reader/src/component/library/usecase/entity/author.dart'
    as e;
import 'package:latin_reader/src/external/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:latin_reader/src/component/library/usecase/entity/authors.dart'
    as e;
import 'package:latin_reader/src/component/library/author_view.dart';
part 'author_service.g.dart';

class AuthorService {
  AuthorService({
    required this.repository,
    required this.workRepository,
  });

  final AuthorRepository repository;
  final WorkRepository workRepository;

  Future<e.Authors> getAuthors() async => await repository.getAllAuthors();

  Future<e.Author> getAuthor(String id) async => await repository.getAuthor(id);

  Future<e.Authors> getAuthorsByWork(String workId) async =>
      await repository.getAuthorsByWork(workId);

  Future<e.Author> fillWorksFor(e.Author author) async {
    var works = await workRepository.getWorksByAuthor(author.id);
    author.works = works;
    return author;
  }

  Future<UnmodifiableListView<AuthorView>> getLibraryAuthors() async =>
      await repository.getLibraryAuthors();

  Future<UnmodifiableListView<AuthorDetailsView>> getLibraryAuthorDetails(
          String id) async =>
      await repository.getLibraryAuthorDetails(id);

//
}

@riverpod
AuthorService authorService(AuthorServiceRef ref) => AuthorService(
    repository: AuthorRepository(AppDb()),
    workRepository: WorkRepository(AppDb()));

@riverpod
Future<e.Authors> authors(AuthorsRef ref) async =>
    await ref.watch(authorServiceProvider).getAuthors();

@riverpod
Future<e.Authors> authorsWithWorks(AuthorsWithWorksRef ref) async {
  var authors = await ref.watch(authorServiceProvider).getAuthors();
  authors.list().forEach((author) async {
    author = await ref.watch(authorServiceProvider).fillWorksFor(author);
  });
  return authors;
}

@riverpod
Future<e.Author> author(AuthorRef ref, String id) async =>
    await ref.watch(authorServiceProvider).getAuthor(id);

@riverpod
Future<e.Authors> authorsByWork(AuthorsByWorkRef ref, String workId) async =>
    await ref.watch(authorServiceProvider).getAuthorsByWork(workId);

@riverpod
Future<UnmodifiableListView<AuthorView>> libraryAuthors(
        LibraryAuthorsRef ref) async =>
    await ref.watch(authorServiceProvider).getLibraryAuthors();

@riverpod
Future<UnmodifiableListView<AuthorDetailsView>> libraryAuthorDetails(
        LibraryAuthorDetailsRef ref, String id) async =>
    await ref.watch(authorServiceProvider).getLibraryAuthorDetails(id);
