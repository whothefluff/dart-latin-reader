import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/external/provider_work.dart';

final _closingPunctSigns = ['.', ',', '!', '?', ':', ';', ')'];

typedef _LastVisibleIndexCallback = void Function(int first, int last);

enum _PageFlow { previous, next }

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
  late int _workSize;
  var _currentFirstVisibleIndex = 0;
  var _currentLastVisibleIndex = 0;
  var _fromIndex = 0;
  var _toIndex = _pageSize;
  var _pageFlow = _PageFlow.next;

  @override
  Widget build(BuildContext context) {
    final workSizeProvider = ref.watch(libraryWorkDetailsProvider(widget.workId)
        .select((model) => model.whenData((work) => work.numberOfWords)));
    return workSizeProvider.when(
      data: (workSize) {
        _workSize = workSize;
        return _scaffold();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _scaffold() {
    final segmentsProvider = ref.watch(
      libraryWorkContentsPartiallyProvider(widget.workId, _fromIndex, _toIndex),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Styled Word List')),
      body: segmentsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (segments) => Column(
          children: [
            Expanded(
              child: _StyledWordList(
                  segments: segments,
                  onNavigateNext: _loadNextPage,
                  onNavigatePrevious: _loadPreviousPage,
                  onVisibleIndicesChanged: (first, last) {
                    _currentFirstVisibleIndex = first;
                    _currentLastVisibleIndex = last;
                    _pageFlow = _PageFlow.next;
                  },
                  pageFlow: _pageFlow),
            ),
          ],
        ),
      ),
    );
  }

  void _loadNextPage() {
    log.info(() => 'TextPage - attempting to navigate to next page');
    setState(() {
      if (_currentLastVisibleIndex != _workSize) {
        _pageFlow = _PageFlow.next;
        _fromIndex = _currentLastVisibleIndex + 1;
        _toIndex = min(_currentLastVisibleIndex + _pageSize, _workSize);
      }
    });
  }

  void _loadPreviousPage() {
    log.info(() => 'TextPage - attempting to navigate to previous page');
    setState(() {
      if (_currentFirstVisibleIndex != 0) {
        _pageFlow = _PageFlow.previous;
        _currentLastVisibleIndex = _currentFirstVisibleIndex - 1;
        _fromIndex = max(0, _currentLastVisibleIndex - _pageSize);
        _toIndex = _currentLastVisibleIndex;
      }
    });
  }
//
}

class _StyledWordList extends StatefulWidget {
  const _StyledWordList({
    required this.segments,
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onVisibleIndicesChanged,
    required this.pageFlow,
  });

  final UnmodifiableListView<WorkContentsElementView> segments;
  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;
  final _LastVisibleIndexCallback onVisibleIndicesChanged;
  final _PageFlow pageFlow;

  @override
  _StyledWordListState createState() => _StyledWordListState();
//
}

class _TextRenderer {
  _TextRenderer(
    this.textTheme,
    this.workSegments,
  );

  final TextTheme textTheme;
  static const Map<String, String> styleToLineBreak = {
    'POEM': '\n\n',
    'PROL': '\n\n',
    'EPIL': '\n\n',
    'BOOK': '\n\n\n',
  };
  late final Map<String, TextStyle> styles = {
    'BOOK': textTheme.headlineSmall!,
    'PROL': textTheme.titleMedium!,
    'POEM': textTheme.titleMedium!,
    'EPIL': textTheme.titleMedium!,
    'VERS': textTheme.bodyLarge!,
    'default': textTheme.bodyMedium!,
  };
  final UnmodifiableListView<WorkContentsElementView> workSegments;

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
      log.info(() => 'TextPage - handling left tap');
      onNavigateNext();
    } else if (tapPosition.dx > 4 * screenWidth / 5) {
      log.info(() => 'TextPage - handling right tap');
      onNavigatePrevious();
    }
  }

  void handleSwipe(double? velocity) {
    if (velocity != null) {
      if (velocity < 0) {
        log.info(() => 'TextPage - handling left swipe');
        onNavigateNext();
      } else if (velocity > 0) {
        log.info(() => 'TextPage - handling right swipe');
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

class _VisibleSegmentRange {
//
  final int first;
  final int last;

  _VisibleSegmentRange.build(
    TextPainter textPainter,
    List<InlineSpan> allSpans,
    UnmodifiableListView<WorkContentsElementView> segments,
    _PageFlow pageFlow,
    BoxConstraints constraints,
  )   : first = pageFlow == _PageFlow.previous
            ? _getFirstVisibleWord(textPainter, allSpans, segments, constraints)
            : 0,
        last = pageFlow == _PageFlow.next
            ? _getLastVisibleWord(textPainter, allSpans, segments, constraints)
            : segments.length - 1;

  static int _getFirstVisibleWord(
      TextPainter textPainter,
      List<InlineSpan> allSpans,
      UnmodifiableListView<WorkContentsElementView> segments,
      BoxConstraints constraints) {
    var high = allSpans.length - 1;
    var low = 0;
    var firstFittingIndex = high + 1;
    while (low <= high) {
      var mid = (low + high) ~/ 2;
      textPainter.text = TextSpan(children: allSpans.sublist(mid));
      textPainter.layout(maxWidth: constraints.maxWidth);
      if (textPainter.height <= constraints.maxHeight) {
        firstFittingIndex = mid;
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }
    // Adjust firstFittingIndex to start of next verse if necessary
    if (firstFittingIndex > 0 && firstFittingIndex < segments.length) {
      var firstElement = segments[firstFittingIndex];
      if (firstElement.typ == 'VERS') {
        var currentNode = firstElement.node;
        var previousNode =
            firstFittingIndex > 0 ? segments[firstFittingIndex - 1].node : null;
        if (currentNode != previousNode) {
          return firstFittingIndex;
        }
        // If we're in the middle of a verse, move forward to the start of the next verse
        while (firstFittingIndex < segments.length - 1 &&
            segments[firstFittingIndex + 1].node == currentNode) {
          firstFittingIndex++;
        }
        // Now firstFittingIndex is at the end of the current verse
        // Move it forward one more to get to the start of the next verse
        if (firstFittingIndex < segments.length - 1) {
          firstFittingIndex++;
        }
      }
    }
    return firstFittingIndex;
  }

  static int _getLastVisibleWord(
      TextPainter textPainter,
      List<InlineSpan> allSpans,
      UnmodifiableListView<WorkContentsElementView> segments,
      BoxConstraints constraints) {
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
    if (lastFittingIndex < segments.length - 1) {
      var lastElement = segments[lastFittingIndex];
      if (lastElement.typ == 'VERS') {
        var currentNode = lastElement.node;
        var nextNode = lastFittingIndex + 1 < segments.length
            ? segments[lastFittingIndex + 1].node
            : null;
        // If the next word is from a different verse (node), we're good
        if (currentNode != nextNode) {
          return lastFittingIndex;
        }
        // If we're in the middle of a verse, move back to the end of the previous verse
        while (lastFittingIndex > 0 &&
            segments[lastFittingIndex - 1].node == currentNode) {
          lastFittingIndex--;
        }
        // Now lastFittingIndex is at the start of the current verse
        // Move it back one more to get to the end of the previous verse
        if (lastFittingIndex > 0) {
          lastFittingIndex--;
        }
      } else {
        if (lastFittingIndex < segments.length &&
            _isPunctuation(segments[lastFittingIndex + 1].word)) {
          lastFittingIndex--;
        }
      }
    }
    return lastFittingIndex;
  }

  static bool _isPunctuation(String word) {
    return _closingPunctSigns.contains(word) ||
        _closingPunctSigns.any((sign) => word.startsWith(sign));
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
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final allSpans = _TextRenderer(
      Theme.of(context).textTheme,
      widget.segments,
    ).createSpans();
    textPainter.text = TextSpan(children: allSpans);
    textPainter.layout(maxWidth: constraints.maxWidth);
    final visible = _VisibleSegmentRange.build(
      textPainter,
      allSpans,
      widget.segments,
      widget.pageFlow,
      constraints,
    );
    log.info(() =>
        'TextPage - displaying new range (${widget.segments[visible.first].idx} - ${widget.segments[visible.last].idx})');
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.onVisibleIndicesChanged(
              widget.segments[visible.first].idx,
              widget.segments[visible.last].idx,
            ));
    return Text.rich(
      key: _textKey,
      TextSpan(children: allSpans.sublist(visible.first, visible.last + 1)),
    );
  }
//
}
