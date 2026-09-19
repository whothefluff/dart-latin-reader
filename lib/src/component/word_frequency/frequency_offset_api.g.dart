// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequency_offset_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$frequencyOffsetNotifierHash() =>
    r'53e1fed506de120cc84c260eb9a33415fcc42649';

/// Tracks the pagination cursor for the word frequency report. Session state only.
///
/// Resets to zero when the frequency settings or library selection change.
///
/// Copied from [FrequencyOffsetNotifier].
@ProviderFor(FrequencyOffsetNotifier)
final frequencyOffsetNotifierProvider =
    AutoDisposeNotifierProvider<FrequencyOffsetNotifier, int>.internal(
      FrequencyOffsetNotifier.new,
      name: r'frequencyOffsetNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$frequencyOffsetNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FrequencyOffsetNotifier = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
