import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/library/authors_api.dart';
import '../../../component/settings/library_settings_api.dart';
import '../../router/config.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

class AuthorsPage extends ConsumerWidget {
  const AuthorsPage({
    super.key,
  });

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: libraryListAppBar(context, ref, shown: LibraryView.authors),
    body: authorsGrid(ref),
  );

  Widget authorsGrid(WidgetRef ref) => ref
      .watch(authorsProvider)
      .when(
        data: (authors) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300),
          itemCount: authors.length,
          itemBuilder: (context, index) {
            final cardBorderRadius = BorderRadius.circular(12);
            final author = authors[index];
            return Card(
              child: InkWell(
                onTap: () async {
                  await AuthorDetailsRoute(author.id).push<void>(context);
                },
                borderRadius: cardBorderRadius,
                child: GridTile(
                  footer: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                      color: ColorScheme.of(context).shadow.withValues(alpha: 0.2),
                    ),
                    child: GridTileBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(authors[index].name),
                          Text(authors[index].numberOfWorks.toString()),
                        ],
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(authors[index].image),
                        fit: BoxFit.cover,
                      ),
                      // Apply the same borderRadius as the InkWell
                      borderRadius: cardBorderRadius,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        loading: showLoading,
        error: showError(ref, authorsProvider),
      );
  //
}
