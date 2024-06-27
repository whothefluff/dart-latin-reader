import 'package:latin_reader/src/component/library/usecase/entity/works.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work.dart';

abstract interface class WorkRepository {
//
  Future<Works> getAllWorks();
  Future<Work> getWork(String id);
  Future<Works> getWorksByAuthor(String authorId);
//
}
