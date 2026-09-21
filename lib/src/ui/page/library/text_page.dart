import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../logger.dart';
import '../../../component/library/subdivision_type.dart';
import '../../../component/library/work_contents_api.dart';
import '../../../component/library/work_details_api.dart';
import '../../../component/morph_analysis/enriched_morph_search_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../../component/settings/reader_settings_api.dart';
import '../../app.dart';
import '../../router/config.dart';
import '../../widget/custom_adaptive_scaffold.dart';
import '../../widget/custom_adaptive_scaffold/adaptive_layout.dart';
import '../../widget/custom_adaptive_scaffold/adaptive_scaffold.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';
import '../../widget/custom_adaptive_scaffold/slot_layout.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import '../settings/settings_shell_page.dart' show SettingsTab;
import 'work_index_sheet.dart';

/// Line terminator that will be stable across all platforms even after rendering
const _lineTerminator = '\n';

/// Whether tokens of [type] introduce the text after them
bool _isHeadingType(SubdivisionType type) => switch (type) {
  (SubdivisionType.book ||
      SubdivisionType.prologue ||
      SubdivisionType.poem ||
      SubdivisionType.epilogue ||
      SubdivisionType.title) =>
    true,
  SubdivisionType.verse || SubdivisionType.paragraph => false,
};

/// Whether nodes of [type] never break across pages
bool _isUnbreakableType(SubdivisionType type) =>
    type == SubdivisionType.verse || _isHeadingType(type);

const _closingPunctSigns = ['.', ',', '!', '?', ':', ';', ')', ']'];
const _openingPunctSigns = ['(', '['];
const _blank = ' ';

enum _PageFlow {
  previous,
  next,
}

