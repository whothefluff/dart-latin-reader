import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorksPage extends StatelessWidget {
  const WorksPage({super.key, required this.authorIndex});

  final int authorIndex;

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(authorIndex * 10, (i) => 'Work $i');
    return Scaffold(
      appBar: AppBar(
        title: Text('Works of Author $authorIndex'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          // TODO(whothefluff): (someday) return list of all works and add to nav bar
          title: Text(items[index]),
          onTap: () => context.go('works/$index'),
        ),
      ),
    );
  }
}
