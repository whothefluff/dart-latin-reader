import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'frequency_settings_api.g.dart';

//infrastructure

@Riverpod(keepAlive: true)
class FrequencySettingsNotifier extends _$FrequencySettingsNotifier {
  //
  static const _prefix = 'frequency.';
  static const _pageSize = '${_prefix}pageSize';
  static const _ascending = '${_prefix}ascending';
  static const _groupByLemma = '${_prefix}groupByLemma';
  static const _macronsOn = '${_prefix}showMacrons';

  @override
  Future<FrequencySettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedLimit = await repo.get(_pageSize, PrefInt.hint);
    final savedAscending = await repo.get(_ascending, PrefBool.hint);
    final savedGroupByLemma = await repo.get(_groupByLemma, PrefBool.hint);
    final savedShowMacrons = await repo.get(_macronsOn, PrefBool.hint);
    final settings = FrequencySettings(
      pageSize: savedLimit?.value ?? FrequencySettings._defaultPageSize,
      ascending: savedAscending?.value ?? FrequencySettings._defaultAscending,
      groupByLemma: savedGroupByLemma?.value ?? FrequencySettings._defaultGroupByLemma,
      showMacrons: savedShowMacrons?.value ?? FrequencySettings._defaultShowMacrons,
    );
    return log.exit(r: settings)!;
  }

  Future<void> updateSettings(FrequencySettings newSettings) async {
    log.entry(args: [newSettings]);
    final previous = state.valueOrNull;
    if (previous != null && previous != newSettings) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(newSettings);
      // Persist (with rollback on failure)
      try {
        final repo = ref.read(settingsRepositoryProvider);
        await repo.set(_pageSize, PrefInt(newSettings.pageSize));
        await repo.set(_ascending, PrefBool(newSettings.ascending));
        await repo.set(_groupByLemma, PrefBool(newSettings.groupByLemma));
        await repo.set(_macronsOn, PrefBool(newSettings.showMacrons));
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

/// Holds the settings for the word frequency report.
///
/// Passing `const FrequencySettings()` to
/// [FrequencySettingsNotifier.updateSettings] resets all fields because they
/// all have detaults
@immutable
class FrequencySettings {
  const FrequencySettings({
    this.pageSize = _defaultPageSize,
    this.ascending = _defaultAscending,
    this.groupByLemma = _defaultGroupByLemma,
    this.showMacrons = _defaultShowMacrons,
  });

  final int pageSize;
  final bool ascending;
  final bool groupByLemma;
  final bool showMacrons;
  static const int _defaultPageSize = 100;
  static const bool _defaultAscending = false;
  static const bool _defaultGroupByLemma = false;
  static const bool _defaultShowMacrons = true;

  /// Returns a copy with the given fields replaced.
  FrequencySettings copyWith({
    int? pageSize,
    bool? ascending,
    bool? groupByLemma,
    bool? showMacrons,
  }) => FrequencySettings(
    pageSize: pageSize ?? this.pageSize,
    ascending: ascending ?? this.ascending,
    groupByLemma: groupByLemma ?? this.groupByLemma,
    showMacrons: showMacrons ?? this.showMacrons,
  );

  @override
  String toString() =>
      'FrequencySettings{'
      'pageSize: $pageSize, '
      'ascending: $ascending, '
      'groupByLemma: $groupByLemma, '
      'showMacrons: $showMacrons}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencySettings &&
          other.pageSize == pageSize &&
          other.ascending == ascending &&
          other.groupByLemma == groupByLemma &&
          other.showMacrons == showMacrons);

  @override
  int get hashCode => Object.hash(pageSize, ascending, groupByLemma, showMacrons);
  //
}
