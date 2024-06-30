import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkDetailsPage extends StatelessWidget {
  const WorkDetailsPage({super.key, required this.workId});

  final String workId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work $workId'),
      ),
      body: ListView(
        children: [
          const BookThingy(author: 'author', title: 'title'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Scrollable free text\n' * 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookThingy extends StatelessWidget {
  const BookThingy({super.key, required this.author, required this.title});

  final String author;
  final String title;

  static const boxConstraints = BoxConstraints(
    maxWidth: 200,
    maxHeight: 400,
  );

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

    var basicInfo = const Flexible(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Details(bookTitle: 'bookTitle', bookAuthor: 'bookAuthor'),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
      constraints: BookThingy.boxConstraints,
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

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.bookTitle,
    required this.bookAuthor,
  });

  final String bookTitle;
  final String bookAuthor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BookThingy.boxConstraints,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'),
                Text('Page No:'),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton(
                  onPressed: () => context.push('/reader/1'),
                  child: const Text('Read'),
                ),
                TextButton(
                  onPressed: () => context.push('/author/1'),
                  child: const Text('Go to author'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
