import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../logger.dart';
import '../../../component/library/work_contents_api.dart';
import '../../../component/library/work_details_api.dart';
import '../../../component/morph_analysis/enriched_morph_search_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../app.dart';
import '../../router/config.dart';
import '../../widget/custom_adaptive_scaffold.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';
import '../../widget/navigation_rail.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';

/// Line terminator that will be stable across all platforms even after rendering
const _lineTerminator = '\n';
const _closingPunctSigns = ['.', ',', '!', '?', ':', ';', ')', ']'];
const _openingPunctSigns = ['(', '['];
const _blank = ' ';

enum _PageFlow {
  previous,
  next,
}

class TextPage extends ConsumerStatefulWidget {
  const TextPage(
    this.workId, {
    super.key,
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
  int _toIndex = _pageSize;
  _PageFlow _pageFlow = _PageFlow.next;

  @override
  Widget build(context) {
    final workSizeProvider = ref.watch(
      workDetailsProvider(
        widget.workId,
      ).select((model) => model.whenData((work) => work.numberOfWords)),
    );
    return workSizeProvider.when(
      data: (workSize) {
        _workSize = workSize;
        return _scaffold();
      },
      loading: showLoading,
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  Widget _scaffold() {
    final segmentsProvider = ref.watch(workContentsProvider(widget.workId, _fromIndex, _toIndex));
    return Scaffold(
      appBar: AppBar(),
      body: segmentsProvider.when(
        data: _buildResponsiveContent,
        loading: showLoading,
        error: error(ref),
      ),
    );
  }

  Widget _buildResponsiveContent(WorkContentsSegments segments) {
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
    log.info(() => 'attempting to navigate to next page');
    setState(() {
      if (_currentLastVisibleIndex != _workSize) {
        _pageFlow = _PageFlow.next;
        _fromIndex = _currentLastVisibleIndex + 1;
        _toIndex = min(_currentLastVisibleIndex + _pageSize, _workSize);
      }
    });
  }

  void _loadPreviousPage() {
    log.info(() => 'attempting to navigate to previous page');
    setState(() {
      if (_currentFirstVisibleIndex != 0) {
        _pageFlow = _PageFlow.previous;
        _currentLastVisibleIndex = _currentFirstVisibleIndex - 1;
        _fromIndex = max(0, _currentLastVisibleIndex - _pageSize);
        _toIndex = _currentLastVisibleIndex;
      }
    });
  }

  Widget Function(Object error, StackTrace _) error(WidgetRef ref) =>
      showError(ref, workContentsProvider(widget.workId, _fromIndex, _toIndex));
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
  final WorkContentsSegments workSegments;
  static const _empty = '';

  String _getSpace(int index, WorkContentsSegment segment) {
    final nextIsPunctuation =
        index + 1 < workSegments.length &&
        _closingPunctSigns.any((sign) => workSegments[index + 1].word.startsWith(sign));
    final endsWithOpeningParenthesis = segment.word.endsWith('(');
    return nextIsPunctuation || endsWithOpeningParenthesis ? _empty : _blank;
  }

  String _getLineBreak(
    String? previousStyle,
    String currentStyle,
    String? previousNode,
    String currentNode,
  ) {
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
    final spans = <InlineSpan>[];
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
      spans.add(
        TextSpan(
          text: buffer.toString(),
          style: styles[currentStyle] ?? styles['default'],
        ),
      );
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
  final List<String> _mainBranchesNames = mainBranches.map((e) => e.id).toList();

  void handleTap(_PageFlow pageFlow) {
    if (pageFlow == _PageFlow.next) {
      log.info(() => 'handling right tap');
      onNavigateNext();
    } else if (pageFlow == _PageFlow.previous) {
      log.info(() => 'handling left tap');
      onNavigatePrevious();
    }
  }

  void handleSwipe(double? velocity) {
    if (velocity != null) {
      if (velocity < 0) {
        log.info(() => 'handling left swipe');
        onNavigateNext();
      } else if (velocity > 0) {
        log.info(() => 'handling right swipe');
        onNavigatePrevious();
      }
    }
  }

  void _dismissModalAndNavigate(BuildContext context, int index) {
    context
      ..pop()
      ..go(_mainBranchesNames[index]);
  }

  Future<void> _showBottomNavBar(BuildContext context) async {
    final customAdaptiveScaffoldState =
        customAdaptiveScaffoldKey.currentState ??
        Exception('CustomAdaptiveScaffold state is null') as CustomAdaptiveScaffoldState;
    final stateWidget = customAdaptiveScaffoldState.widget;
    await showModalBottomSheet<Builder>(
      context: context,
      builder: (_) => CustomAdaptiveScaffold.standardBottomNavigationBar(
        destinations: stateWidget.destinations,
        currentIndex: stateWidget.selectedIndex,
        onDestinationSelected: (i) => _dismissModalAndNavigate(context, i),
        labelBehavior: stateWidget.bottomNavigationBarLabelBehavior,
      ),
    );
  }

  Future<void> _showNavigationOverlay(BuildContext context) async {
    final customAdaptiveScaffoldState =
        customAdaptiveScaffoldKey.currentState ??
        Exception('CustomAdaptiveScaffold state is null') as CustomAdaptiveScaffoldState;
    final stateWidget = customAdaptiveScaffoldState.widget;
    final navRailTheme = Theme.of(context).navigationRailTheme;
    await showModalNavigationRail<Builder>(
      context: context,
      builder: (_) => CustomAdaptiveScaffold.standardNavigationRail(
        width: stateWidget.navigationRailWidth,
        leading: stateWidget.leadingUnextendedNavRail,
        trailing: stateWidget.trailingNavRail,
        selectedIndex: stateWidget.selectedIndex,
        extended: stateWidget.largeBreakpoint.isActive(context),
        destinations: stateWidget.destinations
            .map(CustomAdaptiveScaffold.toRailDestination)
            .toList(),
        onDestinationSelected: (i) => _dismissModalAndNavigate(context, i),
        backgroundColor: navRailTheme.backgroundColor,
        selectedIconTheme: navRailTheme.selectedIconTheme,
        unselectedIconTheme: navRailTheme.unselectedIconTheme,
        selectedLabelTextStyle: navRailTheme.selectedLabelTextStyle,
        unSelectedLabelTextStyle: navRailTheme.unselectedLabelTextStyle,
      ),
    );
  }

  //
}

class _TextSelector {
  /// If the user selected exactly just a full word (with no other words or
  /// symbols), this word will be returned stripped of whitespace
  ///
  /// Otherwise null
  String? singleWord(TextSelection selection, String visibleText) {
    // Ignore selected spaces at word boundary
    final trimmedSelectedText = selection.textInside(visibleText).trim();
    if (trimmedSelectedText.isNotEmpty &&
        _isFullWordSelected(trimmedSelectedText, visibleText, selection)) {
      log.info(() => 'word "$trimmedSelectedText" selected');
      return trimmedSelectedText;
    } else {
      log.info(() => 'no word selected');
      return null;
    }
  }

  bool _isFullWordSelected(
    String trimmedSelectedText,
    String visibleText,
    TextSelection textSelection,
  ) {
    // Also handles selections starting with whitespace
    final actualWordStart = visibleText.indexOf(trimmedSelectedText, textSelection.start);
    final previousChar = actualWordStart > 0 ? visibleText[actualWordStart - 1] : null;
    final startIsValid =
        previousChar == null ||
        previousChar == _blank ||
        previousChar == _lineTerminator ||
        _closingPunctSigns.contains(previousChar) ||
        _openingPunctSigns.contains(previousChar);
    final actualWordEnd = actualWordStart + trimmedSelectedText.length;
    final nextChar = actualWordEnd < visibleText.length ? visibleText[actualWordEnd] : null;
    final endIsValid =
        nextChar == null ||
        nextChar == _blank ||
        _closingPunctSigns.contains(nextChar) ||
        _openingPunctSigns.contains(nextChar); // Unlikely, but typos occur
    final middleIsValid =
        !trimmedSelectedText.contains(_blank) &&
        !_closingPunctSigns.any(trimmedSelectedText.contains) &&
        !_openingPunctSigns.any(trimmedSelectedText.contains);
    return startIsValid && endIsValid && middleIsValid;
  }

  /*   /// Finds the first non-whitespace character that comes before the
  /// [selectedWord], if any. Ignores the previous batch of visible text, which
  /// is an obvious limitation
  ///
  /// This method assumes that the selection will contain only this one word
  /// instance and nothing else
  String? charBeforeWord(TextSelection selection, String visibleText, String selectedWord) {
    final wordStartIndex = visibleText.indexOf(selectedWord, selection.start);
    // Iterate backwards from the character immediately preceding the word
    for (var i = wordStartIndex - 1; i >= 0; i--) {
      final char = visibleText[i];
      if (char.trim().isNotEmpty) {
        return char;
      }
    }
    return null;
  } */

  //
}

/// This context menu button will first navigate to the morphological
/// information page
///
/// From there, it's possible to go to the desired dictionary entry (which, in
/// case it can belong to several words, the user will have to choose)
class _WordDetailsButton extends ContextMenuButtonItem {
  _WordDetailsButton({
    required String word,
    required this.ref,
    required this.context,
  }) : super(onPressed: () => _onPressed(word, ref, context), label: 'See details for "$word"');

  final WidgetRef ref;
  final BuildContext context;

  static Future<void> _onPressed(String word, WidgetRef ref, BuildContext context) async {
    log.entry(args: [word]);
    ContextMenuController.removeAny();
    // Using double quotes will force an exact match, avoiding a text search
    final results = await ref.watch(enrichedMorphologicalSearchProvider('"$word"').future);
    if (results.isNotEmpty) {
      final selectedKeys = AnalysisKeys(
        results.map((r) => AnalysisKey(form: r.form, item: r.item, cnt: r.cnt)),
      );
      if (context.mounted) {
        log.exit<void>();
        return MorphologicalDataRoute(selectedKeys.toJson()).push(context);
      }
    } else {
      log.warning(() => 'Nothing found when using morph data button with "$word"');
      if (context.mounted) {
        log.exit(
          r: ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Not found'),
            ),
          ),
        );
      }
    }
  }

  //
}

/// This context menu button will navigate to the English Wiktionary
class _WiktionaryButton extends ContextMenuButtonItem {
  _WiktionaryButton({
    required String word,
    required this.ref,
    required this.context,
  }) : super(
         label: 'Look up in Wiktionary',
         onPressed: () => _onPressed(word, ref, context),
       );

  final WidgetRef ref;
  final BuildContext context;

  static Future<void> _onPressed(String word, WidgetRef ref, BuildContext context) async {
    log.entry(args: [word]);
    ContextMenuController.removeAny();
    final queryWord = (await _isProperNoun(word, ref)) ? _capitalize(word) : word.toLowerCase();
    try {
      if (await launchUrl(Uri.parse('https://en.wiktionary.org/wiki/$queryWord#Latin'))) {
        log.exit<void>();
      } else {
        log.warning(() => 'Could not launch browser when using Wiktionary button');
        if (context.mounted) {
          log.exit(
            r: ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not launch browser')),
            ),
          );
        }
      }
    } on Exception catch (e) {
      log.catching(e);
      if (context.mounted) {
        log.exit(
          r: ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Browser error')),
          ),
        );
      }
    }
  }

  /// Returns true if the word refers to a single person, place, etc.
  ///
  /// For Latin words that might exist both as a common and a proper noun, it
  /// will return *false* (eg Lupus vs lupus)
  ///
  /// The logic could potentially be improved but it would require checking the
  /// previous character (to see if it's capitalized because it appears after a
  /// '.') and detecting whether the word starts with upper case because the
  /// whole line is upper case (like in titles). These checks come with their
  /// own problems
  static Future<bool> _isProperNoun(String word, WidgetRef ref) async {
    log.entry(args: [word]);
    var isProperName = false;
    if (word == _capitalize(word)) {
      // The assumption is that the provider will not find proper names
      final results = await ref.watch(enrichedMorphologicalSearchProvider('"$word"').future);
      isProperName = results.isEmpty;
    }
    return log.exit(r: isProperName)!;
  }

  static String _capitalize(String word) => '${word[0].toUpperCase()}${word.substring(1)}';
  //
}

class _VisibleSegmentRange {
  _VisibleSegmentRange.build(
    TextPainter txtPainter,
    List<InlineSpan> allSpans,
    WorkContentsSegments segments,
    _PageFlow pageFlow,
    BoxConstraints textConstraints,
  ) : first = pageFlow == _PageFlow.previous
          ? _firstVisibleWord(txtPainter, allSpans, segments, textConstraints)
          : 0,
      last = pageFlow == _PageFlow.next
          ? _lastVisibleWord(txtPainter, allSpans, segments, textConstraints)
          : segments.length - 1;

