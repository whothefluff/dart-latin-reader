import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../logger.dart';

/// Logs each navigation of [router] that ends on its error page, with the reason.
void logRouteFailures(GoRouter router, Level level) => router.routerDelegate.addListener(() {
  final topPageNavigation = _topPageNavigation(router.routerDelegate.currentConfiguration);
  if (topPageNavigation.isError) {
    log.log(level, () => 'Navigation to ${topPageNavigation.uri} failed', topPageNavigation.error);
  }
});

/// Returns the navigation that opened the top page of [history].
RouteMatchList _topPageNavigation(RouteMatchList history) => switch (history.lastOrNull) {
  ImperativeRouteMatch(:final matches) => matches,
  _ => history,
};
