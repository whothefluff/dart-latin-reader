import 'package:latin_reader/src/component/library/use_case/entity/view_work_details.dart';

abstract interface class WorkRepository {
//
  Future<WorkDetailsView> getLibraryWorkDetails(String id);
//
}
