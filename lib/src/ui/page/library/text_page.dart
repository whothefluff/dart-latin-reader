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
  var _currentIndex = 0;
  var _lastVisibleIndex = 0;
  static const _pageSize = 250;

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
      _currentIndex = _lastVisibleIndex + 1;
    });
  }

  void _loadPreviousPage() {
    //TODO
  }
//
}

final _closingPunctSigns = ['.', ',', '!', '?', ':', ';', ')'];

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

class _TextRenderer {
  const _TextRenderer(
    this.styles,
    this.workSegments,
  );

  final UnmodifiableListView<WorkContentsElementView> workSegments;
  final Map<String, TextStyle> styles;
  static const Map<String, String> styleToLineBreak = {
    'POEM': '\n\n',
    'PROL': '\n\n',
    'EPIL': '\n\n',
    'BOOK': '\n\n\n',
  };

  String _getSpace(int index, WorkContentsElementView segment) {
    final nextIsPunctuation = index + 1 < workSegments.length &&
        _closingPunctSigns
            .any((sign) => workSegments[index + 1].word.startsWith(sign));
    final currentEndsWithOpeningParenthesis = segment.word.endsWith('(');
    return nextIsPunctuation || currentEndsWithOpeningParenthesis ? '' : ' ';
  }

  String _getLineBreak(String? previousStyle, String currentStyle,
      String? previousNode, String currentNode) {
    var lineBreak = '';
    if (previousStyle != null && currentStyle != previousStyle) {
      lineBreak = styleToLineBreak[currentStyle] ?? '\n';
    } else {
      if (currentNode != previousNode) {
        lineBreak = '\n';
      }
    }
    return lineBreak;
  }

  List<InlineSpan> createSpans() {
    List<InlineSpan> spans = [];
    String? previousStyle;
    String? previousNode;
    for (var index = 0; index < workSegments.length; index++) {
      final segment = workSegments[index];
      final currentStyle = segment.typ;
      final currentNode = segment.node;
      final potentialSpace = _getSpace(index, segment);
      final potentialLineBreak =
          _getLineBreak(previousStyle, currentStyle, previousNode, currentNode);
      spans.add(TextSpan(
        text: '$potentialLineBreak${segment.word}$potentialSpace',
        style: styles[currentStyle] ?? styles['default'],
      ));
      previousStyle = currentStyle;
      previousNode = currentNode;
    }
    return spans;
  }
//
}

class GestureHandler {
  GestureHandler({
    required this.onNavigateNext,
    required this.onNavigatePrevious,
  });

  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;

  void handleTap(Offset tapPosition, BoxConstraints constraints) {
    final screenWidth = constraints.maxWidth;
    if (tapPosition.dx < screenWidth / 5) {
      onNavigateNext();
    } else if (tapPosition.dx > 4 * screenWidth / 5) {
      onNavigatePrevious();
    }
  }

  void handleSwipe(double? velocity) {
    if (velocity == null) return; //TODO necessary?
    if (velocity < 0) {
      onNavigateNext();
    } else if (velocity > 0) {
      onNavigatePrevious();
    }
  }
//
}

class WordSelector {
  WordSelector({
    required this.segments,
    required this.textKey,
  });

  final UnmodifiableListView<WorkContentsElementView> segments;
  final GlobalKey textKey;
  String? _cachedVisibleText;
  String? selected;

  void clearSelectedWord() {
    selected = null;
  }

  void Function(SelectedContent?)? sync(SelectedContent? content) {
    _updateCache();
    if (_cachedVisibleText != null) {
      if (content != null && content.plainText.isNotEmpty) {
        if (_isFullWordSelected(content, _cachedVisibleText!)) {
          selected = content.plainText;
          print('Full word selected: $selected');
        } else {
          clearSelectedWord();
        }
      } else {
        clearSelectedWord();
      }
    } else {
      clearSelectedWord();
    }
    return null;
  }

  void invalidateCacheWhenElementsChange(
      UnmodifiableListView<WorkContentsElementView> oldSegments) {
    if (segments != oldSegments) {
      _cachedVisibleText = null;
    }
  }

  void _updateCache() {
    if (_cachedVisibleText == null) {
      final renderObject = textKey.currentContext?.findRenderObject();
      if (renderObject is RenderParagraph) {
        _cachedVisibleText = renderObject.text.toPlainText();
      } else if (renderObject is RenderBox) {
        RenderParagraph? paragraph;
        renderObject.visitChildren((child) {
          if (child is RenderParagraph) {
            paragraph = child;
          }
        });
        _cachedVisibleText = paragraph?.text.toPlainText();
      }
    }
  }

  bool _isFullWordSelected(SelectedContent content, String fullText) {
    final selectedText = content.plainText;
    final selStart = fullText.indexOf(selectedText);
    if (selStart == -1) return false;
    final selEnd = selStart + selectedText.length;
    final previousChar = fullText[selStart - 1];
    final startIsValid = (selStart == 0 || previousChar == ' ') ||
        _closingPunctSigns.contains(previousChar);
    final nextChar = fullText[selEnd];
    final endIsValid = (selEnd == selectedText.length || nextChar == ' ') ||
        _closingPunctSigns.contains(nextChar);
    final middleIsValid = (!selectedText.contains(' ') &&
        !_closingPunctSigns.any((sign) => selectedText.contains(sign)));
    return startIsValid && endIsValid && middleIsValid;
  }

