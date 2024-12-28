import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/library/authors_api.dart';
import 'package:latin_reader/src/ui/widget/searchable_app_bar.dart';
import 'package:latin_reader/src/ui/widget/show_error.dart';
import 'package:latin_reader/src/ui/widget/show_loading.dart';

class AuthorsPage extends ConsumerWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(context, ref) => Scaffold(
        // TODO(whothefluff): add fts5 encompasing Authors.name, AuthorAbbreviations.val, Works.name, WorkAbbreviations.val
        appBar: SearchableAppBar(
          onFilterPressed: () {},
          onSortPressed: () {},
          onSettingsPressed: () async {
            await context.push('/settings');
          },
          searchSuggestionsBuilder: (context, controller) async => [],
        ),
        body: authorsGrid(ref),
      );

  Widget authorsGrid(WidgetRef ref) => ref.watch(authorsProvider).when(
      data: (authors) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
            ),
            itemCount: authors.length,
            itemBuilder: (context, index) {
              final cardBorderRadius = BorderRadius.circular(12);
              return Card(
                child: InkWell(
                  onTap: () async {
                    await context.push('/authors/${authors[index].id}');
                  },
                  borderRadius: cardBorderRadius,
                  child: GridTile(
                    footer: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12)),
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withValues(alpha: 0.2),
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
                        borderRadius:
                            cardBorderRadius, // Apply the same borderRadius as the InkWell
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      loading: showLoading,
      error: showError(ref, authorsProvider));
//
}
