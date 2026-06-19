import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'app_settings_api.g.dart';

/// Holds the global app settings that dictate the app's overall behavior and appearance.
@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
  });

  final ThemeMode themeMode;

  AppSettings copyWith({ThemeMode? themeMode}) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
  );
  //
}

/// A Notifier that many Widgets can interact with to read global user settings,
/// update user settings, or listen to user settings changes.
///
/// It uses the [SettingsRepository] to persist these settings to local storage.
@Riverpod(keepAlive: true)
class AppSettingsNotifier extends _$AppSettingsNotifier {
  //
  static const _themeKey = 'app.themeMode';
  static final Map<String, ThemeMode> _themeModesByName = ThemeMode.values.asNameMap();

  /// Loads the User's preferred ThemeMode and other global settings
  /// from local storage upon initialization.
  @override
  Future<AppSettings> build() async {
    final repo = ref.watch(settingsRepositoryProvider);
    final themeName = await repo.getString(_themeKey);
    return AppSettings(
      themeMode: _themeModesByName[themeName] ?? ThemeMode.system,
    );
  }

  /// Updates the state and persists the user's preferred ThemeMode to local storage.
  Future<void> updateThemeMode(ThemeMode mode) async {
    final previous = state.valueOrNull;
    if (previous != null && previous.themeMode != mode) {
      // Optimistic update (UI changes instantly)
      state = AsyncData(previous.copyWith(themeMode: mode));
      // Persist (with rollback on failure)
      try {
        await ref.read(settingsRepositoryProvider).setString(_themeKey, mode.name);
      } on Exception catch (e, st) {
        log.catching(e, stackTrace: st);
        if (state.valueOrNull?.themeMode == mode) {
          state = AsyncData(previous);
        }
      }
    }
  }

  //
}
