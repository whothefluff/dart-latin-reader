// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_alphabets_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dictionaryAlphabetLetterPositionHash() =>
    r'fad8ced159a6c8c676da15127691c60d058dfa60';

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

/// See also [dictionaryAlphabetLetterPosition].
@ProviderFor(dictionaryAlphabetLetterPosition)
const dictionaryAlphabetLetterPositionProvider =
    DictionaryAlphabetLetterPositionFamily();

/// See also [dictionaryAlphabetLetterPosition].
class DictionaryAlphabetLetterPositionFamily
    extends Family<AsyncValue<DictionaryAlphabetLetterPosition>> {
  /// See also [dictionaryAlphabetLetterPosition].
  const DictionaryAlphabetLetterPositionFamily();

  /// See also [dictionaryAlphabetLetterPosition].
  DictionaryAlphabetLetterPositionProvider call(
    String dictionary,
    String letter,
  ) {
    return DictionaryAlphabetLetterPositionProvider(
      dictionary,
      letter,
    );
  }

  @override
  DictionaryAlphabetLetterPositionProvider getProviderOverride(
    covariant DictionaryAlphabetLetterPositionProvider provider,
  ) {
    return call(
      provider.dictionary,
      provider.letter,
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
  String? get name => r'dictionaryAlphabetLetterPositionProvider';
}

/// See also [dictionaryAlphabetLetterPosition].
class DictionaryAlphabetLetterPositionProvider
    extends AutoDisposeFutureProvider<DictionaryAlphabetLetterPosition> {
  /// See also [dictionaryAlphabetLetterPosition].
  DictionaryAlphabetLetterPositionProvider(
    String dictionary,
    String letter,
  ) : this._internal(
          (ref) => dictionaryAlphabetLetterPosition(
            ref as DictionaryAlphabetLetterPositionRef,
            dictionary,
            letter,
          ),
          from: dictionaryAlphabetLetterPositionProvider,
          name: r'dictionaryAlphabetLetterPositionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dictionaryAlphabetLetterPositionHash,
          dependencies: DictionaryAlphabetLetterPositionFamily._dependencies,
          allTransitiveDependencies:
              DictionaryAlphabetLetterPositionFamily._allTransitiveDependencies,
          dictionary: dictionary,
          letter: letter,
        );

  DictionaryAlphabetLetterPositionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dictionary,
    required this.letter,
  }) : super.internal();

  final String dictionary;
  final String letter;

  @override
  Override overrideWith(
    FutureOr<DictionaryAlphabetLetterPosition> Function(
            DictionaryAlphabetLetterPositionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DictionaryAlphabetLetterPositionProvider._internal(
        (ref) => create(ref as DictionaryAlphabetLetterPositionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dictionary: dictionary,
        letter: letter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DictionaryAlphabetLetterPosition>
      createElement() {
    return _DictionaryAlphabetLetterPositionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DictionaryAlphabetLetterPositionProvider &&
        other.dictionary == dictionary &&
        other.letter == letter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dictionary.hashCode);
    hash = _SystemHash.combine(hash, letter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DictionaryAlphabetLetterPositionRef
    on AutoDisposeFutureProviderRef<DictionaryAlphabetLetterPosition> {
  /// The parameter `dictionary` of this provider.
  String get dictionary;

  /// The parameter `letter` of this provider.
  String get letter;
}

class _DictionaryAlphabetLetterPositionProviderElement
    extends AutoDisposeFutureProviderElement<DictionaryAlphabetLetterPosition>
    with DictionaryAlphabetLetterPositionRef {
  _DictionaryAlphabetLetterPositionProviderElement(super.provider);

  @override
  String get dictionary =>
      (origin as DictionaryAlphabetLetterPositionProvider).dictionary;
  @override
  String get letter =>
      (origin as DictionaryAlphabetLetterPositionProvider).letter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
