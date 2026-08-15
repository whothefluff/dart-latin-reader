// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_frequency_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$frequencyReportHash() => r'acb0a484387361df5216520a1bd1b1664fd0679f';

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

/// See also [frequencyReport].
@ProviderFor(frequencyReport)
const frequencyReportProvider = FrequencyReportFamily();

/// See also [frequencyReport].
class FrequencyReportFamily extends Family<AsyncValue<FrequencyReport>> {
  /// See also [frequencyReport].
  const FrequencyReportFamily();

  /// See also [frequencyReport].
  FrequencyReportProvider call(FrequencyFilter filter) {
    return FrequencyReportProvider(filter);
  }

  @override
  FrequencyReportProvider getProviderOverride(
    covariant FrequencyReportProvider provider,
  ) {
    return call(provider.filter);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'frequencyReportProvider';
}

/// See also [frequencyReport].
class FrequencyReportProvider
    extends AutoDisposeFutureProvider<FrequencyReport> {
  /// See also [frequencyReport].
  FrequencyReportProvider(FrequencyFilter filter)
    : this._internal(
        (ref) => frequencyReport(ref as FrequencyReportRef, filter),
        from: frequencyReportProvider,
        name: r'frequencyReportProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$frequencyReportHash,
        dependencies: FrequencyReportFamily._dependencies,
        allTransitiveDependencies:
            FrequencyReportFamily._allTransitiveDependencies,
        filter: filter,
      );

  FrequencyReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final FrequencyFilter filter;

  @override
  Override overrideWith(
    FutureOr<FrequencyReport> Function(FrequencyReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FrequencyReportProvider._internal(
        (ref) => create(ref as FrequencyReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FrequencyReport> createElement() {
    return _FrequencyReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FrequencyReportProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FrequencyReportRef on AutoDisposeFutureProviderRef<FrequencyReport> {
  /// The parameter `filter` of this provider.
  FrequencyFilter get filter;
}

class _FrequencyReportProviderElement
    extends AutoDisposeFutureProviderElement<FrequencyReport>
    with FrequencyReportRef {
  _FrequencyReportProviderElement(super.provider);

  @override
  FrequencyFilter get filter => (origin as FrequencyReportProvider).filter;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
