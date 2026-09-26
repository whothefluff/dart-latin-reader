// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_start_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$readingStartHash() => r'b3640d273ff896fd04382236cbec5d99055de283';

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

/// The token a reader page has to start at to show [tokenIndex] of [workId]
///
/// Copied from [readingStart].
@ProviderFor(readingStart)
const readingStartProvider = ReadingStartFamily();

/// The token a reader page has to start at to show [tokenIndex] of [workId]
///
/// Copied from [readingStart].
class ReadingStartFamily extends Family<AsyncValue<int>> {
  /// The token a reader page has to start at to show [tokenIndex] of [workId]
  ///
  /// Copied from [readingStart].
  const ReadingStartFamily();

  /// The token a reader page has to start at to show [tokenIndex] of [workId]
  ///
  /// Copied from [readingStart].
  ReadingStartProvider call(String workId, int tokenIndex) {
    return ReadingStartProvider(workId, tokenIndex);
  }

  @override
  ReadingStartProvider getProviderOverride(
    covariant ReadingStartProvider provider,
  ) {
    return call(provider.workId, provider.tokenIndex);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'readingStartProvider';
}

/// The token a reader page has to start at to show [tokenIndex] of [workId]
///
/// Copied from [readingStart].
class ReadingStartProvider extends AutoDisposeFutureProvider<int> {
  /// The token a reader page has to start at to show [tokenIndex] of [workId]
  ///
  /// Copied from [readingStart].
  ReadingStartProvider(String workId, int tokenIndex)
    : this._internal(
        (ref) => readingStart(ref as ReadingStartRef, workId, tokenIndex),
        from: readingStartProvider,
        name: r'readingStartProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$readingStartHash,
        dependencies: ReadingStartFamily._dependencies,
        allTransitiveDependencies:
            ReadingStartFamily._allTransitiveDependencies,
        workId: workId,
        tokenIndex: tokenIndex,
      );

  ReadingStartProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workId,
    required this.tokenIndex,
  }) : super.internal();

  final String workId;
  final int tokenIndex;

  @override
  Override overrideWith(
    FutureOr<int> Function(ReadingStartRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReadingStartProvider._internal(
        (ref) => create(ref as ReadingStartRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workId: workId,
        tokenIndex: tokenIndex,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _ReadingStartProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReadingStartProvider &&
        other.workId == workId &&
        other.tokenIndex == tokenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workId.hashCode);
    hash = _SystemHash.combine(hash, tokenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReadingStartRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `workId` of this provider.
  String get workId;

  /// The parameter `tokenIndex` of this provider.
  int get tokenIndex;
}

class _ReadingStartProviderElement extends AutoDisposeFutureProviderElement<int>
    with ReadingStartRef {
  _ReadingStartProviderElement(super.provider);

  @override
  String get workId => (origin as ReadingStartProvider).workId;
  @override
  int get tokenIndex => (origin as ReadingStartProvider).tokenIndex;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