  final int first;
  final int last;

  static int _firstVisibleWord(
    TextPainter textPainter,
    List<InlineSpan> allSpans,
    WorkContentsSegments segments,
    BoxConstraints textConstraints,
  ) {
    var high = allSpans.length - 1;
    var low = 0;
    var firstFittingIndex = high + 1;
    while (low <= high) {
      final mid = (low + high) ~/ 2;
      textPainter
        ..text = TextSpan(children: allSpans.sublist(mid))
        ..layout(maxWidth: textConstraints.maxWidth);
      if (textPainter.height <= textConstraints.maxHeight) {
        firstFittingIndex = mid;
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }
    // Adjust firstFittingIndex to start of next verse if necessary
    if (firstFittingIndex > 0 && firstFittingIndex < segments.length) {
      final firstElement = segments[firstFittingIndex];
      if (firstElement.typ == 'VERS') {
        final currentNode = firstElement.node;
        final previousNode = firstFittingIndex > 0 ? segments[firstFittingIndex - 1].node : null;
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
    WorkContentsSegments segments,
    BoxConstraints textConstraints,
  ) {
    var low = 0;
    var high = allSpans.length - 1;
    var lastFittingIndex = low - 1;
    while (low <= high) {
      final mid = (low + high) ~/ 2;
      textPainter
        ..text = TextSpan(children: allSpans.sublist(0, mid + 1))
        ..layout(maxWidth: textConstraints.maxWidth);
      if (textPainter.height <= textConstraints.maxHeight) {
        lastFittingIndex = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    // Adjust lastFittingIndex to end of previous verse if necessary
    if (lastFittingIndex < segments.length - 1) {
      final lastElement = segments[lastFittingIndex];
      if (lastElement.typ == 'VERS') {
        final currentNode = lastElement.node;
        final nextNode = lastFittingIndex + 1 < segments.length
            ? segments[lastFittingIndex + 1].node
            : null;
        // If the next word is from a different verse (node), we're good
        if (currentNode != nextNode) {
          return lastFittingIndex;
        }
        // If we're in the middle of a verse, move back to the end of the previous verse
        while (lastFittingIndex > 0 && segments[lastFittingIndex - 1].node == currentNode) {
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

  static bool _isPunctuation(String word) =>
      _closingPunctSigns.contains(word) || _closingPunctSigns.any((sign) => word.startsWith(sign));
  //
}

class _StyledWordList extends ConsumerStatefulWidget {
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

  final WorkContentsSegments segments;
  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;
  final void Function(int, int) onVisibleIndicesChanged;
  final _PageFlow pageFlow;
  final bool isLargeScreen;
  final BoxConstraints pageConstraints;
  final BoxConstraints? textAreaConstraints;

  @override
  _StyledWordListState createState() => _StyledWordListState();
  //
}

class _StyledWordListState extends ConsumerState<_StyledWordList> {
  //
  final _textSelector = _TextSelector();
  var _wordSelectionButtons = <ContextMenuButtonItem>[];
  late _GestureHandler _gestureHandler;

  @override
  void initState() {
    super.initState();
    _gestureHandler = _GestureHandler(
      onNavigateNext: widget.onNavigateNext,
      onNavigatePrevious: widget.onNavigatePrevious,
      onNavMenuToggle: _handleNavMenuToggle,
      customAdaptiveScaffoldKey: customAdaptiveScaffoldKey,
    );
  }

  @override
  Widget build(context) {
    _rebuildOnScreenSizeChange(context);
    return widget.isLargeScreen
        ? _buildLargeScreenLayout(context)
        : _buildSmallScreenLayout(context);
  }

  Future<void> _handleNavMenuToggle(BuildContext context) async {
    Breakpoints.smallDesktop.isActive(context)
        ? await _gestureHandler._showBottomNavBar(context)
        : await _gestureHandler._showNavigationOverlay(context);
  }

  Widget _buildSmallScreenLayout(BuildContext context) => Row(
    children: [
      Expanded(
        child: SizedBox.expand(
          child: GestureDetector(
            onHorizontalDragEnd: (details) => _gestureHandler.handleSwipe(details.primaryVelocity),
            onDoubleTap: () => _gestureHandler.onNavMenuToggle(context),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              // Use a LayoutBuilder to get the correct constraints
              child: LayoutBuilder(builder: _buildSelectionArea),
            ),
          ),
        ),
      ),
    ],
  );

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
        SizedBox(width: textWidth, child: _buildStylizedTextArea()),
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
    const padding = EdgeInsets.only(left: 24, bottom: 14);
    return Card(
      child: Padding(
        padding: padding,
        // Use a LayoutBuilder to get the correct constraints
        child: LayoutBuilder(builder: _buildSelectionArea),
      ),
    );
  }

  Widget _buildSelectionArea(BuildContext context, BoxConstraints constraints) {
    // Built using the constraints given by SizedBox
    final visibleTextSpan = _buildTextWithOverflowDetection(context, constraints);
    return SelectableText.rich(
      visibleTextSpan,
      onSelectionChanged: (selection, cause) =>
          _handleSelectionChanged(selection, cause, visibleTextSpan.toPlainText()),
      contextMenuBuilder: _buildContextMenu,
      // The scrollbar may appear when resizing with the default physics
      scrollPhysics: const NeverScrollableScrollPhysics(),
    );
  }

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
    String visibleText,
  ) {
    log.info(() => 'user selected text "${selection.textInside(visibleText)}"');
    final selectedWord = _textSelector.singleWord(selection, visibleText);
    setState(() {
      if (selectedWord != null) {
        // TODO(whothefluff): add button for "using macrons" (exact match) when macrons are added
        // although this will not be possible for the wiktionary
        _wordSelectionButtons = [
          _WordDetailsButton(word: selectedWord, ref: ref, context: context),
          _WiktionaryButton(word: selectedWord, ref: ref, context: context),
        ];
      } else {
        _wordSelectionButtons = [];
      }
    });
  }

  Widget _buildContextMenu(BuildContext context, EditableTextState state) =>
      AdaptiveTextSelectionToolbar.buttonItems(
        anchors: state.contextMenuAnchors,
        buttonItems: [
          ...state.contextMenuButtonItems,
          ..._wordSelectionButtons,
        ],
      );

  void _rebuildOnScreenSizeChange(BuildContext context) {
    MediaQuery.of(context);
  }

  TextSpan _buildTextWithOverflowDetection(BuildContext context, BoxConstraints constraints) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final allSpans = _TextRenderer(
      TextTheme.of(context),
      widget.segments,
    ).createSpans();
    textPainter
      ..text = TextSpan(children: allSpans)
      ..layout(maxWidth: constraints.maxWidth);
    final visible = _VisibleSegmentRange.build(
      textPainter,
      allSpans,
      widget.segments,
      widget.pageFlow,
      constraints,
    );
    // dart format off
    log.info(() => 'displaying new range (${widget.segments[visible.first].idx} - ${widget.segments[visible.last].idx})');
    // dart format on
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.onVisibleIndicesChanged(
        widget.segments[visible.first].idx,
        widget.segments[visible.last].idx,
      ),
    );
    return TextSpan(children: allSpans.sublist(visible.first, visible.last + 1));
  }

  //
}
