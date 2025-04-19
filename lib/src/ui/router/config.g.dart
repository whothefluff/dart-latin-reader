// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $settingsRoute,
      $mainRoute,
    ];

RouteBase get $settingsRoute => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsRouteExtension._fromState,
    );

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainRoute => StatefulShellRouteData.$route(
      factory: $MainRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/library',
              factory: $LibraryRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'authors',
                  factory: $AuthorsRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: ':authorId',
                      factory: $AuthorDetailsRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'works',
                  factory: $WorksRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: ':workId',
                      factory: $WorkDetailsRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'reader/:workId',
                  factory: $ReaderRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/dictionaries',
              factory: $DictionariesRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':dictionaryId',
                  factory: $DictionaryEntriesRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'entries/:lemma',
                      factory: $DictionaryEntryRouteExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/word-frequency',
              factory: $WordFrequencyRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/morph-analysis',
              factory: $MorphologyRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/word-lookup',
              factory: $WordLookupRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();
}

extension $LibraryRouteExtension on LibraryRoute {
  static LibraryRoute _fromState(GoRouterState state) => const LibraryRoute();

  String get location => GoRouteData.$location(
        '/library',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AuthorsRouteExtension on AuthorsRoute {
  static AuthorsRoute _fromState(GoRouterState state) => const AuthorsRoute();

  String get location => GoRouteData.$location(
        '/library/authors',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AuthorDetailsRouteExtension on AuthorDetailsRoute {
  static AuthorDetailsRoute _fromState(GoRouterState state) =>
      AuthorDetailsRoute(
        state.pathParameters['authorId']!,
      );

  String get location => GoRouteData.$location(
        '/library/authors/${Uri.encodeComponent(authorId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WorksRouteExtension on WorksRoute {
  static WorksRoute _fromState(GoRouterState state) => const WorksRoute();

  String get location => GoRouteData.$location(
        '/library/works',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WorkDetailsRouteExtension on WorkDetailsRoute {
  static WorkDetailsRoute _fromState(GoRouterState state) => WorkDetailsRoute(
        state.pathParameters['workId']!,
      );

  String get location => GoRouteData.$location(
        '/library/works/${Uri.encodeComponent(workId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ReaderRouteExtension on ReaderRoute {
  static ReaderRoute _fromState(GoRouterState state) => ReaderRoute(
        state.pathParameters['workId']!,
      );

  String get location => GoRouteData.$location(
        '/library/reader/${Uri.encodeComponent(workId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DictionariesRouteExtension on DictionariesRoute {
  static DictionariesRoute _fromState(GoRouterState state) =>
      const DictionariesRoute();

  String get location => GoRouteData.$location(
        '/dictionaries',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DictionaryEntriesRouteExtension on DictionaryEntriesRoute {
  static DictionaryEntriesRoute _fromState(GoRouterState state) =>
      DictionaryEntriesRoute(
        state.pathParameters['dictionaryId']!,
      );

  String get location => GoRouteData.$location(
        '/dictionaries/${Uri.encodeComponent(dictionaryId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DictionaryEntryRouteExtension on DictionaryEntryRoute {
  static DictionaryEntryRoute _fromState(GoRouterState state) =>
      DictionaryEntryRoute(
        state.pathParameters['dictionaryId']!,
        state.pathParameters['lemma']!,
      );

  String get location => GoRouteData.$location(
        '/dictionaries/${Uri.encodeComponent(dictionaryId)}/entries/${Uri.encodeComponent(lemma)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WordFrequencyRouteExtension on WordFrequencyRoute {
  static WordFrequencyRoute _fromState(GoRouterState state) =>
      const WordFrequencyRoute();

  String get location => GoRouteData.$location(
        '/word-frequency',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MorphologyRouteExtension on MorphologyRoute {
  static MorphologyRoute _fromState(GoRouterState state) =>
      const MorphologyRoute();

  String get location => GoRouteData.$location(
        '/morph-analysis',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WordLookupRouteExtension on WordLookupRoute {
  static WordLookupRoute _fromState(GoRouterState state) =>
      const WordLookupRoute();

  String get location => GoRouteData.$location(
        '/word-lookup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
