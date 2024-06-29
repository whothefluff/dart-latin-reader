import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/library/author_details_view.dart';
import 'package:latin_reader/src/component/library/author_service.dart';

class AuthorDetailsPage extends ConsumerWidget {
  const AuthorDetailsPage({super.key, required this.authorId});

  final String authorId;

  @override
  Widget build(context, ref) {
    return ref.watch(libraryAuthorDetailsProvider(authorId)).when(
          data: (authorDetails) {
            return Scaffold(
              appBar: AppBar(
                title: Text(authorDetails.name),
              ),
              body: worksList(context, authorDetails),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(error.toString()),
                TextButton(
                  onPressed: () =>
                      ref.refresh(libraryAuthorDetailsProvider(authorId)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
  }

  Widget worksList(BuildContext context, AuthorDetailsView authorDetails) {
    final allItems = [
      authorItem(context, authorDetails),
      ...authorDetails.works.map(
        (work) => ListTile(
          title: Row(
            children: [
              Expanded(child: Text(work.name)),
              Text('${(work.numberOfWords / 1000).round()}k words'),
            ],
          ),
          onTap: () => context.push('/works/${work.id}'),
        ),
      ),
    ];
    return ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (context, index) {
        return allItems[index];
      },
    );
  }

  Widget authorItem(BuildContext context, AuthorDetailsView author) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              authorImage(author.image),
              aboutAuthor(context, author.about),
            ],
          ),
        ),
      ),
    );
  }

  Padding authorImage(Uint8List image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.memory(
        image,
        filterQuality: FilterQuality.high,
        isAntiAlias: true,
        height: 200,
      ),
    );
  }

  Padding aboutAuthor(BuildContext context, String about) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: RichText(
          text: TextSpan(
            text: about,
            style: DefaultTextStyle.of(context).style,
          ),
        ),
      ),
    );
  }
//
}
