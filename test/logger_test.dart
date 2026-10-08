import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/logger.dart';
import 'package:logging/logging.dart';

void main() {
  group('logUncaughtErrors', () {
    late List<LogRecord> logged;

    setUp(() {
      logged = [];
      addTearDown(log.onRecord.listen(logged.add).cancel);
      final flutterHandler = FlutterError.onError;
      final platformHandler = PlatformDispatcher.instance.onError;
      addTearDown(() {
        FlutterError.onError = flutterHandler;
        PlatformDispatcher.instance.onError = platformHandler;
      });
    });

    test('logs a framework error, then passes it to the earlier handler', () {
      final passedOn = <FlutterErrorDetails>[];
      FlutterError.onError = passedOn.add;
      logUncaughtErrors();
      final details = FlutterErrorDetails(
        exception: Exception('layout failed'),
        stack: StackTrace.current,
      );

      FlutterError.reportError(details);

      expect(logged.map((record) => (record.level, record.error, record.stackTrace)), [
        (Level.SEVERE, details.exception, details.stack),
      ]);
      expect(passedOn, [details]);
    });

    test('logs an uncaught error and leaves it unhandled', () {
      PlatformDispatcher.instance.onError = null;
      logUncaughtErrors();
      final error = Exception('detached future failed');
      final stack = StackTrace.current;

      final handled = PlatformDispatcher.instance.onError!(error, stack);

      expect(logged.map((record) => (record.level, record.error, record.stackTrace)), [
        (Level.SEVERE, error, stack),
      ]);
      expect(handled, isFalse);
    });

    test('an uncaught error is handled when the earlier handler handles it', () {
      final passedOn = <Object>[];
      PlatformDispatcher.instance.onError = (error, _) {
        passedOn.add(error);
        return true;
      };
      logUncaughtErrors();
      final error = Exception('detached future failed');

      final handled = PlatformDispatcher.instance.onError!(error, StackTrace.current);

      expect(passedOn, [error]);
      expect(handled, isTrue);
    });
  });
}
