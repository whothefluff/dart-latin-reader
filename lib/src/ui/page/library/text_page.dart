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
  TextPageState createState() => TextPageState();
//
}

class TextPageState extends ConsumerState<TextPage> {
  int _currentIndex = 1;
  int _lastVisibleIndex = 0;
  static const int _pageSize = 250;

  @override
  Widget build(BuildContext context) {
    final wordsProvider = ref.watch(
      libraryWorkContentsPartiallyProvider(
          widget.workId, _currentIndex, _currentIndex + _pageSize),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Styled Word List')),
      body: wordsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (words) => Column(
          children: [
            Expanded(
              child: _StyledWordList(
                words: words,
                onRightSideTap: _loadNextPage,
                onLastVisibleIndexChanged: (index) {
                  _lastVisibleIndex = _currentIndex + index;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadNextPage() {
    setState(() {
      _currentIndex = _lastVisibleIndex;
    });
  }
//
}

typedef LastVisibleIndexCallback = void Function(int lastVisibleIndex);

class _StyledWordList extends StatefulWidget {
  const _StyledWordList({
    required this.words,
    required this.onRightSideTap,
    required this.onLastVisibleIndexChanged,
  });

  final UnmodifiableListView<WorkContentsElementView> words;
  final VoidCallback onRightSideTap;
  final LastVisibleIndexCallback onLastVisibleIndexChanged;

  @override
  _StyledWordListState createState() => _StyledWordListState();
//
}

class _StyledWordListState extends State<_StyledWordList> {
  int _lastVisibleIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            _buildTextWithOverflowDetection(context, constraints),
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

  Widget _buildTextWithOverflowDetection(
      BuildContext context, BoxConstraints constraints) {
    final styles = {
      'VERS': Theme.of(context).textTheme.bodyLarge!,
      'POEM': Theme.of(context).textTheme.titleMedium!,
      'BOOK': Theme.of(context).textTheme.titleLarge!,
      'default': Theme.of(context).textTheme.bodyMedium!,
    };

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    List<InlineSpan> allSpans =
        List<InlineSpan>.generate(widget.words.length, (index) {
      final wordItem = widget.words[index];
      final punctuationSigns = ['.', ',', '!', '?', ':', ';', ')'];
      bool nextIsPunctuation = index + 1 < widget.words.length &&
          punctuationSigns
              .any((sign) => widget.words[index + 1].word.startsWith(sign));
      bool currentEndsWithOpeningParenthesis = wordItem.word.endsWith('(');
      String spaceIfNeeded =
          nextIsPunctuation || currentEndsWithOpeningParenthesis ? '' : ' ';
      return TextSpan(
        text: '${wordItem.word}$spaceIfNeeded',
        style: styles[wordItem.typ] ?? styles['default'],
      );
    }).toList();

    textPainter.text = TextSpan(children: allSpans);
    textPainter.layout(maxWidth: constraints.maxWidth);

    int binarySearchLastVisibleWord(int low, int high) {
      while (low <= high) {
        int mid = (low + high) ~/ 2;
        textPainter.text = TextSpan(children: allSpans.sublist(0, mid + 1));
        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.height <= constraints.maxHeight) {
          if (mid == high ||
              textPainter.height + textPainter.preferredLineHeight >
                  constraints.maxHeight) {
            return mid;
          }
          low = mid + 1;
        } else {
          high = mid - 1;
        }
      }
      return low - 1;
    }

    _lastVisibleIndex = binarySearchLastVisibleWord(0, allSpans.length - 1);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLastVisibleIndexChanged(_lastVisibleIndex);
    });

    return RichText(
      text: TextSpan(children: allSpans.sublist(0, _lastVisibleIndex)),
    );
  }
//
}
