import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorksPage extends StatelessWidget {
  final int authorIndex;

  const WorksPage({super.key, required this.authorIndex});

  @override
  Widget build(BuildContext context) {
    final List<String> items =
        List<String>.generate(authorIndex * 10, (i) => 'Work $i');
    return Scaffold(
      appBar: AppBar(
        title: Text('Works of Author $authorIndex'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            //TODO return list of all works and add to nav bar
            title: Text(items[index]),
            onTap: () => context.go('works/$index'),
          );
        },
      ),
    );
  }
}
