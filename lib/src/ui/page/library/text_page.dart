import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/external/provider_work.dart';

class TextPage extends ConsumerStatefulWidget {
  const TextPage({
    super.key,
    required this.workId,
  });

  final String workId;

  @override
  TextPageState createState() => TextPageState(workId: workId);
//
}

class TextPageState extends ConsumerState<TextPage> {
  TextPageState({required this.workId});

  final String workId;
  int _currentIndex = 0;
  int _lastVisibleIndex = 0;
  static const int _pageSize = 250;

  @override
  Widget build(BuildContext context) {
    final wordsProvider = ref.watch(
      libraryWorkContentsPartiallyProvider(
          workId, _currentIndex, _currentIndex + _pageSize),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Styled Word List')),
      body: wordsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (words) => Column(
          children: [
            Expanded(
              child: StyledWordList(
                words: words,
                onRightSideTap: _loadNextPage,
                onLastVisibleIndexChanged: (index) {
                  _lastVisibleIndex = _currentIndex + index;
                },
              ),
            ),
            Text('Current index: $_currentIndex'),
          ],
        ),
      ),
    );
  }

  void _loadNextPage() {
    setState(() {
      _currentIndex = _lastVisibleIndex + 1;
    });
  }
}

typedef LastVisibleIndexCallback = void Function(int lastVisibleIndex);

class StyledWordList extends StatefulWidget {
  const StyledWordList({
    super.key,
    required this.words,
    required this.onRightSideTap,
    required this.onLastVisibleIndexChanged,
  });

  final UnmodifiableListView<WorkContentsElementView> words;
  final VoidCallback onRightSideTap;
  final LastVisibleIndexCallback onLastVisibleIndexChanged;

  @override
  _StyledWordListState createState() => _StyledWordListState();
}

class _StyledWordListState extends State<StyledWordList> {
  int _lastVisibleIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            _buildColumnWithOverflowDetection(context, constraints),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: constraints.maxWidth / 2,
              child: GestureDetector(
                onTap: widget.onRightSideTap,
                behavior: HitTestBehavior.translucent,
                child: Container(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColumnWithOverflowDetection(
      BuildContext context, BoxConstraints constraints) {
    final styles = {
      'VERS': Theme.of(context).textTheme.bodyLarge!,
      'POEM': Theme.of(context).textTheme.titleMedium!,
      'BOOK': Theme.of(context).textTheme.titleLarge!,
      'default': Theme.of(context).textTheme.bodyMedium!,
    };

    List<Widget> visibleWords = [];
    double currentHeight = 0;

    for (int i = 0; i < widget.words.length; i++) {
      final wordItem = widget.words[i];
      final textPainter = TextPainter(
        text: TextSpan(
          text: wordItem.word,
          style: styles[wordItem.typ] ?? styles['default'],
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(maxWidth: constraints.maxWidth);

      if (currentHeight + textPainter.height > constraints.maxHeight) {
        _lastVisibleIndex = i - 1;
        break;
      }

      currentHeight += textPainter.height;
      visibleWords.add(Text(
        wordItem.word,
        style: styles[wordItem.typ] ?? styles['default'],
      ));
    }

    // If we've reached the end of the list without overflowing
    if (_lastVisibleIndex == 0 && widget.words.isNotEmpty) {
      _lastVisibleIndex = widget.words.length - 1;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLastVisibleIndexChanged(_lastVisibleIndex);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: visibleWords,
    );
  }
}
