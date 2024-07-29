import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/ui/page/library/author_details_page.dart';
import 'package:latin_reader/src/ui/page/library/authors_page.dart';
import 'package:latin_reader/src/ui/page/library/work_details_page.dart';

import 'page/dictionary/placeholder.dart';
import 'page/library/text_page.dart';
import 'page/library/works_page.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'widget/custom_adaptive_scaffold.dart';

const _homeDestination = NavigationDestination(
  icon: Icon(Icons.auto_stories),
  label: 'Home',
);
final _authorRoutes = [
  GoRoute(
    path: '/',
    redirect: (_, __) => '/authors',
  ),
  GoRoute(
    path: '/authors',
    builder: (context, state) => const AuthorsPage(),
    routes: [
      GoRoute(
        path: ':id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AuthorDetailsPage(authorId: id);
        },
      ),
    ],
  ),
  GoRoute(
    path: '/works',
    //TODO: (someday) implement
    builder: (context, state) => const WorksPage(authorIndex: 0),
    routes: [
      GoRoute(
        path: ':id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return WorkDetailsPage(workId: id);
        },
      ),
    ],
  ),
  GoRoute(
    path: '/reader/:workId',
    pageBuilder: (context, state) {
      return MaterialPage(
        fullscreenDialog: true,
        child: TextPage(
          workId: state.pathParameters['workId']!,
        ),
      );
    },
  ),
];
const _dictionariesDest = NavigationDestination(
  icon: Icon(Icons.book),
  label: 'Dictionaries',
);
final _dictionaryRoutes = [
  GoRoute(
      path: '/dictionaries',
      builder: (context, state) => const PlaceholderDict(title: 'testing'),
      name: '/dictionaries'),
];
const _wordFreqDest = NavigationDestination(
  icon: Icon(Icons.bar_chart),
  label: 'Word Frequency',
);
final _wordFrequencyRoutes = [
  GoRoute(
    path: '/word-frequency',
    builder: (context, state) => const PlaceholderDict(title: 'testing'),
  ),
];
const _wordLookupDest = NavigationDestination(
  icon: Icon(Icons.plagiarism),
  label: 'Word Lookup',
);
final _wordLookupRoutes = [
  GoRoute(
    path: '/word-lookup',
    builder: (context, state) => const PlaceholderDict(title: 'testing'),
  ),
];
final mainBranches = [
  (id: '/authors', navDest: _homeDestination, routes: _authorRoutes),
  (id: '/dictionaries', navDest: _dictionariesDest, routes: _dictionaryRoutes),
  (id: '/word-frequency', navDest: _wordFreqDest, routes: _wordFrequencyRoutes),
  (id: '/word-lookup', navDest: _wordLookupDest, routes: _wordLookupRoutes),
];
final mainBranchesDests = mainBranches.map((e) => e.navDest).toList();
const _pagesWithoutNavBar = ['/reader/:workId'];
const _pagesWithoutNavRail = [..._pagesWithoutNavBar];
final customAdaptiveScaffoldKey = GlobalKey<CustomAdaptiveScaffoldState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  MyAppState createState() => MyAppState();
//
}

class MyAppState extends ConsumerState<MyApp> {
//
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (_, state, navShell) => ScaffoldWithNavBar(
            navigationShell: navShell,
            createBottomNavBar: !_pagesWithoutNavBar.contains(state.fullPath),
            createNavRail: !_pagesWithoutNavRail.contains(state.fullPath),
          ),
          branches: mainBranches
              .map((e) => StatefulShellBranch(routes: e.routes))
              .toList(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) =>
              SettingsView(controller: widget.settingsController),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(state.error!.message),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: _router,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,
        );
      },
    );
  }
//
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    this.createBottomNavBar = true,
    this.createNavRail = true,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final bool createBottomNavBar;
  final bool createNavRail;

  @override
  Widget build(BuildContext context) {
    return CustomAdaptiveScaffold(
      key: customAdaptiveScaffoldKey,
      selectedIndex: navigationShell.currentIndex,
      destinations: mainBranchesDests,
      body: (_) => navigationShell,
      onSelectedIndexChange: _goToBranch,
      useDrawer: false,
      createBottomNavigationBar: createBottomNavBar,
      createNavigationRail: createNavRail,
    );
  }

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
//
}
