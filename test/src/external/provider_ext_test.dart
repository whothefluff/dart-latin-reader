import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/external/provider_ext.dart';

void main() {
  group('readRetryingFailures', () {
    test('a dependency that keeps its failure runs again, and the read succeeds', () async {
      var dependencyRuns = 0;
      final dependency = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        dependencyRuns++;
        return dependencyRuns == 1 ? throw Exception('database is locked') : 1;
      });
      final dependent = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        return await ref.watch(dependency.future) + 1;
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await expectLater(container.readRetryingFailures(dependent), throwsException);

      expect(await container.readRetryingFailures(dependent), 2);
      expect(dependencyRuns, 2);
    });

    test('reads at the same time run a failed dependency again only once', () async {
      var dependencyRuns = 0;
      final dependency = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        dependencyRuns++;
        return dependencyRuns == 1 ? throw Exception('database is locked') : 1;
      });
      final filtered = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        return await ref.watch(dependency.future) + 1;
      });
      final all = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        return await ref.watch(dependency.future) + 2;
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await expectLater(container.read(filtered.future), throwsException);
      await expectLater(container.read(all.future), throwsException);

      final readings = await Future.wait([
        container.readRetryingFailures(filtered),
        container.readRetryingFailures(all),
      ]);

      expect(readings, [2, 3]);
      expect(dependencyRuns, 2);
    });

    test('a provider read through a child container runs again too', () async {
      var runs = 0;
      final failsOnce = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        runs++;
        return runs == 1 ? throw Exception('database is locked') : 1;
      });
      final parent = ProviderContainer();
      addTearDown(parent.dispose);
      final child = ProviderContainer(parent: parent);
      addTearDown(child.dispose);
      await expectLater(child.read(failsOnce.future), throwsException);

      expect(await child.readRetryingFailures(failsOnce), 1);
    });

    test('a provider that did not fail does not run again', () async {
      var runs = 0;
      final working = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        return ++runs;
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.readRetryingFailures(working);

      expect(await container.readRetryingFailures(working), 1);
    });

    test('a failed provider the read does not depend on does not run again', () async {
      var unrelatedRuns = 0;
      final unrelated = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        unrelatedRuns++;
        throw Exception('database is locked');
      });
      final working = FutureProvider.autoDispose<int>((ref) async {
        ref.keepAlive();
        return 1;
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);
      container.listen(unrelated, (_, _) {});
      await expectLater(container.read(unrelated.future), throwsException);

      await container.readRetryingFailures(working);
      await container.pump();

      expect(unrelatedRuns, 1);
    });
  });
}
