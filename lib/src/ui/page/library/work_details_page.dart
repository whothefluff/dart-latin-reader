import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../component/library/work_details_api.dart';
import '../../router/config.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';

class WorkDetailsPage extends ConsumerWidget {
  const WorkDetailsPage(
    this.workId, {
    super.key,
  });

  final String workId;

  @override
  Widget build(context, ref) {
    final workDetailsAsync = ref.watch(workDetailsProvider(workId));
    return Scaffold(
      appBar: AppBar(
        title: workDetailsAsync.maybeWhen(
          data: (workDetails) => Text(workDetails.name),
          orElse: () => const Text('Work details'),
        ),
      ),
      body: workDetailsAsync.when(
        data: (workDetails) => ListView(
          children: [
            BookThingy(
              id: workDetails.id,
              title: workDetails.name,
              numberOfWords: workDetails.numberOfWords,
              authorId: workDetails.authorId,
              authorName: workDetails.authorName,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: workDetails.about,
                      style: DefaultTextStyle.of(context).style,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: showLoading,
        error: showError(ref, workDetailsProvider(workId)),
      ),
    );
  }

  //
}

class BookThingy extends StatelessWidget {
  const BookThingy({
    super.key,
    required this.id,
    required this.title,
    required this.numberOfWords,
    required this.authorId,
    required this.authorName,
  });

  final String id;
  final String title;
  final int numberOfWords;
  final String? authorId;
  final String? authorName;
  static const boxConstraints = BoxConstraints(maxWidth: 200, maxHeight: 400);

  @override
  Widget build(context) {
    final cover = Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: PseudoCover(bookTitle: title, bookAuthor: authorName),
        ),
      ),
    );
    final basicInfo = Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Details(
          workId: id,
          authorId: authorId,
          numberOfWords: numberOfWords,
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

  //
}

class PseudoCover extends StatelessWidget {
  const PseudoCover({
    super.key,
    required this.bookTitle,
    required this.bookAuthor,
  });

  final String bookTitle;
  final String? bookAuthor;
  static const proportion = (2, 3);

  @override
  Widget build(context) {
    final themeColor = ColorScheme.of(context);
    final upper = Expanded(
      flex: proportion.$1,
      child: Container(
        color: themeColor.primary,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            bookAuthor ?? 'Unknown',
            style: TextStyle(color: themeColor.onPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    final lower = Expanded(
      flex: proportion.$2,
      child: Container(
        color: themeColor.secondary,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            bookTitle,
            style: TextStyle(color: themeColor.onSecondary),
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

  //
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.workId,
    required this.authorId,
    required this.numberOfWords,
  });

  final String workId;
  final String? authorId;
  final int numberOfWords;

  @override
  Widget build(context) => ConstrainedBox(
    constraints: BookThingy.boxConstraints,
    child: AspectRatio(
      aspectRatio: 3 / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Number of words: $numberOfWords')],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              readButton(context),
              ?_toAuthorButton(context),
            ],
          ),
        ],
      ),
    ),
  );

  FilledButton readButton(BuildContext context) => FilledButton(
    onPressed: () async => ReaderRoute(workId).push<void>(context),
    child: const Text('Read'),
  );

  TextButton? _toAuthorButton(BuildContext context) => authorId != null
      ? TextButton(
          // TODO(whothefluff): push('/author/id'), if prev stack is different author
          onPressed: () => context.pop(),
          child: const Text('Go to author'),
        )
      : null;
  //
}
