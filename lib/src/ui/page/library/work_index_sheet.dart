import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/library/subdivision_type.dart';
import '../../../component/library/work_index_api.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';

const IconData workIndexIcon = Icons.toc;

const workIndexLabel = 'Contents';

/// Returns the selected subdivision, or null if dismissed.
///
/// Choosing an entry does not navigate directly.
/// The reader owns the jump and applies it after this route closes.
Future<WorkIndexEntry?> showWorkIndex({
  required BuildContext context,
  required String workId,
  required String workName,
  required int currentIndex,
}) {
  final panel = _WorkIndexPanel(
    workId: workId,
    workName: workName,
    currentIndex: currentIndex,
  );
  return Breakpoints.mediumAndUp.isActive(context)
      ? _showAsDialog(context, panel)
      : _showAsSheet(context, panel);
}

Future<WorkIndexEntry?> _showAsDialog(BuildContext context, Widget panel) =>
    showDialog<WorkIndexEntry>(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: 520,
          height: 700,
          child: panel,
        ),
      ),
    );

Future<WorkIndexEntry?> _showAsSheet(BuildContext context, Widget panel) =>
    showModalBottomSheet<WorkIndexEntry>(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      clipBehavior: Clip.antiAlias,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheetContext).bottom),
        child: FractionallySizedBox(
          heightFactor: 0.9,
          child: SafeArea(
            top: false,
            child: panel,
          ),
        ),
      ),
    );

class _WorkIndexPanel extends ConsumerWidget {
  const _WorkIndexPanel({
    required this.workId,
    required this.workName,
    required this.currentIndex,
  });

  final String workId;
  final String workName;
  final int currentIndex;

  @override
  Widget build(context, ref) {
    final provider = workIndexProvider(workId);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 8, 12),
          child: Row(
            children: [
              const Icon(workIndexIcon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(workIndexLabel, style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      workName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const CloseButton(),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ref
              .watch(provider)
              .when(
                loading: showLoading,
                error: showError(ref, provider),
                data: (index) => index.entries.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'No navigable subdivisions are available for this work.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : _WorkIndexTree(
                        key: ObjectKey(index),
                        index: index,
                        currentIndex: currentIndex,
                      ),
              ),
        ),
      ],
    );
  }

  //
}

