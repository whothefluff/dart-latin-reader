// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_author.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryAuthorsHash() => r'213f68ac8901b640f4d4c8d9ef8d5052df0282a0';

/// See also [libraryAuthors].
@ProviderFor(libraryAuthors)
final libraryAuthorsProvider =
    AutoDisposeFutureProvider<UnmodifiableListView<AuthorView>>.internal(
  libraryAuthors,
  name: r'libraryAuthorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$libraryAuthorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LibraryAuthorsRef
    = AutoDisposeFutureProviderRef<UnmodifiableListView<AuthorView>>;
String _$libraryAuthorDetailsHash() =>
    r'537b144746456ba29e0dba56dc0b91bece3c8f5b';

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

/// See also [libraryAuthorDetails].
@ProviderFor(libraryAuthorDetails)
const libraryAuthorDetailsProvider = LibraryAuthorDetailsFamily();

/// See also [libraryAuthorDetails].
class LibraryAuthorDetailsFamily extends Family<AsyncValue<AuthorDetailsView>> {
  /// See also [libraryAuthorDetails].
  const LibraryAuthorDetailsFamily();

  /// See also [libraryAuthorDetails].
  LibraryAuthorDetailsProvider call(
    String id,
  ) {
    return LibraryAuthorDetailsProvider(
      id,
    );
  }

  @override
  LibraryAuthorDetailsProvider getProviderOverride(
    covariant LibraryAuthorDetailsProvider provider,
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
  String? get name => r'libraryAuthorDetailsProvider';
}

/// See also [libraryAuthorDetails].
class LibraryAuthorDetailsProvider
    extends AutoDisposeFutureProvider<AuthorDetailsView> {
  /// See also [libraryAuthorDetails].
  LibraryAuthorDetailsProvider(
    String id,
  ) : this._internal(
          (ref) => libraryAuthorDetails(
            ref as LibraryAuthorDetailsRef,
            id,
          ),
          from: libraryAuthorDetailsProvider,
          name: r'libraryAuthorDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$libraryAuthorDetailsHash,
          dependencies: LibraryAuthorDetailsFamily._dependencies,
          allTransitiveDependencies:
              LibraryAuthorDetailsFamily._allTransitiveDependencies,
          id: id,
        );

  LibraryAuthorDetailsProvider._internal(
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
    FutureOr<AuthorDetailsView> Function(LibraryAuthorDetailsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LibraryAuthorDetailsProvider._internal(
        (ref) => create(ref as LibraryAuthorDetailsRef),
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
  AutoDisposeFutureProviderElement<AuthorDetailsView> createElement() {
    return _LibraryAuthorDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryAuthorDetailsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LibraryAuthorDetailsRef
    on AutoDisposeFutureProviderRef<AuthorDetailsView> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LibraryAuthorDetailsProviderElement
    extends AutoDisposeFutureProviderElement<AuthorDetailsView>
    with LibraryAuthorDetailsRef {
  _LibraryAuthorDetailsProviderElement(super.provider);

  @override
  String get id => (origin as LibraryAuthorDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