String _withoutMacrons(String word) {
  const macronized = 'āēīōūȳĀĒĪŌŪȲ';
  const plain = 'aeiouyAEIOUY';
  return word.replaceAllMapped(
    RegExp('[$macronized]'),
    (match) => plain[macronized.indexOf(match[0]!)],
  );
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
  /// Fetch buffer for pagination. Grows when necessary to be reused by later pages
  static const _initialBufferSize = 250;
  late int _lastIndex; // Highest token index, punctuation included
  int _bufferSize = _initialBufferSize;
  var _currentFirstVisibleIndex = 0;
  var _currentLastVisibleIndex = 0;
  var _fromIndex = 0;
  var _contentGeneration = 0;
  var _pageReady = false;
  var _indexOpen = false;
  int _toIndex = _initialBufferSize - 1;
  _PageFlow _pageFlow = _PageFlow.next;

  @override
  Widget build(context) {
    final lastIndexProvider = ref.watch(
      workDetailsProvider(
        widget.workId,
      ).select((model) => model.whenData((work) => work.lastIndex)),
    );
    return lastIndexProvider.when(
      data: (lastIndex) {
        _lastIndex = lastIndex;
        return _scaffold();
      },
      loading: showLoading,
      error: showError(ref, workDetailsProvider(widget.workId)),
    );
  }

  Widget _scaffold() {
    final segmentsProvider = ref.watch(workContentsProvider(widget.workId, _fromIndex, _toIndex));
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: segmentsProvider.when(
          data: _buildResponsiveContent,
          loading: showLoading,
          error: showError(ref, workContentsProvider(widget.workId, _fromIndex, _toIndex)),
        ),
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
        //keep the generation that produced these segments (so stale callbacks can be ignored)
        final generation = _contentGeneration;
        return _StyledWordList(
          key: ValueKey((widget.workId, generation)), // Recreate selection state after explicit nav
          segments: segments,
          onNavigateNext: _loadNextPage,
          onNavigatePrevious: _loadPreviousPage,
          onOpenIndex: _openIndex,
          onVisibleIndicesChanged: (first, last, {required fitsWholeBuffer}) =>
              _updateVisibleIndices(
                first,
                last,
                fitsWholeBuffer: fitsWholeBuffer,
                generation: generation,
              ),
          pageFlow: _pageFlow,
          isLargeScreen: isLargeScreen,
          pageConstraints: pageConstraints,
          textAreaConstraints: textAreaConstraints,
        );
      },
    );
  }

  void _updateVisibleIndices(
    int first,
    int last, {
    required bool fitsWholeBuffer,
    required int generation,
  }) {
    final isCurrentContent = mounted && generation == _contentGeneration;
    final isWithinBuffer = first >= _fromIndex && last <= _toIndex && first <= last;
    final isBufferCut = switch (_pageFlow) {
      _PageFlow.next => _toIndex < _lastIndex,
      _PageFlow.previous => _fromIndex > 0,
    };
    // A page holding the whole buffer may break at the cut instead of at a real
    // break, and there's more text it could show
    final needsMoreText = fitsWholeBuffer && isBufferCut;
    if (isCurrentContent && isWithinBuffer && needsMoreText) {
      _growBuffer();
    } else if (isCurrentContent && isWithinBuffer) {
      log.info(() => 'displaying range ($first - $last)');
      _currentFirstVisibleIndex = first;
      _currentLastVisibleIndex = last;
      _pageReady = true;
      _shrinkBufferIfOversized(first, last, fitsWholeBuffer: fitsWholeBuffer);
    }
  }

  /// Refetches the current page with twice as many tokens
  void _growBuffer() {
    log.info(() => 'page holds all $_bufferSize fetched tokens, fetching more');
    setState(() {
      _contentGeneration++;
      _pageReady = false;
      _bufferSize *= 2;
      switch (_pageFlow) {
        case _PageFlow.next:
          _toIndex = min(_fromIndex + _bufferSize - 1, _lastIndex);
        case _PageFlow.previous:
          _fromIndex = max(0, _toIndex - _bufferSize + 1);
      }
    });
  }

  /// Halves the buffer when a full page uses a quarter of it or less
  void _shrinkBufferIfOversized(int first, int last, {required bool fitsWholeBuffer}) {
    // Only a page cut short by the viewport tells how much a page holds. One
    // that holds the whole buffer may just have reached the end of the work
    final pageTokens = last - first + 1;
    final isOversized = !fitsWholeBuffer && pageTokens * 4 <= _bufferSize;
    if (isOversized && _bufferSize > _initialBufferSize) {
      _bufferSize = max(_initialBufferSize, _bufferSize ~/ 2);
      log.info(() => 'page holds $pageTokens tokens, fetching $_bufferSize from now on');
    }
  }

  void _loadNextPage() {
    log.info(() => 'attempting to navigate to next page');
    if (_pageReady && _currentLastVisibleIndex < _lastIndex) {
      setState(() {
        _contentGeneration++;
        _pageReady = false;
        _pageFlow = _PageFlow.next;
        _fromIndex = _currentLastVisibleIndex + 1;
        _toIndex = min(_currentLastVisibleIndex + _bufferSize, _lastIndex);
      });
    }
  }

  void _loadPreviousPage() {
    log.info(() => 'attempting to navigate to previous page');
    if (_pageReady && _currentFirstVisibleIndex > 0) {
      setState(() {
        _contentGeneration++;
        _pageReady = false;
        _pageFlow = _PageFlow.previous;
        _currentLastVisibleIndex = _currentFirstVisibleIndex - 1;
        _fromIndex = max(0, _currentLastVisibleIndex - _bufferSize + 1);
        _toIndex = _currentLastVisibleIndex;
      });
    }
  }

  @override
  void didUpdateWidget(TextPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.workId != widget.workId) {
      _contentGeneration++;
      _pageReady = false;
      _currentFirstVisibleIndex = 0;
      _currentLastVisibleIndex = 0;
      _fromIndex = 0;
      _toIndex = _bufferSize - 1;
      _pageFlow = _PageFlow.next;
    }
  }

  Future<void> _openIndex() async {
    final canOpen = !_indexOpen;
    if (canOpen) {
      _indexOpen = true;
      final workId = widget.workId;
      try {
        ContextMenuController.removeAny();
        final workName = ref.read(workDetailsProvider(workId)).valueOrNull?.name ?? 'This work';
        final selected = await showWorkIndex(
          context: context,
          workId: workId,
          workName: workName,
          currentIndex: _currentFirstVisibleIndex,
        );
        // The displayed work may have changed while the sheet was open
        final target = mounted && widget.workId == workId && selected?.workId == workId
            ? selected
            : null;
        if (target != null) {
          _jumpToIndex(target.fromIndex);
        }
      } finally {
        _indexOpen = false;
      }
    }
  }

  void _jumpToIndex(int tokenIndex) {
    final hasContent = _lastIndex >= 0;
    if (hasContent) {
      final target = tokenIndex.clamp(0, _lastIndex);
      log.info(() => 'Jumping to token $target in ${widget.workId}');
      setState(() {
        _contentGeneration++;
        _pageReady = false;
        _pageFlow = _PageFlow.next; //the selected subdivision starts the page
        _fromIndex = target;
        _toIndex = min(target + _bufferSize - 1, _lastIndex);
        _currentFirstVisibleIndex = target;
        _currentLastVisibleIndex = target;
      });
    }
  }

  //
}

class _TextRenderer {
  _TextRenderer(
    this.theme,
    this.workSegments,
    this.readerSettings,
  );

  final ThemeData theme;
  final WorkContentsSegments workSegments;
  final ReaderSettings readerSettings;

  static const _empty = '';

  /// Should be used to open every page no matter what preceded its first segment
  static const String _pageStartBreak = _lineTerminator;

  /// Separation before a block whose type differs from the previous one
  static String _lineBreakBefore(SubdivisionType type) => switch (type) {
    SubdivisionType.book => _lineTerminator * 3,
    SubdivisionType.prologue => _lineTerminator * 2,
    SubdivisionType.epilogue => _lineTerminator * 2,
    SubdivisionType.poem => _lineTerminator * 2,
    SubdivisionType.title => _lineTerminator,
    SubdivisionType.verse => _lineTerminator,
    SubdivisionType.paragraph => _lineTerminator,
  };

