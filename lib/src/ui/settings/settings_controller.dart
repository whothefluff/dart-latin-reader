import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import 'settings_service.dart';

part 'settings_controller.g.dart';

@riverpod
SettingsService settingsService(Ref ref) => SettingsService();

final settingsControllerProvider = Provider<SettingsController>((ref) {
  log.info(() => '@riverpod - settingsController');
  final settingsService = ref.watch(settingsServiceProvider);
  return SettingsController(settingsService);
});

final settingsInitializerProvider = FutureProvider<void>((ref) async {
  log.info(() => '@riverpod - settingsInitializer');
  final controller = ref.watch(settingsControllerProvider);
  await controller.loadSettings();
});

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(
    this._settingsService,
  );

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) {
      return;
    }
    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) {
      return;
    }
    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;
    // Important! Inform listeners a change has occurred.
    notifyListeners();
    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
