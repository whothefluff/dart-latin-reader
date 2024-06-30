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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
