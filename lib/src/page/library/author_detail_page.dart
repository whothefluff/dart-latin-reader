import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthorDetailPage extends StatelessWidget {
  const AuthorDetailPage({super.key, required this.authorIndex});

  final int authorIndex;

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(authorIndex * 10, (i) => 'Work $i');
    return Scaffold(
      appBar: AppBar(
        title: Text('Author $authorIndex'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () => context.push('/works/$index'),
          );
        },
      ),
    );
  }
}
