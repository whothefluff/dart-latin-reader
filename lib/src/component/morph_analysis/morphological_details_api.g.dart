// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morphological_details_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$morphologicalAnalysesHash() =>
    r'289ef353576feab0019105437f07ffca9577d4c4';

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

/// See also [morphologicalAnalyses].
@ProviderFor(morphologicalAnalyses)
const morphologicalAnalysesProvider = MorphologicalAnalysesFamily();

/// See also [morphologicalAnalyses].
class MorphologicalAnalysesFamily extends Family<AsyncValue<Analyses>> {
  /// See also [morphologicalAnalyses].
  const MorphologicalAnalysesFamily();

  /// See also [morphologicalAnalyses].
  MorphologicalAnalysesProvider call(AnalysisKeys keys) {
    return MorphologicalAnalysesProvider(keys);
  }

  @override
  MorphologicalAnalysesProvider getProviderOverride(
    covariant MorphologicalAnalysesProvider provider,
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
  String? get name => r'morphologicalAnalysesProvider';
}

/// See also [morphologicalAnalyses].
class MorphologicalAnalysesProvider
    extends AutoDisposeFutureProvider<Analyses> {
  /// See also [morphologicalAnalyses].
  MorphologicalAnalysesProvider(AnalysisKeys keys)
    : this._internal(
        (ref) => morphologicalAnalyses(ref as MorphologicalAnalysesRef, keys),
        from: morphologicalAnalysesProvider,
        name: r'morphologicalAnalysesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$morphologicalAnalysesHash,
        dependencies: MorphologicalAnalysesFamily._dependencies,
        allTransitiveDependencies:
            MorphologicalAnalysesFamily._allTransitiveDependencies,
        keys: keys,
      );

  MorphologicalAnalysesProvider._internal(
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
    FutureOr<Analyses> Function(MorphologicalAnalysesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MorphologicalAnalysesProvider._internal(
        (ref) => create(ref as MorphologicalAnalysesRef),
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
    return _MorphologicalAnalysesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MorphologicalAnalysesProvider && other.keys == keys;
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
mixin MorphologicalAnalysesRef on AutoDisposeFutureProviderRef<Analyses> {
  /// The parameter `keys` of this provider.
  AnalysisKeys get keys;
}

class _MorphologicalAnalysesProviderElement
    extends AutoDisposeFutureProviderElement<Analyses>
    with MorphologicalAnalysesRef {
  _MorphologicalAnalysesProviderElement(super.provider);

  @override
  AnalysisKeys get keys => (origin as MorphologicalAnalysesProvider).keys;
}

String _$morphologicalAnalysisKeysHash() =>
    r'cc84378a1ea6376e2895b668990f9694c6ce6486';

/// See also [morphologicalAnalysisKeys].
@ProviderFor(morphologicalAnalysisKeys)
const morphologicalAnalysisKeysProvider = MorphologicalAnalysisKeysFamily();

/// See also [morphologicalAnalysisKeys].
class MorphologicalAnalysisKeysFamily extends Family<AsyncValue<AnalysisKeys>> {
  /// See also [morphologicalAnalysisKeys].
  const MorphologicalAnalysisKeysFamily();

  /// See also [morphologicalAnalysisKeys].
  MorphologicalAnalysisKeysProvider call(String form) {
    return MorphologicalAnalysisKeysProvider(form);
  }

  @override
  MorphologicalAnalysisKeysProvider getProviderOverride(
    covariant MorphologicalAnalysisKeysProvider provider,
  ) {
    return call(provider.form);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'morphologicalAnalysisKeysProvider';
}

/// See also [morphologicalAnalysisKeys].
class MorphologicalAnalysisKeysProvider
    extends AutoDisposeFutureProvider<AnalysisKeys> {
  /// See also [morphologicalAnalysisKeys].
  MorphologicalAnalysisKeysProvider(String form)
    : this._internal(
        (ref) => morphologicalAnalysisKeys(
          ref as MorphologicalAnalysisKeysRef,
          form,
        ),
        from: morphologicalAnalysisKeysProvider,
        name: r'morphologicalAnalysisKeysProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$morphologicalAnalysisKeysHash,
        dependencies: MorphologicalAnalysisKeysFamily._dependencies,
        allTransitiveDependencies:
            MorphologicalAnalysisKeysFamily._allTransitiveDependencies,
        form: form,
      );

  MorphologicalAnalysisKeysProvider._internal(
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
    FutureOr<AnalysisKeys> Function(MorphologicalAnalysisKeysRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MorphologicalAnalysisKeysProvider._internal(
        (ref) => create(ref as MorphologicalAnalysisKeysRef),
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
  AutoDisposeFutureProviderElement<AnalysisKeys> createElement() {
    return _MorphologicalAnalysisKeysProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MorphologicalAnalysisKeysProvider && other.form == form;
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
mixin MorphologicalAnalysisKeysRef
    on AutoDisposeFutureProviderRef<AnalysisKeys> {
  /// The parameter `form` of this provider.
  String get form;
}

class _MorphologicalAnalysisKeysProviderElement
    extends AutoDisposeFutureProviderElement<AnalysisKeys>
    with MorphologicalAnalysisKeysRef {
  _MorphologicalAnalysisKeysProviderElement(super.provider);

  @override
  String get form => (origin as MorphologicalAnalysisKeysProvider).form;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
