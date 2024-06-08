import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkDetailPage extends StatelessWidget {
  const WorkDetailPage({super.key, required this.workIndex});

  final int workIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: BookCover(
                author: 'Cicero',
                title: 'De Oratore',
              ),
              title: Text('Work $workIndex'),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              // height: 20,
              child: LinkButton(
                text: 'Author',
                route: '/authors/1',
              ),
              // Center(
              // child: //doesn't seem to be necessary
              // ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  const LinkButton({super.key, required this.text, required this.route});

  final String text;
  final String route;

  @override //TODO: check maybe use a regular text button because it looks soso
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.push(route);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  const BookCover({super.key, required this.author, required this.title});

  final String author;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Matches the height of the FlexibleSpaceBar
      color: Colors.yellow[100],
      child: Row(
        children: [
          // Simulated Book Cover Image
          Container(
            width: 150.0, // Adjust width as needed
            height: double.infinity,
            color: Colors.green[800],
            child: Center(
              child: Text(
                'COVER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Title and Author
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    author.toUpperCase(),
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
