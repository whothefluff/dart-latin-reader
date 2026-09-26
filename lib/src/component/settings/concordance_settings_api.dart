import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'concordance_settings_api.g.dart';

//infrastructure

@Riverpod(keepAlive: true)
class ConcordanceSettingsNotifier extends _$ConcordanceSettingsNotifier {
  //
  static const _prefix = 'concordance.';
  static const _pageSize = '${_prefix}pageSize';

  @override
  Future<ConcordanceSettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedPageSize = await repo.get(_pageSize, PrefInt.hint);
    final settings = ConcordanceSettings(
      pageSize: savedPageSize?.value ?? ConcordanceSettings._defaultPageSize,
    );
    return log.exit(r: settings)!;
  }

  Future<void> updateSettings(ConcordanceSettings newSettings) async {
    log.entry(args: [newSettings]);
    final previous = state.valueOrNull;
    if (previous != null && previous != newSettings) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(newSettings);
      // Persist (with rollback on failure)
      try {
        final repo = ref.read(settingsRepositoryProvider);
        await repo.set(_pageSize, PrefInt(newSettings.pageSize));
      } on Exception catch (e, st) {
        log
          ..catching(e, stackTrace: st)
          ..warning(() => 'Rolling back settings to $previous');
        state = AsyncData(previous);
      }
    } else {
      log.fine('no-op: settings unchanged');
    }
    log.exit<void>();
  }

  //
}

//domain

/// How the concordance's hits are read. What is searched is the query's
@immutable
class ConcordanceSettings {
  const ConcordanceSettings({
    this.pageSize = _defaultPageSize,
  });

  /// Hits per page
  final int pageSize;

  /// The page sizes offered. Every page reads the whole search again, so large
  /// ones mean fewer waits when going through many hits
  static const List<int> pageSizes = [50, 100, 500, 1000];

  static const int _defaultPageSize = 50;

  /// Returns a copy with the given fields replaced.
  ConcordanceSettings copyWith({
    int? pageSize,
  }) => ConcordanceSettings(
    pageSize: pageSize ?? this.pageSize,
  );

  @override
  String toString() => 'ConcordanceSettings{pageSize: $pageSize}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ConcordanceSettings && other.pageSize == pageSize);

  @override
  int get hashCode => pageSize.hashCode;
  //
}
