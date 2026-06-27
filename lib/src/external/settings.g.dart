// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsRepositoryHash() =>
    r'e157c2a8f962603662bd87ad8b95a9f4ae8b7d63';

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
///
/// Copied from [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider = Provider<SettingsRepository>.internal(
  settingsRepository,
  name: r'settingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = ProviderRef<SettingsRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
