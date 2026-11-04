// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lewis_and_short_basic_info_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lnsBasicInfoHash() => r'098eb3d1f9160ff7287fd3d5438355c789db1d53';

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
  LnsBasicInfoProvider call(DictionaryRefs dictionaryRefs) {
    return LnsBasicInfoProvider(dictionaryRefs);
  }

  @override
  LnsBasicInfoProvider getProviderOverride(
    covariant LnsBasicInfoProvider provider,
  ) {
    return call(provider.dictionaryRefs);
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
  LnsBasicInfoProvider(DictionaryRefs dictionaryRefs)
    : this._internal(
        (ref) => lnsBasicInfo(ref as LnsBasicInfoRef, dictionaryRefs),
        from: lnsBasicInfoProvider,
        name: r'lnsBasicInfoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lnsBasicInfoHash,
        dependencies: LnsBasicInfoFamily._dependencies,
        allTransitiveDependencies:
            LnsBasicInfoFamily._allTransitiveDependencies,
        dictionaryRefs: dictionaryRefs,
      );

  LnsBasicInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dictionaryRefs,
  }) : super.internal();

  final DictionaryRefs dictionaryRefs;

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
        dictionaryRefs: dictionaryRefs,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LnsBasicInfoByRef> createElement() {
    return _LnsBasicInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LnsBasicInfoProvider &&
        other.dictionaryRefs == dictionaryRefs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dictionaryRefs.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LnsBasicInfoRef on AutoDisposeFutureProviderRef<LnsBasicInfoByRef> {
  /// The parameter `dictionaryRefs` of this provider.
  DictionaryRefs get dictionaryRefs;
}

class _LnsBasicInfoProviderElement
    extends AutoDisposeFutureProviderElement<LnsBasicInfoByRef>
    with LnsBasicInfoRef {
  _LnsBasicInfoProviderElement(super.provider);

  @override
  DictionaryRefs get dictionaryRefs =>
      (origin as LnsBasicInfoProvider).dictionaryRefs;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
