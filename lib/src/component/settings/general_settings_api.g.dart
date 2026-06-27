// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_settings_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$generalSettingsNotifierHash() =>
    r'33fabe0a4afe2928f187f2ea2a196d1c51c9f1f1';

/// A Notifier that many Widgets can interact with to read global user settings,
/// update user settings, or listen to user settings changes.
///
/// It uses the [SettingsRepository] to persist these settings
///
/// Copied from [GeneralSettingsNotifier].
@ProviderFor(GeneralSettingsNotifier)
final generalSettingsNotifierProvider =
    AsyncNotifierProvider<GeneralSettingsNotifier, GeneralSettings>.internal(
      GeneralSettingsNotifier.new,
      name: r'generalSettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$generalSettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GeneralSettingsNotifier = AsyncNotifier<GeneralSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