  /// Theme style for a block of [type]
  TextStyle _themeStyle(SubdivisionType type) => switch (type) {
    SubdivisionType.book => textTheme.headlineSmall!,
    SubdivisionType.prologue => textTheme.titleMedium!,
    SubdivisionType.epilogue => textTheme.titleMedium!,
    SubdivisionType.poem => textTheme.titleMedium!,
    SubdivisionType.title => textTheme.bodyMedium!,
    SubdivisionType.verse => textTheme.bodyLarge!,
    SubdivisionType.paragraph => textTheme.bodyMedium!,
  };

  TextTheme get textTheme => theme.textTheme;

  String _getSpace(int index, WorkContentsSegment segment) {
    final nextIsPunctuation =
        index + 1 < workSegments.length &&
        _closingPunctSigns.any((sign) => workSegments[index + 1].word.startsWith(sign));
    final endsWithOpeningParenthesis = segment.word.endsWith('(');
    return nextIsPunctuation || endsWithOpeningParenthesis ? _empty : _blank;
  }

  String _getLineBreak(
    SubdivisionType? previousStyle,
    SubdivisionType currentStyle,
    String? previousNode,
    String currentNode,
  ) {
    var lineBreak = _empty;
    if (previousStyle != null && currentStyle != previousStyle) {
      lineBreak = _lineBreakBefore(currentStyle);
    } else {
      if (currentNode != previousNode) {
        lineBreak = _lineTerminator;
      }
    }
    return lineBreak;
  }

  List<TextSpan> createSpans() {
    final baseTextStyle = TextStyle(
      fontFamily: readerSettings.fontFamily,
      fontSize: readerSettings.fontSize,
      height: readerSettings.lineHeight,
      letterSpacing: readerSettings.letterSpacing,
      wordSpacing: readerSettings.wordSpacing,
    );
    return workSegments.mapIndexed((i, segment) {
      final previousSegment = i > 0 ? workSegments[i - 1] : null;
      final prevStyle = previousSegment?.typ;
      final prevNode = previousSegment?.node;
      final currStyle = segment.typ;
      final currNode = segment.node;
      // Merge the theme style for this block (e.g. TITL vs VERS) with the user settings
      final blockThemeStyle = _themeStyle(currStyle);
      final mergedStyle = blockThemeStyle.merge(baseTextStyle);
      final finalStyle = readerSettings.fontFamily != null
          ? GoogleFonts.getFont(readerSettings.fontFamily!, textStyle: mergedStyle)
          : mergedStyle;
      // Pagination expects one outer span per segment
      return TextSpan(
        text: _getLineBreak(prevStyle, currStyle, prevNode, currNode),
        style: finalStyle,
        children: [
          ..._wordSpans(segment),
          TextSpan(text: _getSpace(i, segment)),
        ],
      );
    }).toList();
  }

  /// Spans for segments [first]..[last], as laid out on a page
  static List<InlineSpan> pageSpans(List<TextSpan> spans, int first, int last) {
    final opening = spans[first];
    return [
      TextSpan(text: _pageStartBreak, style: opening.style, children: opening.children),
      ...spans.sublist(first + 1, last + 1),
    ];
  }

  /// Letter spans for [segment]
  List<TextSpan> _wordSpans(WorkContentsSegment segment) {
    final word = readerSettings.showMacrons ? segment.macronizedWord : segment.word;
    final mask = readerSettings.showMacrons ? segment.uncertaintyBitMask : 0;
    final uncertainStyle = TextStyle(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
      decorationColor: theme.colorScheme.primary,
      decorationThickness: 1,
    );
    return mask == 0
        ? [TextSpan(text: word)]
        : word.runes.mapIndexed((i, rune) {
            final isUncertain = ((mask >> i) & 1) != 0;
            return TextSpan(
              text: String.fromCharCode(rune),
              style: isUncertain ? uncertainStyle : null,
            );
          }).toList();
  }

  //
}

class _GestureHandler {
  _GestureHandler({
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onNavMenuToggle,
  });

  final void Function() onNavigateNext;
  final void Function() onNavigatePrevious;
  final void Function(BuildContext context) onNavMenuToggle;

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

  //
}

class _TextSelector {
  //

