import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'dictionary_settings_api.g.dart';

//infrastructure

@Riverpod(keepAlive: true)
class DictionarySettingsNotifier extends _$DictionarySettingsNotifier {
  //
  static const _prefix = 'dictionary.';
  static const _openFirstSense = '${_prefix}openFirstSense';

  @override
  Future<DictionarySettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedOpenFirstSense = await repo.get(_openFirstSense, PrefBool.hint);
    final settings = DictionarySettings(
      openFirstSense: savedOpenFirstSense?.value ?? DictionarySettings._defaultOpenFirstSense,
    );
    return log.exit(r: settings)!;
  }

  Future<void> updateSettings(DictionarySettings newSettings) async {
    log.entry(args: [newSettings]);
    final previous = state.valueOrNull;
    if (previous != null && previous != newSettings) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(newSettings);
      // Persist (with rollback on failure)
      try {
        final repo = ref.read(settingsRepositoryProvider);
        await repo.set(_openFirstSense, PrefBool(newSettings.openFirstSense));
      } on Exception catch (e, st) {
        log
          ..catching(e, stackTrace: st)
          ..warning(() => 'Rolling back settings to $previous');
        state = AsyncData(previous);
      }
    } else {
      log.fine(() => 'no-op: settings unchanged');
    }
    log.exit<void>();
  }

  //
}

//domain

/// Holds the settings for the dictionary
///
/// All fields have defaults and can be reset to them by omitting the parameter
/// in [copyWith].
@immutable
class DictionarySettings {
  const DictionarySettings({
    this.openFirstSense = _defaultOpenFirstSense,
  });

  /// Whether an entry with several senses starts with the first one open
  final bool openFirstSense;
  static const bool _defaultOpenFirstSense = false;

  /// Returns a copy with the given fields replaced.
  DictionarySettings copyWith({
    bool? openFirstSense,
  }) => DictionarySettings(
    openFirstSense: openFirstSense ?? this.openFirstSense,
  );

  @override
  String toString() => 'DictionarySettings{openFirstSense: $openFirstSense}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictionarySettings && other.openFirstSense == openFirstSense);

  @override
  int get hashCode => openFirstSense.hashCode;
  //
}
