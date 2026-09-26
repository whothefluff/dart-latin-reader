// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concordance_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$concordanceHitsHash() => r'acaddb142c4ea66163d3f8ecafcf3e877b2ce79c';

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

/// The hits of [query].
///
/// [limit] entries starting from [offset].
///
/// Copied from [concordanceHits].
@ProviderFor(concordanceHits)
const concordanceHitsProvider = ConcordanceHitsFamily();

/// The hits of [query].
///
/// [limit] entries starting from [offset].
///
/// Copied from [concordanceHits].
class ConcordanceHitsFamily extends Family<AsyncValue<ConcordanceHits>> {
  /// The hits of [query].
  ///
  /// [limit] entries starting from [offset].
  ///
  /// Copied from [concordanceHits].
  const ConcordanceHitsFamily();

  /// The hits of [query].
  ///
  /// [limit] entries starting from [offset].
  ///
  /// Copied from [concordanceHits].
  ConcordanceHitsProvider call(ConcordanceQuery query, int offset, int limit) {
    return ConcordanceHitsProvider(query, offset, limit);
  }

  @override
  ConcordanceHitsProvider getProviderOverride(
    covariant ConcordanceHitsProvider provider,
  ) {
    return call(provider.query, provider.offset, provider.limit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'concordanceHitsProvider';
}

/// The hits of [query].
///
/// [limit] entries starting from [offset].
///
/// Copied from [concordanceHits].
class ConcordanceHitsProvider
    extends AutoDisposeFutureProvider<ConcordanceHits> {
  /// The hits of [query].
  ///
  /// [limit] entries starting from [offset].
  ///
  /// Copied from [concordanceHits].
  ConcordanceHitsProvider(ConcordanceQuery query, int offset, int limit)
    : this._internal(
        (ref) =>
            concordanceHits(ref as ConcordanceHitsRef, query, offset, limit),
        from: concordanceHitsProvider,
        name: r'concordanceHitsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$concordanceHitsHash,
        dependencies: ConcordanceHitsFamily._dependencies,
        allTransitiveDependencies:
            ConcordanceHitsFamily._allTransitiveDependencies,
        query: query,
        offset: offset,
        limit: limit,
      );

  ConcordanceHitsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.offset,
    required this.limit,
  }) : super.internal();

  final ConcordanceQuery query;
  final int offset;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<ConcordanceHits> Function(ConcordanceHitsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConcordanceHitsProvider._internal(
        (ref) => create(ref as ConcordanceHitsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        offset: offset,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ConcordanceHits> createElement() {
    return _ConcordanceHitsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConcordanceHitsProvider &&
        other.query == query &&
        other.offset == offset &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ConcordanceHitsRef on AutoDisposeFutureProviderRef<ConcordanceHits> {
  /// The parameter `query` of this provider.
  ConcordanceQuery get query;

  /// The parameter `offset` of this provider.
  int get offset;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _ConcordanceHitsProviderElement
    extends AutoDisposeFutureProviderElement<ConcordanceHits>
    with ConcordanceHitsRef {
  _ConcordanceHitsProviderElement(super.provider);

  @override
  ConcordanceQuery get query => (origin as ConcordanceHitsProvider).query;
  @override
  int get offset => (origin as ConcordanceHitsProvider).offset;
  @override
  int get limit => (origin as ConcordanceHitsProvider).limit;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
