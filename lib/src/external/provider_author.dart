import 'dart:collection';
import 'package:latin_reader/src/component/library/use_case/entity/view_author_details.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';
import 'package:latin_reader/src/component/library/use_case_get_library_authors.dart';
import 'package:latin_reader/src/component/library/use_case_get_library_author_details.dart';
import 'package:latin_reader/src/external/db_repository.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'provider_author.g.dart';

@riverpod
Future<UnmodifiableListView<AuthorView>> libraryAuthors(
    LibraryAuthorsRef ref) async {
  ref.cacheFor(const Duration(minutes: 2));
  return await GetLibraryAuthorsUseCase(AuthorRepository(AppDb())).invoke();
}

@riverpod
Future<AuthorDetailsView> libraryAuthorDetails(
    LibraryAuthorDetailsRef ref, String id) async {
  ref.cacheFor(const Duration(minutes: 2));
  return await GetLibraryAuthorDetailsUseCase(AuthorRepository(AppDb()), id)
      .invoke();
}
