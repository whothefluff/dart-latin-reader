// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolved_freq_morph_form_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resolvedFreqMorphFormsHash() =>
    r'e138316d485690bac6b34d4f49f474048280fb92';

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

/// Returns the stored morphological matches for [form] in [workIds].
///
/// If [macronForm] is provided, results must also match that macronized spelling.
/// Page size, page offset, and sort order do not affect this lookup.
///
/// Copied from [resolvedFreqMorphForms].
@ProviderFor(resolvedFreqMorphForms)
const resolvedFreqMorphFormsProvider = ResolvedFreqMorphFormsFamily();

/// Returns the stored morphological matches for [form] in [workIds].
///
/// If [macronForm] is provided, results must also match that macronized spelling.
/// Page size, page offset, and sort order do not affect this lookup.
///
/// Copied from [resolvedFreqMorphForms].
class ResolvedFreqMorphFormsFamily
    extends Family<AsyncValue<FrequencyMorphCandidates>> {
  /// Returns the stored morphological matches for [form] in [workIds].
  ///
  /// If [macronForm] is provided, results must also match that macronized spelling.
  /// Page size, page offset, and sort order do not affect this lookup.
  ///
  /// Copied from [resolvedFreqMorphForms].
  const ResolvedFreqMorphFormsFamily();

  /// Returns the stored morphological matches for [form] in [workIds].
  ///
  /// If [macronForm] is provided, results must also match that macronized spelling.
  /// Page size, page offset, and sort order do not affect this lookup.
  ///
  /// Copied from [resolvedFreqMorphForms].
  ResolvedFreqMorphFormsProvider call(
    WorkIds workIds,
    String form, {
    String? macronForm,
  }) {
    return ResolvedFreqMorphFormsProvider(
      workIds,
      form,
      macronForm: macronForm,
    );
  }

  @override
  ResolvedFreqMorphFormsProvider getProviderOverride(
    covariant ResolvedFreqMorphFormsProvider provider,
  ) {
    return call(
      provider.workIds,
      provider.form,
      macronForm: provider.macronForm,
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
  String? get name => r'resolvedFreqMorphFormsProvider';
}

/// Returns the stored morphological matches for [form] in [workIds].
///
/// If [macronForm] is provided, results must also match that macronized spelling.
/// Page size, page offset, and sort order do not affect this lookup.
///
/// Copied from [resolvedFreqMorphForms].
class ResolvedFreqMorphFormsProvider
    extends AutoDisposeFutureProvider<FrequencyMorphCandidates> {
  /// Returns the stored morphological matches for [form] in [workIds].
  ///
  /// If [macronForm] is provided, results must also match that macronized spelling.
  /// Page size, page offset, and sort order do not affect this lookup.
  ///
  /// Copied from [resolvedFreqMorphForms].
  ResolvedFreqMorphFormsProvider(
    WorkIds workIds,
    String form, {
    String? macronForm,
  }) : this._internal(
         (ref) => resolvedFreqMorphForms(
           ref as ResolvedFreqMorphFormsRef,
           workIds,
           form,
           macronForm: macronForm,
         ),
         from: resolvedFreqMorphFormsProvider,
         name: r'resolvedFreqMorphFormsProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$resolvedFreqMorphFormsHash,
         dependencies: ResolvedFreqMorphFormsFamily._dependencies,
         allTransitiveDependencies:
             ResolvedFreqMorphFormsFamily._allTransitiveDependencies,
         workIds: workIds,
         form: form,
         macronForm: macronForm,
       );

  ResolvedFreqMorphFormsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workIds,
    required this.form,
    required this.macronForm,
  }) : super.internal();

  final WorkIds workIds;
  final String form;
  final String? macronForm;

  @override
  Override overrideWith(
    FutureOr<FrequencyMorphCandidates> Function(
      ResolvedFreqMorphFormsRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ResolvedFreqMorphFormsProvider._internal(
        (ref) => create(ref as ResolvedFreqMorphFormsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workIds: workIds,
        form: form,
        macronForm: macronForm,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FrequencyMorphCandidates> createElement() {
    return _ResolvedFreqMorphFormsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResolvedFreqMorphFormsProvider &&
        other.workIds == workIds &&
        other.form == form &&
        other.macronForm == macronForm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workIds.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);
    hash = _SystemHash.combine(hash, macronForm.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ResolvedFreqMorphFormsRef
    on AutoDisposeFutureProviderRef<FrequencyMorphCandidates> {
  /// The parameter `workIds` of this provider.
  WorkIds get workIds;

  /// The parameter `form` of this provider.
  String get form;

  /// The parameter `macronForm` of this provider.
  String? get macronForm;
}

class _ResolvedFreqMorphFormsProviderElement
    extends AutoDisposeFutureProviderElement<FrequencyMorphCandidates>
    with ResolvedFreqMorphFormsRef {
  _ResolvedFreqMorphFormsProviderElement(super.provider);

  @override
  WorkIds get workIds => (origin as ResolvedFreqMorphFormsProvider).workIds;
  @override
  String get form => (origin as ResolvedFreqMorphFormsProvider).form;
  @override
  String? get macronForm =>
      (origin as ResolvedFreqMorphFormsProvider).macronForm;
}

String _$resolvedFreqMorphFormsOfLemmaHash() =>
    r'75f55cbe2959c76174ba7c24bb6d65b91e128187';

/// Returns the stored morphological matches for [dictionaryRef] in [workIds].
///
/// Results may include several inflected forms of the lemma.
///
/// Copied from [resolvedFreqMorphFormsOfLemma].
@ProviderFor(resolvedFreqMorphFormsOfLemma)
const resolvedFreqMorphFormsOfLemmaProvider =
    ResolvedFreqMorphFormsOfLemmaFamily();

/// Returns the stored morphological matches for [dictionaryRef] in [workIds].
///
/// Results may include several inflected forms of the lemma.
///
/// Copied from [resolvedFreqMorphFormsOfLemma].
class ResolvedFreqMorphFormsOfLemmaFamily
    extends Family<AsyncValue<FrequencyMorphCandidates>> {
  /// Returns the stored morphological matches for [dictionaryRef] in [workIds].
  ///
  /// Results may include several inflected forms of the lemma.
  ///
  /// Copied from [resolvedFreqMorphFormsOfLemma].
  const ResolvedFreqMorphFormsOfLemmaFamily();

  /// Returns the stored morphological matches for [dictionaryRef] in [workIds].
  ///
  /// Results may include several inflected forms of the lemma.
  ///
  /// Copied from [resolvedFreqMorphFormsOfLemma].
  ResolvedFreqMorphFormsOfLemmaProvider call(
    WorkIds workIds,
    String dictionaryRef,
  ) {
    return ResolvedFreqMorphFormsOfLemmaProvider(workIds, dictionaryRef);
  }

  @override
  ResolvedFreqMorphFormsOfLemmaProvider getProviderOverride(
    covariant ResolvedFreqMorphFormsOfLemmaProvider provider,
  ) {
    return call(provider.workIds, provider.dictionaryRef);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'resolvedFreqMorphFormsOfLemmaProvider';
}

/// Returns the stored morphological matches for [dictionaryRef] in [workIds].
///
/// Results may include several inflected forms of the lemma.
///
/// Copied from [resolvedFreqMorphFormsOfLemma].
class ResolvedFreqMorphFormsOfLemmaProvider
    extends AutoDisposeFutureProvider<FrequencyMorphCandidates> {
  /// Returns the stored morphological matches for [dictionaryRef] in [workIds].
  ///
  /// Results may include several inflected forms of the lemma.
  ///
  /// Copied from [resolvedFreqMorphFormsOfLemma].
  ResolvedFreqMorphFormsOfLemmaProvider(WorkIds workIds, String dictionaryRef)
    : this._internal(
        (ref) => resolvedFreqMorphFormsOfLemma(
          ref as ResolvedFreqMorphFormsOfLemmaRef,
          workIds,
          dictionaryRef,
        ),
        from: resolvedFreqMorphFormsOfLemmaProvider,
        name: r'resolvedFreqMorphFormsOfLemmaProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$resolvedFreqMorphFormsOfLemmaHash,
        dependencies: ResolvedFreqMorphFormsOfLemmaFamily._dependencies,
        allTransitiveDependencies:
            ResolvedFreqMorphFormsOfLemmaFamily._allTransitiveDependencies,
        workIds: workIds,
        dictionaryRef: dictionaryRef,
      );

  ResolvedFreqMorphFormsOfLemmaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workIds,
    required this.dictionaryRef,
  }) : super.internal();

  final WorkIds workIds;
  final String dictionaryRef;

  @override
  Override overrideWith(
    FutureOr<FrequencyMorphCandidates> Function(
      ResolvedFreqMorphFormsOfLemmaRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ResolvedFreqMorphFormsOfLemmaProvider._internal(
        (ref) => create(ref as ResolvedFreqMorphFormsOfLemmaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workIds: workIds,
        dictionaryRef: dictionaryRef,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FrequencyMorphCandidates> createElement() {
    return _ResolvedFreqMorphFormsOfLemmaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResolvedFreqMorphFormsOfLemmaProvider &&
        other.workIds == workIds &&
        other.dictionaryRef == dictionaryRef;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workIds.hashCode);
    hash = _SystemHash.combine(hash, dictionaryRef.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ResolvedFreqMorphFormsOfLemmaRef
    on AutoDisposeFutureProviderRef<FrequencyMorphCandidates> {
  /// The parameter `workIds` of this provider.
  WorkIds get workIds;

  /// The parameter `dictionaryRef` of this provider.
  String get dictionaryRef;
}

class _ResolvedFreqMorphFormsOfLemmaProviderElement
    extends AutoDisposeFutureProviderElement<FrequencyMorphCandidates>
    with ResolvedFreqMorphFormsOfLemmaRef {
  _ResolvedFreqMorphFormsOfLemmaProviderElement(super.provider);

  @override
  WorkIds get workIds =>
      (origin as ResolvedFreqMorphFormsOfLemmaProvider).workIds;
  @override
  String get dictionaryRef =>
      (origin as ResolvedFreqMorphFormsOfLemmaProvider).dictionaryRef;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
