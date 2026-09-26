import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';

part 'library_selection_api.g.dart';

//infrastructure

/// Stores the library selection used by the word frequency report.
///
/// The selection is not saved between app sessions.
@riverpod
class LibrarySelectionNotifier extends _$LibrarySelectionNotifier {
  //
  @override
  LibrarySelection build() {
    log.entry<void>();
    return log.exit(r: const LibrarySelection.empty())!;
  }

  void updateSelection(LibrarySelection newSelection) {
    log.entry(args: [newSelection]);
    if (state == newSelection) {
      log.fine('no-op: selection unchanged');
    } else {
      state = newSelection;
    }
    log.exit<void>();
  }

  //
}

//domain

/// Selected work IDs grouped by author ID.
///
/// A null author ID groups works without an author.
/// An empty selection means the report includes the whole library.
@immutable
class LibrarySelection {
  /// Copies [byAuthor] and its sets into unmodifiable collections,
  /// excluding entries with no selected works.
  LibrarySelection(
    Map<String?, Set<String>> byAuthor,
  ) : _byAuthor = UnmodifiableMapView(
        Map<String?, Set<String>>.fromEntries(
          byAuthor.entries
              .where((bucket) => bucket.value.isNotEmpty)
              .map((bucket) => MapEntry(bucket.key, UnmodifiableSetView(Set.of(bucket.value)))),
        ),
      );

  const LibrarySelection.empty() : _byAuthor = const {};

  /// Reads a selection written by [toJsonMap]
  LibrarySelection.fromJsonMap(
    Map<String, Object?> map,
  ) : this(
        map.map(
          (authorId, works) => MapEntry(
            authorId.isEmpty ? null : authorId,
            (works! as List).cast<String>().toSet(),
          ),
        ),
      );

  final Map<String?, Set<String>> _byAuthor;
  static const _equality = MapEquality<String?, Set<String>>(values: SetEquality<String>());

  bool get isEmpty => _byAuthor.isEmpty;

  /// Number of authors. Anonymous count as its own source
  int get sourceCount => _byAuthor.length;

  UnmodifiableSetView<String> get allWorkIds =>
      UnmodifiableSetView(_byAuthor.values.expand((works) => works).toSet());

  /// Returns the selected work IDs for [authorId].
  ///
  /// Pass `null` for works with no author.
  /// Returns an empty set if none of those works are selected.
  Set<String> worksOf(String? authorId) => _byAuthor[authorId] ?? const <String>{};

  /// Returns a copy with [workIds] selected or deselected for [authorId].
  ///
  /// Pass `null` for [authorId] to change the selection of works with no author.
  /// Other works keep their current selection.
  LibrarySelection withWorks(String? authorId, Set<String> workIds, {required bool selected}) {
    final next = Map<String?, Set<String>>.fromEntries(
      _byAuthor.entries.map((bucket) => MapEntry(bucket.key, Set<String>.of(bucket.value))),
    );
    final works = next[authorId] ??= <String>{};
    if (selected) {
      works.addAll(workIds);
    } else {
      works.removeAll(workIds);
    }
    return LibrarySelection(next);
  }

  /// Work IDs by author ID, with works that have no author under `''`
  Map<String, Object?> toJsonMap() => _byAuthor.map(
    (authorId, works) => MapEntry(authorId ?? '', works.sorted((a, b) => a.compareTo(b))),
  );

  @override
  String toString() => 'LibrarySelection{sources: $sourceCount, works: ${allWorkIds.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibrarySelection && _equality.equals(other._byAuthor, _byAuthor));

  @override
  int get hashCode => _equality.hash(_byAuthor);
  //
}
