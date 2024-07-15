import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                onNavigateNext: _loadNextPage,
                onNavigatePrevious: _loadPreviousPage,
                onLastVisibleIndexChanged: (index) =>
                    _lastVisibleIndex = _currentIndex + index,
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

  void _loadPreviousPage() {
    //TODO
  }
//
}

typedef LastVisibleIndexCallback = void Function(int lastVisibleIndex);

class _StyledWordList extends StatefulWidget {
  const _StyledWordList({
    required this.words,
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onLastVisibleIndexChanged,
  });

  final UnmodifiableListView<WorkContentsElementView> words;
  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;
  final LastVisibleIndexCallback onLastVisibleIndexChanged;

  @override
  _StyledWordListState createState() => _StyledWordListState();
//
}

class _StyledWordListState extends State<_StyledWordList> {
//
  int _lastVisibleIndex = 0;
  String? _selectedWord;
  final _textKey = GlobalKey();

  final closingPunctSigns = ['.', ',', '!', '?', ':', ';', ')'];

  void _handleTap(Offset tapPosition, BoxConstraints constraints) {
    final screenWidth = constraints.maxWidth;
    if (tapPosition.dx < screenWidth / 5) {
      widget.onNavigatePrevious();
    } else if (tapPosition.dx > 4 * screenWidth / 5) {
      widget.onNavigateNext();
    }
  }

  void _handleSwipe(double? velocity) {
    if (velocity == null) return; //necessary?
    if (velocity < 0) {
      widget.onNavigateNext();
    } else if (velocity > 0) {
      widget.onNavigatePrevious();
    }
  }

  String? _getFullText() {
    final renderObject = _textKey.currentContext?.findRenderObject();
    if (renderObject is RenderParagraph) {
      return renderObject.text.toPlainText();
    } else if (renderObject is RenderBox) {
      // Try to find a descendant RenderParagraph
      RenderParagraph? paragraph;
      renderObject.visitChildren((child) {
        if (child is RenderParagraph) {
          paragraph = child;
        }
      });
      return paragraph?.text.toPlainText();
    }
    return null;
  }

  bool _isFullWordSelected(SelectedContent content, String fullText) {
    final selectedText = content.plainText;
    final selectionStart = fullText.indexOf(selectedText);
    if (selectionStart == -1) return false;
    final selectionEnd = selectionStart + selectedText.length;
    final bool isStartValid =
        (selectionStart == 0 || fullText[selectionStart - 1] == ' ') ||
            closingPunctSigns.contains(fullText[selectionStart - 1]);
    final bool isEndValid = (selectionEnd == selectedText.length ||
            fullText[selectionEnd] == ' ') ||
        closingPunctSigns.contains(fullText[selectionEnd]);

    return isStartValid && isEndValid && !selectedText.contains(' ');
  }

  @override
  Widget build(BuildContext context) {
    _rebuildOnScreenSizeChange(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          //TODO: add on tap for big screens but not here since
          //it collides with the text events, possibly with Stack and margins
          // onTap
          onHorizontalDragEnd: (DragEndDetails details) {
            _handleSwipe(details.primaryVelocity);
          },
          child: SelectionArea(
            onSelectionChanged: (content) {
              final fullText = _getFullText();
              if (fullText == null) return;

              if (content != null && content.plainText.isNotEmpty) {
                if (_isFullWordSelected(content, fullText)) {
                  setState(() {
                    _selectedWord = content.plainText;
                  });
                  print('Full word selected: $_selectedWord');
                } else {
                  setState(() {
                    _selectedWord = null;
                  });
                }
              } else {
                setState(() {
                  _selectedWord = null;
                });
              }
            },
            contextMenuBuilder: (context, selectableRegionState) {
              final List<ContextMenuButtonItem> buttonItems =
                  selectableRegionState.contextMenuButtonItems;
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: selectableRegionState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
            child: _buildTextWithOverflowDetection(context, constraints),
          ),
        );
      },
    );
  }

  void _rebuildOnScreenSizeChange(BuildContext context) {
    MediaQuery.of(context);
  }

  Widget _buildTextWithOverflowDetection(
      BuildContext context, BoxConstraints constraints) {
    final styles = {
      'VERS': Theme.of(context).textTheme.bodyLarge!,
      'POEM': Theme.of(context).textTheme.titleMedium!,
      'BOOK': Theme.of(context).textTheme.titleLarge!,
      'default': Theme.of(context).textTheme.bodyMedium!,
    };

    bool needsSpace(int index) {
      bool nextIsPunctuation = index + 1 < widget.words.length &&
          closingPunctSigns
              .any((sign) => widget.words[index + 1].word.startsWith(sign));
      bool currentEndsWithOpeningParenthesis =
          widget.words[index].word.endsWith('(');
      return !nextIsPunctuation && !currentEndsWithOpeningParenthesis;
    }

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    List<InlineSpan> createSpansWithLineBreaks() {
      List<InlineSpan> spans = [];
      String? previousStyle;
      for (int index = 0; index < widget.words.length; index++) {
        final wordItem = widget.words[index];
        final currentStyle = wordItem.typ;
        final potentialSpace = needsSpace(index) ? ' ' : '';
        final potentialLineBreak =
            previousStyle != null && currentStyle != previousStyle ? '\n' : '';
        spans.add(TextSpan(
          text: '$potentialLineBreak${wordItem.word}$potentialSpace',
          style: styles[currentStyle] ?? styles['default'],
        ));
        previousStyle = currentStyle;
      }
      return spans;
    }

    final allSpans = createSpansWithLineBreaks();

    textPainter.text = TextSpan(children: allSpans);
    textPainter.layout(maxWidth: constraints.maxWidth);

    bool isPunctuation(String word) {
      return closingPunctSigns.contains(word) ||
          closingPunctSigns.any((sign) => word.startsWith(sign));
    }

    int getLastVisibleWord(int low, int high) {
      var lastFittingIndex = low - 1;
      while (low <= high) {
        var mid = (low + high) ~/ 2;
        textPainter.text = TextSpan(children: allSpans.sublist(0, mid + 1));
        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.height <= constraints.maxHeight) {
          lastFittingIndex = mid;
          low = mid + 1;
        } else {
          high = mid - 1;
        }
      }
      if (lastFittingIndex < widget.words.length &&
          isPunctuation(widget.words[lastFittingIndex].word)) {
        return lastFittingIndex - 1;
      }
      return lastFittingIndex;
    }

    _lastVisibleIndex = getLastVisibleWord(0, allSpans.length - 1);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLastVisibleIndexChanged(_lastVisibleIndex);
    });

    return Text.rich(
      key: _textKey,
      TextSpan(children: allSpans.sublist(0, _lastVisibleIndex)),
    );
  }
//
}
