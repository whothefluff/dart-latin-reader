import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logger.dart';

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
SettingsRepository settingsRepository(Ref _) {
  log.info(() => '@riverpod');
  return SettingsRepository(SharedPreferencesAsync());
}

/// A dumb key-value store wrapper. Domain logic belongs in specific AsyncNotifiers.
class SettingsRepository {
  SettingsRepository(
    this._prefs,
  );

  final SharedPreferencesAsync _prefs;

  /// Retrieves the value stored at [key], wrapped in the appropriate [Pref]
  /// subclass.
  ///
  /// Callers should provide a [typeHint] matching the expected type; the hint's
  /// value is ignored, only its runtime type is used for dispatch.
  ///
  /// Returns null if the key does not exist in storage, a [Pref] wrapping the
  ///  value otherwise.
  Future<T?> get<T extends Pref>(String key, T typeHint) {
    log.entry(args: [key, typeHint]);
    final pref = _get(key, typeHint);
    return log.exit(r: pref)!;
  }

  Future<T?> _get<T extends Pref>(String key, T typeHint) => switch (typeHint) {
    PrefString _ => _prefs.getString(key).then((v) => v != null ? PrefString(v) as T? : null),
    PrefBool _ => _prefs.getBool(key).then((v) => v != null ? PrefBool(v) as T? : null),
    PrefInt _ => _prefs.getInt(key).then((v) => v != null ? PrefInt(v) as T? : null),
    PrefDouble _ => _prefs.getDouble(key).then((v) => v != null ? PrefDouble(v) as T? : null),
  };

  /// Stores [value] at [key].
  ///
  /// Passing null removes the key from storage; a subsequent [get] for that key
  /// will return null.
  Future<void> set(String key, Pref? value) {
    log.entry(args: [key, value]);
    final v = _set(key, value);
    return log.exit(r: v)!;
  }

  Future<void> _set(String key, Pref? value) => switch (value) {
    null => _prefs.remove(key),
    final PrefString v => _prefs.setString(key, v.value),
    final PrefBool v => _prefs.setBool(key, v.value),
    final PrefInt v => _prefs.setInt(key, v.value),
    final PrefDouble v => _prefs.setDouble(key, v.value),
  };

  /// Clears all stored preferences
  Future<void> clearAll() {
    log.entry<void>();
    final v = _clearAll();
    return log.exit(r: v)!;
  }

  Future<void> _clearAll() => _prefs.clear();
  //
}

sealed class Pref {}

class PrefString implements Pref {
  const PrefString(
    this.value,
  );

  final String value;
  static const hint = PrefString('');
  //
}

class PrefBool implements Pref {
  const PrefBool(
    // ignore: avoid_positional_boolean_parameters because it's domain-agnostic
    this.value,
  );

  final bool value;
  static const hint = PrefBool(false);
  //
}

class PrefInt implements Pref {
  const PrefInt(
    this.value,
  );

  final int value;
  static const hint = PrefInt(0);
  //
}

class PrefDouble implements Pref {
  const PrefDouble(
    this.value,
  );

  final double value;
  static const hint = PrefDouble(0);
  //
}
