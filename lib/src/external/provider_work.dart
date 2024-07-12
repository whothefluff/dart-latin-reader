import 'dart:collection';

import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_details.dart';
import 'package:latin_reader/src/component/library/use_case_get_library_work_contents_partially.dart';
import 'package:latin_reader/src/component/library/use_case_get_library_work_details.dart';
import 'package:latin_reader/src/external/db_repository.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'provider_work.g.dart';

@riverpod
Future<WorkDetailsView> libraryWorkDetails(
    LibraryWorkDetailsRef ref, String id) async {
  ref.cacheFor(const Duration(minutes: 2));
  return await GetLibraryWorkDetailsUseCase(WorkRepository(AppDb()), id)
      .invoke();
}

@riverpod
Future<UnmodifiableListView<WorkContentsElementView>>
    libraryWorkContentsPartially(LibraryWorkContentsPartiallyRef ref, String id,
        int fromIndex, int toIndex) async {
  ref.cacheFor(const Duration(minutes: 3));
  return await GetLibraryWorkContentsPartiallyUseCase(
          WorkRepository(AppDb()), id, fromIndex, toIndex)
      .invoke();
}
