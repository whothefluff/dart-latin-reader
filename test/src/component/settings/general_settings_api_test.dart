import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/settings/general_settings_api.dart';
import 'package:latin_reader/src/external/settings.dart';

class _InMemorySettings implements SettingsRepository {
  _InMemorySettings(
    this._values,
  );

  final Map<String, Pref> _values;

  @override
  Future<T?> get<T extends Pref>(String key, T typeHint) async => _values[key] as T?;

  @override
  Future<void> set(String key, Pref? value) async {
    if (value == null) {
      _values.remove(key);
    } else {
      _values[key] = value;
    }
  }

  @override
  Future<void> clearAll() async => _values.clear();

  //
}

ProviderContainer _containerFor(SettingsRepository repository) {
  final container = ProviderContainer(
    overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
  );
  addTearDown(container.dispose);
  return container;
}

Future<GeneralSettings> _loadAfterRestart(SettingsRepository repository) =>
    _containerFor(repository).read(generalSettingsNotifierProvider.future);

Future<void> _save(SettingsRepository repository, GeneralSettings settings) async {
  final container = _containerFor(repository);
  await container.read(generalSettingsNotifierProvider.future);
  await container.read(generalSettingsNotifierProvider.notifier).updateSettings(settings);
}

void main() {
  group('GeneralSettingsNotifier', () {
    test('an accent color is kept after a restart', () async {
      final repository = _InMemorySettings({'app.themeMode': const PrefString('dark')});
      const teal = GeneralSettings(themeMode: ThemeMode.dark, accentColor: Color(0xFF009688));

      await _save(repository, teal);

      expect(await _loadAfterRestart(repository), teal);
    });

    test('going back to the baseline is kept after a restart', () async {
      final repository = _InMemorySettings({
        'app.themeMode': const PrefString('dark'),
        'app.accentColor': const PrefInt(0xFF009688),
      });
      const baseline = GeneralSettings(themeMode: ThemeMode.dark);

      await _save(repository, baseline);

      expect(await _loadAfterRestart(repository), baseline);
    });
  });
}
