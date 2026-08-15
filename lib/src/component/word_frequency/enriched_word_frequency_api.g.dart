// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enriched_word_frequency_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enrichedFrequencyReportHash() =>
    r'f4c566426824e103bfe771bf90b23e806b396caa';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [enrichedFrequencyReport].
@ProviderFor(enrichedFrequencyReport)
const enrichedFrequencyReportProvider = EnrichedFrequencyReportFamily();

/// See also [enrichedFrequencyReport].
class EnrichedFrequencyReportFamily
    extends Family<AsyncValue<EnrichedFrequencyReport>> {
  /// See also [enrichedFrequencyReport].
  const EnrichedFrequencyReportFamily();

  /// See also [enrichedFrequencyReport].
  EnrichedFrequencyReportProvider call(FrequencyFilter filter) {
    return EnrichedFrequencyReportProvider(filter);
  }

  @override
  EnrichedFrequencyReportProvider getProviderOverride(
    covariant EnrichedFrequencyReportProvider provider,
  ) {
    return call(provider.filter);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'enrichedFrequencyReportProvider';
}

/// See also [enrichedFrequencyReport].
class EnrichedFrequencyReportProvider
    extends AutoDisposeFutureProvider<EnrichedFrequencyReport> {
  /// See also [enrichedFrequencyReport].
  EnrichedFrequencyReportProvider(FrequencyFilter filter)
    : this._internal(
        (ref) =>
            enrichedFrequencyReport(ref as EnrichedFrequencyReportRef, filter),
        from: enrichedFrequencyReportProvider,
        name: r'enrichedFrequencyReportProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$enrichedFrequencyReportHash,
        dependencies: EnrichedFrequencyReportFamily._dependencies,
        allTransitiveDependencies:
            EnrichedFrequencyReportFamily._allTransitiveDependencies,
        filter: filter,
      );

  EnrichedFrequencyReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final FrequencyFilter filter;

  @override
  Override overrideWith(
    FutureOr<EnrichedFrequencyReport> Function(
      EnrichedFrequencyReportRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EnrichedFrequencyReportProvider._internal(
        (ref) => create(ref as EnrichedFrequencyReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EnrichedFrequencyReport> createElement() {
    return _EnrichedFrequencyReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnrichedFrequencyReportProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EnrichedFrequencyReportRef
    on AutoDisposeFutureProviderRef<EnrichedFrequencyReport> {
  /// The parameter `filter` of this provider.
  FrequencyFilter get filter;
}

class _EnrichedFrequencyReportProviderElement
    extends AutoDisposeFutureProviderElement<EnrichedFrequencyReport>
    with EnrichedFrequencyReportRef {
  _EnrichedFrequencyReportProviderElement(super.provider);

  @override
  FrequencyFilter get filter =>
      (origin as EnrichedFrequencyReportProvider).filter;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
