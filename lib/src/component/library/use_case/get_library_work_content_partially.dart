import 'dart:collection';

import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';

abstract interface class GetLibraryWorkContentPartiallyUseCase {
//
  Future<UnmodifiableListView<WorkContentsElementView>> invoke();
//
}
