import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {},
        ),
        title: Row(
          children: [
            Expanded(
              child: SearchAnchor.bar(
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<Widget>.empty();
                },
                // isFullScreen: true,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: authors(),
    );
  }

  Scaffold authors() {
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
