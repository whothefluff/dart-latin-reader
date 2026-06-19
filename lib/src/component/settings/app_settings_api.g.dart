// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appSettingsNotifierHash() =>
    r'4c27d44f9e18f92f11acdaf8d1e8218cba8e935d';

/// A Notifier that many Widgets can interact with to read global user settings,
/// update user settings, or listen to user settings changes.
///
/// It uses the [SettingsRepository] to persist these settings to local storage.
///
/// Copied from [AppSettingsNotifier].
@ProviderFor(AppSettingsNotifier)
final appSettingsNotifierProvider =
    AsyncNotifierProvider<AppSettingsNotifier, AppSettings>.internal(
      AppSettingsNotifier.new,
      name: r'appSettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appSettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppSettingsNotifier = AsyncNotifier<AppSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
