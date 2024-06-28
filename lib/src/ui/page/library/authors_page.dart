import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/library/author_service.dart';
import 'package:latin_reader/src/ui/widget/searchable_app_bar.dart';

class AuthorsPage extends ConsumerWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: SearchableAppBar(
        onFilterPressed: () {},
        onSortPressed: () {},
        onSettingsPressed: () {
          context.push('/settings');
        },
        searchSuggestionsBuilder: (context, controller) async => [],
      ),
      body: authorsGrid(ref),
    );
  }

  Widget authorsGrid(WidgetRef ref) {
    return ref.watch(libraryAuthorsProvider).when(
          data: (authors) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
              ),
              itemCount: authors.length,
              itemBuilder: (context, int index) {
                var cardBorderRadius = BorderRadius.circular(12);
                return Card(
                  child: InkWell(
                    onTap: () {
                      context.push('/authors/$index');
                    },
                    borderRadius: cardBorderRadius,
                    child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withOpacity(0.2),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(authors[index].name),
                            Text(authors[index].numberOfWorks.toString()),
                          ],
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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $error'),
                TextButton(
                  onPressed: () => ref.refresh(authorsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
  }
}
