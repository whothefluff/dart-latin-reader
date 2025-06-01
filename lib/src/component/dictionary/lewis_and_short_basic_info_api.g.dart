// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lewis_and_short_basic_info_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lnsBasicInfoHash() => r'1056cb95ddd871608810e3f11f265ddac84f298e';

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
class LnsBasicInfoFamily extends Family<AsyncValue<LnsBasicInfo>> {
  /// See also [lnsBasicInfo].
  const LnsBasicInfoFamily();

  /// See also [lnsBasicInfo].
  LnsBasicInfoProvider call(
    Iterable<String> lemmas,
  ) {
    return LnsBasicInfoProvider(
      lemmas,
    );
  }

  @override
  LnsBasicInfoProvider getProviderOverride(
    covariant LnsBasicInfoProvider provider,
  ) {
    return call(
      provider.lemmas,
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
  String? get name => r'lnsBasicInfoProvider';
}

/// See also [lnsBasicInfo].
class LnsBasicInfoProvider extends AutoDisposeFutureProvider<LnsBasicInfo> {
  /// See also [lnsBasicInfo].
  LnsBasicInfoProvider(
    Iterable<String> lemmas,
  ) : this._internal(
          (ref) => lnsBasicInfo(
            ref as LnsBasicInfoRef,
            lemmas,
          ),
          from: lnsBasicInfoProvider,
          name: r'lnsBasicInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lnsBasicInfoHash,
          dependencies: LnsBasicInfoFamily._dependencies,
          allTransitiveDependencies:
              LnsBasicInfoFamily._allTransitiveDependencies,
          lemmas: lemmas,
        );

  LnsBasicInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lemmas,
  }) : super.internal();

  final Iterable<String> lemmas;

  @override
  Override overrideWith(
    FutureOr<LnsBasicInfo> Function(LnsBasicInfoRef provider) create,
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
        lemmas: lemmas,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LnsBasicInfo> createElement() {
    return _LnsBasicInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LnsBasicInfoProvider && other.lemmas == lemmas;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lemmas.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LnsBasicInfoRef on AutoDisposeFutureProviderRef<LnsBasicInfo> {
  /// The parameter `lemmas` of this provider.
  Iterable<String> get lemmas;
}

class _LnsBasicInfoProviderElement
    extends AutoDisposeFutureProviderElement<LnsBasicInfo>
    with LnsBasicInfoRef {
  _LnsBasicInfoProviderElement(super.provider);

  @override
  Iterable<String> get lemmas => (origin as LnsBasicInfoProvider).lemmas;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
