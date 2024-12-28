import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/library/author_details_api.dart';
import 'package:latin_reader/src/ui/widget/show_error.dart';
import 'package:latin_reader/src/ui/widget/show_loading.dart';

class AuthorDetailsPage extends ConsumerWidget {
  const AuthorDetailsPage({super.key, required this.authorId});

  final String authorId;

  @override
  Widget build(context, ref) => ref.watch(authorDetailsProvider(authorId)).when(
        data: (authorDetails) => Scaffold(
          appBar: AppBar(
            title: Text(authorDetails.name),
          ),
          body: worksList(context, authorDetails),
        ),
        loading: showLoading,
        error: showError(ref, authorDetailsProvider(authorId)),
      );

  Widget worksList(BuildContext context, AuthorDetails authorDetails) {
    final allItems = [
      authorItem(context, authorDetails),
      ...workItems(context, authorDetails),
    ];
    return ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (context, index) => allItems[index],
    );
  }

  Iterable<ListTile> workItems(
          BuildContext context, AuthorDetails authorDetails) =>
      authorDetails.works.map(
        (work) => ListTile(
          title: Row(
            children: [
              Expanded(child: Text(work.name)),
              Text('${(work.numberOfWords / 1000).round()}k words'),
            ],
          ),
          onTap: () async => context.push('/works/${work.id}'),
        ),
      );

  Widget authorItem(BuildContext context, AuthorDetails author) => Padding(
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

  Padding authorImage(Uint8List image) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.memory(
          image,
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
          height: 200,
        ),
      );

  Padding aboutAuthor(BuildContext context, String about) => Padding(
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
//
}
