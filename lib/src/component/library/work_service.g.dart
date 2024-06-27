// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workServiceHash() => r'ebb5afe16b504a527d8bb70b6033bc9527d24f18';

/// See also [workService].
@ProviderFor(workService)
final workServiceProvider = AutoDisposeProvider<WorkService>.internal(
  workService,
  name: r'workServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$workServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WorkServiceRef = AutoDisposeProviderRef<WorkService>;
String _$worksHash() => r'ec461f3d27ee50a91ce112b35a43daa59c3cb8bd';

/// See also [works].
@ProviderFor(works)
final worksProvider = AutoDisposeFutureProvider<e.Works>.internal(
  works,
  name: r'worksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$worksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WorksRef = AutoDisposeFutureProviderRef<e.Works>;
String _$worksWithAuthorsHash() => r'a14b5988c1f650f61b6f7f2a8caf0f074c534ab6';

/// See also [worksWithAuthors].
@ProviderFor(worksWithAuthors)
final worksWithAuthorsProvider = AutoDisposeFutureProvider<e.Works>.internal(
  worksWithAuthors,
  name: r'worksWithAuthorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$worksWithAuthorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WorksWithAuthorsRef = AutoDisposeFutureProviderRef<e.Works>;
String _$workHash() => r'8143a0214b14f97cd1c4ae4dc8de6b2d462c89b9';

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

/// See also [work].
@ProviderFor(work)
const workProvider = WorkFamily();

/// See also [work].
class WorkFamily extends Family<AsyncValue<e.Work>> {
  /// See also [work].
  const WorkFamily();

  /// See also [work].
  WorkProvider call(
    String id,
  ) {
    return WorkProvider(
      id,
    );
  }

  @override
  WorkProvider getProviderOverride(
    covariant WorkProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'workProvider';
}

/// See also [work].
class WorkProvider extends AutoDisposeFutureProvider<e.Work> {
  /// See also [work].
  WorkProvider(
    String id,
  ) : this._internal(
          (ref) => work(
            ref as WorkRef,
            id,
          ),
          from: workProvider,
          name: r'workProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$workHash,
          dependencies: WorkFamily._dependencies,
          allTransitiveDependencies: WorkFamily._allTransitiveDependencies,
          id: id,
        );

  WorkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<e.Work> Function(WorkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkProvider._internal(
        (ref) => create(ref as WorkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<e.Work> createElement() {
    return _WorkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WorkRef on AutoDisposeFutureProviderRef<e.Work> {
  /// The parameter `id` of this provider.
  String get id;
}

class _WorkProviderElement extends AutoDisposeFutureProviderElement<e.Work>
    with WorkRef {
  _WorkProviderElement(super.provider);

  @override
  String get id => (origin as WorkProvider).id;
}

String _$worksByAuthorHash() => r'250e4bee225809f868d74125614d8b06ac150e93';

/// See also [worksByAuthor].
@ProviderFor(worksByAuthor)
const worksByAuthorProvider = WorksByAuthorFamily();

/// See also [worksByAuthor].
class WorksByAuthorFamily extends Family<AsyncValue<e.Works>> {
  /// See also [worksByAuthor].
  const WorksByAuthorFamily();

  /// See also [worksByAuthor].
  WorksByAuthorProvider call(
    String authorId,
  ) {
    return WorksByAuthorProvider(
      authorId,
    );
  }

  @override
  WorksByAuthorProvider getProviderOverride(
    covariant WorksByAuthorProvider provider,
  ) {
    return call(
      provider.authorId,
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
  String? get name => r'worksByAuthorProvider';
}

/// See also [worksByAuthor].
class WorksByAuthorProvider extends AutoDisposeFutureProvider<e.Works> {
  /// See also [worksByAuthor].
  WorksByAuthorProvider(
    String authorId,
  ) : this._internal(
          (ref) => worksByAuthor(
            ref as WorksByAuthorRef,
            authorId,
          ),
          from: worksByAuthorProvider,
          name: r'worksByAuthorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$worksByAuthorHash,
          dependencies: WorksByAuthorFamily._dependencies,
          allTransitiveDependencies:
              WorksByAuthorFamily._allTransitiveDependencies,
          authorId: authorId,
        );

  WorksByAuthorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.authorId,
  }) : super.internal();

  final String authorId;

  @override
  Override overrideWith(
    FutureOr<e.Works> Function(WorksByAuthorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorksByAuthorProvider._internal(
        (ref) => create(ref as WorksByAuthorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        authorId: authorId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<e.Works> createElement() {
    return _WorksByAuthorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorksByAuthorProvider && other.authorId == authorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, authorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WorksByAuthorRef on AutoDisposeFutureProviderRef<e.Works> {
  /// The parameter `authorId` of this provider.
  String get authorId;
}

class _WorksByAuthorProviderElement
    extends AutoDisposeFutureProviderElement<e.Works> with WorksByAuthorRef {
  _WorksByAuthorProviderElement(super.provider);

  @override
  String get authorId => (origin as WorksByAuthorProvider).authorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
