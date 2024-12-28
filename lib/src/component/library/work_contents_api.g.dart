// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_contents_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workContentsHash() => r'596b0a29a234fb134fa243b96b5e4ea3c60a57ac';

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

/// See also [workContents].
@ProviderFor(workContents)
const workContentsProvider = WorkContentsFamily();

/// See also [workContents].
class WorkContentsFamily extends Family<AsyncValue<WorkContentsSegments>> {
  /// See also [workContents].
  const WorkContentsFamily();

  /// See also [workContents].
  WorkContentsProvider call(
    String id,
    int fromIndex,
    int toIndex,
  ) {
    return WorkContentsProvider(
      id,
      fromIndex,
      toIndex,
    );
  }

  @override
  WorkContentsProvider getProviderOverride(
    covariant WorkContentsProvider provider,
  ) {
    return call(
      provider.id,
      provider.fromIndex,
      provider.toIndex,
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
  String? get name => r'workContentsProvider';
}

/// See also [workContents].
class WorkContentsProvider
    extends AutoDisposeFutureProvider<WorkContentsSegments> {
  /// See also [workContents].
  WorkContentsProvider(
    String id,
    int fromIndex,
    int toIndex,
  ) : this._internal(
          (ref) => workContents(
            ref as WorkContentsRef,
            id,
            fromIndex,
            toIndex,
          ),
          from: workContentsProvider,
          name: r'workContentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$workContentsHash,
          dependencies: WorkContentsFamily._dependencies,
          allTransitiveDependencies:
              WorkContentsFamily._allTransitiveDependencies,
          id: id,
          fromIndex: fromIndex,
          toIndex: toIndex,
        );

  WorkContentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.fromIndex,
    required this.toIndex,
  }) : super.internal();

  final String id;
  final int fromIndex;
  final int toIndex;

  @override
  Override overrideWith(
    FutureOr<WorkContentsSegments> Function(WorkContentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkContentsProvider._internal(
        (ref) => create(ref as WorkContentsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        fromIndex: fromIndex,
        toIndex: toIndex,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WorkContentsSegments> createElement() {
    return _WorkContentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkContentsProvider &&
        other.id == id &&
        other.fromIndex == fromIndex &&
        other.toIndex == toIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, fromIndex.hashCode);
    hash = _SystemHash.combine(hash, toIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkContentsRef on AutoDisposeFutureProviderRef<WorkContentsSegments> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `fromIndex` of this provider.
  int get fromIndex;

  /// The parameter `toIndex` of this provider.
  int get toIndex;
}

class _WorkContentsProviderElement
    extends AutoDisposeFutureProviderElement<WorkContentsSegments>
    with WorkContentsRef {
  _WorkContentsProviderElement(super.provider);

  @override
  String get id => (origin as WorkContentsProvider).id;
  @override
  int get fromIndex => (origin as WorkContentsProvider).fromIndex;
  @override
  int get toIndex => (origin as WorkContentsProvider).toIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
