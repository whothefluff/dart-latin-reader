import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../component/concordance/concordance_query.dart';
import '../../component/morph_analysis/morphological_details_api.dart';
import '../page/concordance/concordance_page.dart';
import '../page/dictionary/dictionaries_page.dart';
import '../page/dictionary/dictionary_entries_page.dart';
import '../page/dictionary/dictionary_entry_page.dart';
import '../page/library/author_details_page.dart';
import '../page/library/authors_page.dart';
import '../page/library/text_page.dart';
import '../page/library/work_details_page.dart';
import '../page/morphology/morphological_data_page.dart';
import '../page/morphology/morphological_search_page.dart';
import '../page/settings/settings_shell_page.dart';
import '../page/word_frequency/word_frequency_page.dart';

part 'config.g.dart';

const String libraryId = 'library';

const String dictionariesId = 'dictionaries';

const String wordFrequencyId = 'word-frequency';

const String morphAnalysisId = 'morph-analysis';

const String concordanceId = 'concordance';

const List<({String id, NavigationDestination navDest})> mainBranches = [
  (
    id: '/$libraryId',
    navDest: NavigationDestination(
      icon: Icon(Icons.auto_stories),
      label: 'Library',
    ),
  ),
  (
    id: '/$dictionariesId',
    navDest: NavigationDestination(
      icon: Icon(Icons.translate),
      label: 'Dictionaries',
    ),
  ),
  (
    id: '/$wordFrequencyId',
    navDest: NavigationDestination(
      icon: Icon(Icons.bar_chart),
      label: 'Frequency',
      tooltip: 'Word Frequency',
    ),
  ),
  (
    id: '/$morphAnalysisId',
    navDest: NavigationDestination(
      icon: Icon(Icons.edit_note),
      label: 'Morphology',
      tooltip: 'Morphological Analysis',
    ),
  ),
  (
    id: '/$concordanceId',
    navDest: NavigationDestination(
      icon: Icon(Icons.manage_search),
      label: 'Concordance',
      tooltip: 'Search the library',
    ),
  ),
];

const pagesWithoutNavBar = ['/library/reader/:workId'];

const List<String> pagesWithoutNavRail = [...pagesWithoutNavBar];

@TypedGoRoute<SettingsRoute>(path: '/settings/:tab')
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute({
    this.tab = 'general',
  });

  final String tab;

  @override
  Widget build(context, state) => SettingsShellPage(tab: tab);
  //
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
    TypedStatefulShellBranch<ConcordanceBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ConcordanceRoute>(
          path: '/concordance',
          routes: [TypedGoRoute<ConcordanceHitsRoute>(path: 'hits')],
        ),
      ],
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

class ConcordanceBranch extends StatefulShellBranchData {
  const ConcordanceBranch();
}

class LibraryRoute extends GoRouteData with _$LibraryRoute {
  const LibraryRoute();

  /// overriding redirect doesn't do shit to avoid the exception
  @override
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
    this.workId, {
    this.startingPoint,
    this.highlights = const [],
  });

  final String workId;

  /// Where the first page starts at.
  /// The beginning of the work when `null`.
  final int? startingPoint;

  /// Tokens marked on the page
  final List<int> highlights;

  @override
  Page<void> buildPage(context, state) => MaterialPage(
    fullscreenDialog: true,
    child: TextPage(
      workId,
      startingPoint: startingPoint,
      highlights: highlights,
    ),
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

/// The picked analyses are part of the location, so leaving them is going to the clean search
class MorphologicalSearchRoute extends GoRouteData with _$MorphologicalSearchRoute {
  const MorphologicalSearchRoute({
    this.keys,
  });

  /// The [AnalysisKeys] shown, as JSON. Null before a form is picked
  final String? keys;

  @override
  Widget build(context, state) => MorphologicalSearchPage(
    keys: switch (keys) {
      final keys? => AnalysisKeys.fromJson(keys),
      null => null,
    },
  );
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

/// The Concordance tab's first page (the search).
/// The searches themselves are part of [ConcordanceHitsRoute].
class ConcordanceRoute extends GoRouteData with _$ConcordanceRoute {
  const ConcordanceRoute({
    this.search,
  });

  /// A [ConcordanceQuery] as JSON to fill the form with.
  /// Null for a blank one
  final String? search;

  @override
  Widget build(context, state) => ConcordancePage(
    query: switch (search) {
      final search? => ConcordanceQuery.fromJson(search),
      null => null,
    },
  );
  //
}

class ConcordanceHitsRoute extends GoRouteData with _$ConcordanceHitsRoute {
  const ConcordanceHitsRoute({
    required this.search,
    this.offset = 0,
    this.locked = true,
  });

  /// A [ConcordanceQuery] as JSON
  final String search;

  final int offset;

  /// Whether the cannot be edited
  final bool locked;

  @override
  Widget build(context, state) => ConcordanceHitsPage(
    query: ConcordanceQuery.fromJson(search),
    offset: offset,
    locked: locked,
  );
  //
}
