// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorServiceHash() => r'56e6b36a22f8c890d0e09687d3dce327e57e38a4';

/// See also [authorService].
@ProviderFor(authorService)
final authorServiceProvider = AutoDisposeProvider<AuthorService>.internal(
  authorService,
  name: r'authorServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authorServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthorServiceRef = AutoDisposeProviderRef<AuthorService>;
String _$authorsHash() => r'fedafa69cd347eaea88292fdbbb4b73f3e3314d9';

/// See also [authors].
@ProviderFor(authors)
final authorsProvider = AutoDisposeFutureProvider<e.Authors>.internal(
  authors,
  name: r'authorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthorsRef = AutoDisposeFutureProviderRef<e.Authors>;
String _$authorsWithWorksHash() => r'85316f5359b0a2c5b11d069af137fb3f37e156c4';

/// See also [authorsWithWorks].
@ProviderFor(authorsWithWorks)
final authorsWithWorksProvider = AutoDisposeFutureProvider<e.Authors>.internal(
  authorsWithWorks,
  name: r'authorsWithWorksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authorsWithWorksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthorsWithWorksRef = AutoDisposeFutureProviderRef<e.Authors>;
String _$authorHash() => r'ec2765f423d4af16edce12ceca2d1bfe5e6b1119';

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

/// See also [author].
@ProviderFor(author)
const authorProvider = AuthorFamily();

/// See also [author].
class AuthorFamily extends Family<AsyncValue<e.Author>> {
  /// See also [author].
  const AuthorFamily();

  /// See also [author].
  AuthorProvider call(
    String id,
  ) {
    return AuthorProvider(
      id,
    );
  }

  @override
  AuthorProvider getProviderOverride(
    covariant AuthorProvider provider,
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
  String? get name => r'authorProvider';
}

/// See also [author].
class AuthorProvider extends AutoDisposeFutureProvider<e.Author> {
  /// See also [author].
  AuthorProvider(
    String id,
  ) : this._internal(
          (ref) => author(
            ref as AuthorRef,
            id,
          ),
          from: authorProvider,
          name: r'authorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authorHash,
          dependencies: AuthorFamily._dependencies,
          allTransitiveDependencies: AuthorFamily._allTransitiveDependencies,
          id: id,
        );

  AuthorProvider._internal(
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
    FutureOr<e.Author> Function(AuthorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthorProvider._internal(
        (ref) => create(ref as AuthorRef),
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
  AutoDisposeFutureProviderElement<e.Author> createElement() {
    return _AuthorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AuthorRef on AutoDisposeFutureProviderRef<e.Author> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AuthorProviderElement extends AutoDisposeFutureProviderElement<e.Author>
    with AuthorRef {
  _AuthorProviderElement(super.provider);

  @override
  String get id => (origin as AuthorProvider).id;
}

String _$authorsByWorkHash() => r'0d9e20bb761ff352963197aa35923eed1004d9b7';

/// See also [authorsByWork].
@ProviderFor(authorsByWork)
const authorsByWorkProvider = AuthorsByWorkFamily();

/// See also [authorsByWork].
class AuthorsByWorkFamily extends Family<AsyncValue<e.Authors>> {
  /// See also [authorsByWork].
  const AuthorsByWorkFamily();

  /// See also [authorsByWork].
  AuthorsByWorkProvider call(
    String workId,
  ) {
    return AuthorsByWorkProvider(
      workId,
    );
  }

  @override
  AuthorsByWorkProvider getProviderOverride(
    covariant AuthorsByWorkProvider provider,
  ) {
    return call(
      provider.workId,
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
  String? get name => r'authorsByWorkProvider';
}

/// See also [authorsByWork].
class AuthorsByWorkProvider extends AutoDisposeFutureProvider<e.Authors> {
  /// See also [authorsByWork].
  AuthorsByWorkProvider(
    String workId,
  ) : this._internal(
          (ref) => authorsByWork(
            ref as AuthorsByWorkRef,
            workId,
          ),
          from: authorsByWorkProvider,
          name: r'authorsByWorkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authorsByWorkHash,
          dependencies: AuthorsByWorkFamily._dependencies,
          allTransitiveDependencies:
              AuthorsByWorkFamily._allTransitiveDependencies,
          workId: workId,
        );

  AuthorsByWorkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workId,
  }) : super.internal();

  final String workId;

  @override
  Override overrideWith(
    FutureOr<e.Authors> Function(AuthorsByWorkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthorsByWorkProvider._internal(
        (ref) => create(ref as AuthorsByWorkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workId: workId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<e.Authors> createElement() {
    return _AuthorsByWorkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorsByWorkProvider && other.workId == workId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AuthorsByWorkRef on AutoDisposeFutureProviderRef<e.Authors> {
  /// The parameter `workId` of this provider.
  String get workId;
}

class _AuthorsByWorkProviderElement
    extends AutoDisposeFutureProviderElement<e.Authors> with AuthorsByWorkRef {
  _AuthorsByWorkProviderElement(super.provider);

  @override
  String get workId => (origin as AuthorsByWorkProvider).workId;
}

String _$libraryAuthorsHash() => r'741e38e9b6fcec32d29845e35cb3ecae9ecd15d2';

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
    r'f8cbe95456ed98f17ca41eee589f3d23899f7c47';

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
