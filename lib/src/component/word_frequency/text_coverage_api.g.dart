// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_coverage_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$textCoverageHash() => r'87c66b330e925617f489fdc6e120c53fd1a4e28c';

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

/// See also [textCoverage].
@ProviderFor(textCoverage)
const textCoverageProvider = TextCoverageFamily();

/// See also [textCoverage].
class TextCoverageFamily extends Family<AsyncValue<TextCoverage>> {
  /// See also [textCoverage].
  const TextCoverageFamily();

  /// See also [textCoverage].
  TextCoverageProvider call(WorkIds workIds, CoverageBasis basis) {
    return TextCoverageProvider(workIds, basis);
  }

  @override
  TextCoverageProvider getProviderOverride(
    covariant TextCoverageProvider provider,
  ) {
    return call(provider.workIds, provider.basis);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'textCoverageProvider';
}

/// See also [textCoverage].
class TextCoverageProvider extends AutoDisposeFutureProvider<TextCoverage> {
  /// See also [textCoverage].
  TextCoverageProvider(WorkIds workIds, CoverageBasis basis)
    : this._internal(
        (ref) => textCoverage(ref as TextCoverageRef, workIds, basis),
        from: textCoverageProvider,
        name: r'textCoverageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$textCoverageHash,
        dependencies: TextCoverageFamily._dependencies,
        allTransitiveDependencies:
            TextCoverageFamily._allTransitiveDependencies,
        workIds: workIds,
        basis: basis,
      );

  TextCoverageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workIds,
    required this.basis,
  }) : super.internal();

  final WorkIds workIds;
  final CoverageBasis basis;

  @override
  Override overrideWith(
    FutureOr<TextCoverage> Function(TextCoverageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TextCoverageProvider._internal(
        (ref) => create(ref as TextCoverageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workIds: workIds,
        basis: basis,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TextCoverage> createElement() {
    return _TextCoverageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TextCoverageProvider &&
        other.workIds == workIds &&
        other.basis == basis;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workIds.hashCode);
    hash = _SystemHash.combine(hash, basis.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TextCoverageRef on AutoDisposeFutureProviderRef<TextCoverage> {
  /// The parameter `workIds` of this provider.
  WorkIds get workIds;

  /// The parameter `basis` of this provider.
  CoverageBasis get basis;
}

class _TextCoverageProviderElement
    extends AutoDisposeFutureProviderElement<TextCoverage>
    with TextCoverageRef {
  _TextCoverageProviderElement(super.provider);

  @override
  WorkIds get workIds => (origin as TextCoverageProvider).workIds;
  @override
  CoverageBasis get basis => (origin as TextCoverageProvider).basis;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
