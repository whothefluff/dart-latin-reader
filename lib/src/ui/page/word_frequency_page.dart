import 'package:flutter/material.dart';

class WordFrequencyPage extends StatelessWidget {
  const WordFrequencyPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Word Frequency'),
        ),
        body: const Center(
          child: Text('Word Frequency Page'),
        ),
      );
}
