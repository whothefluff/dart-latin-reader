import 'dart:collection';
import 'package:latin_reader/src/component/library/use_case/entity/view_author.dart';

abstract interface class GetLibraryAuthorsUseCase {
//
  Future<UnmodifiableListView<AuthorView>> invoke();
//
}
