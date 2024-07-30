import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/library/use_case/entity/view_work_contents_element.dart';
import 'package:latin_reader/src/external/provider_work.dart';
import 'package:latin_reader/src/ui/app.dart';
import 'package:latin_reader/src/ui/widget/custom_adaptive_scaffold.dart';
import 'package:latin_reader/src/ui/widget/navigation_rail.dart';

const _closingPunctSigns = ['.', ',', '!', '?', ':', ';', ')'];
const _blank = ' ';
final _lineTerminator = Platform.lineTerminator;

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
      appBar: AppBar(),
      body: segmentsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (segments) => _buildResponsiveContent(segments),
      ),
    );
  }

  Widget _buildResponsiveContent(
    UnmodifiableListView<WorkContentsElementView> segments,
  ) {
    const a4Width = 595.0;
    const marginsSpace = 200;
    return LayoutBuilder(
      builder: (context, pageConstraints) {
        final isLargeScreen = pageConstraints.maxWidth > a4Width + marginsSpace;
        const largeScreenTxtConsts = BoxConstraints(maxWidth: a4Width);
        final textAreaConstraints = isLargeScreen ? largeScreenTxtConsts : null;
        return _StyledWordList(
          segments: segments,
          onNavigateNext: _loadNextPage,
          onNavigatePrevious: _loadPreviousPage,
          onVisibleIndicesChanged: _updateVisibleIndices,
          pageFlow: _pageFlow,
          isLargeScreen: isLargeScreen,
          pageConstraints: pageConstraints,
          textAreaConstraints: textAreaConstraints,
        );
      },
    );
  }

  void _updateVisibleIndices(int first, int last) {
    _currentFirstVisibleIndex = first;
    _currentLastVisibleIndex = last;
    _pageFlow = _PageFlow.next;
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

class _TextRenderer {
  _TextRenderer(
    this.textTheme,
    this.workSegments,
  );

  final TextTheme textTheme;
  static final Map<String, String> styleToLineBreak = {
    'POEM': _lineTerminator + _lineTerminator,
    'PROL': _lineTerminator + _lineTerminator,
    'EPIL': _lineTerminator + _lineTerminator,
    'BOOK': _lineTerminator + _lineTerminator + _lineTerminator,
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
  static const _empty = '';

  String _getSpace(int index, WorkContentsElementView segment) {
    final nextIsPunctuation = index + 1 < workSegments.length &&
        _closingPunctSigns
            .any((sign) => workSegments[index + 1].word.startsWith(sign));
    final endsWithOpeningParenthesis = segment.word.endsWith('(');
    return nextIsPunctuation || endsWithOpeningParenthesis ? _empty : _blank;
  }

  String _getLineBreak(String? previousStyle, String currentStyle,
      String? previousNode, String currentNode) {
    var lineBreak = _empty;
    if (previousStyle != null && currentStyle != previousStyle) {
      lineBreak = styleToLineBreak[currentStyle] ?? _lineTerminator;
    } else {
      if (currentNode != previousNode) {
        lineBreak = _lineTerminator;
      }
    }
    return lineBreak;
  }

  List<InlineSpan> createSpans() {
    List<InlineSpan> spans = [];
    String? prevStyle;
    String? prevNode;
    for (var index = 0; index < workSegments.length; index++) {
      final segment = workSegments[index];
      final currentStyle = segment.typ;
      final currentNode = segment.node;
      final buffer = StringBuffer()
        ..write(_getLineBreak(prevStyle, currentStyle, prevNode, currentNode))
        ..write(segment.word)
        ..write(_getSpace(index, segment));
      spans.add(TextSpan(
        text: buffer.toString(),
        style: styles[currentStyle] ?? styles['default'],
      ));
      prevStyle = currentStyle;
      prevNode = currentNode;
    }
    return spans;
  }
//
}

class _GestureHandler {
  _GestureHandler({
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onNavMenuToggle,
    required this.customAdaptiveScaffoldKey,
  });

  final void Function() onNavigateNext;
  final void Function() onNavigatePrevious;
  final void Function(BuildContext context) onNavMenuToggle;
  final GlobalKey<CustomAdaptiveScaffoldState> customAdaptiveScaffoldKey;
  final _mainBranchesNames = mainBranches.map((e) => e.id).toList();

  void handleTap(_PageFlow pageFlow) {
    if (pageFlow == _PageFlow.next) {
      log.info(() => 'TextPage - handling right tap');
      onNavigateNext();
    } else if (pageFlow == _PageFlow.previous) {
      log.info(() => 'TextPage - handling left tap');
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

  void _dismissModalAndNavigate(BuildContext context, int index) {
    context.pop();
    context.go(_mainBranchesNames[index]);
  }

  void _showBottomNavBar(BuildContext context) {
    final customAdaptiveScaffoldState =
        customAdaptiveScaffoldKey.currentState ??
            Exception('CustomAdaptiveScaffold state is null')
                as CustomAdaptiveScaffoldState;
    final stateWidget = customAdaptiveScaffoldState.widget;
    showModalBottomSheet<Builder>(
        context: context,
        builder: (_) {
          return CustomAdaptiveScaffold.standardBottomNavigationBar(
            destinations: stateWidget.destinations,
            currentIndex: stateWidget.selectedIndex,
            onDestinationSelected: (i) => _dismissModalAndNavigate(context, i),
            labelBehavior: stateWidget.bottomNavigationBarLabelBehavior,
          );
        });
  }

  void _showNavigationOverlay(BuildContext context) {
    final customAdaptiveScaffoldState =
        customAdaptiveScaffoldKey.currentState ??
            Exception('CustomAdaptiveScaffold state is null')
                as CustomAdaptiveScaffoldState;
    final stateWidget = customAdaptiveScaffoldState.widget;
    final navRailTheme = Theme.of(context).navigationRailTheme;
    showModalNavigationRail<Builder>(
        context: context,
        builder: (_) {
          return CustomAdaptiveScaffold.standardNavigationRail(
            width: stateWidget.navigationRailWidth,
            leading: stateWidget.leadingUnextendedNavRail,
            trailing: stateWidget.trailingNavRail,
            selectedIndex: stateWidget.selectedIndex,
            extended: stateWidget.largeBreakpoint.isActive(context),
            destinations: stateWidget.destinations
                .map((nd) => CustomAdaptiveScaffold.toRailDestination(nd))
                .toList(),
            onDestinationSelected: (i) => _dismissModalAndNavigate(context, i),
            backgroundColor: navRailTheme.backgroundColor,
            selectedIconTheme: navRailTheme.selectedIconTheme,
            unselectedIconTheme: navRailTheme.unselectedIconTheme,
            selectedLabelTextStyle: navRailTheme.selectedLabelTextStyle,
            unSelectedLabelTextStyle: navRailTheme.unselectedLabelTextStyle,
          );
        });
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
    UnmodifiableListView<WorkContentsElementView> oldSegments,
  ) {
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
        previousChar == _blank ||
        previousChar == _lineTerminator ||
        _closingPunctSigns.contains(previousChar);
    final nextChar = selEnd < fullText.length ? fullText[selEnd] : null;
    final endIsValid = nextChar == null ||
        nextChar == _blank ||
        _closingPunctSigns.contains(nextChar);
    final middleIsValid = (!selectedText.contains(_blank) &&
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
    TextPainter txtPainter,
    List<InlineSpan> allSpans,
    UnmodifiableListView<WorkContentsElementView> segments,
    _PageFlow pageFlow,
    BoxConstraints textConstraints,
  )   : first = pageFlow == _PageFlow.previous
            ? _firstVisibleWord(txtPainter, allSpans, segments, textConstraints)
            : 0,
        last = pageFlow == _PageFlow.next
            ? _lastVisibleWord(txtPainter, allSpans, segments, textConstraints)
            : segments.length - 1;

  static int _firstVisibleWord(
    TextPainter textPainter,
    List<InlineSpan> allSpans,
    UnmodifiableListView<WorkContentsElementView> segments,
    BoxConstraints textConstraints,
  ) {
    var high = allSpans.length - 1;
    var low = 0;
    var firstFittingIndex = high + 1;
    while (low <= high) {
      var mid = (low + high) ~/ 2;
      textPainter.text = TextSpan(children: allSpans.sublist(mid));
      textPainter.layout(maxWidth: textConstraints.maxWidth);
      if (textPainter.height <= textConstraints.maxHeight) {
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

  static int _lastVisibleWord(
    TextPainter textPainter,
    List<InlineSpan> allSpans,
    UnmodifiableListView<WorkContentsElementView> segments,
    BoxConstraints textConstraints,
  ) {
    var low = 0;
    var high = allSpans.length - 1;
    var lastFittingIndex = low - 1;
    while (low <= high) {
      var mid = (low + high) ~/ 2;
      textPainter.text = TextSpan(children: allSpans.sublist(0, mid + 1));
      textPainter.layout(maxWidth: textConstraints.maxWidth);
      if (textPainter.height <= textConstraints.maxHeight) {
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

class _StyledWordList extends StatefulWidget {
  const _StyledWordList({
    required this.segments,
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onVisibleIndicesChanged,
    required this.pageFlow,
    required this.isLargeScreen,
    required this.pageConstraints,
    required this.textAreaConstraints,
  });

  final UnmodifiableListView<WorkContentsElementView> segments;
  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;
  final _LastVisibleIndexCallback onVisibleIndicesChanged;
  final _PageFlow pageFlow;
  final bool isLargeScreen;
  final BoxConstraints pageConstraints;
  final BoxConstraints? textAreaConstraints;

  @override
  _StyledWordListState createState() => _StyledWordListState();
//
}

class _StyledWordListState extends State<_StyledWordList> {
//
  final _textKey = GlobalKey();
  late _GestureHandler _gestureHandler;
  late final _wordSelector = _WordSelector(
    segments: widget.segments,
    textKey: _textKey,
  );
  var _wordSelectionButtons = <ContextMenuButtonItem>[];

  @override
  void initState() {
    super.initState();
    _gestureHandler = _GestureHandler(
        onNavigateNext: widget.onNavigateNext,
        onNavigatePrevious: widget.onNavigatePrevious,
        onNavMenuToggle: _handleNavMenuToggle,
        customAdaptiveScaffoldKey: customAdaptiveScaffoldKey);
  }

  @override
  void didUpdateWidget(covariant _StyledWordList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _wordSelector.invalidateCacheWhenElementsChange(oldWidget.segments);
  }

  @override
  Widget build(BuildContext context) {
    _rebuildOnScreenSizeChange(context);
    return widget.isLargeScreen
        ? _buildLargeScreenLayout(context)
        : _buildSmallScreenLayout(context);
  }

  void _handleNavMenuToggle(BuildContext context) {
    Breakpoints.smallDesktop.isActive(context)
        ? _gestureHandler._showBottomNavBar(context)
        : _gestureHandler._showNavigationOverlay(context);
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    return Row(children: [
      Expanded(
        child: SizedBox.expand(
          child: GestureDetector(
            onHorizontalDragEnd: (details) =>
                _gestureHandler.handleSwipe(details.primaryVelocity),
            onDoubleTap: () => _gestureHandler.onNavMenuToggle(context),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: _buildSelectionArea(context, widget.pageConstraints),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildLargeScreenLayout(BuildContext context) {
    final availableWidth = widget.pageConstraints.maxWidth;
    final textWidth = widget.textAreaConstraints!.maxWidth;
    final marginWidth = (availableWidth - textWidth) / 2;
    return Row(
      children: [
        if (marginWidth > 0)
          SizedBox(
            width: marginWidth,
            child: GestureDetector(
              onTap: () => _gestureHandler.handleTap(_PageFlow.previous),
              onSecondaryTap: () => _gestureHandler.onNavMenuToggle(context),
            ),
          ),
        SizedBox(
          width: textWidth,
          child: _buildStylizedTextArea(),
        ),
        if (marginWidth > 0)
          SizedBox(
            width: marginWidth,
            child: GestureDetector(
              onTap: () => _gestureHandler.handleTap(_PageFlow.next),
              onSecondaryTap: () => _gestureHandler.onNavMenuToggle(context),
            ),
          ),
      ],
    );
  }

  Widget _buildStylizedTextArea() {
    const padding = EdgeInsets.only(
        left: 24, right: BorderSide.strokeAlignCenter, top: 0, bottom: 14);
    return Card(
      child: Padding(
        padding: padding,
        child: LayoutBuilder(
          builder: (context, textAreaConstraints) {
            return _buildSelectionArea(context, textAreaConstraints);
          },
        ),
      ),
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
