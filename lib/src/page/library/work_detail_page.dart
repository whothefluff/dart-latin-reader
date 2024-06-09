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
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Work $workIndex'),
            ),
          ),
          const SliverToBoxAdapter(
              child: BookThingy(author: 'author', title: 'title')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Scrollable free text\n' * 100,
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
    const cover = Flexible(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: PseudoCover(bookTitle: 'bookTitle', bookAuthor: 'bookAuthor'),
        ),
      ),
    );

    var basicInfo = Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(),
            ),
            const Text('Page No:'),
            TextButton(
              onPressed: () => context.go('/author/1'),
              child: const Text('Go to author'),
            ),
            FilledButton(
              onPressed: () => context.go('/works'),
              child: const Text('Read'),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              cover,
              basicInfo,
            ],
          ),
        ),
      ),
    );
  }
}

class PseudoCover extends StatelessWidget {
  const PseudoCover({
    super.key,
    required this.bookTitle,
    required this.bookAuthor,
  });

  final String bookTitle;
  final String bookAuthor;
  static const proportion = (2, 3);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final onSecondaryColor = Theme.of(context).colorScheme.onSecondary;

    final upper = Expanded(
      flex: proportion.$1,
      child: Container(
        color: primaryColor,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            bookAuthor,
            style: TextStyle(
              color: onPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    final lower = Expanded(
      flex: proportion.$2,
      child: Container(
        color: secondaryColor,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            bookTitle,
            style: TextStyle(
              color: onSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
        maxHeight: 400,
      ),
      child: AspectRatio(
        aspectRatio: proportion.$1 / proportion.$2,
        child: Column(
          children: [
            upper,
            lower,
          ],
        ),
      ),
    );
  }
}
