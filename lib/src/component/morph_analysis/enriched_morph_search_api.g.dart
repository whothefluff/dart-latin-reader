// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enriched_morph_search_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enrichedMorphologicalSearchHash() =>
    r'248c68ac62d72ce2cfb356e6ed617feb0ba2af74';

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

/// See also [enrichedMorphologicalSearch].
@ProviderFor(enrichedMorphologicalSearch)
const enrichedMorphologicalSearchProvider = EnrichedMorphologicalSearchFamily();

/// See also [enrichedMorphologicalSearch].
class EnrichedMorphologicalSearchFamily
    extends Family<AsyncValue<EnrichedResults>> {
  /// See also [enrichedMorphologicalSearch].
  const EnrichedMorphologicalSearchFamily();

  /// See also [enrichedMorphologicalSearch].
  EnrichedMorphologicalSearchProvider call(
    String form,
  ) {
    return EnrichedMorphologicalSearchProvider(
      form,
    );
  }

  @override
  EnrichedMorphologicalSearchProvider getProviderOverride(
    covariant EnrichedMorphologicalSearchProvider provider,
  ) {
    return call(
      provider.form,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'enrichedMorphologicalSearchProvider';
}

/// See also [enrichedMorphologicalSearch].
class EnrichedMorphologicalSearchProvider
    extends AutoDisposeFutureProvider<EnrichedResults> {
  /// See also [enrichedMorphologicalSearch].
  EnrichedMorphologicalSearchProvider(
    String form,
  ) : this._internal(
          (ref) => enrichedMorphologicalSearch(
            ref as EnrichedMorphologicalSearchRef,
            form,
          ),
          from: enrichedMorphologicalSearchProvider,
          name: r'enrichedMorphologicalSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$enrichedMorphologicalSearchHash,
          dependencies: EnrichedMorphologicalSearchFamily._dependencies,
          allTransitiveDependencies:
              EnrichedMorphologicalSearchFamily._allTransitiveDependencies,
          form: form,
        );

  EnrichedMorphologicalSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.form,
  }) : super.internal();

  final String form;

  @override
  Override overrideWith(
    FutureOr<EnrichedResults> Function(EnrichedMorphologicalSearchRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EnrichedMorphologicalSearchProvider._internal(
        (ref) => create(ref as EnrichedMorphologicalSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        form: form,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EnrichedResults> createElement() {
    return _EnrichedMorphologicalSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnrichedMorphologicalSearchProvider && other.form == form;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EnrichedMorphologicalSearchRef
    on AutoDisposeFutureProviderRef<EnrichedResults> {
  /// The parameter `form` of this provider.
  String get form;
}

class _EnrichedMorphologicalSearchProviderElement
    extends AutoDisposeFutureProviderElement<EnrichedResults>
    with EnrichedMorphologicalSearchRef {
  _EnrichedMorphologicalSearchProviderElement(super.provider);

  @override
  String get form => (origin as EnrichedMorphologicalSearchProvider).form;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
