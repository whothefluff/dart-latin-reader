import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension CacheForExtension on Ref<Object?> {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);
    // When the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }

  //
}

extension ReadRetryingFailuresExtension on ProviderContainer {
  /// Reads [provider], retrying any failures in it or its dependencies.
  ///
  /// Reuses retries already in progress.
  Future<T> readRetryingFailures<T>(AutoDisposeFutureProvider<T> provider) {
    [if (exists(provider)) readProviderElement(provider)] // also when a parent container holds it
        .expand((element) => _dependencyTreeOf(element, {}))
        .map((element) => element.origin)
        .whereType<ProviderBase<AsyncValue<Object?>>>()
        .where((dependency) {
          final state = read(dependency);
          return state.hasError && !state.isLoading; // a retry keeps the error while it loads
        })
        .toSet()
        .forEach(invalidate);
    return read(provider.future);
  }

  /// [element] and all its dependencies, each included once.
  Set<ProviderElementBase<Object?>> _dependencyTreeOf(
    ProviderElementBase<Object?> element,
    Set<ProviderElementBase<Object?>> visited,
  ) {
    if (visited.add(element)) {
      element.visitAncestors((dependency) => _dependencyTreeOf(dependency, visited));
    }
    return visited;
  }

  //
}
