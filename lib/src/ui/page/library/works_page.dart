import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/library/catalog_api.dart';
import '../../../component/settings/library_settings_api.dart';
import '../../router/config.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

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
          final works = worksByTitle(catalog);
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
  //
}
