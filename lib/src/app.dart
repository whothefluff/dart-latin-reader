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
        ShellRoute(
          //navigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ScaffoldWithNavBar(child: child);
          },
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
                  pageBuilder: (context, state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return MaterialPage(
                        child: AuthorDetailPage(authorIndex: id));
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/works',
              pageBuilder: (context, state) => const MaterialPage(
                  child:
                      WorksPage(authorIndex: 0)), //not yet implemented, if ever
              routes: [
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return MaterialPage(child: WorkDetailPage(workIndex: id));
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/reader/:workId',
              pageBuilder: (context, state) => MaterialPage<TextPage>(
                child: TextPage(
                  workIndex: state.pathParameters['workId']!,
                ),
              ),
            ),
            GoRoute(
              path: '/dictionaries',
              pageBuilder: (context, state) => const MaterialPage(
                child: PlaceholderDict(title: 'testing'),
              ),
            ),
            // GoRoute(
            //   path: '/settings',
            //   builder: (context, state) =>
            //       SettingsView(controller: widget.settingsController),
            // ),
          ],
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage<void>(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SelectableText(state.error!.message),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
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
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
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
    required this.child,
    super.key,
  });

  final Widget child;
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
    '/notcreatedyet': wordFrequencyDestination,
    '/notcreatedyet2': wordLookupDestination,
  };
  static final mainDestinations = mainPages.values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int idx) => _goToRoute(idx, context),
        selectedIndex: _getRouteIndex(context),
        destinations: mainDestinations,
      ),
    );
  }

  static void _goToRoute(int index, BuildContext context) {
    context.go(mainPages.keys.elementAt(index));
  }

  _getRouteIndex(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.path;
    final currentPathIndex = mainPages.keys.toList().indexOf(currentPath);
    final pathIndex = currentPathIndex == -1 ? 0 : currentPathIndex;
    //bind 0 somehow to the home page and or / route
    return pathIndex;
  }
}
