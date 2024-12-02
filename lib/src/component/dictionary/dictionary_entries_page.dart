import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryEntriesPage extends ConsumerWidget {
  const DictionaryEntriesPage({super.key, required this.dictionaryId});

  final String dictionaryId;

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary Contents'),
      ),
      body: const Center(
        child: Text('Placeholder'),
      ),
    );
  }
}
