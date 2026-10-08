import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/ui/widget/show_error.dart';
import 'package:latin_reader/src/ui/widget/show_loading.dart';

void main() {
  group('showError', () {
    testWidgets('Retry runs a failed dependency again, and the provider loads', (tester) async {
      var dependencyRuns = 0;
      final dependency = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        dependencyRuns++;
        return dependencyRuns == 1 ? throw Exception('database is locked') : 1;
      });
      final dependent = FutureProvider.autoDispose<int>(
        (ref) async => await ref.watch(dependency.future) + 1,
      );
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Consumer(
              builder: (_, ref, _) => ref
                  .watch(dependent)
                  .when(
                    data: (_) => const SizedBox.shrink(),
                    loading: showLoading,
                    error: showError(ref, dependent),
                  ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(TextButton, 'Retry'));
      await tester.pumpAndSettle();

      final container = ProviderScope.containerOf(tester.element(find.byType(Consumer)));
      expect(container.read(dependent).valueOrNull, 2);
      expect(dependencyRuns, 2);
    });
  });
}
