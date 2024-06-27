import 'package:latin_reader/src/external/repository.dart';
import 'package:latin_reader/src/component/library/usecase/entity/work.dart'
    as e;
import 'package:latin_reader/src/external/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:latin_reader/src/component/library/usecase/entity/works.dart'
    as e;
part 'work_service.g.dart';

class WorkService {
  WorkService({
    required this.repository,
    required this.authorRepository,
  });

  final WorkRepository repository;
  final AuthorRepository authorRepository;

  Future<e.Works> getWorks() async => await repository.getAllWorks();

  Future<e.Work> getWork(String id) async => await repository.getWork(id);

  Future<e.Works> getWorksByAuthor(String authorId) async =>
      await repository.getWorksByAuthor(authorId);

  Future<e.Work> fillAuthorsFor(e.Work work) async {
    var authors = await authorRepository.getAuthorsByWork(work.id);
    work.authors = authors;
    return work;
  }
//
}

@riverpod
WorkService workService(WorkServiceRef ref) => WorkService(
    repository: WorkRepository(AppDb()),
    authorRepository: AuthorRepository(AppDb()));

@riverpod
Future<e.Works> works(WorksRef ref) async =>
    await ref.watch(workServiceProvider).getWorks();

@riverpod
Future<e.Works> worksWithAuthors(WorksWithAuthorsRef ref) async {
  var works = await ref.watch(workServiceProvider).getWorks();
  works.list().forEach((work) async {
    work = await ref.watch(workServiceProvider).fillAuthorsFor(work);
  });
  return works;
}

@riverpod
Future<e.Work> work(WorkRef ref, String id) async =>
    await ref.watch(workServiceProvider).getWork(id);

@riverpod
Future<e.Works> worksByAuthor(WorksByAuthorRef ref, String authorId) async =>
    await ref.watch(workServiceProvider).getWorksByAuthor(authorId);
