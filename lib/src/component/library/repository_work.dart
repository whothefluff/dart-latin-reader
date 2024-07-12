import 'dart:collection';

import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_details.dart';

abstract interface class WorkRepository {
//
  Future<WorkDetailsView> getLibraryWorkDetails(String id);

  Future<UnmodifiableListView<WorkContentsElementView>>
      getLibraryWorkContentsPartially(String id, int fromIndex, int toIndex);
//
}
