// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry_senses_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dictionaryEntrySensesHash() =>
    r'92959641b5319d83dcaf594bbd2385864a3254cd';

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

/// See also [dictionaryEntrySenses].
@ProviderFor(dictionaryEntrySenses)
const dictionaryEntrySensesProvider = DictionaryEntrySensesFamily();

/// See also [dictionaryEntrySenses].
class DictionaryEntrySensesFamily
    extends Family<AsyncValue<DictionaryEntrySenses>> {
  /// See also [dictionaryEntrySenses].
  const DictionaryEntrySensesFamily();

  /// See also [dictionaryEntrySenses].
  DictionaryEntrySensesProvider call(String dictionary, String entryKey) {
    return DictionaryEntrySensesProvider(dictionary, entryKey);
  }

  @override
  DictionaryEntrySensesProvider getProviderOverride(
    covariant DictionaryEntrySensesProvider provider,
  ) {
    return call(provider.dictionary, provider.entryKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dictionaryEntrySensesProvider';
}

/// See also [dictionaryEntrySenses].
class DictionaryEntrySensesProvider
    extends AutoDisposeFutureProvider<DictionaryEntrySenses> {
  /// See also [dictionaryEntrySenses].
  DictionaryEntrySensesProvider(String dictionary, String entryKey)
    : this._internal(
        (ref) => dictionaryEntrySenses(
          ref as DictionaryEntrySensesRef,
          dictionary,
          entryKey,
        ),
        from: dictionaryEntrySensesProvider,
        name: r'dictionaryEntrySensesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dictionaryEntrySensesHash,
        dependencies: DictionaryEntrySensesFamily._dependencies,
        allTransitiveDependencies:
            DictionaryEntrySensesFamily._allTransitiveDependencies,
        dictionary: dictionary,
        entryKey: entryKey,
      );

  DictionaryEntrySensesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dictionary,
    required this.entryKey,
  }) : super.internal();

  final String dictionary;
  final String entryKey;

  @override
  Override overrideWith(
    FutureOr<DictionaryEntrySenses> Function(DictionaryEntrySensesRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DictionaryEntrySensesProvider._internal(
        (ref) => create(ref as DictionaryEntrySensesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dictionary: dictionary,
        entryKey: entryKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DictionaryEntrySenses> createElement() {
    return _DictionaryEntrySensesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DictionaryEntrySensesProvider &&
        other.dictionary == dictionary &&
        other.entryKey == entryKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dictionary.hashCode);
    hash = _SystemHash.combine(hash, entryKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DictionaryEntrySensesRef
    on AutoDisposeFutureProviderRef<DictionaryEntrySenses> {
  /// The parameter `dictionary` of this provider.
  String get dictionary;

  /// The parameter `entryKey` of this provider.
  String get entryKey;
}

class _DictionaryEntrySensesProviderElement
    extends AutoDisposeFutureProviderElement<DictionaryEntrySenses>
    with DictionaryEntrySensesRef {
  _DictionaryEntrySensesProviderElement(super.provider);

  @override
  String get dictionary => (origin as DictionaryEntrySensesProvider).dictionary;
  @override
  String get entryKey => (origin as DictionaryEntrySensesProvider).entryKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