  /// If the user selected exactly just a full word (with no other words or
  /// symbols), this word will be returned stripped of whitespace
  ///
  /// Otherwise null
  String? singleWord(TextSelection selection, String visibleText) {
    // Ignore selected spaces at word boundary
    final trimmedSelectedText = selection.textInside(visibleText).trim();
    final isWordSelected =
        trimmedSelectedText.isNotEmpty &&
        _isFullWordSelected(trimmedSelectedText, visibleText, selection);
    log.info(() => isWordSelected ? 'word "$trimmedSelectedText" selected' : 'no word selected');
    return isWordSelected ? trimmedSelectedText : null;
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
    required bool compact,
    bool ignoreMacrons = false,
  }) : super(
         label: _label(word, compact: compact, ignoreMacrons: ignoreMacrons),
         onPressed: () => _onPressed(
           ignoreMacrons ? _withoutMacrons(word) : word,
           ref,
           context,
         ),
       );

  final WidgetRef ref;
  final BuildContext context;

  static String _label(String word, {required bool compact, required bool ignoreMacrons}) =>
      switch ((compact, ignoreMacrons)) {
        (true, false) => 'Morph',
        (true, true) => 'Morph (plain)',
        (false, false) => 'See details for "$word"',
        (false, true) => 'See details ignoring macrons',
      };

  static Future<void> _onPressed(String word, WidgetRef ref, BuildContext context) async {
    log.entry(args: [word]);
    ContextMenuController.removeAny();
    // Using double quotes will force an exact match, avoiding a text search
    final results = await ref.read(enrichedMorphologicalSearchProvider('"$word"').future);
    if (results.isNotEmpty) {
      final selectedKeys = AnalysisKeys(
        results.map((r) => AnalysisKey(form: r.form, item: r.item, cnt: r.cnt)),
      );
      if (context.mounted) {
        log.exit<void>();
        await MorphologicalDataRoute(selectedKeys.toJson()).push<void>(context);
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
    required bool compact,
  }) : super(
         label: compact ? 'Wiktionary' : 'Look up in Wiktionary',
         onPressed: () => _onPressed(word, ref, context),
       );

  final WidgetRef ref;
  final BuildContext context;

  static Future<void> _onPressed(String word, WidgetRef ref, BuildContext context) async {
    log.entry(args: [word]);
    ContextMenuController.removeAny();
    final plainWord = _withoutMacrons(word);
    final queryWord = (await _isProperNoun(word, ref))
        ? _capitalize(plainWord)
        : plainWord.toLowerCase();
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
      final results = await ref.read(enrichedMorphologicalSearchProvider('"$word"').future);
      isProperName = results.isEmpty;
    }
    return log.exit(r: isProperName)!;
  }

  static String _capitalize(String word) => '${word[0].toUpperCase()}${word.substring(1)}';
  //
}

class _VisibleSegmentRange {
  const _VisibleSegmentRange._({
    required this.first,
    required this.last,
    required this.fitsWholeBuffer,
  });

  factory _VisibleSegmentRange.build(
    List<TextSpan> allSpans,
    WorkContentsSegments segments,
    _PageFlow pageFlow,
    BoxConstraints textConstraints,
    TextScaler textScaler,
    StrutStyle strutStyle,
  ) {
    //match the SelectableText strut so measurement and rendering use the same layout settings
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
      strutStyle: strutStyle,
    );
    try {
      final breaks = _PageBreaks(painter, allSpans, segments, textConstraints);
      return switch (pageFlow) {
        _PageFlow.next => breaks.pageFromStart(),
        _PageFlow.previous => breaks.pageToEnd(),
      };
    } finally {
      painter.dispose();
    }
  }

  /// The page could hold more than the buffer, so its edge at the cut may not
  /// be a real break
  final bool fitsWholeBuffer;

  final int first;
  final int last;
  //
}

/// Where a page over the fetched buffer may start or end
///
/// A page never splits a unit (a verse, a heading, or a word and the
/// punctuation after it) and never separates a heading from the start of the
/// text it introduces. Neither rule may leave the page empty
class _PageBreaks {
  _PageBreaks(
    this._painter,
    this._spans,
    this._segments,
    this._constraints,
  );

  final TextPainter _painter;
  final List<TextSpan> _spans;
  final WorkContentsSegments _segments;
  final BoxConstraints _constraints;

  int get _length => _segments.length;

  /// The page that starts the buffer
  _VisibleSegmentRange pageFromStart() {
    // The page overflows from the first end that doesn't fit
    final lastFitting = _firstWhere(0, _length - 1, (end) => !_fits(0, end)) - 1;
    return _VisibleSegmentRange._(
      first: 0,
      // Keep a non-empty range even if one token exceeds the viewport
      last: _settleEnd(max(0, lastFitting)),
      fitsWholeBuffer: lastFitting == _length - 1,
    );
  }

  /// The page that ends the buffer
  _VisibleSegmentRange pageToEnd() {
    final firstFitting = _firstWhere(0, _length - 1, (start) => _fits(start, _length - 1));
    return _VisibleSegmentRange._(
      // Keep a non-empty range even if one token exceeds the viewport
      first: _settleStart(min(firstFitting, _length - 1)),
      last: _length - 1,
      fitsWholeBuffer: firstFitting == 0,
    );
  }

  /// Moves [end] back to avoid splitting a unit or stranding a heading
  int _settleEnd(int end) {
    final splitsUnit = _continuesPrevious(end + 1);
    final strandsHeading = end + 1 < _length && _isHeading(end);
    final unitStart = _unitStart(end);
    return (splitsUnit || strandsHeading) && unitStart > 0 ? _settleEnd(unitStart - 1) : end;
  }

