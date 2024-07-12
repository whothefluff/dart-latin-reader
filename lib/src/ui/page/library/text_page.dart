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
//
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
//
}

class _StyledWordListState extends State<StyledWordList> {
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

    List<InlineSpan> allSpans = widget.words
        .map((wordItem) => TextSpan(
              text: '${wordItem.word} ',
              style: styles[wordItem.typ] ?? styles['default'],
            ))
        .toList();

    textPainter.text = TextSpan(children: allSpans);
    textPainter.layout(maxWidth: constraints.maxWidth);

    final lastPosition = textPainter.getPositionForOffset(Offset(
      constraints.maxWidth,
      constraints.maxHeight,
    ));

    int lastVisibleIndex = lastPosition.offset;

    // Find the last fully visible word
    int currentLength = 0;
    int wordIndex = 0;
    for (var span in allSpans) {
      if (currentLength + span.toPlainText().length > lastVisibleIndex) {
        break;
      }
      currentLength += span.toPlainText().length;
      wordIndex++;
    }

    _lastVisibleIndex = wordIndex - 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLastVisibleIndexChanged(_lastVisibleIndex);
    });

    return RichText(
      text: TextSpan(children: allSpans.sublist(0, wordIndex)),
    );
  }
//
}
