// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry_senses_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dictionaryEntrySensesHash() =>
    r'8fad5cd789a1ea80f0ab3577bffed5d7206a7be3';

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
  DictionaryEntrySensesProvider call(String dictionary, String lemma) {
    return DictionaryEntrySensesProvider(dictionary, lemma);
  }

  @override
  DictionaryEntrySensesProvider getProviderOverride(
    covariant DictionaryEntrySensesProvider provider,
  ) {
    return call(provider.dictionary, provider.lemma);
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
  DictionaryEntrySensesProvider(String dictionary, String lemma)
    : this._internal(
        (ref) => dictionaryEntrySenses(
          ref as DictionaryEntrySensesRef,
          dictionary,
          lemma,
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
        lemma: lemma,
      );

  DictionaryEntrySensesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dictionary,
    required this.lemma,
  }) : super.internal();

  final String dictionary;
  final String lemma;

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
        lemma: lemma,
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
        other.lemma == lemma;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dictionary.hashCode);
    hash = _SystemHash.combine(hash, lemma.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DictionaryEntrySensesRef
    on AutoDisposeFutureProviderRef<DictionaryEntrySenses> {
  /// The parameter `dictionary` of this provider.
  String get dictionary;

  /// The parameter `lemma` of this provider.
  String get lemma;
}

class _DictionaryEntrySensesProviderElement
    extends AutoDisposeFutureProviderElement<DictionaryEntrySenses>
    with DictionaryEntrySensesRef {
  _DictionaryEntrySensesProviderElement(super.provider);

  @override
  String get dictionary => (origin as DictionaryEntrySensesProvider).dictionary;
  @override
  String get lemma => (origin as DictionaryEntrySensesProvider).lemma;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
