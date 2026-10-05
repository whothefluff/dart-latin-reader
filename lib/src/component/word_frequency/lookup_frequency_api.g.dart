// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookup_frequency_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lookupFrequenciesHash() => r'eaa9f8a45627ce2ff4cb50848069950c030e904f';

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

/// Returns the most frequent candidate lemma's count for every lookup of a form in [lookupForms],
/// plus any-candidate text coverage for the works selected by [scope] and [workId].
/// Keyed by plain forms, so the cache isn't split per macronized spelling.
///
/// Copied from [lookupFrequencies].
@ProviderFor(lookupFrequencies)
const lookupFrequenciesProvider = LookupFrequenciesFamily();

/// Returns the most frequent candidate lemma's count for every lookup of a form in [lookupForms],
/// plus any-candidate text coverage for the works selected by [scope] and [workId].
/// Keyed by plain forms, so the cache isn't split per macronized spelling.
///
/// Copied from [lookupFrequencies].
class LookupFrequenciesFamily extends Family<AsyncValue<LookupFrequencies>> {
  /// Returns the most frequent candidate lemma's count for every lookup of a form in [lookupForms],
  /// plus any-candidate text coverage for the works selected by [scope] and [workId].
  /// Keyed by plain forms, so the cache isn't split per macronized spelling.
  ///
  /// Copied from [lookupFrequencies].
  const LookupFrequenciesFamily();

  /// Returns the most frequent candidate lemma's count for every lookup of a form in [lookupForms],
  /// plus any-candidate text coverage for the works selected by [scope] and [workId].
  /// Keyed by plain forms, so the cache isn't split per macronized spelling.
  ///
  /// Copied from [lookupFrequencies].
  LookupFrequenciesProvider call(
    String workId,
    FrequencyScope scope,
    LookupForms lookupForms,
  ) {
    return LookupFrequenciesProvider(workId, scope, lookupForms);
  }

  @override
  LookupFrequenciesProvider getProviderOverride(
    covariant LookupFrequenciesProvider provider,
  ) {
    return call(provider.workId, provider.scope, provider.lookupForms);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lookupFrequenciesProvider';
}

/// Returns the most frequent candidate lemma's count for every lookup of a form in [lookupForms],
/// plus any-candidate text coverage for the works selected by [scope] and [workId].
/// Keyed by plain forms, so the cache isn't split per macronized spelling.
///
/// Copied from [lookupFrequencies].
class LookupFrequenciesProvider
    extends AutoDisposeFutureProvider<LookupFrequencies> {
  /// Returns the most frequent candidate lemma's count for every lookup of a form in [lookupForms],
  /// plus any-candidate text coverage for the works selected by [scope] and [workId].
  /// Keyed by plain forms, so the cache isn't split per macronized spelling.
  ///
  /// Copied from [lookupFrequencies].
  LookupFrequenciesProvider(
    String workId,
    FrequencyScope scope,
    LookupForms lookupForms,
  ) : this._internal(
        (ref) => lookupFrequencies(
          ref as LookupFrequenciesRef,
          workId,
          scope,
          lookupForms,
        ),
        from: lookupFrequenciesProvider,
        name: r'lookupFrequenciesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lookupFrequenciesHash,
        dependencies: LookupFrequenciesFamily._dependencies,
        allTransitiveDependencies:
            LookupFrequenciesFamily._allTransitiveDependencies,
        workId: workId,
        scope: scope,
        lookupForms: lookupForms,
      );

  LookupFrequenciesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workId,
    required this.scope,
    required this.lookupForms,
  }) : super.internal();

  final String workId;
  final FrequencyScope scope;
  final LookupForms lookupForms;

  @override
  Override overrideWith(
    FutureOr<LookupFrequencies> Function(LookupFrequenciesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LookupFrequenciesProvider._internal(
        (ref) => create(ref as LookupFrequenciesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workId: workId,
        scope: scope,
        lookupForms: lookupForms,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LookupFrequencies> createElement() {
    return _LookupFrequenciesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LookupFrequenciesProvider &&
        other.workId == workId &&
        other.scope == scope &&
        other.lookupForms == lookupForms;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workId.hashCode);
    hash = _SystemHash.combine(hash, scope.hashCode);
    hash = _SystemHash.combine(hash, lookupForms.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LookupFrequenciesRef on AutoDisposeFutureProviderRef<LookupFrequencies> {
  /// The parameter `workId` of this provider.
  String get workId;

  /// The parameter `scope` of this provider.
  FrequencyScope get scope;

  /// The parameter `lookupForms` of this provider.
  LookupForms get lookupForms;
}

class _LookupFrequenciesProviderElement
    extends AutoDisposeFutureProviderElement<LookupFrequencies>
    with LookupFrequenciesRef {
  _LookupFrequenciesProviderElement(super.provider);

  @override
  String get workId => (origin as LookupFrequenciesProvider).workId;
  @override
  FrequencyScope get scope => (origin as LookupFrequenciesProvider).scope;
  @override
  LookupForms get lookupForms =>
      (origin as LookupFrequenciesProvider).lookupForms;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
