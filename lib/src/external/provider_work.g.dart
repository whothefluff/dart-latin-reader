// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_work.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryWorkDetailsHash() =>
    r'a4747e9b2a754bb028a66032bbb13f1b8de03237';

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

/// See also [libraryWorkDetails].
@ProviderFor(libraryWorkDetails)
const libraryWorkDetailsProvider = LibraryWorkDetailsFamily();

/// See also [libraryWorkDetails].
class LibraryWorkDetailsFamily extends Family<AsyncValue<WorkDetailsView>> {
  /// See also [libraryWorkDetails].
  const LibraryWorkDetailsFamily();

  /// See also [libraryWorkDetails].
  LibraryWorkDetailsProvider call(
    String id,
  ) {
    return LibraryWorkDetailsProvider(
      id,
    );
  }

  @override
  LibraryWorkDetailsProvider getProviderOverride(
    covariant LibraryWorkDetailsProvider provider,
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
  String? get name => r'libraryWorkDetailsProvider';
}

/// See also [libraryWorkDetails].
class LibraryWorkDetailsProvider
    extends AutoDisposeFutureProvider<WorkDetailsView> {
  /// See also [libraryWorkDetails].
  LibraryWorkDetailsProvider(
    String id,
  ) : this._internal(
          (ref) => libraryWorkDetails(
            ref as LibraryWorkDetailsRef,
            id,
          ),
          from: libraryWorkDetailsProvider,
          name: r'libraryWorkDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$libraryWorkDetailsHash,
          dependencies: LibraryWorkDetailsFamily._dependencies,
          allTransitiveDependencies:
              LibraryWorkDetailsFamily._allTransitiveDependencies,
          id: id,
        );

  LibraryWorkDetailsProvider._internal(
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
    FutureOr<WorkDetailsView> Function(LibraryWorkDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LibraryWorkDetailsProvider._internal(
        (ref) => create(ref as LibraryWorkDetailsRef),
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
  AutoDisposeFutureProviderElement<WorkDetailsView> createElement() {
    return _LibraryWorkDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryWorkDetailsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LibraryWorkDetailsRef on AutoDisposeFutureProviderRef<WorkDetailsView> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LibraryWorkDetailsProviderElement
    extends AutoDisposeFutureProviderElement<WorkDetailsView>
    with LibraryWorkDetailsRef {
  _LibraryWorkDetailsProviderElement(super.provider);

  @override
  String get id => (origin as LibraryWorkDetailsProvider).id;
}

String _$libraryWorkContentsPartiallyHash() =>
    r'df1e7aaccb3512530775b64e00a3b5babc42f55c';

/// See also [libraryWorkContentsPartially].
@ProviderFor(libraryWorkContentsPartially)
const libraryWorkContentsPartiallyProvider =
    LibraryWorkContentsPartiallyFamily();

/// See also [libraryWorkContentsPartially].
class LibraryWorkContentsPartiallyFamily
    extends Family<AsyncValue<UnmodifiableListView<WorkContentsElementView>>> {
  /// See also [libraryWorkContentsPartially].
  const LibraryWorkContentsPartiallyFamily();

  /// See also [libraryWorkContentsPartially].
  LibraryWorkContentsPartiallyProvider call(
    String id,
    int fromIndex,
    int toIndex,
  ) {
    return LibraryWorkContentsPartiallyProvider(
      id,
      fromIndex,
      toIndex,
    );
  }

  @override
  LibraryWorkContentsPartiallyProvider getProviderOverride(
    covariant LibraryWorkContentsPartiallyProvider provider,
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
  String? get name => r'libraryWorkContentsPartiallyProvider';
}

/// See also [libraryWorkContentsPartially].
class LibraryWorkContentsPartiallyProvider extends AutoDisposeFutureProvider<
    UnmodifiableListView<WorkContentsElementView>> {
  /// See also [libraryWorkContentsPartially].
  LibraryWorkContentsPartiallyProvider(
    String id,
    int fromIndex,
    int toIndex,
  ) : this._internal(
          (ref) => libraryWorkContentsPartially(
            ref as LibraryWorkContentsPartiallyRef,
            id,
            fromIndex,
            toIndex,
          ),
          from: libraryWorkContentsPartiallyProvider,
          name: r'libraryWorkContentsPartiallyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$libraryWorkContentsPartiallyHash,
          dependencies: LibraryWorkContentsPartiallyFamily._dependencies,
          allTransitiveDependencies:
              LibraryWorkContentsPartiallyFamily._allTransitiveDependencies,
          id: id,
          fromIndex: fromIndex,
          toIndex: toIndex,
        );

  LibraryWorkContentsPartiallyProvider._internal(
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
    FutureOr<UnmodifiableListView<WorkContentsElementView>> Function(
            LibraryWorkContentsPartiallyRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LibraryWorkContentsPartiallyProvider._internal(
        (ref) => create(ref as LibraryWorkContentsPartiallyRef),
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
  AutoDisposeFutureProviderElement<
      UnmodifiableListView<WorkContentsElementView>> createElement() {
    return _LibraryWorkContentsPartiallyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryWorkContentsPartiallyProvider &&
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

mixin LibraryWorkContentsPartiallyRef on AutoDisposeFutureProviderRef<
    UnmodifiableListView<WorkContentsElementView>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `fromIndex` of this provider.
  int get fromIndex;

  /// The parameter `toIndex` of this provider.
  int get toIndex;
}

class _LibraryWorkContentsPartiallyProviderElement
    extends AutoDisposeFutureProviderElement<
        UnmodifiableListView<WorkContentsElementView>>
    with LibraryWorkContentsPartiallyRef {
  _LibraryWorkContentsPartiallyProviderElement(super.provider);

  @override
  String get id => (origin as LibraryWorkContentsPartiallyProvider).id;
  @override
  int get fromIndex =>
      (origin as LibraryWorkContentsPartiallyProvider).fromIndex;
  @override
  int get toIndex => (origin as LibraryWorkContentsPartiallyProvider).toIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
