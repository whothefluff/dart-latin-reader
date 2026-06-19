import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.g.dart';

/// A pure, asynchronous abstraction over the platform's local storage.
///
/// It does *not* hold any domain knowledge (e.g., it knows nothing about
/// theme modes or specific app features).
/// Instead, it serves as a pure, asynchronous abstraction over the
/// persistence layer (currently [SharedPreferencesAsync]).
///
/// Feature-specific Notifiers (like `AppSettingsNotifier` or `ReaderSettingsNotifier`)
/// should use this service to persist their state using namespaced keys
/// (e.g., `'app.themeMode'` or `'reader.showMacrons'`).
@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) => SettingsRepository(SharedPreferencesAsync());

/// A dumb key-value store wrapper. Domain logic belongs in specific AsyncNotifiers.
class SettingsRepository {
  SettingsRepository(
    this._prefs,
  );

  final SharedPreferencesAsync _prefs;

  Future<String?> getString(String key) => _prefs.getString(key);

  Future<void> setString(String key, String value) => _prefs.setString(key, value);

  Future<bool?> getBool(String key) => _prefs.getBool(key);

  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  Future<int?> getInt(String key) => _prefs.getInt(key);

  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);
  //
}
