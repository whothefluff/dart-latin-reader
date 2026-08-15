// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_lemmas_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$formLemmasHash() => r'ff3d670fe378ac5b88ef34f3b6ec6803da0ca083';

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

/// See also [formLemmas].
@ProviderFor(formLemmas)
const formLemmasProvider = FormLemmasFamily();

/// See also [formLemmas].
class FormLemmasFamily extends Family<AsyncValue<FormLemmaMap>> {
  /// See also [formLemmas].
  const FormLemmasFamily();

  /// See also [formLemmas].
  FormLemmasProvider call(Forms forms) {
    return FormLemmasProvider(forms);
  }

  @override
  FormLemmasProvider getProviderOverride(
    covariant FormLemmasProvider provider,
  ) {
    return call(provider.forms);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formLemmasProvider';
}

/// See also [formLemmas].
class FormLemmasProvider extends AutoDisposeFutureProvider<FormLemmaMap> {
  /// See also [formLemmas].
  FormLemmasProvider(Forms forms)
    : this._internal(
        (ref) => formLemmas(ref as FormLemmasRef, forms),
        from: formLemmasProvider,
        name: r'formLemmasProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$formLemmasHash,
        dependencies: FormLemmasFamily._dependencies,
        allTransitiveDependencies: FormLemmasFamily._allTransitiveDependencies,
        forms: forms,
      );

  FormLemmasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.forms,
  }) : super.internal();

  final Forms forms;

  @override
  Override overrideWith(
    FutureOr<FormLemmaMap> Function(FormLemmasRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormLemmasProvider._internal(
        (ref) => create(ref as FormLemmasRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        forms: forms,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FormLemmaMap> createElement() {
    return _FormLemmasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormLemmasProvider && other.forms == forms;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, forms.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormLemmasRef on AutoDisposeFutureProviderRef<FormLemmaMap> {
  /// The parameter `forms` of this provider.
  Forms get forms;
}

class _FormLemmasProviderElement
    extends AutoDisposeFutureProviderElement<FormLemmaMap>
    with FormLemmasRef {
  _FormLemmasProviderElement(super.provider);

  @override
  Forms get forms => (origin as FormLemmasProvider).forms;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
