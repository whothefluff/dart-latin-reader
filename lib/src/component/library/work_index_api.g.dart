// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_index_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workIndexHash() => r'9a4dd9d69d261e5b3d2812477e2b4f369bea215c';

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

/// See also [workIndex].
@ProviderFor(workIndex)
const workIndexProvider = WorkIndexFamily();

/// See also [workIndex].
class WorkIndexFamily extends Family<AsyncValue<WorkIndex>> {
  /// See also [workIndex].
  const WorkIndexFamily();

  /// See also [workIndex].
  WorkIndexProvider call(String work) {
    return WorkIndexProvider(work);
  }

  @override
  WorkIndexProvider getProviderOverride(covariant WorkIndexProvider provider) {
    return call(provider.work);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'workIndexProvider';
}

/// See also [workIndex].
class WorkIndexProvider extends AutoDisposeFutureProvider<WorkIndex> {
  /// See also [workIndex].
  WorkIndexProvider(String work)
    : this._internal(
        (ref) => workIndex(ref as WorkIndexRef, work),
        from: workIndexProvider,
        name: r'workIndexProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$workIndexHash,
        dependencies: WorkIndexFamily._dependencies,
        allTransitiveDependencies: WorkIndexFamily._allTransitiveDependencies,
        work: work,
      );

  WorkIndexProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.work,
  }) : super.internal();

  final String work;

  @override
  Override overrideWith(
    FutureOr<WorkIndex> Function(WorkIndexRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkIndexProvider._internal(
        (ref) => create(ref as WorkIndexRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        work: work,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WorkIndex> createElement() {
    return _WorkIndexProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkIndexProvider && other.work == work;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, work.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkIndexRef on AutoDisposeFutureProviderRef<WorkIndex> {
  /// The parameter `work` of this provider.
  String get work;
}

class _WorkIndexProviderElement
    extends AutoDisposeFutureProviderElement<WorkIndex>
    with WorkIndexRef {
  _WorkIndexProviderElement(super.provider);

  @override
  String get work => (origin as WorkIndexProvider).work;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
