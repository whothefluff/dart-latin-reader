// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_details_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorDetailsHash() => r'f27cc1fc375443fcd2fce8e8beaf5ff332cfd286';

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

/// See also [authorDetails].
@ProviderFor(authorDetails)
const authorDetailsProvider = AuthorDetailsFamily();

/// See also [authorDetails].
class AuthorDetailsFamily extends Family<AsyncValue<AuthorDetails>> {
  /// See also [authorDetails].
  const AuthorDetailsFamily();

  /// See also [authorDetails].
  AuthorDetailsProvider call(
    String author,
  ) {
    return AuthorDetailsProvider(
      author,
    );
  }

  @override
  AuthorDetailsProvider getProviderOverride(
    covariant AuthorDetailsProvider provider,
  ) {
    return call(
      provider.author,
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
  String? get name => r'authorDetailsProvider';
}

/// See also [authorDetails].
class AuthorDetailsProvider extends AutoDisposeFutureProvider<AuthorDetails> {
  /// See also [authorDetails].
  AuthorDetailsProvider(
    String author,
  ) : this._internal(
          (ref) => authorDetails(
            ref as AuthorDetailsRef,
            author,
          ),
          from: authorDetailsProvider,
          name: r'authorDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authorDetailsHash,
          dependencies: AuthorDetailsFamily._dependencies,
          allTransitiveDependencies:
              AuthorDetailsFamily._allTransitiveDependencies,
          author: author,
        );

  AuthorDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.author,
  }) : super.internal();

  final String author;

  @override
  Override overrideWith(
    FutureOr<AuthorDetails> Function(AuthorDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthorDetailsProvider._internal(
        (ref) => create(ref as AuthorDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        author: author,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AuthorDetails> createElement() {
    return _AuthorDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorDetailsProvider && other.author == author;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, author.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuthorDetailsRef on AutoDisposeFutureProviderRef<AuthorDetails> {
  /// The parameter `author` of this provider.
  String get author;
}

class _AuthorDetailsProviderElement
    extends AutoDisposeFutureProviderElement<AuthorDetails>
    with AuthorDetailsRef {
  _AuthorDetailsProviderElement(super.provider);

  @override
  String get author => (origin as AuthorDetailsProvider).author;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
