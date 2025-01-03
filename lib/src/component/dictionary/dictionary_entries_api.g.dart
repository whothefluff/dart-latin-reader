// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entries_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dictionaryEntriesHash() => r'aca1a064c138de720d8dd7a55d451356ffb6e050';

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

/// See also [dictionaryEntries].
@ProviderFor(dictionaryEntries)
const dictionaryEntriesProvider = DictionaryEntriesFamily();

/// See also [dictionaryEntries].
class DictionaryEntriesFamily
    extends Family<AsyncValue<UnmodifiableListView<Entry>>> {
  /// See also [dictionaryEntries].
  const DictionaryEntriesFamily();

  /// See also [dictionaryEntries].
  DictionaryEntriesProvider call(
    String dictionary,
  ) {
    return DictionaryEntriesProvider(
      dictionary,
    );
  }

  @override
  DictionaryEntriesProvider getProviderOverride(
    covariant DictionaryEntriesProvider provider,
  ) {
    return call(
      provider.dictionary,
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
  String? get name => r'dictionaryEntriesProvider';
}

/// See also [dictionaryEntries].
class DictionaryEntriesProvider
    extends AutoDisposeFutureProvider<UnmodifiableListView<Entry>> {
  /// See also [dictionaryEntries].
  DictionaryEntriesProvider(
    String dictionary,
  ) : this._internal(
          (ref) => dictionaryEntries(
            ref as DictionaryEntriesRef,
            dictionary,
          ),
          from: dictionaryEntriesProvider,
          name: r'dictionaryEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dictionaryEntriesHash,
          dependencies: DictionaryEntriesFamily._dependencies,
          allTransitiveDependencies:
              DictionaryEntriesFamily._allTransitiveDependencies,
          dictionary: dictionary,
        );

  DictionaryEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dictionary,
  }) : super.internal();

  final String dictionary;

  @override
  Override overrideWith(
    FutureOr<UnmodifiableListView<Entry>> Function(
            DictionaryEntriesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DictionaryEntriesProvider._internal(
        (ref) => create(ref as DictionaryEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dictionary: dictionary,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UnmodifiableListView<Entry>>
      createElement() {
    return _DictionaryEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DictionaryEntriesProvider && other.dictionary == dictionary;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dictionary.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DictionaryEntriesRef
    on AutoDisposeFutureProviderRef<UnmodifiableListView<Entry>> {
  /// The parameter `dictionary` of this provider.
  String get dictionary;
}

class _DictionaryEntriesProviderElement
    extends AutoDisposeFutureProviderElement<UnmodifiableListView<Entry>>
    with DictionaryEntriesRef {
  _DictionaryEntriesProviderElement(super.provider);

  @override
  String get dictionary => (origin as DictionaryEntriesProvider).dictionary;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
