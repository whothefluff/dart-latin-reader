import 'dart:collection';
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';
import 'package:latin_reader/src/component/library/use_case/get_library_authors.dart'
    as i;
import 'package:latin_reader/src/component/library/repository_author.dart' as i;

class GetLibraryAuthorsUseCase implements i.GetLibraryAuthorsUseCase {
  GetLibraryAuthorsUseCase(
    this._repository,
  );

  final i.AuthorRepository _repository;

  @override
  Future<UnmodifiableListView<AuthorView>> invoke() async =>
      await _repository.getLibraryAuthors();
//
}
