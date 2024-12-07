import 'package:latin_reader/src/component/library/repository_work.dart' as i;
import 'package:latin_reader/src/component/library/use_case/entity/view_work_details.dart';
import 'package:latin_reader/src/component/library/use_case/get_library_work_details.dart'
    as i;

class GetLibraryWorkDetailsUseCase implements i.GetLibraryWorkDetailsUseCase {
  GetLibraryWorkDetailsUseCase(
    this._repository,
    this._id,
  );

  final i.WorkRepository _repository;
  final String _id;

  @override
  Future<WorkDetailsView> invoke() async =>
      _repository.getLibraryWorkDetails(_id);
//
}
