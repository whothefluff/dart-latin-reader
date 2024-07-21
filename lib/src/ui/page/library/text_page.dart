import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/external/provider_work.dart';

final _closingPunctSigns = ['.', ',', '!', '?', ':', ';', ')'];

typedef _LastVisibleIndexCallback = void Function(int first, int last);

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
//
  static const _pageSize = 250;
  var _currentFirstVisibleIndex = 0;
  var _currentLastVisibleIndex = 0;
  var _fromIndex = 0;
  var _toIndex = _pageSize;

  @override
  Widget build(BuildContext context) {
    final segmentsProvider = ref.watch(
      libraryWorkContentsPartiallyProvider(widget.workId, _fromIndex, _toIndex),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Styled Word List')),
      body: segmentsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (segment) => Column(
          children: [
            Expanded(
              child: _StyledWordList(
                  segments: segment,
                  onNavigateNext: _loadNextPage,
                  onNavigatePrevious: _loadPreviousPage,
                  onVisibleIndicesChanged: (first, last) {
                    _currentFirstVisibleIndex = first;
                    _currentLastVisibleIndex = last;
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _loadNextPage() {
    setState(() {
      // if (_currentLastVisibleIndex + _pageSize <= totalLength ) { //TODO implement ending of work
      _fromIndex = _currentLastVisibleIndex + 1;
      _toIndex = _currentLastVisibleIndex + _pageSize;
    });
  }

  void _loadPreviousPage() {
    // setState(() {
    //TODO implement final solution
    // if (_fromIndex != 0) {
    //   _currentLastVisibleIndex = _currentFirstVisibleIndex - 1;
    //   _fromIndex = max(0, _currentLastVisibleIndex - _pageSize);
    //   _toIndex = _currentLastVisibleIndex;
    // }
    // });
  }
//
}

class _StyledWordList extends StatefulWidget {
  const _StyledWordList({
    required this.segments,
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onVisibleIndicesChanged,
  });

  final UnmodifiableListView<WorkContentsElementView> segments;
  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;
  final _LastVisibleIndexCallback onVisibleIndicesChanged;

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

class _GestureHandler {
  _GestureHandler({
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
    if (velocity != null) {
      if (velocity < 0) {
        onNavigateNext();
      } else if (velocity > 0) {
        onNavigatePrevious();
      }
    }
  }
//
}

class _WordSelector {
  _WordSelector({
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

  void synchronize(SelectedContent? content) {
    _refreshCache();
    if (_cachedVisibleText != null) {
      if (content != null && content.plainText.isNotEmpty) {
        if (_isFullWordSelected(content, _cachedVisibleText!)) {
          selected = content.plainText;
        } else {
          clearSelectedWord();
        }
      } else {
        clearSelectedWord();
      }
    } else {
      clearSelectedWord();
    }
  }

  void invalidateCacheWhenElementsChange(
      UnmodifiableListView<WorkContentsElementView> oldSegments) {
    if (segments != oldSegments) {
      _cachedVisibleText = null;
    }
  }

  void _refreshCache() {
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
    final previousChar = selStart > 0 ? fullText[selStart - 1] : null;
    final startIsValid = previousChar == null ||
        previousChar == ' ' ||
        previousChar == '\n' ||
        _closingPunctSigns.contains(previousChar);
    final nextChar = selEnd < fullText.length ? fullText[selEnd] : null;
    final endIsValid = nextChar == null ||
        nextChar == ' ' ||
        _closingPunctSigns.contains(nextChar);
    final middleIsValid = (!selectedText.contains(' ') &&
        !_closingPunctSigns.any((sign) => selectedText.contains(sign)));
    return startIsValid && endIsValid && middleIsValid;
  }

  bool fullSingleWordSelected() {
    return selected != null;
  }
//
}

class _WordSelectionButton extends ContextMenuButtonItem {
  _WordSelectionButton({
    required String word,
  }) : super(
          onPressed: () => _onPressed(word),
          label: 'See details for "$word"',
        );

  static void _onPressed(String word) {
    print('Selected word: $word');
  }
//
}

class _StyledWordListState extends State<_StyledWordList> {
//
  final _textKey = GlobalKey();
  late _GestureHandler _gestureHandler;
  late final _wordSelector =
      _WordSelector(segments: widget.segments, textKey: _textKey);
  var _wordSelectionButtons = <ContextMenuButtonItem>[];

  @override
  void initState() {
    super.initState();
    _gestureHandler = _GestureHandler(
      onNavigateNext: widget.onNavigateNext,
      onNavigatePrevious: widget.onNavigatePrevious,
    );
  }

  @override
  void didUpdateWidget(covariant _StyledWordList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _wordSelector.invalidateCacheWhenElementsChange(oldWidget.segments);
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
          child: _buildSelectionArea(context, constraints),
        );
      },
    );
  }

  Widget _buildSelectionArea(BuildContext context, BoxConstraints constraints) {
    return SelectionArea(
      onSelectionChanged: _handleSelectionChanged,
      contextMenuBuilder: _buildContextMenu,
      child: _buildTextWithOverflowDetection(context, constraints),
    );
  }

  void _handleSelectionChanged(SelectedContent? content) {
    _wordSelector.synchronize(content);
    setState(() {
      if (_wordSelector.fullSingleWordSelected()) {
        final selectedWord = _wordSelector.selected!;
        _wordSelectionButtons = [_WordSelectionButton(word: selectedWord)];
      } else {
        _wordSelectionButtons = [];
      }
    });
  }

  Widget _buildContextMenu(BuildContext context, SelectableRegionState state) {
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: state.contextMenuAnchors,
      buttonItems: [
        ...state.contextMenuButtonItems,
        ..._wordSelectionButtons,
      ],
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

    bool isPunctuation(String word) {
      return _closingPunctSigns.contains(word) ||
          _closingPunctSigns.any((sign) => word.startsWith(sign));
    }

    List<T> tail<T>(List<T> list, int inclussiveEnd) {
      return list.sublist(0, inclussiveEnd + 1);
    }

    int getLastVisibleWord(TextPainter textPainter, List<InlineSpan> allSpans) {
      var low = 0;
      var high = allSpans.length - 1;
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
      if (lastFittingIndex < widget.segments.length - 1) {
        var lastElement = widget.segments[lastFittingIndex];
        if (lastElement.typ == 'VERS') {
          var currentNode = lastElement.node;
          var nextNode = lastFittingIndex + 1 < widget.segments.length
              ? widget.segments[lastFittingIndex + 1].node
              : null;
          // If the next word is from a different verse (node), we're good
          if (currentNode != nextNode) {
            return lastFittingIndex;
          }
          // If we're in the middle of a verse, move back to the end of the previous verse
          while (lastFittingIndex > 0 &&
              widget.segments[lastFittingIndex - 1].node == currentNode) {
            lastFittingIndex--;
          }
          // Now lastFittingIndex is at the start of the current verse
          // Move it back one more to get to the end of the previous verse
          if (lastFittingIndex > 0) {
            lastFittingIndex--;
          }
        } else {
          if (lastFittingIndex < widget.segments.length &&
              isPunctuation(widget.segments[lastFittingIndex + 1].word)) {
            lastFittingIndex--;
          }
        }
      }
      return lastFittingIndex;
    }

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final allSpans = _TextRenderer(
      textStyles,
      widget.segments,
    ).createSpans();
    textPainter.text = TextSpan(children: allSpans);
    textPainter.layout(maxWidth: constraints.maxWidth);
    final lastVisible = getLastVisibleWord(textPainter, allSpans);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        widget.onVisibleIndicesChanged(
            widget.segments[0].idx, widget.segments[lastVisible].idx));
    return Text.rich(
      key: _textKey,
      TextSpan(children: tail(allSpans, lastVisible)),
    );
  }
//
}