  bool singleFullWordSelected() {
    return selected != null;
  }
//
}

class WordSelectionButton extends ContextMenuButtonItem {
  const WordSelectionButton._(
    this.word,
    VoidCallback onPressed,
  ) : super(onPressed: onPressed, label: 'See details');

  final String word;

  factory WordSelectionButton({required String word}) {
    return WordSelectionButton._(word, () => _onPressed(word));
  }

  static void _onPressed(String word) {
    print(word);
  }
//
}

class _StyledWordListState extends State<_StyledWordList> {
//
  var _lastVisibleIndex = 0;
  final _textKey = GlobalKey();
  late GestureHandler _gestureHandler;
  late final _wordSelector =
      WordSelector(segments: widget.words, textKey: _textKey);
  ContextMenuButtonItem? _wordSelectionButton;

  @override
  void initState() {
    super.initState();
    _gestureHandler = GestureHandler(
      onNavigateNext: widget.onNavigateNext,
      onNavigatePrevious: widget.onNavigatePrevious,
    );
  }

  @override
  void didUpdateWidget(covariant _StyledWordList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _wordSelector.invalidateCacheWhenElementsChange(oldWidget.words);
  }

  @override
  Widget build(BuildContext context) {
    _rebuildOnScreenSizeChange(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          //TODO: add on tap for big screens but not here since
          //it collides with the text events, possibly with Stack and margins
          // onTap: (TapDownDetails details) => _gestureHandler.handleTap(details.globalPosition, constraints),
          onHorizontalDragEnd: (DragEndDetails details) {
            _gestureHandler.handleSwipe(details.primaryVelocity);
          },
          child: SelectionArea(
            onSelectionChanged: (content) {
              _wordSelector.sync(content);
              setState(() {
                if (_wordSelector.singleFullWordSelected()) {
                  final selectedWord = _wordSelector.selected!;
                  _wordSelectionButton =
                      WordSelectionButton(word: selectedWord);
                } else {
                  _wordSelectionButton = null;
                }
              });
            },
            contextMenuBuilder: (context, selectableRegionState) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  var buttonItems = [
                    ...selectableRegionState.contextMenuButtonItems,
                    if (_wordSelectionButton != null) _wordSelectionButton!,
                  ];
                  return AdaptiveTextSelectionToolbar.buttonItems(
                    anchors: selectableRegionState.contextMenuAnchors,
                    buttonItems: buttonItems,
                  );
                },
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
    final textStyles = {
      'BOOK': Theme.of(context).textTheme.headlineSmall!,
      'PROL': Theme.of(context).textTheme.titleMedium!,
      'POEM': Theme.of(context).textTheme.titleMedium!,
      'EPIL': Theme.of(context).textTheme.titleMedium!,
      'VERS': Theme.of(context).textTheme.bodyLarge!,
      'default': Theme.of(context).textTheme.bodyMedium!,
    };
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: null,
    );
    final allSpans = _TextRenderer(textStyles, widget.words).createSpans();
    textPainter.text = TextSpan(children: allSpans);
    textPainter.layout(maxWidth: constraints.maxWidth);

    bool isPunctuation(String word) {
      return _closingPunctSigns.contains(word) ||
          _closingPunctSigns.any((sign) => word.startsWith(sign));
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
      // Adjust lastFittingIndex to end of previous verse if necessary
      if (lastFittingIndex < widget.words.length - 1) {
        var lastElement = widget.words[lastFittingIndex];
        if (lastElement.typ == 'VERS') {
          var currentNode = lastElement.node;
          var nextNode = lastFittingIndex + 1 < widget.words.length
              ? widget.words[lastFittingIndex + 1].node
              : null;
          // If the next word is from a different verse (node), we're good
          if (currentNode != nextNode) {
            return lastFittingIndex;
          }
          // If we're in the middle of a verse, move back to the end of the previous verse
          while (lastFittingIndex > 0 &&
              widget.words[lastFittingIndex - 1].node == currentNode) {
            lastFittingIndex--;
          }
          // Now lastFittingIndex is at the start of the current verse
          // Move it back one more to get to the end of the previous verse
          if (lastFittingIndex > 0) {
            lastFittingIndex--;
          }
        } else {
          if (lastFittingIndex < widget.words.length &&
              isPunctuation(widget.words[lastFittingIndex + 1].word)) {
            lastFittingIndex--;
          }
        }
      }
      return lastFittingIndex;
    }

    _lastVisibleIndex = getLastVisibleWord(0, allSpans.length - 1);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLastVisibleIndexChanged(_lastVisibleIndex);
    });

    List<T> tail<T>(List<T> list, int inclussiveEnd) {
      return list.sublist(0, inclussiveEnd + 1);
    }

    return Text.rich(
      key: _textKey,
      TextSpan(children: tail(allSpans, _lastVisibleIndex)),
    );
  }
//
}
