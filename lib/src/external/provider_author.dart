import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_author_details.dart';
import 'package:latin_reader/src/component/library/use_case_get_library_author_details.dart';
import 'package:latin_reader/src/component/library/use_case_get_library_authors.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/db_repository.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider_author.g.dart';

@riverpod
Future<UnmodifiableListView<AuthorView>> libraryAuthors(Ref ref) async {
  log.info(() => '@riverpod - libraryAuthors');
  final db = await ref.watch(dbProvider.future);
  ref.cacheFor(const Duration(minutes: 2));
  final repo = AuthorRepository(db);
  return GetLibraryAuthorsUseCase(repo).invoke();
}

@riverpod
Future<AuthorDetailsView> libraryAuthorDetails(Ref ref, String id) async {
  log.info(() => '@riverpod - libraryAuthorDetails');
  final db = await ref.watch(dbProvider.future);
  ref.cacheFor(const Duration(minutes: 2));
  return GetLibraryAuthorDetailsUseCase(AuthorRepository(db), id).invoke();
}
