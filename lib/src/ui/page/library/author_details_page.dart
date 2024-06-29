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
                title: Text(authorDetails[0].name),
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

  Widget worksList(
      BuildContext context, List<AuthorDetailsView> authorDetails) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.memory(
                      authorDetails[0].image,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: authorDetails[0].about,
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ...authorDetails.map(
          (item) => ListTile(
            title: Text(item.workName),
            onTap: () => context.push('/works/${item.workId}'),
          ),
        ),
      ],
    );
  }
//
}
