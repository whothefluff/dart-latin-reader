// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_details_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workDetailsHash() => r'4dab8c0895bb481c1515def30792e77e06f9a542';

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

/// See also [workDetails].
@ProviderFor(workDetails)
const workDetailsProvider = WorkDetailsFamily();

/// See also [workDetails].
class WorkDetailsFamily extends Family<AsyncValue<WorkDetails>> {
  /// See also [workDetails].
  const WorkDetailsFamily();

  /// See also [workDetails].
  WorkDetailsProvider call(String work) {
    return WorkDetailsProvider(work);
  }

  @override
  WorkDetailsProvider getProviderOverride(
    covariant WorkDetailsProvider provider,
  ) {
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
  String? get name => r'workDetailsProvider';
}

/// See also [workDetails].
class WorkDetailsProvider extends AutoDisposeFutureProvider<WorkDetails> {
  /// See also [workDetails].
  WorkDetailsProvider(String work)
    : this._internal(
        (ref) => workDetails(ref as WorkDetailsRef, work),
        from: workDetailsProvider,
        name: r'workDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$workDetailsHash,
        dependencies: WorkDetailsFamily._dependencies,
        allTransitiveDependencies: WorkDetailsFamily._allTransitiveDependencies,
        work: work,
      );

  WorkDetailsProvider._internal(
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
    FutureOr<WorkDetails> Function(WorkDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkDetailsProvider._internal(
        (ref) => create(ref as WorkDetailsRef),
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
  AutoDisposeFutureProviderElement<WorkDetails> createElement() {
    return _WorkDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkDetailsProvider && other.work == work;
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
mixin WorkDetailsRef on AutoDisposeFutureProviderRef<WorkDetails> {
  /// The parameter `work` of this provider.
  String get work;
}

class _WorkDetailsProviderElement
    extends AutoDisposeFutureProviderElement<WorkDetails>
    with WorkDetailsRef {
  _WorkDetailsProviderElement(super.provider);

  @override
  String get work => (origin as WorkDetailsProvider).work;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