  /// Moves [start] forward to avoid splitting a unit or stranding a heading
  int _settleStart(int start) {
    final splitsUnit = _continuesPrevious(start);
    final strandsHeading = start > 0 && _isHeading(start - 1);
    final nextUnit = _unitEnd(start) + 1;
    return (splitsUnit || strandsHeading) && nextUnit < _length ? _settleStart(nextUnit) : start;
  }

  int _unitStart(int index) => _continuesPrevious(index) ? _unitStart(index - 1) : index;

  int _unitEnd(int index) => _continuesPrevious(index + 1) ? _unitEnd(index + 1) : index;

  /// Whether [index] belongs to the same unit as the segment before it
  bool _continuesPrevious(int index) =>
      index > 0 &&
      index < _length &&
      (_isUnbreakableType(_segments[index].typ)
          ? _segments[index - 1].node == _segments[index].node
          : _isPunctuation(_segments[index].word));

  bool _isHeading(int index) => _isHeadingType(_segments[index].typ);

  bool _fits(int first, int last) {
    _painter
      ..text = TextSpan(children: _TextRenderer.pageSpans(_spans, first, last))
      ..layout(maxWidth: _constraints.maxWidth);
    return _painter.height <= _constraints.maxHeight;
  }

  /// Lowest index in [low]..[high] where [test] holds, or [high] + 1 when it
  /// never does. [test] must fail up to some index and hold from there on
  static int _firstWhere(int low, int high, bool Function(int) test) {
    final mid = (low + high) ~/ 2;
    return low > high
        ? low
        : test(mid)
        ? _firstWhere(low, mid - 1, test)
        : _firstWhere(mid + 1, high, test);
  }

  static bool _isPunctuation(String word) =>
      _closingPunctSigns.contains(word) || _closingPunctSigns.any((sign) => word.startsWith(sign));
  //
}

class _StyledWordList extends ConsumerStatefulWidget {
  const _StyledWordList({
    super.key,
    required this.segments,
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onOpenIndex,
    required this.onVisibleIndicesChanged,
    required this.pageFlow,
    required this.isLargeScreen,
    required this.pageConstraints,
    required this.textAreaConstraints,
  });

  final WorkContentsSegments segments;
  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;
  final Future<void> Function() onOpenIndex;
  final void Function(int, int, {required bool fitsWholeBuffer}) onVisibleIndicesChanged;
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

  // TODO(whothefluff): add test that only passes with the mirrored gaps match
  /// [RenderEditable] implementation detail (verify with Flutter version)
  final _readerCaretGap = 1.0;
  final _readerCursorWidth = 2.0;
  final _textSelector = _TextSelector();
  final StrutStyle _readerStrut = StrutStyle.disabled;
  late _GestureHandler _gestureHandler;
  var _navMenuOpen = false;
  var _layoutRevision = 0;

  @override
  void initState() {
    super.initState();
    _gestureHandler = _GestureHandler(
      onNavigateNext: widget.onNavigateNext,
      onNavigatePrevious: widget.onNavigatePrevious,
      onNavMenuToggle: _handleNavMenuToggle,
    );
  }

  Future<void> _handleNavMenuToggle(BuildContext context) async {
    final canOpen = !_navMenuOpen;
    if (canOpen) {
      _navMenuOpen = true;
      // the dialog only records the choice (it runs once the modal is gone)
      Future<void> Function()? pendingAction;
      void choose(BuildContext dialogContext, Future<void> Function() action) {
        if (pendingAction == null) {
          pendingAction = action;
          Navigator.of(dialogContext).pop();
        }
      }

      try {
        ContextMenuController.removeAny();
        final branchIds = mainBranches.map((entry) => entry.id).toList();
        await showGeneralDialog<void>(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Dismiss',
          barrierColor: Theme.of(context).bottomSheetTheme.modalBarrierColor ?? Colors.black54,
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (ctx, animation, secondaryAnimation) => _NavMenuModal(
            scaffoldKey: customAdaptiveScaffoldKey,
            onNavigate: (index) => choose(
              ctx,
              () async => context.go(branchIds[index]),
            ),
            onIndex: () => choose(
              ctx,
              widget.onOpenIndex,
            ),
            onSettings: () => choose(
              ctx,
              () async => const SettingsRoute(tab: SettingsTab.library).push<void>(context),
            ),
            onBack: () => choose(
              ctx,
              () async => context.pop(),
            ),
          ),
        );
        final action = mounted && context.mounted ? pendingAction : null;
        if (action != null) {
          await action();
        }
      } finally {
        _navMenuOpen = false;
      }
    }
  }

  @override
  Widget build(context) {
    _rebuildOnScreenSizeChange(context);
    final readerSettings =
        ref.watch(readerSettingsNotifierProvider).valueOrNull ?? const ReaderSettings();
    return widget.isLargeScreen
        ? _buildLargeScreenLayout(context, readerSettings)
        : _buildSmallScreenLayout(context, readerSettings);
  }

