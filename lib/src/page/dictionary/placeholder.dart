import 'package:flutter/material.dart';

class PlaceholderDict extends StatelessWidget {
  const PlaceholderDict({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Placeholder'),
      ),
    );
  }
}
