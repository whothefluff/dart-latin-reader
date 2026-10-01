import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Color, ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'general_settings_api.g.dart';

//infrastructure

/// A Notifier that many Widgets can interact with to read global user settings,
/// update user settings, or listen to user settings changes.
///
/// It uses the [SettingsRepository] to persist these settings
@Riverpod(keepAlive: true)
class GeneralSettingsNotifier extends _$GeneralSettingsNotifier {
  //
  static const _theme = 'app.themeMode';
  static const _accentColor = 'app.accentColor';
  static final Map<String, ThemeMode> _themeModesByName = ThemeMode.values.asNameMap();

  /// Loads the User's preferred ThemeMode and other global settings
  /// upon initialization.
  @override
  Future<GeneralSettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedTheme = (await repo.get(_theme, PrefString.hint))?.value;
    final savedAccentColor = await repo.get(_accentColor, PrefInt.hint);
    final settings = GeneralSettings(
      themeMode: _themeModesByName[savedTheme] ?? GeneralSettings._defaultThemeMode,
      accentColor: savedAccentColor != null
          ? Color(savedAccentColor.value)
          : GeneralSettings._defaultAccentColor,
    );
    return log.exit(r: settings)!;
  }

  /// Updates and saves the app settings.
  Future<void> updateSettings(GeneralSettings newSettings) async {
    log.entry(args: [newSettings]);
    final previous = state.valueOrNull;
    if (previous != null && previous != newSettings) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(newSettings);
      // Persist (with rollback on failure)
      try {
        final repo = ref.read(settingsRepositoryProvider);
        await repo.set(_theme, PrefString(newSettings.themeMode.name));
        await repo.set(_accentColor, _accentColorValue(newSettings));
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

  PrefInt? _accentColorValue(GeneralSettings newSettings) =>
      newSettings.accentColor != null ? PrefInt(newSettings.accentColor!.toARGB32()) : null;

  //
}

//domain

/// Holds the global app settings that dictate the app's overall behavior and appearance.
@immutable
class GeneralSettings {
  const GeneralSettings({
    required this.themeMode,
    required this.accentColor,
  });

  const GeneralSettings.defaults()
    : this(
        themeMode: _defaultThemeMode,
        accentColor: _defaultAccentColor,
      );

  final ThemeMode themeMode;

  /// The color the app's color scheme is generated from, or `null` for Material's baseline scheme
  final Color? accentColor;
  static const _unset = Object();
  static const ThemeMode _defaultThemeMode = ThemeMode.system;
  static const Color? _defaultAccentColor = null;

  /// Returns a copy with the given fields replaced.
  ///
  /// [accentColor] uses a sentinel default so that null can be passed explicitly
  /// to reset the color to the baseline scheme, distinguishing it from "not
  /// provided".
  GeneralSettings copyWith({
    ThemeMode? themeMode,
    Object? accentColor = _unset,
  }) => GeneralSettings(
    themeMode: themeMode ?? this.themeMode,
    accentColor: accentColor == _unset ? this.accentColor : accentColor as Color?,
  );
  @override
  String toString() => 'GeneralSettings{themeMode: $themeMode, accentColor: $accentColor}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeneralSettings &&
          other.themeMode == themeMode &&
          other.accentColor == accentColor);

  @override
  int get hashCode => Object.hash(themeMode, accentColor);
  //
}
