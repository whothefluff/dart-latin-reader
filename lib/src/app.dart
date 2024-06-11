import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:latin_reader/src/page/library/author_detail_page.dart';
import 'package:latin_reader/src/page/library/authors_page.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/page/library/work_detail_page.dart';
import 'page/dictionary/placeholder.dart';
import 'page/library/works_page.dart';
import 'settings/settings_controller.dart';
import 'page/library/text_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      //navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: [
        StatefulShellRoute.indexedStack(
          //navigatorKey: _shellNavigatorKey,
          builder: (context, state, navShell) =>
              ScaffoldWithNavBar(navigationShell: navShell),
          branches: [
            StatefulShellBranch(
              routes: [
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
                        final id = int.parse(state.pathParameters['id']!);
                        return AuthorDetailPage(authorIndex: id);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: '/works',
                  builder: (context, state) => const WorksPage(
                      authorIndex: 0), //not yet implemented, if ever
                  routes: [
                    GoRoute(
                      path: ':id',
                      builder: (context, state) {
                        final id = int.parse(state.pathParameters['id']!);
                        return WorkDetailPage(workIndex: id);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: '/reader/:workId',
                  builder: (context, state) => TextPage(
                    workIndex: state.pathParameters['workId']!,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/dictionaries',
                builder: (context, state) =>
                    const PlaceholderDict(title: 'testing'),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/word-frequency',
                builder: (context, state) =>
                    const PlaceholderDict(title: 'testing'),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/word-lookup',
                builder: (context, state) =>
                    const PlaceholderDict(title: 'testing'),
              ),
            ]),
            // GoRoute(
            //   path: '/settings',
            //   builder: (context, state) =>
            //       SettingsView(controller: widget.settingsController),
            // ),
          ],
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
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  static const homeDestination = NavigationDestination(
    icon: Icon(Icons.auto_stories),
    label: 'Home',
  );
  static const dictionariesDestination = NavigationDestination(
    icon: Icon(Icons.book),
    label: 'Dictionaries',
  );
  static const wordFrequencyDestination = NavigationDestination(
    icon: Icon(Icons.bar_chart),
    label: 'Word Frequency',
  );
  static const wordLookupDestination = NavigationDestination(
    icon: Icon(Icons.plagiarism),
    label: 'Word Lookup',
  );
  static const mainPages = {
    '/authors': homeDestination,
    '/dictionaries': dictionariesDestination,
    '/word-frequency': wordFrequencyDestination,
    '/word-lookup': wordLookupDestination,
  };
  static final mainDestinations = mainPages.values.toList();

  @override
  Widget build(context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (idx) => _goToBranch(idx, context),
        selectedIndex: navigationShell.currentIndex,
        destinations: mainDestinations,
      ),
    );
  }

  void _goToBranch(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
