// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_frequency_filter_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeFrequencyFilterHash() =>
    r'430492a688b62ecaa1acbf9af57f62881e399533';

/// The [FrequencyFilter] the report is currently showing.
///
/// Builds the word frequency filter from the library selection, settings,
/// and current page offset.
///
/// An empty selection includes all works in the library.
///
/// Copied from [activeFrequencyFilter].
@ProviderFor(activeFrequencyFilter)
final activeFrequencyFilterProvider =
    AutoDisposeFutureProvider<FrequencyFilter>.internal(
      activeFrequencyFilter,
      name: r'activeFrequencyFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeFrequencyFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveFrequencyFilterRef =
    AutoDisposeFutureProviderRef<FrequencyFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
