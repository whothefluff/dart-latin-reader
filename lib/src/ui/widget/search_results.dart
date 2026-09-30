import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'show_error.dart';
import 'show_loading.dart';

/// The results of one search in a search view
///
/// It's a sliver, laid out by [searchResultsView].
/// A search view can show several, and each one loads and fails on its own
class SearchResults<T> extends ConsumerWidget {
  const SearchResults({
    super.key,
    required this.provider,
    required Iterable<Widget> Function(T found) tiles,
  }) : _tiles = tiles;

  final AutoDisposeFutureProvider<T> provider;

  // Safe because this field is only read through this instance, with its original T
  // ignore: unsafe_variance
  final Iterable<Widget> Function(T found) _tiles;

  @override
  Widget build(context, ref) => ref
      .watch(provider)
      .when(
        data: (found) => SliverList.list(children: _tiles(found).toList()),
        loading: () => SliverToBoxAdapter(child: showLoading()),
        error: (e, stack) => SliverToBoxAdapter(child: showError(ref, provider)(e, stack)),
      );
  //
}

/// A search view's list of the [SearchResults] its suggestions builder returns
///
/// [SearchAnchor]'s own list takes finished tiles, so its builder would have to await the search:
/// it then shows whichever call finishes last, even one for older text, and can't build them again
/// for a Retry. Returning [SearchResults] right away avoids both, and this list lays them out
/// lazily. Like [SearchAnchor]'s own list, it's padded at the bottom for the system bars.
Widget searchResultsView(Iterable<Widget> results) => Builder(
  builder: (context) => CustomScrollView(
    slivers: [
      ...results,
      SliverPadding(padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom)),
    ],
  ),
);