class _WorkIndexTree extends StatefulWidget {
  const _WorkIndexTree({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  final WorkIndex index;
  final int currentIndex;

  @override
  State<_WorkIndexTree> createState() => _WorkIndexTreeState();
  //
}

class _WorkIndexTreeState extends State<_WorkIndexTree> {
  //
  static const _listPadding = 8.0;
  static const _macronized = 'āēīōūȳ';
  static const _plain = 'aeiouy';
  static final _macronPattern = RegExp('[$_macronized]');
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  late final WorkIndexEntry? _current = widget.index.currentAt(widget.currentIndex);

  /// The current entry and its ancestors; empty if there is no current entry
  ///
  /// Leaves are included because expanding one is harmless
  late final Set<String> _currentPath = [?_current]
      .expand((current) => [...widget.index.ancestorsOf(current), current])
      .map((entry) => entry.node)
      .toSet();

  // State is only ever replaced, never modified in place
  // Search does not change _expanded, so clearing it restores the previous tree state
  late Set<String> _expanded = _currentPath;

  var _query = '';

  @override
  void initState() {
    super.initState();
    _revealCurrent();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => Column(
    children: [
      _searchBar(),
      Expanded(child: _results(_rows)),
    ],
  );

  Widget _results(List<WorkIndexEntry> rows) => rows.isEmpty
      ? const Center(child: Text('No matching sections.'))
      : Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: _listPadding),
            itemCount: rows.length,
            itemExtent: _rowExtent(context),
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) => _entryRow(context, rows[index]),
          ),
        );

  Widget _searchBar() => Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search sections',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear search',
                      icon: const Icon(Icons.close),
                      onPressed: _clearSearch,
                    ),
              isDense: true,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: _search,
          ),
        ),
        IconButton(
          tooltip: 'Current section',
          icon: const Icon(Icons.adjust),
          onPressed: _current == null ? null : _showCurrent,
        ),
        IconButton(
          tooltip: 'Collapse all',
          icon: const Icon(Icons.compress),
          onPressed: _query.isNotEmpty || _expanded.isEmpty ? null : _collapseAll,
        ),
      ],
    ),
  );

  Widget _entryRow(BuildContext context, WorkIndexEntry entry) {
    final colors = Theme.of(context).colorScheme;
    final selected = _isCurrent(entry);
    final searching = _query.isNotEmpty;
    final hasChildren = widget.index.childrenOf(entry.node).isNotEmpty;
    final expanded = _expanded.contains(entry.node);
    final subtitle = _subtitle(entry);
    // Cap visual indentation so deep trees remain readable on narrow screens
    final indentation = searching ? 0.0 : min(entry.depth, 6) * 16.0;
    final path = [..._ancestry(entry), entry.label].join(' / ');
    return Tooltip(
      message: [path, subtitle].where((line) => line.isNotEmpty).join('\n'),
      child: Semantics(
        selected: selected,
        child: Material(
          color: selected ? colors.secondaryContainer : Colors.transparent,
          child: Row(
            children: [
              SizedBox(width: indentation),
              if (hasChildren && !searching)
                IconButton(
                  tooltip: '${expanded ? 'Collapse' : 'Expand'} ${entry.label}',
                  onPressed: () => _toggle(entry.node),
                  icon: AnimatedRotation(
                    turns: expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 150),
                    child: const Icon(Icons.chevron_right),
                  ),
                )
              else
                const SizedBox(width: 48),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(entry),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                              color: selected ? colors.onSecondaryContainer : colors.onSurface,
                            ),
                          ),
                          if (subtitle.isNotEmpty)
                            Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: selected
                                    ? colors.onSecondaryContainer
                                    : colors.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Search results are flat, with ancestry displayed as context.
  String _subtitle(WorkIndexEntry entry) => [
    if (_query.isNotEmpty) ..._ancestry(entry),
    _typeLabel(entry),
    'Ref. ${entry.referenceLabel}',
  ].join(' • ');

  /// Ancestor labels, outermost first
  Iterable<String> _ancestry(WorkIndexEntry entry) =>
      widget.index.ancestorsOf(entry).map((ancestor) => ancestor.label);

  double _rowExtent(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    return max(64.0, scaler.scale(16) * 1.4 + scaler.scale(12) * 1.4 + 24);
  }

  bool _isCurrent(WorkIndexEntry entry) => entry.node == _current?.node;

  /// The tree as currently expanded, or a flat list of matches while searching
  List<WorkIndexEntry> get _rows =>
      (_query.isEmpty ? _visible(widget.index.roots) : _matches).toList(growable: false);

  Iterable<WorkIndexEntry> _visible(Iterable<WorkIndexEntry> level) => level.expand(
    (entry) => [
      entry,
      if (_expanded.contains(entry.node)) ..._visible(widget.index.childrenOf(entry.node)),
    ],
  );

  // References intentionally do not participate in search or tree structure.
  Iterable<WorkIndexEntry> get _matches => widget.index.entries.where(
    (entry) =>
        _normalize(entry.label).contains(_query) || _normalize(_typeLabel(entry)).contains(_query),
  );

  void _search(String text) {
    setState(() {
      _query = _normalize(text.trim());
    });
    _scrollToTop();
  }

  void _clearSearch() {
    _searchController.clear();
    _search('');
  }

  void _toggle(String node) {
    setState(() {
      _expanded = _expanded.contains(node) ? _expanded.difference({node}) : _expanded.union({node});
    });
  }

  void _collapseAll() {
    setState(() {
      _expanded = const {};
    });
    _scrollToTop();
  }

  void _showCurrent() {
    _searchController.clear();
    setState(() {
      _query = '';
      _expanded = _expanded.union(_currentPath);
    });
    FocusScope.of(context).unfocus();
    _revealCurrent();
  }

  //does nothing if the list has no attached position
  void _scrollToTop() => _scrollController.positions.forEach(_jumpToTop);

  //waits until layout is complete
  //does nothing if the list has no attached position
  void _revealCurrent() => WidgetsBinding.instance.addPostFrameCallback(
    (_) => _scrollController.positions.forEach(_jumpToCurrent),
  );

  // Puts the current row about a third of the way down
  void _jumpToCurrent(ScrollPosition position) {
    final row = _rows.indexWhere(_isCurrent); // -1 when there's no current entry
    if (row >= 0) {
      final target = _listPadding + row * _rowExtent(context) - position.viewportDimension * 0.35;
      position.jumpTo(target.clamp(position.minScrollExtent, position.maxScrollExtent));
    }
  }

  static void _jumpToTop(ScrollPosition position) => position.jumpTo(0);

  // Counters are zero-based within their parent
  static String _typeLabel(WorkIndexEntry entry) => switch (entry.typ) {
    SubdivisionType.book => 'Book ${entry.cnt + 1}',
    SubdivisionType.poem => 'Poem ${entry.cnt + 1}',
    SubdivisionType.prologue => 'Prologue',
    SubdivisionType.epilogue => 'Epilogue',
    SubdivisionType.verse => 'Verse ${entry.cnt + 1}',
    SubdivisionType.paragraph => 'Paragraph ${entry.cnt + 1}',
    SubdivisionType.title => 'Title',
  };

  static String _normalize(String value) => value.toLowerCase().replaceAllMapped(
    _macronPattern,
    (match) => _plain[_macronized.indexOf(match[0]!)],
  );
  //
}