  Widget _buildSmallScreenLayout(BuildContext context, ReaderSettings settings) => Row(
    children: [
      Expanded(
        child: SizedBox.expand(
          child: GestureDetector(
            onHorizontalDragEnd: (details) => _gestureHandler.handleSwipe(details.primaryVelocity),
            onDoubleTap: () => _gestureHandler.onNavMenuToggle(context),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              // Use a LayoutBuilder to get the correct constraints
              child: LayoutBuilder(
                builder: (ctx, constr) => _buildSelectionArea(ctx, constr, settings),
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildLargeScreenLayout(BuildContext context, ReaderSettings settings) {
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
        SizedBox(width: textWidth, child: _buildStylizedTextArea(settings)),
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

  Widget _buildStylizedTextArea(ReaderSettings settings) {
    const padding = EdgeInsets.only(left: 24, bottom: 14);
    return Card(
      child: Padding(
        padding: padding,
        // Use a LayoutBuilder to get the correct constraints
        child: LayoutBuilder(builder: (ctx, constr) => _buildSelectionArea(ctx, constr, settings)),
      ),
    );
  }

  Widget _buildSelectionArea(
    BuildContext context,
    BoxConstraints constraints,
    ReaderSettings settings,
  ) {
    // Built using the constraints given by SizedBox
    final visibleTextSpan = _buildTextWithOverflowDetection(context, constraints, settings);
    return SelectableText.rich(
      visibleTextSpan,
      strutStyle: _readerStrut,
      textScaler: MediaQuery.textScalerOf(context),
      textDirection: TextDirection.ltr,
      cursorWidth: _readerCursorWidth,
      onSelectionChanged: (selection, _) => _preloadSelectionLookups(
        selection,
        visibleTextSpan.toPlainText(),
      ),
      contextMenuBuilder: _buildContextMenu,
    );
  }

  /// Starts lookups immediately when a full word is selected and cache results
  void _preloadSelectionLookups(
    TextSelection selection,
    String visibleText,
  ) {
    if (selection.isValid) {
      log.info(() => 'user selected text "${selection.textInside(visibleText)}"');
    }
    final selectedWord = _getSelectedWord(selection, visibleText);
    if (selectedWord != null) {
      _preloadWordLookups(selectedWord);
    }
  }

  String? _getSelectedWord(
    TextSelection selection,
    String visibleText,
  ) => selection.isValid ? _textSelector.singleWord(selection, visibleText) : null;

  void _preloadWordLookups(String word) {
    ref.read(enrichedMorphologicalSearchProvider('"$word"'));
    final settings = ref.read(readerSettingsNotifierProvider).valueOrNull ?? const ReaderSettings();
    final plainWord = _getAlternativeLookupWord(word, settings.showMacrons);
    if (plainWord != null) {
      ref.read(enrichedMorphologicalSearchProvider('"$plainWord"'));
    }
  }

  String? _getAlternativeLookupWord(String? word, bool showMacrons) {
    final plainWord = word == null ? null : _withoutMacrons(word);
    return showMacrons && plainWord != word ? plainWord : null;
  }

  Widget _buildContextMenu(BuildContext readerContext, EditableTextState state) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: state.widget.controller,
        builder: (_, value, _) => Consumer(
          builder: (_, menuRef, _) => _buildToolbarForSelection(
            readerContext,
            state,
            value,
            menuRef,
          ),
        ),
      );

  Widget _buildToolbarForSelection(
    BuildContext readerContext,
    EditableTextState state,
    TextEditingValue value,
    WidgetRef menuRef,
  ) {
    final selectedWord = _getSelectedWord(value.selection, value.text);
    final settings =
        menuRef.watch(readerSettingsNotifierProvider).valueOrNull ?? const ReaderSettings();
    final comparison = _watchMacronLookupComparison(menuRef, selectedWord, settings.showMacrons);
    return comparison.pending
        ? const SizedBox.shrink()
        : AdaptiveTextSelectionToolbar.buttonItems(
            anchors: state.contextMenuAnchors,
            buttonItems: _arrangeButtonItems(
              state.contextMenuButtonItems,
              selectedWord == null
                  ? const []
                  : _buildWordLookupButtons(
                      readerContext,
                      selectedWord,
                      showIgnoringMacrons: comparison.showIgnoringMacrons,
                    ),
            ),
          );
  }

  /// Returns buttons set in specific order
  List<ContextMenuButtonItem> _arrangeButtonItems(
    List<ContextMenuButtonItem> builtIn,
    List<ContextMenuButtonItem> lookups,
  ) {
    const copy = ContextMenuButtonType.copy;
    const selectAll = ContextMenuButtonType.selectAll;
    return [
      ...lookups,
      ...builtIn.where((item) => item.type == copy),
      ...builtIn.where((item) => item.type == selectAll),
      ...builtIn.where((item) => item.type != copy && item.type != selectAll),
    ];
  }

  /// Returns true for devices with touchscreens
  bool _usesCompactLabels(BuildContext context) => const {
    TargetPlatform.android,
    TargetPlatform.fuchsia,
    TargetPlatform.iOS,
  }.contains(Theme.of(context).platform);

  /// Compares the normal lookup with a lookup that ignores macrons
  ///
  /// - `pending` is `true` while waiting for the lookup results
  /// - `showIgnoringMacrons` is `true` when ignoring macrons finds results
  ///   that differ from the normal lookup
  ({bool pending, bool showIgnoringMacrons}) _watchMacronLookupComparison(
    WidgetRef menuRef,
    String? word,
    bool showMacrons,
  ) {
    var comparison = (pending: false, showIgnoringMacrons: false);
    final plainWord = _getAlternativeLookupWord(word, showMacrons);
    if (word != null && plainWord != null) {
      final displayedSearch = menuRef.watch(
        enrichedMorphologicalSearchProvider('"$word"'),
      );
      final plainSearch = menuRef.watch(
        enrichedMorphologicalSearchProvider('"$plainWord"'),
      );
      comparison = (
        pending: _isLookupComparisonPending(displayedSearch, plainSearch),
        showIgnoringMacrons: _plainLookupOffersDifferentResults(
          displayedSearch.asData?.value,
          plainSearch.asData?.value,
        ),
      );
    }
    return comparison;
  }

  bool _isLookupComparisonPending(
    AsyncValue<EnrichedResults> displayed,
    AsyncValue<EnrichedResults> plain,
  ) => !displayed.hasError && !plain.hasError && (displayed.isLoading || plain.isLoading);

  bool _plainLookupOffersDifferentResults(EnrichedResults? displayed, EnrichedResults? plain) =>
      displayed != null &&
      plain != null &&
      plain.isNotEmpty &&
      !const SetEquality<EnrichedResult>().equals(
        displayed.toSet(),
        plain.toSet(),
      );

  List<ContextMenuButtonItem> _buildWordLookupButtons(
    BuildContext readerContext,
    String word, {
    required bool showIgnoringMacrons,
  }) {
    final compact = _usesCompactLabels(readerContext);
    return [
      _WordDetailsButton(
        word: word,
        ref: ref,
        context: readerContext,
        compact: compact,
      ),
      if (showIgnoringMacrons)
        _WordDetailsButton(
          word: word,
          ref: ref,
          context: readerContext,
          compact: compact,
          ignoreMacrons: true,
        ),
      _WiktionaryButton(
        word: word,
        ref: ref,
        context: readerContext,
        compact: compact,
      ),
    ];
  }

  void _rebuildOnScreenSizeChange(BuildContext context) {
    MediaQuery.of(context);
  }

  TextSpan _buildTextWithOverflowDetection(
    BuildContext context,
    BoxConstraints constraints,
    ReaderSettings settings,
  ) {
    final revision = ++_layoutRevision;
    final isMeasurable =
        widget.segments.isNotEmpty && constraints.maxWidth > 0 && constraints.maxHeight > 0;
    return isMeasurable
        ? _layOutPage(context, constraints, settings, revision)
        : const TextSpan(text: '');
  }

  /// Fits as much of the buffer as the page holds and reports the range once
  /// it's on screen
  TextSpan _layOutPage(
    BuildContext context,
    BoxConstraints constraints,
    ReaderSettings settings,
    int revision,
  ) {
    final segments = widget.segments;
    final allSpans = _TextRenderer(Theme.of(context), segments, settings).createSpans();
    final visible = _VisibleSegmentRange.build(
      allSpans,
      segments,
      widget.pageFlow,
      BoxConstraints(
        maxWidth: max(0.0, constraints.maxWidth - _readerCursorWidth - _readerCaretGap),
        maxHeight: constraints.maxHeight,
      ),
      MediaQuery.textScalerOf(context),
      _readerStrut,
    );
    final first = segments[visible.first].idx;
    final last = segments[visible.last].idx;
    final notify = widget.onVisibleIndicesChanged;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // A newer layout pass owns the reported range
      if (mounted && revision == _layoutRevision) {
        notify(first, last, fitsWholeBuffer: visible.fitsWholeBuffer);
      }
    });
    return TextSpan(children: _TextRenderer.pageSpans(allSpans, visible.first, visible.last));
  }

  //
}

class _NavMenuModal extends StatelessWidget {
  const _NavMenuModal({
    required this.scaffoldKey,
    required this.onNavigate,
    required this.onIndex,
    required this.onSettings,
    required this.onBack,
  });

  final GlobalKey<CustomAdaptiveScaffoldState> scaffoldKey;
  final ValueChanged<int> onNavigate;
  final VoidCallback onIndex;
  final VoidCallback onSettings;
  final VoidCallback onBack;

  @override
  Widget build(context) {
    final state = scaffoldKey.currentState;
    return state == null ? const SizedBox.shrink() : _overlay(context, state.widget);
  }

  Widget _overlay(BuildContext context, CustomAdaptiveScaffold w) {
    // Where the AppBar's left edge should sit, per active form.
    final isBottom = w.smallBreakpoint.isActive(context);
    final isUnextended = w.mediumBreakpoint.isActive(context); // medium range only
    final railWidth = isUnextended ? w.navigationRailWidth : w.extendedNavigationRailWidth;
    final appBarLeft = isBottom
        ? 0.0
        : railWidth + CustomAdaptiveScaffold.navigationRailStartInset(context);
    return Stack(
      children: [
        AdaptiveLayout(
          transitionDuration: w.transitionDuration,
          internalAnimations: w.internalAnimations,
          animateInitialLayout: false,
          // Mirror the scaffold's primaryNavigation EXACTLY (all breakpoints!).
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              w.mediumBreakpoint: _railSlot(
                context,
                w,
                key: const Key('navModal.primaryNavigation'),
                extended: false,
              ),
              w.mediumLargeBreakpoint: _railSlot(
                context,
                w,
                key: const Key('navModal.primaryNavigation1'),
                extended: true,
              ),
              w.largeBreakpoint: _railSlot(
                context,
                w,
                key: const Key('navModal.primaryNavigation2'),
                extended: true,
              ),
              w.extraLargeBreakpoint: _railSlot(
                context,
                w,
                key: const Key('navModal.primaryNavigation3'),
                extended: true,
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              w.smallBreakpoint: SlotLayout.from(
                key: const Key('navModal.bottomNavigation'),
                inAnimation: AdaptiveScaffold.bottomToTop,
                //outAnimation: AdaptiveScaffold.topToBottom,
                builder: (_) => CustomAdaptiveScaffold.standardBottomNavigationBar(
                  currentIndex: w.selectedIndex,
                  destinations: w.destinations,
                  onDestinationSelected: onNavigate,
                  labelBehavior: w.bottomNavigationBarLabelBehavior,
                ),
              ),
            },
          ),
          // Body is now just a transparent, tap-through area.
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.standard: SlotLayout.from(
                key: const Key('navModal.body'),
                builder: (_) => const IgnorePointer(child: SizedBox.expand()),
              ),
            },
          ),
        ),
        // AppBar on top, tracking the rail edge but NOT animating on open.
        AnimatedPositioned(
          duration: w.transitionDuration,
          //curve: Easing.emphasizedDecelerate,
          top: 0,
          left: appBarLeft,
          right: 0,
          //the rail covers the left safe area so the AppBar needs no left padding
          child: MediaQuery.removePadding(
            context: context,
            removeLeft: !isBottom,
            child: Material(color: Colors.transparent, child: _appBar(context)),
          ),
        ),
      ],
    );
  }

  Widget _appBar(BuildContext context) => AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
    elevation: 4,
    leading: BackButton(onPressed: onBack),
    actions: [
      IconButton(
        tooltip: workIndexLabel,
        icon: const Icon(workIndexIcon),
        onPressed: onIndex,
      ),
      IconButton(
        tooltip: 'Reader settings',
        icon: const Icon(Icons.settings),
        onPressed: onSettings,
      ),
    ],
  );

