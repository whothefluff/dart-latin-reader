import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/widget/searchable_app_bar.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchableAppBar(
        onFilterPressed: () {},
        onSortPressed: () {},
        onSettingsPressed: () {
          context.push('/settings');
        },
        searchSuggestionsBuilder: (context, controller) async => [],
      ),
      body: authorsGrid(),
    );
  }

  Scaffold authorsGrid() {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
        ),
        itemCount: 10,
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Author $index'),
                      Text('0'), //no of works
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    '$index',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
