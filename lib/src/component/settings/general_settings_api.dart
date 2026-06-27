import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'general_settings_api.g.dart';

/// A Notifier that many Widgets can interact with to read global user settings,
/// update user settings, or listen to user settings changes.
///
/// It uses the [SettingsRepository] to persist these settings
@Riverpod(keepAlive: true)
class GeneralSettingsNotifier extends _$GeneralSettingsNotifier {
  //
  static const _theme = 'app.themeMode';
  static final Map<String, ThemeMode> _themeModesByName = ThemeMode.values.asNameMap();

  /// Loads the User's preferred ThemeMode and other global settings
  /// upon initialization.
  @override
  Future<GeneralSettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedTheme = (await repo.get(_theme, PrefString.hint))?.value;
    final settings = GeneralSettings(themeMode: _themeModesByName[savedTheme] ?? ThemeMode.system);
    return log.exit(r: settings)!;
  }

  /// Updates the state and persists the user's preferred ThemeMode
  Future<void> updateThemeMode(ThemeMode mode) async {
    log.entry(args: [mode]);
    final previous = state.valueOrNull;
    if (previous != null && previous.themeMode != mode) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(previous.copyWith(themeMode: mode));
      // Persist (with rollback on failure)
      try {
        await ref.read(settingsRepositoryProvider).set(_theme, PrefString(mode.name));
      } on Exception catch (e, st) {
        log
          ..catching(e, stackTrace: st)
          ..warning(() => 'Rolling back theme to ${previous.themeMode}');
        state = AsyncData(previous);
      }
    } else {
      log.fine(() => 'no-op: theme unchanged');
    }
    log.exit<void>();
  }

  //
}

/// Holds the global app settings that dictate the app's overall behavior and appearance.
@immutable
class GeneralSettings {
  const GeneralSettings({
    this.themeMode = ThemeMode.system,
  });

  final ThemeMode themeMode;

  GeneralSettings copyWith({ThemeMode? themeMode}) => GeneralSettings(
    themeMode: themeMode ?? this.themeMode,
  );
  //
}
