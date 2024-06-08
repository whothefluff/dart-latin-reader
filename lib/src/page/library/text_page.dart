import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key, required this.workIndex});

  final dynamic workIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Text'),
      ),
      body: const Center(
        child: Text('Text'),
      ),
    );
  }
}
