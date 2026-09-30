import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/library/authors_api.dart';
import '../../../component/library/catalog_api.dart';
import '../../../component/settings/library_settings_api.dart';
import '../../router/config.dart';
import '../../widget/search_results.dart';
import '../../widget/searchable_app_bar.dart';

/// A work with its author's name
///
/// `null` for anonymous works
typedef ListedWork = ({CatalogWork work, String? authorName});

/// All works in [catalog], from every author, sorted by title
List<ListedWork> worksByTitle(LibraryCatalog catalog) => catalog.authors
    .expand<ListedWork>(
      (author) => author.works.map((work) => (work: work, authorName: author.name)),
    )
    .followedBy(catalog.anonymousWorks.map((work) => (work: work, authorName: null)))
    .sortedBy((listed) => listed.work.name);

SearchableAppBar libraryListAppBar(
  BuildContext context,
  WidgetRef ref, {
  required LibraryView shown,
}) {
  final (other, icon, tooltip) = switch (shown) {
    LibraryView.authors => (LibraryView.works, Icons.my_library_books, 'List works'),
    // TODO(whothefluff): change to article_person when available
    LibraryView.works => (LibraryView.authors, Icons.people, 'List authors'),
  };
  return SearchableAppBar(
    onFilterPressed: () {},
    onSortPressed: () {},
    onSettingsPressed: () async {
      await const SettingsRoute().push<void>(context);
    },
    searchHintText: switch (shown) {
      LibraryView.authors => 'Search authors...',
      LibraryView.works => 'Search works...',
    },
    searchSuggestionsBuilder: (_, controller) {
      final text = controller.text.trim();
      return [
        if (text.isNotEmpty)
          switch (shown) {
            LibraryView.authors => SearchResults(
              provider: authorsProvider,
              tiles: (all) => all
                  .where((author) => author.matches(text))
                  .map((author) => _authorTile(context, controller, author)),
            ),
            LibraryView.works => SearchResults(
              provider: libraryCatalogProvider,
              tiles: (catalog) => worksByTitle(catalog)
                  .where((listed) => listed.work.matches(text))
                  .map((listed) => _workTile(context, controller, listed)),
            ),
          },
      ];
    },
    extraActions: [
      IconButton(
        tooltip: tooltip,
        icon: Icon(icon),
        onPressed: () async => _switchTo(context, ref, other),
      ),
    ],
  );
}

Future<void> _switchTo(BuildContext context, WidgetRef ref, LibraryView view) async {
  final notifier = ref.read(librarySettingsNotifierProvider.notifier);
  final settings = await ref.read(librarySettingsNotifierProvider.future);
  await notifier.updateSettings(settings.copyWith(view: view)); //saves first, so library re-uses it
  if (context.mounted) {
    libraryListRoute(view).go(context);
  }
}

ListTile _authorTile(
  BuildContext context,
  SearchController controller,
  Author author,
) => ListTile(
  title: Text(author.name),
  onTap: () async {
    controller.closeView(controller.text);
    await AuthorDetailsRoute(author.id).push<void>(context);
  },
);

ListTile _workTile(
  BuildContext context,
  SearchController controller,
  ListedWork listed,
) => ListTile(
  title: Text(listed.work.name),
  subtitle: Text(listed.authorName ?? 'Unknown'),
  onTap: () async {
    controller.closeView(controller.text);
    await WorkDetailsRoute(listed.work.id).push<void>(context);
  },
);
