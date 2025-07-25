import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/morph_analysis/morphological_details_api.dart';
import '../page/dictionary/dictionaries_page.dart';
import '../page/dictionary/dictionary_entries_page.dart';
import '../page/dictionary/dictionary_entry_page.dart';
import '../page/library/author_details_page.dart';
import '../page/library/authors_page.dart';
import '../page/library/text_page.dart';
import '../page/library/work_details_page.dart';
import '../page/morphology/morphological_data_page.dart';
import '../page/morphology/morphological_search_page.dart';
import '../page/word_frequency_page.dart';
import '../page/word_lookup_page.dart';
import '../settings/settings_controller.dart';
import '../settings/settings_view.dart';

part 'config.g.dart';

const List<({String id, NavigationDestination navDest})> mainBranches = [
  (
    id: '/library',
    navDest: NavigationDestination(
      icon: Icon(Icons.auto_stories),
      label: 'Library',
    ),
  ),
  (
    id: '/dictionaries',
    navDest: NavigationDestination(
      icon: Icon(Icons.translate),
      label: 'Dictionaries',
    ),
  ),
  (
    id: '/word-frequency',
    navDest: NavigationDestination(
      icon: Icon(Icons.bar_chart),
      label: 'Frequency',
      tooltip: 'Word Frequency',
    ),
  ),
  (
    id: '/morph-analysis',
    navDest: NavigationDestination(
      icon: Icon(Icons.edit_note),
      label: 'Morphology',
      tooltip: 'Morphological Analysis',
    ),
  ),
  (
    id: '/word-lookup',
    navDest: NavigationDestination(
      icon: Icon(Icons.find_in_page),
      label: 'Usage',
      tooltip: 'Corpus Usage',
    ),
  ),
];

const pagesWithoutNavBar = ['/library/reader/:workId'];

const List<String> pagesWithoutNavRail = [...pagesWithoutNavBar];

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(context, state) => Consumer(
    builder: (_, ref, _) {
      final controller = ref.watch(settingsControllerProvider);
      return SettingsView(controller: controller);
    },
  );
}

@TypedStatefulShellRoute<MainRoute>(
  branches: <TypedStatefulShellBranch>[
    TypedStatefulShellBranch<LibraryBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<LibraryRoute>(
          path: '/library',
          routes: [
            TypedGoRoute<AuthorsRoute>(
              path: 'authors',
              routes: [TypedGoRoute<AuthorDetailsRoute>(path: ':authorId')],
            ),
            TypedGoRoute<WorksRoute>(
              path: 'works',
              routes: [TypedGoRoute<WorkDetailsRoute>(path: ':workId')],
            ),
            TypedGoRoute<ReaderRoute>(path: 'reader/:workId'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<DictionariesBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DictionariesRoute>(
          path: '/dictionaries',
          routes: [
            TypedGoRoute<DictionaryEntriesRoute>(
              path: ':dictionaryId',
              routes: [TypedGoRoute<DictionaryEntryRoute>(path: 'entries/:lemma')],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<WordFrequencyBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<WordFrequencyRoute>(path: '/word-frequency')],
    ),
    TypedStatefulShellBranch<MorphologyBranch>(
      routes: [
        TypedGoRoute<MorphologicalSearchRoute>(path: '/morph-search'),
        TypedGoRoute<MorphologicalDataRoute>(path: '/morph-detail/:keys'),
      ],
    ),
    TypedStatefulShellBranch<WordLookupBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<WordLookupRoute>(path: '/word-lookup')],
    ),
  ],
)
/// Serves as a type definition for the router's shell navigation structure.
///
/// The class is intentionally kept as a minimal implementation, serving
/// primarily as a type definition which is why the [builder] method is not
/// redefined. The actual shell route behavior is handled explicitly in the
/// router configuration using [StatefulShellRoute.indexedStack]
class MainRoute extends StatefulShellRouteData {
  const MainRoute();
}

class LibraryBranch extends StatefulShellBranchData {
  const LibraryBranch();
}

class DictionariesBranch extends StatefulShellBranchData {
  const DictionariesBranch();
}

class WordFrequencyBranch extends StatefulShellBranchData {
  const WordFrequencyBranch();
}

class MorphologyBranch extends StatefulShellBranchData {
  const MorphologyBranch();
}

class WordLookupBranch extends StatefulShellBranchData {
  const WordLookupBranch();
}

class LibraryRoute extends GoRouteData with _$LibraryRoute {
  const LibraryRoute();

  @override
  /// overriding redirect doesn't do shit to avoid the exception
  Widget build(context, state) => const AuthorsRoute().build(context, state);

  @override
  String? redirect(context, state) => state.fullPath == '/library' ? '/library/authors' : null;
  //
}

class AuthorsRoute extends GoRouteData with _$AuthorsRoute {
  const AuthorsRoute();

  @override
  Widget build(context, state) => const AuthorsPage();
  //
}

class AuthorDetailsRoute extends GoRouteData with _$AuthorDetailsRoute {
  const AuthorDetailsRoute(
    this.authorId,
  );

  final String authorId;

  @override
  Widget build(context, state) => AuthorDetailsPage(authorId);
  //
}

class WorksRoute extends GoRouteData with _$WorksRoute {
  const WorksRoute();

  @override
  Widget build(context, state) => const Icon(Icons.error);
  //
}

class WorkDetailsRoute extends GoRouteData with _$WorkDetailsRoute {
  const WorkDetailsRoute(
    this.workId,
  );

  final String workId;

  @override
  Widget build(context, state) => WorkDetailsPage(workId);
  //
}

class ReaderRoute extends GoRouteData with _$ReaderRoute {
  const ReaderRoute(
    this.workId,
  );

  final String workId;

  @override
  Page<void> buildPage(context, state) => MaterialPage(
    fullscreenDialog: true,
    child: TextPage(workId),
  );
  //
}

class DictionariesRoute extends GoRouteData with _$DictionariesRoute {
  const DictionariesRoute();

  @override
  Page<void> buildPage(context, state) => const MaterialPage(child: DictionariesPage());
  //
}

class DictionaryEntriesRoute extends GoRouteData with _$DictionaryEntriesRoute {
  const DictionaryEntriesRoute(
    this.dictionaryId,
  );

  final String dictionaryId;

  @override
  Page<void> buildPage(context, state) => MaterialPage(child: DictionaryEntriesPage(dictionaryId));
  //
}

class DictionaryEntryRoute extends GoRouteData with _$DictionaryEntryRoute {
  const DictionaryEntryRoute(
    this.dictionaryId,
    this.lemma,
  );

  final String dictionaryId;
  final String lemma;

  @override
  Page<void> buildPage(context, state) =>
      MaterialPage(child: DictionaryEntryPage(dictionaryId, lemma));
  //
}

class WordFrequencyRoute extends GoRouteData with _$WordFrequencyRoute {
  const WordFrequencyRoute();

  @override
  Widget build(context, state) => const WordFrequencyPage();
  //
}

class MorphologicalSearchRoute extends GoRouteData with _$MorphologicalSearchRoute {
  const MorphologicalSearchRoute();

  @override
  Widget build(context, state) => const MorphologicalSearchPage();
  //
}

class MorphologicalDataRoute extends GoRouteData with _$MorphologicalDataRoute {
  const MorphologicalDataRoute(
    this.keys,
  );

  final String keys;

  @override
  Widget build(context, state) => MorphologicalDataPage(AnalysisKeys.fromJson(keys));
  //
}

class WordLookupRoute extends GoRouteData with _$WordLookupRoute {
  const WordLookupRoute();

  @override
  Widget build(context, state) => const WordLookupPage();
  //
}
