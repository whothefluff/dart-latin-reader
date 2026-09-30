import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/library/catalog_api.dart';
import '../../../component/settings/library_settings_api.dart';
import '../../router/config.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

/// A work with its author's name
///
/// `null` for anonymous works
typedef _ListedWork = ({CatalogWork work, String? authorName});

/// Lists all works, from every author, sorted by title
class WorksPage extends ConsumerWidget {
  const WorksPage({
    super.key,
  });

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: libraryListAppBar(context, ref, shown: LibraryView.works),
    body: worksList(ref),
  );

  Widget worksList(WidgetRef ref) => ref
      .watch(libraryCatalogProvider)
      .when(
        data: (catalog) {
          final works = _byTitle(catalog);
          return ListView.builder(
            itemCount: works.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(works[index].work.name),
              subtitle: Text(works[index].authorName ?? 'Unknown'),
              onTap: () async {
                await WorkDetailsRoute(works[index].work.id).push<void>(context);
              },
            ),
          );
        },
        loading: showLoading,
        error: showError(ref, libraryCatalogProvider),
      );

  List<_ListedWork> _byTitle(LibraryCatalog catalog) => catalog.authors
      .expand<_ListedWork>(
        (author) => author.works.map((work) => (work: work, authorName: author.name)),
      )
      .followedBy(catalog.anonymousWorks.map((work) => (work: work, authorName: null)))
      .sortedBy((listed) => listed.work.name);
  //
}
