import 'package:flutter/material.dart';

class WordLookupPage extends StatelessWidget {
  const WordLookupPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Word Lookup'),
        ),
        body: const Center(
          child: Text('Word Lookup Page'),
        ),
      );
}
