// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbHash() => r'0ab9228ad9ddea187f88e5155c32fd04caf3920b';

/// Provides one db connection for the lifetime of the app
///
/// Copied from [db].
@ProviderFor(db)
final dbProvider = FutureProvider<AppDb>.internal(
  db,
  name: r'dbProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dbHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DbRef = FutureProviderRef<AppDb>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
