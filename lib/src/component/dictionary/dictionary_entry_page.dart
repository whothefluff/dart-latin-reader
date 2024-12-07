import 'package:flutter/material.dart';

class DictionaryEntryPage extends StatelessWidget {
  const DictionaryEntryPage(
    this.dictionary,
    this.lemma, {
    super.key,
  });

  final String dictionary;
  final String lemma;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(lemma),
        ),
        body: const Center(
          child: Text('Placeholder'),
        ),
      );
}
