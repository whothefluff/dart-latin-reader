import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logger.dart';

// TODO(whothefluff): after upgrading to Riverpod 3 (access to args),
//  replace manual provider logs with observer logging

/// Logs provider failures at severe level with the provider, error and stack trace.
///
/// Failures are logged even when callers catch them.
class ProviderFailureLogger extends ProviderObserver {
  const ProviderFailureLogger();

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) => log.severe(() => '$provider failed', error, stackTrace);
  //
}
