import 'dart:collection';

import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/component/library/use_case/get_library_work_content_partially.dart'
    as i;
import 'package:latin_reader/src/component/library/repository_work.dart' as i;

class GetLibraryWorkContentsPartiallyUseCase
    implements i.GetLibraryWorkContentPartiallyUseCase {
  GetLibraryWorkContentsPartiallyUseCase(
    this._repository,
    this._id,
    this._fromIndex,
    this._toIndex,
  );

  final i.WorkRepository _repository;
  final String _id;
  final int _fromIndex;
  final int _toIndex;

  @override
  Future<UnmodifiableListView<WorkContentsElementView>> invoke() async =>
      await _repository.getLibraryWorkContentsPartially(
          _id, _fromIndex, _toIndex);
//
}
