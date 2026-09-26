// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lemma_choices_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lemmaChoicesHash() => r'0cdde3fe35f15083817b958bfada4f6142413fd3';

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

/// Lemmas starting with [prefix], exact match first, then shortest first
///
/// Copied from [lemmaChoices].
@ProviderFor(lemmaChoices)
const lemmaChoicesProvider = LemmaChoicesFamily();

/// Lemmas starting with [prefix], exact match first, then shortest first
///
/// Copied from [lemmaChoices].
class LemmaChoicesFamily extends Family<AsyncValue<LemmaChoices>> {
  /// Lemmas starting with [prefix], exact match first, then shortest first
  ///
  /// Copied from [lemmaChoices].
  const LemmaChoicesFamily();

  /// Lemmas starting with [prefix], exact match first, then shortest first
  ///
  /// Copied from [lemmaChoices].
  LemmaChoicesProvider call(String prefix) {
    return LemmaChoicesProvider(prefix);
  }

  @override
  LemmaChoicesProvider getProviderOverride(
    covariant LemmaChoicesProvider provider,
  ) {
    return call(provider.prefix);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lemmaChoicesProvider';
}

/// Lemmas starting with [prefix], exact match first, then shortest first
///
/// Copied from [lemmaChoices].
class LemmaChoicesProvider extends AutoDisposeFutureProvider<LemmaChoices> {
  /// Lemmas starting with [prefix], exact match first, then shortest first
  ///
  /// Copied from [lemmaChoices].
  LemmaChoicesProvider(String prefix)
    : this._internal(
        (ref) => lemmaChoices(ref as LemmaChoicesRef, prefix),
        from: lemmaChoicesProvider,
        name: r'lemmaChoicesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lemmaChoicesHash,
        dependencies: LemmaChoicesFamily._dependencies,
        allTransitiveDependencies:
            LemmaChoicesFamily._allTransitiveDependencies,
        prefix: prefix,
      );

  LemmaChoicesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.prefix,
  }) : super.internal();

  final String prefix;

  @override
  Override overrideWith(
    FutureOr<LemmaChoices> Function(LemmaChoicesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LemmaChoicesProvider._internal(
        (ref) => create(ref as LemmaChoicesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        prefix: prefix,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LemmaChoices> createElement() {
    return _LemmaChoicesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LemmaChoicesProvider && other.prefix == prefix;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, prefix.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LemmaChoicesRef on AutoDisposeFutureProviderRef<LemmaChoices> {
  /// The parameter `prefix` of this provider.
  String get prefix;
}

class _LemmaChoicesProviderElement
    extends AutoDisposeFutureProviderElement<LemmaChoices>
    with LemmaChoicesRef {
  _LemmaChoicesProviderElement(super.provider);

  @override
  String get prefix => (origin as LemmaChoicesProvider).prefix;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
