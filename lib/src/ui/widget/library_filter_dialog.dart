import 'package:flutter/material.dart';

import '../../component/library/catalog_api.dart';
import '../../component/word_frequency/library_selection_api.dart';

/// Lets the user choose works (for the word frequency report or the concordance).
///
/// Pressing Done returns the edited [LibrarySelection] to the caller.
/// Closing the dialog without pressing Done discards the edits.
class LibraryFilterDialog extends StatefulWidget {
  const LibraryFilterDialog({
    super.key,
    required this.catalog,
    required this.selection,
  });

  final LibraryCatalog catalog;
  final LibrarySelection selection;

  @override
  State<LibraryFilterDialog> createState() => _LibraryFilterDialogState();
  //
}

class _LibraryFilterDialogState extends State<LibraryFilterDialog> {
  //
  final _searchController = TextEditingController();
  var _query = '';
  late LibrarySelection _draft = widget.selection;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final q = _query.trim().toLowerCase();
    final authors = q.isEmpty
        ? widget.catalog.authors
        : widget.catalog.authors.where(
            (a) =>
                a.name.toLowerCase().contains(q) ||
                a.works.any((w) => w.name.toLowerCase().contains(q)),
          );
    final anonymous = q.isEmpty
        ? widget.catalog.anonymousWorks
        : widget.catalog.anonymousWorks.where((w) => w.name.toLowerCase().contains(q));
    return Dialog(
      child: SizedBox(
        width: 420,
        height: 560,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Filter authors or works',
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...authors.map(
                    (author) => _AuthorNode(
                      author: author,
                      works: _visibleWorks(author, q),
                      selection: _draft,
                      onToggle: _toggle,
                    ),
                  ),
                  if (anonymous.isNotEmpty)
                    _AnonymousNode(
                      works: anonymous.toList(),
                      selection: _draft,
                      onToggle: _toggle,
                    ),
                ],
              ),
            ),
            OverflowBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => setState(() => _draft = const LibrarySelection.empty()),
                  child: const Text('Clear'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, _draft),
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggle(String? authorId, Set<String> workIds, {required bool selected}) =>
      setState(() => _draft = _draft.withWorks(authorId, workIds, selected: selected));

  /// Works shown under [author] for [query].
  ///
  /// An author-name match returns all his works, otherwise only matching works
  List<CatalogWork> _visibleWorks(CatalogAuthor author, String query) =>
      query.isEmpty || author.name.toLowerCase().contains(query)
      ? author.works
      : author.works.where((w) => w.name.toLowerCase().contains(query)).toList();

  //
}

class _AuthorNode extends StatelessWidget {
  const _AuthorNode({
    required this.author,
    required this.works,
    required this.selection,
    required this.onToggle,
  });

  final CatalogAuthor author;

  final List<CatalogWork> works;

  final LibrarySelection selection;
  final void Function(String? authorId, Set<String> workIds, {required bool selected}) onToggle;

  @override
  Widget build(context) {
    final visibleIds = works.map((w) => w.id).toSet();
    final selected = selection.worksOf(author.id);
    final selectedVisible = visibleIds.intersection(selected);
    final state = selectedVisible.isEmpty
        ? false
        : (selectedVisible.length == visibleIds.length ? true : null);
    return ExpansionTile(
      leading: Checkbox(
        tristate: true,
        value: state,
        onChanged: (_) => onToggle(author.id, visibleIds, selected: state != true),
      ),
      title: Text(author.name),
      children: works
          .map(
            (work) => CheckboxListTile(
              title: Text(work.name),
              value: selected.contains(work.id),
              onChanged: (v) => onToggle(author.id, {work.id}, selected: v ?? false),
            ),
          )
          .toList(),
    );
  }

  //
}

class _AnonymousNode extends StatelessWidget {
  const _AnonymousNode({
    required this.works,
    required this.selection,
    required this.onToggle,
  });

  final List<CatalogWork> works;
  final LibrarySelection selection;
  final void Function(String? authorId, Set<String> workIds, {required bool selected}) onToggle;

  @override
  Widget build(context) {
    // The "No Author" checkbox changes only the works shown by the search.
    // Example: works A and B are selected, but the search shows only A.
    // Unchecking the checkbox deselects A; B stays selected.
    final visibleIds = works.map((w) => w.id).toSet();
    final selected = selection.worksOf(null);
    final selectedVisible = visibleIds.intersection(selected);
    final state = selectedVisible.isEmpty
        ? false
        : (selectedVisible.length == visibleIds.length ? true : null);
    return ExpansionTile(
      leading: Checkbox(
        tristate: true,
        value: state,
        onChanged: (_) => onToggle(null, visibleIds, selected: state != true),
      ),
      title: const Text('— No Author —'),
      children: works
          .map(
            (work) => CheckboxListTile(
              title: Text(work.name),
              value: selected.contains(work.id),
              onChanged: (v) => onToggle(null, {work.id}, selected: v ?? false),
            ),
          )
          .toList(),
    );
  }

  //
}
