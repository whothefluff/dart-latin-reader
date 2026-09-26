// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$settingsRoute, $mainRoute];

RouteBase get $settingsRoute => GoRouteData.$route(
  path: '/settings/:tab',

  factory: _$SettingsRoute._fromState,
);

mixin _$SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) =>
      SettingsRoute(tab: state.pathParameters['tab'] ?? 'general');

  SettingsRoute get _self => this as SettingsRoute;

  @override
  String get location =>
      GoRouteData.$location('/settings/${Uri.encodeComponent(_self.tab)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainRoute => StatefulShellRouteData.$route(
  factory: $MainRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/library',

          factory: _$LibraryRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'authors',

              factory: _$AuthorsRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':authorId',

                  factory: _$AuthorDetailsRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'works',

              factory: _$WorksRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':workId',

                  factory: _$WorkDetailsRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'reader/:workId',

              factory: _$ReaderRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/dictionaries',

          factory: _$DictionariesRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':dictionaryId',

              factory: _$DictionaryEntriesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'entries/:lemma',

                  factory: _$DictionaryEntryRoute._fromState,
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

          factory: _$WordFrequencyRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/morph-search',

          factory: _$MorphologicalSearchRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/morph-detail/:keys',

          factory: _$MorphologicalDataRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/concordance',

          factory: _$ConcordanceRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'hits',

              factory: _$ConcordanceHitsRoute._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();
}

mixin _$LibraryRoute on GoRouteData {
  static LibraryRoute _fromState(GoRouterState state) => const LibraryRoute();

  @override
  String get location => GoRouteData.$location('/library');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AuthorsRoute on GoRouteData {
  static AuthorsRoute _fromState(GoRouterState state) => const AuthorsRoute();

  @override
  String get location => GoRouteData.$location('/library/authors');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AuthorDetailsRoute on GoRouteData {
  static AuthorDetailsRoute _fromState(GoRouterState state) =>
      AuthorDetailsRoute(state.pathParameters['authorId']!);

  AuthorDetailsRoute get _self => this as AuthorDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/library/authors/${Uri.encodeComponent(_self.authorId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$WorksRoute on GoRouteData {
  static WorksRoute _fromState(GoRouterState state) => const WorksRoute();

  @override
  String get location => GoRouteData.$location('/library/works');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$WorkDetailsRoute on GoRouteData {
  static WorkDetailsRoute _fromState(GoRouterState state) =>
      WorkDetailsRoute(state.pathParameters['workId']!);

  WorkDetailsRoute get _self => this as WorkDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/library/works/${Uri.encodeComponent(_self.workId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ReaderRoute on GoRouteData {
  static ReaderRoute _fromState(GoRouterState state) => ReaderRoute(
    state.pathParameters['workId']!,
    startingPoint: _$convertMapValue(
      'starting-point',
      state.uri.queryParameters,
      int.tryParse,
    ),
    highlights:
        (state.uri.queryParametersAll['highlights']
                    ?.map(int.parse)
                    .cast<int>()
                    ?.toList()
                as List<int>?)
            ?.toList() ??
        const [],
  );

  ReaderRoute get _self => this as ReaderRoute;

  @override
  String get location => GoRouteData.$location(
    '/library/reader/${Uri.encodeComponent(_self.workId)}',
    queryParams: {
      if (_self.startingPoint != null)
        'starting-point': _self.startingPoint!.toString(),
      if (!_$iterablesEqual(_self.highlights, const []))
        'highlights': _self.highlights.map((e) => e.toString()).toList(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$DictionariesRoute on GoRouteData {
  static DictionariesRoute _fromState(GoRouterState state) =>
      const DictionariesRoute();

  @override
  String get location => GoRouteData.$location('/dictionaries');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$DictionaryEntriesRoute on GoRouteData {
  static DictionaryEntriesRoute _fromState(GoRouterState state) =>
      DictionaryEntriesRoute(state.pathParameters['dictionaryId']!);

  DictionaryEntriesRoute get _self => this as DictionaryEntriesRoute;

  @override
  String get location => GoRouteData.$location(
    '/dictionaries/${Uri.encodeComponent(_self.dictionaryId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$DictionaryEntryRoute on GoRouteData {
  static DictionaryEntryRoute _fromState(GoRouterState state) =>
      DictionaryEntryRoute(
        state.pathParameters['dictionaryId']!,
        state.pathParameters['lemma']!,
      );

  DictionaryEntryRoute get _self => this as DictionaryEntryRoute;

  @override
  String get location => GoRouteData.$location(
    '/dictionaries/${Uri.encodeComponent(_self.dictionaryId)}/entries/${Uri.encodeComponent(_self.lemma)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$WordFrequencyRoute on GoRouteData {
  static WordFrequencyRoute _fromState(GoRouterState state) =>
      const WordFrequencyRoute();

  @override
  String get location => GoRouteData.$location('/word-frequency');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$MorphologicalSearchRoute on GoRouteData {
  static MorphologicalSearchRoute _fromState(GoRouterState state) =>
      const MorphologicalSearchRoute();

  @override
  String get location => GoRouteData.$location('/morph-search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$MorphologicalDataRoute on GoRouteData {
  static MorphologicalDataRoute _fromState(GoRouterState state) =>
      MorphologicalDataRoute(state.pathParameters['keys']!);

  MorphologicalDataRoute get _self => this as MorphologicalDataRoute;

  @override
  String get location =>
      GoRouteData.$location('/morph-detail/${Uri.encodeComponent(_self.keys)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ConcordanceRoute on GoRouteData {
  static ConcordanceRoute _fromState(GoRouterState state) =>
      ConcordanceRoute(search: state.uri.queryParameters['search']);

  ConcordanceRoute get _self => this as ConcordanceRoute;

  @override
  String get location => GoRouteData.$location(
    '/concordance',
    queryParams: {if (_self.search != null) 'search': _self.search},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ConcordanceHitsRoute on GoRouteData {
  static ConcordanceHitsRoute _fromState(GoRouterState state) =>
      ConcordanceHitsRoute(
        search: state.uri.queryParameters['search']!,
        offset:
            _$convertMapValue('offset', state.uri.queryParameters, int.parse) ??
            0,
        locked:
            _$convertMapValue(
              'locked',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            true,
      );

  ConcordanceHitsRoute get _self => this as ConcordanceHitsRoute;

  @override
  String get location => GoRouteData.$location(
    '/concordance/hits',
    queryParams: {
      'search': _self.search,
      if (_self.offset != 0) 'offset': _self.offset.toString(),
      if (_self.locked != true) 'locked': _self.locked.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$iterablesEqual<T>(Iterable<T>? iterable1, Iterable<T>? iterable2) {
  if (identical(iterable1, iterable2)) return true;
  if (iterable1 == null || iterable2 == null) return false;
  final iterator1 = iterable1.iterator;
  final iterator2 = iterable2.iterator;
  while (true) {
    final hasNext1 = iterator1.moveNext();
    final hasNext2 = iterator2.moveNext();
    if (hasNext1 != hasNext2) return false;
    if (!hasNext1) return true;
    if (iterator1.current != iterator2.current) return false;
  }
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}
