import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:latin_reader/src/page/library/author_detail_page.dart';
import 'package:latin_reader/src/page/library/authors_page.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/page/library/work_detail_page.dart';
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
      initialLocation: '/',
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
                return MaterialPage(child: AuthorDetailPage(authorIndex: id));
              },
            ),
          ],
        ),
        GoRoute(
          path: '/works',
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
        // GoRoute(
        //   path: '/settings',
        //   builder: (context, state) =>
        //       SettingsView(controller: widget.settingsController),
        // ),
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
