import 'package:flutter/material.dart';

class DictionariesPage extends StatelessWidget {
  const DictionariesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Dictionaries'),
        ),
        body: const Center(
          child: Text('Dictionaries Page'),
        ),
      );
}
