// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_selection_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$librarySelectionNotifierHash() =>
    r'5c93b455174d6e7799f780dad11f2a35fbee0290';

/// Stores the library selection used by the word frequency report.
///
/// The selection is not saved between app sessions.
///
/// Copied from [LibrarySelectionNotifier].
@ProviderFor(LibrarySelectionNotifier)
final librarySelectionNotifierProvider =
    AutoDisposeNotifierProvider<
      LibrarySelectionNotifier,
      LibrarySelection
    >.internal(
      LibrarySelectionNotifier.new,
      name: r'librarySelectionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$librarySelectionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LibrarySelectionNotifier = AutoDisposeNotifier<LibrarySelection>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
