import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthorDetailPage extends StatelessWidget {
  const AuthorDetailPage({super.key, required this.authorIndex});

  final int authorIndex;
  static const boxConstraints = BoxConstraints(
    //maxWidth: 500,
    maxHeight: 200,
  );

  @override
  Widget build(BuildContext context) {
    final works = List<String>.generate(authorIndex * 10, (i) => 'Work $i');
    final items = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: AuthorDetailPage.boxConstraints,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Text('Author $authorIndex'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 150),
                    child: RichText(text: const TextSpan(text: 'data')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ...works.map(
        (item) => ListTile(
          title: Text(item),
          onTap: () => context.push('/works/${works.indexOf(item) - 1}'),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Author $authorIndex'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
