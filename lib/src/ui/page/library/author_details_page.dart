import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/library/author_details_api.dart';
import '../../router/config.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';

class AuthorDetailsPage extends ConsumerWidget {
  const AuthorDetailsPage(
    this.authorId, {
    super.key,
  });

  final String authorId;

  @override
  Widget build(context, ref) {
    final authorDetailsAsync = ref.watch(authorDetailsProvider(authorId));
    return Scaffold(
      appBar: AppBar(
        title: authorDetailsAsync.maybeWhen(
          data: (authorDetails) => Text(authorDetails.name),
          orElse: () => const Text('My App'),
        ),
      ),
      body: authorDetailsAsync.when(
        data: (authorDetails) => worksList(context, authorDetails),
        loading: showLoading,
        error: showError(ref, authorDetailsProvider(authorId)),
      ),
    );
  }

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

  Iterable<ListTile> workItems(BuildContext context, AuthorDetails authorDetails) =>
      authorDetails.works.map(
        (work) => ListTile(
          title: Row(
            children: [
              Expanded(child: Text(work.name)),
              Text('${(work.numberOfWords / 1000).round()}k words'),
            ],
          ),
          onTap: () async {
            await WorkDetailsRoute(work.id).push<void>(context);
          },
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
