import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/provider_failure_logger.dart';
import 'package:logging/logging.dart';

void main() {
  group('ProviderFailureLogger', () {
    test('logs each failed run of a provider once, with its error and stack trace', () async {
      final failures = [Exception('database is locked'), Exception('disk I/O error')];
      var runs = 0;
      final failing = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        throw failures[runs++];
      });
      final logged = <LogRecord>[];
      addTearDown(log.onRecord.listen(logged.add).cancel);
      final container = ProviderContainer(observers: const [ProviderFailureLogger()]);
      addTearDown(container.dispose);

      await expectLater(container.read(failing.future), throwsException);
      container.invalidate(failing);
      await expectLater(container.read(failing.future), throwsException);

      expect(
        logged.map((record) => (record.level, record.error)),
        failures.map((failure) => (Level.SEVERE, failure)),
      );
      expect(logged.map((record) => record.stackTrace), everyElement(isNotNull));
    });
  });
}
