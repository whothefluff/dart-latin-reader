// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morphological_search_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$morphologicalSearchHash() =>
    r'b0543b788f8f8b082c0d90c6449c5dd3946ffc59';

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

/// See also [morphologicalSearch].
@ProviderFor(morphologicalSearch)
const morphologicalSearchProvider = MorphologicalSearchFamily();

/// See also [morphologicalSearch].
class MorphologicalSearchFamily extends Family<AsyncValue<Results>> {
  /// See also [morphologicalSearch].
  const MorphologicalSearchFamily();

  /// See also [morphologicalSearch].
  MorphologicalSearchProvider call(
    String form,
  ) {
    return MorphologicalSearchProvider(
      form,
    );
  }

  @override
  MorphologicalSearchProvider getProviderOverride(
    covariant MorphologicalSearchProvider provider,
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
  String? get name => r'morphologicalSearchProvider';
}

/// See also [morphologicalSearch].
class MorphologicalSearchProvider extends AutoDisposeFutureProvider<Results> {
  /// See also [morphologicalSearch].
  MorphologicalSearchProvider(
    String form,
  ) : this._internal(
          (ref) => morphologicalSearch(
            ref as MorphologicalSearchRef,
            form,
          ),
          from: morphologicalSearchProvider,
          name: r'morphologicalSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$morphologicalSearchHash,
          dependencies: MorphologicalSearchFamily._dependencies,
          allTransitiveDependencies:
              MorphologicalSearchFamily._allTransitiveDependencies,
          form: form,
        );

  MorphologicalSearchProvider._internal(
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
    FutureOr<Results> Function(MorphologicalSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MorphologicalSearchProvider._internal(
        (ref) => create(ref as MorphologicalSearchRef),
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
  AutoDisposeFutureProviderElement<Results> createElement() {
    return _MorphologicalSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MorphologicalSearchProvider && other.form == form;
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
mixin MorphologicalSearchRef on AutoDisposeFutureProviderRef<Results> {
  /// The parameter `form` of this provider.
  String get form;
}

class _MorphologicalSearchProviderElement
    extends AutoDisposeFutureProviderElement<Results>
    with MorphologicalSearchRef {
  _MorphologicalSearchProviderElement(super.provider);

  @override
  String get form => (origin as MorphologicalSearchProvider).form;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
