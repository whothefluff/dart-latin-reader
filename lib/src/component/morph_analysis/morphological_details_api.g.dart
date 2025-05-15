// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morphological_details_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$morphologicalDetailsByKeysHash() =>
    r'0ee61c616ed5251ea4e538082d7b50abe7e3cb47';

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

/// See also [morphologicalDetailsByKeys].
@ProviderFor(morphologicalDetailsByKeys)
const morphologicalDetailsByKeysProvider = MorphologicalDetailsByKeysFamily();

/// See also [morphologicalDetailsByKeys].
class MorphologicalDetailsByKeysFamily extends Family<AsyncValue<Analyses>> {
  /// See also [morphologicalDetailsByKeys].
  const MorphologicalDetailsByKeysFamily();

  /// See also [morphologicalDetailsByKeys].
  MorphologicalDetailsByKeysProvider call(
    AnalysisKeys keys,
  ) {
    return MorphologicalDetailsByKeysProvider(
      keys,
    );
  }

  @override
  MorphologicalDetailsByKeysProvider getProviderOverride(
    covariant MorphologicalDetailsByKeysProvider provider,
  ) {
    return call(
      provider.keys,
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
  String? get name => r'morphologicalDetailsByKeysProvider';
}

/// See also [morphologicalDetailsByKeys].
class MorphologicalDetailsByKeysProvider
    extends AutoDisposeFutureProvider<Analyses> {
  /// See also [morphologicalDetailsByKeys].
  MorphologicalDetailsByKeysProvider(
    AnalysisKeys keys,
  ) : this._internal(
          (ref) => morphologicalDetailsByKeys(
            ref as MorphologicalDetailsByKeysRef,
            keys,
          ),
          from: morphologicalDetailsByKeysProvider,
          name: r'morphologicalDetailsByKeysProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$morphologicalDetailsByKeysHash,
          dependencies: MorphologicalDetailsByKeysFamily._dependencies,
          allTransitiveDependencies:
              MorphologicalDetailsByKeysFamily._allTransitiveDependencies,
          keys: keys,
        );

  MorphologicalDetailsByKeysProvider._internal(
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
    FutureOr<Analyses> Function(MorphologicalDetailsByKeysRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MorphologicalDetailsByKeysProvider._internal(
        (ref) => create(ref as MorphologicalDetailsByKeysRef),
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
  AutoDisposeFutureProviderElement<Analyses> createElement() {
    return _MorphologicalDetailsByKeysProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MorphologicalDetailsByKeysProvider && other.keys == keys;
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
mixin MorphologicalDetailsByKeysRef on AutoDisposeFutureProviderRef<Analyses> {
  /// The parameter `keys` of this provider.
  AnalysisKeys get keys;
}

class _MorphologicalDetailsByKeysProviderElement
    extends AutoDisposeFutureProviderElement<Analyses>
    with MorphologicalDetailsByKeysRef {
  _MorphologicalDetailsByKeysProviderElement(super.provider);

  @override
  AnalysisKeys get keys => (origin as MorphologicalDetailsByKeysProvider).keys;
}

String _$morphologicalDetailsByFormHash() =>
    r'2b0e96d88dbf2bb6bacbfe9655fdeb98a3e9b01a';

/// See also [morphologicalDetailsByForm].
@ProviderFor(morphologicalDetailsByForm)
const morphologicalDetailsByFormProvider = MorphologicalDetailsByFormFamily();

/// See also [morphologicalDetailsByForm].
class MorphologicalDetailsByFormFamily extends Family<AsyncValue<Analyses>> {
  /// See also [morphologicalDetailsByForm].
  const MorphologicalDetailsByFormFamily();

  /// See also [morphologicalDetailsByForm].
  MorphologicalDetailsByFormProvider call(
    String form,
  ) {
    return MorphologicalDetailsByFormProvider(
      form,
    );
  }

  @override
  MorphologicalDetailsByFormProvider getProviderOverride(
    covariant MorphologicalDetailsByFormProvider provider,
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
  String? get name => r'morphologicalDetailsByFormProvider';
}

/// See also [morphologicalDetailsByForm].
class MorphologicalDetailsByFormProvider
    extends AutoDisposeFutureProvider<Analyses> {
  /// See also [morphologicalDetailsByForm].
  MorphologicalDetailsByFormProvider(
    String form,
  ) : this._internal(
          (ref) => morphologicalDetailsByForm(
            ref as MorphologicalDetailsByFormRef,
            form,
          ),
          from: morphologicalDetailsByFormProvider,
          name: r'morphologicalDetailsByFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$morphologicalDetailsByFormHash,
          dependencies: MorphologicalDetailsByFormFamily._dependencies,
          allTransitiveDependencies:
              MorphologicalDetailsByFormFamily._allTransitiveDependencies,
          form: form,
        );

  MorphologicalDetailsByFormProvider._internal(
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
    FutureOr<Analyses> Function(MorphologicalDetailsByFormRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MorphologicalDetailsByFormProvider._internal(
        (ref) => create(ref as MorphologicalDetailsByFormRef),
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
  AutoDisposeFutureProviderElement<Analyses> createElement() {
    return _MorphologicalDetailsByFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MorphologicalDetailsByFormProvider && other.form == form;
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
mixin MorphologicalDetailsByFormRef on AutoDisposeFutureProviderRef<Analyses> {
  /// The parameter `form` of this provider.
  String get form;
}

class _MorphologicalDetailsByFormProviderElement
    extends AutoDisposeFutureProviderElement<Analyses>
    with MorphologicalDetailsByFormRef {
  _MorphologicalDetailsByFormProviderElement(super.provider);

  @override
  String get form => (origin as MorphologicalDetailsByFormProvider).form;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
