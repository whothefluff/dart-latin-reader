// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import '../library/catalog_api.dart';
import 'concordance.drift.dart';
import 'concordance_parameters.dart';
import 'concordance_query.dart';

part 'concordance_api.g.dart';

//infrastructure

/// The hits of [query].
///
/// [limit] entries starting from [offset].
@riverpod
Future<ConcordanceHits> concordanceHits(
  Ref ref,
  ConcordanceQuery query,
  int offset,
  int limit,
) async {
  log.info(() => '@riverpod - using $query, offset $offset, limit $limit');
  ref.cacheFor(const Duration(minutes: 5));
  final catalog = await ref.watch(libraryCatalogProvider.future);
  final db = await ref.watch(dbProvider.future);
  final repo = ConcordanceRepository(db.concordanceDrift);
  return GetConcordanceHitsUseCase(repo, query, catalog, offset, limit).invoke();
}

class ConcordanceRepository implements IConcordanceRepository {
  ConcordanceRepository(
    this._db,
  );

  final ConcordanceDrift _db;

  @override
  Future<ConcordanceHits> getHits(query, workIds, offset, limit) async {
    final parameters = ConcordanceParameters.of(query, workIds);
    final stopwatch = Stopwatch()..start();
    final rows = await _db
        .getConcordanceHits(
          works: parameters.works,
          phrase: parameters.phrase,
          fromIdx: parameters.fromIdx,
          toIdx: parameters.toIdx,
          titles: parameters.titles,
          sort: parameters.sort,
          limit: limit,
          offset: offset,
        )
        .get();
    final elapsed = stopwatch.elapsedMilliseconds;
    //groupBy keeps the order of the rows and hits
    final byHit = groupBy(rows, (row) => (row.workId, row.slot1Idx, row.slot2Idx, row.slot3Idx));
    final hits = ConcordanceHits(
      hits: byHit.values.map(_hit),
      total: rows.firstOrNull?.totalHits ?? 0,
      offset: offset,
    );
    log.fine(() => 'read ${hits.hits.length} of ${hits.total} hits in $elapsed ms: $parameters');
    return hits;
  }

  static ConcordanceHit _hit(List<GetConcordanceHitsResult> rows) {
    final head = rows.first;
    return ConcordanceHit(
      workId: head.workId,
      reference: head.reference,
      slotIndices: [head.slot1Idx, head.slot2Idx, head.slot3Idx].nonNulls,
      context: rows.map(
        (row) => ConcordanceToken(
          idx: row.contextIdx,
          word: row.contextWord,
          macronizedWord: row.contextMacronizedWord,
          reference: row.contextReference,
        ),
      ),
    );
  }

  //
}

//interactors

abstract interface class IConcordanceRepository {
  //
  /// [workIds] in the order hits are sorted by.
  /// Never empty.
  Future<ConcordanceHits> getHits(
    ConcordanceQuery query,
    List<String> workIds,
    int offset,
    int limit,
  );
  //
}

class GetConcordanceHitsUseCase implements IGetConcordanceHitsUseCase {
  GetConcordanceHitsUseCase(
    this._repository,
    this._query,
    this._catalog,
    this._offset,
    this._limit,
  );

  final IConcordanceRepository _repository;
  final ConcordanceQuery _query;
  final LibraryCatalog _catalog;
  final int _offset;
  final int _limit;

  @override
  Future<ConcordanceHits> invoke() async {
    final workIds = _searchedWorks();
    return workIds.isEmpty || !_query.isComplete
        ? ConcordanceHits(hits: const [], total: 0, offset: _offset)
        : await _repository.getHits(_query, workIds, _offset, _limit);
  }

  /// The works to search, by author and then by name (the catalog's order)
  List<String> _searchedWorks() {
    final selection = _query.selection;
    final selected = selection.allWorkIds;
    // a work written by several authors is listed once for each
    final catalogOrder = _catalog.allWorkIds.toSet();
    return switch (_query.part) {
      final part? => [part.workId],
      null => catalogOrder.where((id) => selection.isEmpty || selected.contains(id)).toList(),
    };
  }

  //
}

//domain

abstract interface class IGetConcordanceHitsUseCase {
  //
  Future<ConcordanceHits> invoke();
  //
}

/// A page of hits
@immutable
class ConcordanceHits {
  ConcordanceHits({
    required Iterable<ConcordanceHit> hits,
    required this.total,
    required this.offset,
  }) : hits = UnmodifiableListView(hits.toList(growable: false));

  final UnmodifiableListView<ConcordanceHit> hits;

  /// Hits on every page
  final int total;

  /// Hits on the pages before this one
  final int offset;

  bool get hasNextPage => offset + hits.length < total;

  @override
  String toString() => 'ConcordanceHits{hits: ${hits.length}, total: $total, offset: $offset}';
  //
}

/// Where the words of a query were found, with the text around them
@immutable
class ConcordanceHit {
  ConcordanceHit({
    required this.workId,
    required this.reference,
    required Iterable<int> slotIndices,
    required Iterable<ConcordanceToken> context,
  }) : slotIndices = UnmodifiableListView(slotIndices.toList(growable: false)),
       context = UnmodifiableListView(context.toList(growable: false));

  final String workId;

  /// Citation of the first word (e.g. 1.3.12). Display only
  final String reference;

  /// The token of each slot, in order
  final UnmodifiableListView<int> slotIndices;

  /// Up to 12 tokens before the first slot, every token up to the last slot,
  /// and as many after it
  final UnmodifiableListView<ConcordanceToken> context;

  int get firstIdx => slotIndices.first;
  int get lastIdx => slotIndices.last;

  Iterable<ConcordanceToken> get before => context.where((token) => token.idx < firstIdx);

  /// From the first slot to the last, words in between included
  Iterable<ConcordanceToken> get match =>
      context.where((token) => token.idx >= firstIdx && token.idx <= lastIdx);

  Iterable<ConcordanceToken> get after => context.where((token) => token.idx > lastIdx);

  bool isSlot(ConcordanceToken token) => slotIndices.contains(token.idx);

  @override
  String toString() => 'ConcordanceHit{workId: $workId, slots: $slotIndices}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConcordanceHit &&
          other.workId == workId &&
          const ListEquality<int>().equals(other.slotIndices, slotIndices));

  @override
  int get hashCode => Object.hash(workId, const ListEquality<int>().hash(slotIndices));
  //
}

@immutable
class ConcordanceToken {
  const ConcordanceToken({
    required this.idx,
    required this.word,
    required this.macronizedWord,
    required this.reference,
  });

  final int idx;
  final String word;
  final String macronizedWord;

  /// Citation of the token's line (a verse, a title...). 
  /// Where it changes, a new line starts.
  final String reference;

  @override
  String toString() => 'ConcordanceToken{idx: $idx, word: $word}';
  //
}
