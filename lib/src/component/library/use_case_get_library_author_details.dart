import 'package:latin_reader/src/component/library/use_case/entity/view_author_details.dart';
import 'package:latin_reader/src/component/library/use_case/get_library_author_details.dart'
    as i;
import 'package:latin_reader/src/component/library/repository_author.dart' as i;

class GetLibraryAuthorDetailsUseCase
    implements i.GetLibraryAuthorDetailsUseCase {
  GetLibraryAuthorDetailsUseCase(
    this._repository,
    this._id,
  );

  final i.AuthorRepository _repository;
  final String _id;

  @override
  Future<AuthorDetailsView> invoke() async =>
      await _repository.getLibraryAuthorDetails(_id);
//
}
