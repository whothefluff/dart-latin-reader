// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lewis_and_short_basic_info_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lnsBasicInfoHash() => r'96e5a5980b63441913f59ff5c9bbceec5b2b7c26';

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

/// See also [lnsBasicInfo].
@ProviderFor(lnsBasicInfo)
const lnsBasicInfoProvider = LnsBasicInfoFamily();

/// See also [lnsBasicInfo].
class LnsBasicInfoFamily extends Family<AsyncValue<LnsBasicInfoByRef>> {
  /// See also [lnsBasicInfo].
  const LnsBasicInfoFamily();

  /// See also [lnsBasicInfo].
  LnsBasicInfoProvider call(PossibleLemmas lnsRefs) {
    return LnsBasicInfoProvider(lnsRefs);
  }

  @override
  LnsBasicInfoProvider getProviderOverride(
    covariant LnsBasicInfoProvider provider,
  ) {
    return call(provider.lnsRefs);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lnsBasicInfoProvider';
}

/// See also [lnsBasicInfo].
class LnsBasicInfoProvider
    extends AutoDisposeFutureProvider<LnsBasicInfoByRef> {
  /// See also [lnsBasicInfo].
  LnsBasicInfoProvider(PossibleLemmas lnsRefs)
    : this._internal(
        (ref) => lnsBasicInfo(ref as LnsBasicInfoRef, lnsRefs),
        from: lnsBasicInfoProvider,
        name: r'lnsBasicInfoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lnsBasicInfoHash,
        dependencies: LnsBasicInfoFamily._dependencies,
        allTransitiveDependencies:
            LnsBasicInfoFamily._allTransitiveDependencies,
        lnsRefs: lnsRefs,
      );

  LnsBasicInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lnsRefs,
  }) : super.internal();

  final PossibleLemmas lnsRefs;

  @override
  Override overrideWith(
    FutureOr<LnsBasicInfoByRef> Function(LnsBasicInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LnsBasicInfoProvider._internal(
        (ref) => create(ref as LnsBasicInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lnsRefs: lnsRefs,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LnsBasicInfoByRef> createElement() {
    return _LnsBasicInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LnsBasicInfoProvider && other.lnsRefs == lnsRefs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lnsRefs.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LnsBasicInfoRef on AutoDisposeFutureProviderRef<LnsBasicInfoByRef> {
  /// The parameter `lnsRefs` of this provider.
  PossibleLemmas get lnsRefs;
}

class _LnsBasicInfoProviderElement
    extends AutoDisposeFutureProviderElement<LnsBasicInfoByRef>
    with LnsBasicInfoRef {
  _LnsBasicInfoProviderElement(super.provider);

  @override
  PossibleLemmas get lnsRefs => (origin as LnsBasicInfoProvider).lnsRefs;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
