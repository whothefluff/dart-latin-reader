import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/route_failure_logger.dart';
import 'package:logging/logging.dart';

void main() {
  group('logRouteFailures', () {
    testWidgets('logs each failed navigation once, with its location and error', (tester) async {
      final router = GoRouter(
        routes: [GoRoute(path: '/', builder: (_, _) => const Text('home'))],
      );
      addTearDown(router.dispose);
      logRouteFailures(router, Level.WARNING);
      final logged = <LogRecord>[];
      addTearDown(log.onRecord.listen(logged.add).cancel);
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      router.go('/gone');
      await tester.pumpAndSettle();
      router.go('/');
      await tester.pumpAndSettle();
      unawaited(router.push('/pushed'));
      await tester.pumpAndSettle();

      expect(logged.map((record) => [record.level, record.message, record.error]), [
        [Level.WARNING, contains('/gone'), isA<GoException>()],
        [Level.WARNING, contains('/pushed'), isA<GoException>()],
      ]);
    });
  });
}
