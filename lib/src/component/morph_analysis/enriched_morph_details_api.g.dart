// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enriched_morph_details_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enrichedMorphologicalAnalysesHash() =>
    r'78445436cb0f98499ace6db252a568599c717f73';

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

/// See also [enrichedMorphologicalAnalyses].
@ProviderFor(enrichedMorphologicalAnalyses)
const enrichedMorphologicalAnalysesProvider =
    EnrichedMorphologicalAnalysesFamily();

/// See also [enrichedMorphologicalAnalyses].
class EnrichedMorphologicalAnalysesFamily
    extends Family<AsyncValue<EnrichedAnalyses>> {
  /// See also [enrichedMorphologicalAnalyses].
  const EnrichedMorphologicalAnalysesFamily();

  /// See also [enrichedMorphologicalAnalyses].
  EnrichedMorphologicalAnalysesProvider call(AnalysisKeys keys) {
    return EnrichedMorphologicalAnalysesProvider(keys);
  }

  @override
  EnrichedMorphologicalAnalysesProvider getProviderOverride(
    covariant EnrichedMorphologicalAnalysesProvider provider,
  ) {
    return call(provider.keys);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'enrichedMorphologicalAnalysesProvider';
}

/// See also [enrichedMorphologicalAnalyses].
class EnrichedMorphologicalAnalysesProvider
    extends AutoDisposeFutureProvider<EnrichedAnalyses> {
  /// See also [enrichedMorphologicalAnalyses].
  EnrichedMorphologicalAnalysesProvider(AnalysisKeys keys)
    : this._internal(
        (ref) => enrichedMorphologicalAnalyses(
          ref as EnrichedMorphologicalAnalysesRef,
          keys,
        ),
        from: enrichedMorphologicalAnalysesProvider,
        name: r'enrichedMorphologicalAnalysesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$enrichedMorphologicalAnalysesHash,
        dependencies: EnrichedMorphologicalAnalysesFamily._dependencies,
        allTransitiveDependencies:
            EnrichedMorphologicalAnalysesFamily._allTransitiveDependencies,
        keys: keys,
      );

  EnrichedMorphologicalAnalysesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.keys,
  }) : super.internal();

  final AnalysisKeys keys;

  @override
  Override overrideWith(
    FutureOr<EnrichedAnalyses> Function(
      EnrichedMorphologicalAnalysesRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EnrichedMorphologicalAnalysesProvider._internal(
        (ref) => create(ref as EnrichedMorphologicalAnalysesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        keys: keys,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EnrichedAnalyses> createElement() {
    return _EnrichedMorphologicalAnalysesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnrichedMorphologicalAnalysesProvider && other.keys == keys;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, keys.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EnrichedMorphologicalAnalysesRef
    on AutoDisposeFutureProviderRef<EnrichedAnalyses> {
  /// The parameter `keys` of this provider.
  AnalysisKeys get keys;
}

class _EnrichedMorphologicalAnalysesProviderElement
    extends AutoDisposeFutureProviderElement<EnrichedAnalyses>
    with EnrichedMorphologicalAnalysesRef {
  _EnrichedMorphologicalAnalysesProviderElement(super.provider);

  @override
  AnalysisKeys get keys =>
      (origin as EnrichedMorphologicalAnalysesProvider).keys;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
