// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'library.drift.dart';
import 'semivowel_spelling.dart';
import 'subdivision_type.dart';

part 'work_index_api.g.dart';

//infrastructure

@riverpod
Future<WorkIndex> workIndex(Ref ref, String work) async {
  log.info(() => '@riverpod - using $work');
  ref.cacheFor(const Duration(minutes: 10));
  final db = await ref.watch(dbProvider.future);
  final repo = LibraryRepository(db.libraryDrift);
  return GetWorkIndexUseCase(repo, work).invoke();
}

class LibraryRepository implements ILibraryRepository {
  LibraryRepository(
    this._db,
  );

  final LibraryDrift _db;

  @override
  Future<WorkIndex> getWorkIndexOf(String work) async {
    log.fine('reading index of work "$work" from db');
    final dbData = await _db.getLibraryWorkIndexes(work).get();
    return WorkIndex(dbData);
  }

  //
}

//interactors

abstract interface class ILibraryRepository {
  //
  Future<WorkIndex> getWorkIndexOf(String work);
  //
}

class GetWorkIndexUseCase implements IGetWorkIndexUseCase {
  GetWorkIndexUseCase(
    this._repository,
    this._work,
  );

  final ILibraryRepository _repository;
  final String _work;

  @override
  Future<WorkIndex> invoke() async => _repository.getWorkIndexOf(_work);
  //
}

//domain

abstract interface class IGetWorkIndexUseCase {
  //
  Future<WorkIndex> invoke();
  //
}

/// A titled subdivision of a work
@immutable
class WorkIndexEntry {
  const WorkIndexEntry({
    required this.workId,
    required this.node,
    required this.parent,
    required this.depth,
    required this.typ,
    required this.cnt,
    required this.fromIndex,
    required this.toIndex,
    required this.label,
    required this.numeralWordIndexes,
    required this.startReference,
    required this.endReference,
  });

  WorkIndexEntry.fromSql({
    required String workId,
    required String node,
    required String? parent,
    required int depth,
    required SubdivisionType typ,
    required int cnt,
    required int fromIndex,
    required int toIndex,
    required String label,
    required String? numeralWordIndexes,
    required String startReference,
    required String endReference,
  }) : this(
         workId: workId,
         node: node,
         parent: parent,
         depth: depth,
         typ: typ,
         cnt: cnt,
         fromIndex: fromIndex,
         toIndex: toIndex,
         label: label,
         numeralWordIndexes: LabelWordIndexes.fromSql(numeralWordIndexes),
         startReference: startReference,
         endReference: endReference,
       );

  final String workId;
  final String node;
  final String? parent;

  /// 0 for works (the root)
  final int depth;

  final SubdivisionType typ;

  /// Position among the siblings of the same type. Zero-based.
  final int cnt;

  /// First WorkContents.idx of the subdivision. Inclusive.
  final int fromIndex;

  /// Last WorkContents.idx of the subdivision. Inclusive.
  final int toIndex;

  /// The title
  final String label;

  final LabelWordIndexes numeralWordIndexes;

  /// Source reference of the title (e.g. 1.3). Display only.
  final String startReference;

  /// Source reference of the title's last token. Display only.
  final String endReference;

  String get referenceLabel =>
      startReference == endReference ? startReference : '$startReference – $endReference';

  /// Returns [label] with [spelling], except for its numerals.
  String labelSpelledWith(SemivowelSpelling spelling) {
    final words = _word.allMatches(label).indexed.map(
      (word) => numeralWordIndexes.contains(word.$1) ? word.$2[0]! : spelling.respell(word.$2[0]!),
    );
    final gaps = label.split(_word);
    return [gaps.first, ...IterableZip([words, gaps.skip(1)]).expand((pair) => pair)].join();
  }

  static final RegExp _word = RegExp(r'\p{L}+', unicode: true);

  @override
  String toString() => 'WorkIndexEntry{label: $label}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkIndexEntry && other.workId == workId && other.node == node);

  @override
  int get hashCode => Object.hash(workId, node);
  //
}

extension type const LabelWordIndexes._(UnmodifiableSetView<int> unm)
    implements UnmodifiableSetView<int> {
  LabelWordIndexes.fromSql(
    String? column,
  ) : this._(
        UnmodifiableSetView(
          (column ?? '').split(',').where((index) => index.isNotEmpty).map(int.parse).toSet(),
        ),
      );
}

/// Titled subdivisions of a work, as a tree
@immutable
class WorkIndex {
  WorkIndex(
    Iterable<WorkIndexEntry> source,
  ) : this._(UnmodifiableListView(source.toList(growable: false)));

  WorkIndex._(
    this.entries,
  ) : _byNode = Map.fromEntries(entries.map((entry) => MapEntry(entry.node, entry))),
      _children = groupBy(entries, (entry) => entry.parent);

  /// Every entry in reading order
  final UnmodifiableListView<WorkIndexEntry> entries;

  final Map<String, WorkIndexEntry> _byNode;
  final Map<String?, List<WorkIndexEntry>> _children;

  /// The works
  UnmodifiableListView<WorkIndexEntry> get roots => childrenOf(null);

  /// Direct children of [node] (or the root entries when [node] is `null`)
  UnmodifiableListView<WorkIndexEntry> childrenOf(String? node) =>
      UnmodifiableListView(_children[node] ?? const []);

  /// All parents of [entry], ordered from the root down to its direct parent
  List<WorkIndexEntry> ancestorsOf(WorkIndexEntry entry) => switch (_byNode[entry.parent]) {
    final parent? => [...ancestorsOf(parent), parent],
    null => const [],
  };

  /// The deepest subdivision containing [tokenIndex], or `null` if none contains it
  WorkIndexEntry? currentAt(int tokenIndex) => entries.lastWhereOrNull(
    (entry) => entry.fromIndex <= tokenIndex && tokenIndex <= entry.toIndex,
  );

  @override
  String toString() => 'WorkIndex{entries: ${entries.length}}';
  //
}
