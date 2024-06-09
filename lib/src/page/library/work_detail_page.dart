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
              background: const BookThingy(
                author: 'Cicero',
                title: 'De Oratore',
              ),
              title: Text('Work $workIndex'),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              child: LinkButton(
                text: 'Author',
                route: '/authors/1',
              ),
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

class BookThingy extends StatelessWidget {
  const BookThingy({super.key, required this.author, required this.title});

  final String author;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Matches the height of the FlexibleSpaceBar
      child: Row(
        children: [
          // Simulated Book Cover Image
          PseudoCover(
            bookAuthor: 'Cicero',
            bookTitle: 'Testing',
          ),
          // Title and Author
          Expanded(
            child: Text(
              'Title: $title\nAuthor: $author',
            ),
          ),
        ],
      ),
    );
  }
}

class PseudoCover extends StatelessWidget {
  final String bookTitle;
  final String bookAuthor;

  const PseudoCover({
    Key? key,
    required this.bookTitle,
    required this.bookAuthor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final onSecondaryColor = Theme.of(context).colorScheme.onSecondary;

    return Container(
      width: 300.0, // Adjust width as needed
      height: 500.0, // Adjust height as needed
      child: Column(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                bookAuthor,
                style: TextStyle(
                  color: onPrimaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: secondaryColor,
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bookTitle,
                    style: TextStyle(
                      color: onSecondaryColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