  SlotLayoutConfig _railSlot(
    BuildContext context,
    CustomAdaptiveScaffold w, {
    required Key key,
    required bool extended,
  }) {
    final navRailTheme = Theme.of(context).navigationRailTheme;
    final destinations = w.destinations.map(CustomAdaptiveScaffold.toRailDestination).toList();
    return SlotLayout.from(
      key: key,
      inAnimation: AdaptiveScaffold.leftOutIn, // or CustomAdaptiveScaffold.leftOutIn
      //outAnimation: AdaptiveScaffold.leftInOut,
      builder: (_) => Material(
        // Restores the opaque, edge-to-edge surface + divider/shadow you had
        // before via Material(elevation: 1.0, ...).
        color: navRailTheme.backgroundColor ?? Theme.of(context).colorScheme.surface,
        elevation: 1.0,
        child: CustomAdaptiveScaffold.standardNavigationRail(
          padding: EdgeInsets.zero, // <-- removes the 8px gap on all sides
          width: extended ? w.extendedNavigationRailWidth : w.navigationRailWidth,
          extended: extended,
          leading: extended ? w.leadingExtendedNavRail : w.leadingUnextendedNavRail,
          trailing: w.trailingNavRail,
          selectedIndex: w.selectedIndex,
          destinations: destinations,
          onDestinationSelected: onNavigate,
          backgroundColor: navRailTheme.backgroundColor,
          selectedIconTheme: navRailTheme.selectedIconTheme,
          unselectedIconTheme: navRailTheme.unselectedIconTheme,
          selectedLabelTextStyle: navRailTheme.selectedLabelTextStyle,
          unSelectedLabelTextStyle: navRailTheme.unselectedLabelTextStyle,
          labelType: navRailTheme.labelType,
          groupAlignment: w.groupAlignment,
        ),
      ),
    );
  }

  //
}
