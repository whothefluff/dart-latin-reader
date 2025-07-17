import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import 'router/config.dart';
import 'settings/settings_controller.dart';
import 'widget/custom_adaptive_scaffold.dart';
import 'widget/show_loading.dart';

final customAdaptiveScaffoldKey = GlobalKey<CustomAdaptiveScaffoldState>();

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
  });

  @override
  AppState createState() => AppState();
  //
}

class AppState extends ConsumerState<App> {
  //
  late final GoRouter _router;
  final StatefulShellRoute _generatedRoute = $mainRoute is StatefulShellRoute
      ? $mainRoute as StatefulShellRoute
      : throw AssertionError('Not a StatefulShellRoute');

  @override
  Widget build(context) => ref
      .watch(settingsInitializerProvider)
      .when(
        loading: showLoading,
        data: (_) {
          final settingsController = ref.watch(settingsControllerProvider);
          return ListenableBuilder(
            listenable: settingsController,
            builder: (_, _) => MaterialApp.router(
              key: ValueKey(settingsController.themeMode),
              routerConfig: _router,
              restorationScopeId: 'app',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('es'),
              ],
              onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,
            ),
          );
        },
        error: (error, stack) => MaterialApp(
          home: Scaffold(
            body: Center(child: Text('Error: $error')),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: const LibraryRoute().location,
      routes: [
        mainRoute(),
        $settingsRoute,
      ],
      errorBuilder: backToHome,
    );
  }

  StatefulShellRoute mainRoute() => StatefulShellRoute.indexedStack(
    builder: (_, state, navShell) => ScaffoldWithNavBar(
      navigationShell: navShell,
      createBottomNavBar: !pagesWithoutNavBar.contains(state.fullPath),
      createNavRail: !pagesWithoutNavRail.contains(state.fullPath),
    ),
    branches: _generatedRoute.branches,
  );

  Widget backToHome(BuildContext context, GoRouterState state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(state.error!.message),
          TextButton(
            onPressed: () => const LibraryRoute().go(context),
            child: const Text('Home'),
          ),
        ],
      ),
    ),
  );
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
  Widget build(context) => MediaQuery(
    key: ValueKey('${MediaQuery.sizeOf(context).width}_${MediaQuery.sizeOf(context).height}'),
    data: MediaQuery.of(context),
    child: CustomAdaptiveScaffold(
      key: customAdaptiveScaffoldKey,
      selectedIndex: navigationShell.currentIndex,
      destinations: mainBranches.map((b) => b.navDest).toList(),
      body: (_) => navigationShell,
      onSelectedIndexChange: _goToBranch,
      useDrawer: false,
      createBottomNavigationBar: createBottomNavBar,
      createNavigationRail: createNavRail,
    ),
  );

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      //navigate to the initial location when tapping the item that is already active
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  //
}
