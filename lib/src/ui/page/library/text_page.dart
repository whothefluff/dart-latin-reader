import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../logger.dart';
import '../../../component/library/proper_noun_state.dart';
import '../../../component/library/punctuation.dart';
import '../../../component/library/subdivision_type.dart';
import '../../../component/library/work_contents_api.dart';
import '../../../component/library/work_details_api.dart';
import '../../../component/morph_analysis/enriched_morph_details_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../../component/settings/reader_settings_api.dart';
import '../../../component/word_frequency/lookup_frequency_api.dart';
import '../../../external/provider_ext.dart';
import '../../app.dart';
import '../../router/config.dart';
import '../../widget/custom_adaptive_scaffold.dart';
import '../../widget/custom_adaptive_scaffold/adaptive_layout.dart';
import '../../widget/custom_adaptive_scaffold/adaptive_scaffold.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';
import '../../widget/custom_adaptive_scaffold/slot_layout.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import '../settings/settings_shell_page.dart' show SettingsTab;
import 'page_segments.dart';
import 'reader_input.dart';
import 'selection_lookups.dart';
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

const _blank = ' ';

enum _PageFlow {
  previous,
  next,
}

class TextPage extends ConsumerStatefulWidget {
  const TextPage(
    this.workId, {
    super.key,
    this.startingPoint,
    this.highlights = const [],
  });

  final String workId;

  /// Where the first page starts at.
  /// The beginning of the work when `null`.
  final int? startingPoint;

  /// Tokens marked on a page
  final List<int> highlights;

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
  var _navMenuOpen = false;
  int _toIndex = _initialBufferSize - 1;
  _PageFlow _pageFlow = _PageFlow.next;

  @override
  void initState() {
    super.initState();
    _restartAt(widget.startingPoint ?? 0);
  }

  @override
  Widget build(context) {
    final lastIndexProvider = ref.watch(
      workDetailsProvider(
        widget.workId,
      ).select((model) => model.whenData((work) => work.lastIndex)),
    );
    //the scaffold wraps both stages so the loading and error states are padded too
    return SafeBodyScaffold(
      //keep outside the loading/data/error content so its FocusScope survives page replacement
      body: ReaderKeysAndWheel(
        onNext: _loadNextPage,
        onPrevious: _loadPreviousPage,
        onOpenMenu: _openMenu,
        child: lastIndexProvider.when(
          data: (lastIndex) {
            _lastIndex = lastIndex;
            return _contents();
          },
          loading: showLoading,
          error: showError(ref, workDetailsProvider(widget.workId)),
        ),
      ),
    );
  }

  Widget _contents() {
    final segmentsProvider = ref.watch(workContentsProvider(widget.workId, _fromIndex, _toIndex));
    return segmentsProvider.when(
      data: _withFrequencies,
      loading: showLoading,
      error: showError(ref, workContentsProvider(widget.workId, _fromIndex, _toIndex)),
    );
  }

  /// Waits for the frequencies only while common or uncommon words are marked
  Widget _withFrequencies(WorkContentsSegments segments) {
    final (:marks, :scope) = ref.watch(
      readerSettingsNotifierProvider.select(
        (value) => (
          marks: value.valueOrNull?.marksFrequencies ?? false,
          scope:
              value.valueOrNull?.frequencyScope ?? const ReaderSettings.defaults().frequencyScope,
        ),
      ),
    );
    final provider = lookupFrequenciesProvider(
      widget.workId,
      scope,
      LookupForms(segments.map((segment) => segment.lookupForm).nonNulls),
    );
    return marks
        ? ref
              .watch(provider)
              .when(
                data: (frequencies) => _buildResponsiveContent(segments, frequencies),
                loading: showLoading,
                error: showError(ref, provider),
              )
        : _buildResponsiveContent(segments, null);
  }

  Widget _buildResponsiveContent(
    WorkContentsSegments segments,
    LookupFrequencies? frequencies,
  ) => LayoutBuilder(
    builder: (context, pageConstraints) {
      //keep the generation that produced these segments (so stale callbacks can be ignored)
      final generation = _contentGeneration;
      return _StyledWordList(
        key: ValueKey((widget.workId, generation)), // Recreate selection state after explicit nav
        segments: segments,
        frequencies: frequencies,
        highlights: widget.highlights,
        onNavigateNext: _loadNextPage,
        onNavigatePrevious: _loadPreviousPage,
        onOpenMenu: _openMenu,
        onVisibleIndicesChanged: (first, last, {required fitsWholeBuffer}) => _updateVisibleIndices(
          first,
          last,
          fitsWholeBuffer: fitsWholeBuffer,
          generation: generation,
        ),
        pageFlow: _pageFlow,
        geometry: ReaderGeometry.inWindow(context, pageConstraints.maxWidth),
      );
    },
  );

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
    if (oldWidget.workId != widget.workId || oldWidget.startingPoint != widget.startingPoint) {
      _restartAt(widget.startingPoint ?? 0);
    }
  }

  /// Discards the current page and lays out a new one from [start]
  void _restartAt(int start) {
    _contentGeneration++;
    _pageReady = false;
    _currentFirstVisibleIndex = start;
    _currentLastVisibleIndex = start;
    _fromIndex = start;
    _toIndex = start + _bufferSize - 1;
    _pageFlow = _PageFlow.next;
  }

  Future<void> _openMenu() async {
    final canOpen = !_navMenuOpen;
    if (canOpen) {
      _navMenuOpen = true;
      try {
        ContextMenuController.removeAny();
        final branchIds = mainBranches.map((entry) => entry.id).toList();
        //the menu closes registers what to do, but it doesn't run yet
        final action = await showGeneralDialog<Future<void> Function()>(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Dismiss',
          barrierColor: Theme.of(context).bottomSheetTheme.modalBarrierColor ?? Colors.black54,
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (menuContext, _, _) => _NavMenuModal(
            scaffoldKey: customAdaptiveScaffoldKey,
            onNavigate: (index) => _closeMenu(
              menuContext,
              () async => context.go(branchIds[index]),
            ),
            onIndex: () => _closeMenu(menuContext, _openIndex),
            onSettings: () => _closeMenu(
              menuContext,
              () async => const SettingsRoute(tab: SettingsTab.library).push<void>(context),
            ),
            onBack: () => _closeMenu(menuContext, () async => context.pop()),
          ),
        );
        if (mounted && action != null) {
          await action();
        }
      } finally {
        _navMenuOpen = false;
      }
    }
  }

  /// Only the first choice closes the menu (popping again while it closes would pop the reader)
  void _closeMenu(BuildContext menuContext, Future<void> Function() action) {
    if (ModalRoute.isCurrentOf(menuContext) ?? false) {
      Navigator.of(menuContext).pop(action);
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
    this.highlights,
    this.bands,
  );

  final ThemeData theme;
  final WorkContentsSegments workSegments;
  final ReaderSettings readerSettings;

  /// Token indices to mark
  final List<int> highlights;

  /// `null` unless common or uncommon words are marked
  final FrequencyBands? bands;

  static const _empty = '';

  /// Keeps faded text above 4.5:1 contrast on the page, in both themes
  static const _uncommonAlpha = 0.65;

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
        closingPunctSigns.any(workSegments[index + 1].word.startsWith);
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
          ..._wordSpans(segment, finalStyle.color ?? theme.colorScheme.onSurface),
          TextSpan(text: _getSpace(i, segment)),
        ],
      );
    }).toList();
  }

  /// Spans for segments [first]..[last], as laid out on a page
  static List<TextSpan> pageSpans(List<TextSpan> spans, int first, int last) {
    final opening = spans[first];
    return [
      TextSpan(text: _pageStartBreak, style: opening.style, children: opening.children),
      ...spans.sublist(first + 1, last + 1),
    ];
  }

  /// Letter spans for [segment], colored by frequency and inside a marked span when highlighted
  List<TextSpan> _wordSpans(WorkContentsSegment segment, Color textColor) {
    final word = readerSettings.showMacrons ? segment.macronizedWord : segment.word;
    final mask = readerSettings.showMacrons ? segment.uncertaintyBitMask : 0;
    final uncertainStyle = TextStyle(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
      decorationColor: theme.colorScheme.primary,
      decorationThickness: 1,
    );
    final letters = mask == 0
        ? [TextSpan(text: word)]
        : word.runes.mapIndexed((i, rune) {
            final isUncertain = ((mask >> i) & 1) != 0;
            return TextSpan(
              text: String.fromCharCode(rune),
              style: isUncertain ? uncertainStyle : null,
            );
          }).toList();
    final isHighlighted = highlights.contains(segment.idx);
    //color and background do not affect pagination
    final highlightStyle = TextStyle(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      color: theme.colorScheme.onTertiaryContainer,
    );
    final frequencyColor = _frequencyColor(
      segment,
      isHighlighted ? theme.colorScheme.onTertiaryContainer : textColor,
    );
    final colored = frequencyColor == null
        ? letters
        : [
            TextSpan(
              style: TextStyle(color: frequencyColor),
              children: letters,
            ),
          ];
    return isHighlighted ? [TextSpan(style: highlightStyle, children: colored)] : colored;
  }

  /// Primary for common words, a faded [textColor] for uncommon ones, null for the rest
  Color? _frequencyColor(WorkContentsSegment segment, Color textColor) =>
      switch (_bandOf(segment)) {
        FrequencyBand.common => theme.colorScheme.primary,
        FrequencyBand.uncommon => textColor.withValues(alpha: _uncommonAlpha),
        null => null,
      };

  FrequencyBand? _bandOf(WorkContentsSegment segment) {
    final lookupForm = segment.lookupForm;
    final macronLookupForm = segment.macronLookupForm;
    final bands = this.bands;
    return lookupForm == null || macronLookupForm == null || bands == null
        ? null
        : bands.bandOf(
            Lookup.of(
              lookupForm,
              segment.properNounState,
              macronized: (form: macronLookupForm, uncertaintyBitMask: segment.uncertaintyBitMask),
            ),
          );
  }

  //
}

/// Analysis keys and the enriched morphological analyses found for them.
typedef _WordReadings = ({AnalysisKeys keys, EnrichedAnalyses analyses});

/// Wiktionary pages, morphology lookups, and macron comparison status for a word.
///
/// Candidate readings have not been ruled out by the word's certain macrons.
typedef _WordLookups = ({
  Set<String> wiktionaryPages,
  Future<_WordReadings> Function() lookUpReadings,
  Future<_WordReadings> Function() lookUpCandidateReadings,
  ({bool pending, bool showIgnoringMacrons}) macronComparison,
});

/// A context menu button that opens a word's morphological analyses.
class _WordDetailsButton extends ContextMenuButtonItem {
  _WordDetailsButton({
    required String word,
    required Future<_WordReadings> Function() lookUp,
    required BuildContext pageContext,
    required bool compact,
    bool ignoreMacrons = false,
  }) : super(
         label: _label(word, compact: compact, ignoreMacrons: ignoreMacrons),
         onPressed: () => open(lookUp, pageContext),
       );

  static String _label(String word, {required bool compact, required bool ignoreMacrons}) =>
      switch ((compact, ignoreMacrons)) {
        (true, false) => 'Morph',
        (true, true) => 'Morph (plain)',
        (false, false) => 'See details for "$word"',
        (false, true) => 'See details ignoring macrons',
      };

  static Future<void> open(
    Future<_WordReadings> Function() lookUp,
    BuildContext pageContext,
  ) async {
    ContextMenuController.removeAny();
    await lookUpThenOpen(
      pageContext,
      lookUp: lookUp,
      open: (readings) => _showReadings(readings, pageContext),
    );
  }

  static Future<void> _showReadings(_WordReadings readings, BuildContext pageContext) async {
    log.entry(args: [readings.keys]);
    if (readings.analyses.isNotEmpty) {
      log.exit<void>();
      await MorphologicalDataRoute(readings.keys.toJson()).push<void>(pageContext);
    } else {
      log
        ..warning(() => 'Nothing found when using morph data button with ${readings.keys}')
        ..exit(
          r: ScaffoldMessenger.of(pageContext).showSnackBar(
            const SnackBar(
              content: Text('Not found'),
            ),
          ),
        );
    }
  }

  //
}

/// A context menu button that opens an English Wiktionary entry.
class _WiktionaryButton extends ContextMenuButtonItem {
  _WiktionaryButton({
    required String page,
    required BuildContext pageContext,
    required bool compact,
  }) : super(
         label: labelFor(compact: compact),
         onPressed: () => open(page, pageContext),
       );

  static String labelFor({required bool compact}) =>
      compact ? 'Wiktionary' : 'Look up in Wiktionary';

  static Future<void> open(String page, BuildContext pageContext) async {
    log.entry(args: [page]);
    ContextMenuController.removeAny();
    try {
      if (await launchUrl(Uri.parse('https://en.wiktionary.org/wiki/$page#Latin'))) {
        log.exit<void>();
      } else {
        log.warning(() => 'Could not launch browser when using Wiktionary button');
        if (pageContext.mounted) {
          log.exit(
            r: ScaffoldMessenger.of(pageContext).showSnackBar(
              const SnackBar(content: Text('Could not launch browser')),
            ),
          );
        }
      }
    } on Exception catch (e) {
      log.catching(e);
      if (pageContext.mounted) {
        log.exit(
          r: ScaffoldMessenger.of(pageContext).showSnackBar(
            const SnackBar(content: Text('Browser error')),
          ),
        );
      }
    }
  }

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

  static bool _isPunctuation(String word) => closingPunctSigns.any(word.startsWith);
  //
}

class _StyledWordList extends ConsumerStatefulWidget {
  const _StyledWordList({
    super.key,
    required this.segments,
    required this.frequencies,
    required this.highlights,
    required this.onNavigateNext,
    required this.onNavigatePrevious,
    required this.onOpenMenu,
    required this.onVisibleIndicesChanged,
    required this.pageFlow,
    required this.geometry,
  });

  /// `null` unless common or uncommon words are marked
  final LookupFrequencies? frequencies;
  final WorkContentsSegments segments;
  final List<int> highlights;
  final VoidCallback onNavigateNext;
  final VoidCallback onNavigatePrevious;
  final VoidCallback onOpenMenu;
  final void Function(int, int, {required bool fitsWholeBuffer}) onVisibleIndicesChanged;
  final _PageFlow pageFlow;
  final ReaderGeometry geometry;

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
  final StrutStyle _readerStrut = StrutStyle.disabled;
  var _layoutRevision = 0;

  @override
  Widget build(context) {
    _rebuildOnScreenSizeChange(context);
    final readerSettings =
        ref.watch(readerSettingsNotifierProvider).valueOrNull ?? const ReaderSettings.defaults();
    final geometry = widget.geometry;
    return ReaderGestures(
      geometry: geometry,
      onNext: widget.onNavigateNext,
      onPrevious: widget.onNavigatePrevious,
      onOpenMenu: widget.onOpenMenu,
      textArea: geometry.hasMargins
          ? _buildStylizedTextArea(readerSettings)
          : _buildFullPageTextArea(readerSettings),
    );
  }

  Widget _buildFullPageTextArea(ReaderSettings settings) => Padding(
    padding: EdgeInsets.symmetric(horizontal: Breakpoints.small.margin),
    // Use a LayoutBuilder to get the correct constraints
    child: LayoutBuilder(builder: (ctx, constr) => _buildSelectionArea(ctx, constr, settings)),
  );

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
    final page = _buildTextWithOverflowDetection(context, constraints, settings);
    return SelectableText.rich(
      page.text,
      strutStyle: _readerStrut,
      textScaler: MediaQuery.textScalerOf(context),
      textDirection: TextDirection.ltr,
      cursorWidth: _readerCursorWidth,
      onSelectionChanged: (selection, _) => _preloadSelectionLookups(page, selection),
      contextMenuBuilder: (_, state) => _buildContextMenu(state, page),
    );
  }

  /// Preloads morphology results for a fully selected word.
  void _preloadSelectionLookups(PageSegments page, TextSelection selection) {
    if (selection.isValid) {
      log.info(() => 'user selected text "${selection.textInside(page.text.toPlainText())}"');
    }
    final segment = page.selectedSegment(selection);
    final lookupForm = segment?.lookupForm;
    log.info(() => segment == null ? 'no word selected' : '$segment selected');
    if (segment != null && lookupForm != null && page.showMacrons) {
      _lookUpCandidateReadings(segment).ignore();
    } else if (segment != null && lookupForm != null) {
      _lookUpAllReadings(segment, lookupForm).ignore();
    }
  }

  Widget _buildContextMenu(EditableTextState state, PageSegments page) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: state.widget.controller,
        builder: (_, value, _) => Consumer(
          builder: (_, menuRef, _) => _buildToolbarForSelection(state, value, menuRef, page),
        ),
      );

  Widget _buildToolbarForSelection(
    EditableTextState state,
    TextEditingValue value,
    WidgetRef menuRef,
    PageSegments page,
  ) {
    final lookups = _watchWordLookups(menuRef, page, page.selectedSegment(value.selection));
    return lookups != null && lookups.macronComparison.pending
        ? const SizedBox.shrink()
        : AdaptiveTextSelectionToolbar.buttonItems(
            anchors: state.contextMenuAnchors,
            buttonItems: _arrangeButtonItems(
              state.contextMenuButtonItems,
              lookups == null
                  ? const []
                  : _buildWordLookupButtons(
                      state.contextMenuAnchors.primaryAnchor,
                      value.selection.textInside(value.text).trim(),
                      lookups,
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

  /// Lookup data for [segment], or `null` if [segment] is missing or has no lookup form.
  _WordLookups? _watchWordLookups(
    WidgetRef menuRef,
    PageSegments page,
    WorkContentsSegment? segment,
  ) {
    final lookupForm = segment?.lookupForm;
    return segment == null || lookupForm == null
        ? null
        : _watchLookupsOf(menuRef, page, segment, lookupForm);
  }

  /// Lookups for [segment], based on [page]'s macron setting.
  ///
  /// `lookUpReadings` returns all readings when macrons are hidden. Otherwise,
  /// it returns candidate readings, matching the displayed spelling if it has macrons.
  _WordLookups _watchLookupsOf(
    WidgetRef menuRef,
    PageSegments page,
    WorkContentsSegment segment,
    String lookupForm,
  ) {
    final shown = page.shownText(segment);
    final isShownWithMacrons = shown != segment.word;
    Future<_WordReadings> lookUpCandidateReadings() => _lookUpCandidateReadings(segment);
    return (
      wiktionaryPages: wiktionaryPagesOf(segment, widget.segments),
      lookUpReadings: switch ((page.showMacrons, isShownWithMacrons)) {
        (false, _) => () => _lookUpAllReadings(segment, lookupForm),
        (true, false) => lookUpCandidateReadings,
        (true, true) => () async => _readingsMacronizedAs(await lookUpCandidateReadings(), shown),
      },
      lookUpCandidateReadings: lookUpCandidateReadings,
      macronComparison: isShownWithMacrons
          ? _compareWithMacrons(_watchCandidateReadings(menuRef, segment), shown)
          : (pending: false, showIgnoringMacrons: false),
    );
  }

  /// Compares the candidate readings with [macronized].
  ///
  /// `pending` is true while loading without an error.
  /// `showIgnoringMacrons` is true if a candidate has a different spelling or the lookup failed.
  ({bool pending, bool showIgnoringMacrons}) _compareWithMacrons(
    AsyncValue<_WordReadings> readings,
    String macronized,
  ) => (
    pending: readings.isLoading && !readings.hasError,
    showIgnoringMacrons:
        readings.hasError || _ignoringMacronsFindsMore(readings.valueOrNull, macronized),
  );

  bool _ignoringMacronsFindsMore(_WordReadings? readings, String macronized) =>
      readings != null &&
      readings.analyses.any((analysis) => !_isMacronizedAs(analysis, macronized));

  /// Returns only the analyses matching [macronized], along with their keys.
  _WordReadings _readingsMacronizedAs(_WordReadings readings, String macronized) {
    final analyses = readings.analyses
        .where((analysis) => _isMacronizedAs(analysis, macronized))
        .toList();
    return (
      keys: AnalysisKeys(
        analyses.map(
          (analysis) => AnalysisKey(form: analysis.form, item: analysis.item, cnt: analysis.cnt),
        ),
      ),
      analyses: EnrichedAnalyses(analyses),
    );
  }

  bool _isMacronizedAs(EnrichedAnalysis analysis, String macronized) =>
      isMacronizedAs(macronized, form: analysis.form, macronizedForm: analysis.macronizedForm);

  AsyncValue<_WordReadings> _watchCandidateReadings(
    WidgetRef menuRef,
    WorkContentsSegment segment,
  ) => _watchReadings(
    menuRef,
    menuRef.watch(lookupFormCandidateAnalysisKeysProvider(segment.workId, segment.idx)),
  );

  AsyncValue<_WordReadings> _watchReadings(WidgetRef menuRef, AsyncValue<AnalysisKeys> keys) =>
      keys.when(
        data: (found) => _watchAnalysesOf(menuRef, found),
        error: AsyncError.new,
        loading: AsyncLoading.new,
      );

  AsyncValue<_WordReadings> _watchAnalysesOf(WidgetRef menuRef, AnalysisKeys keys) => menuRef
      .watch(enrichedMorphologicalAnalysesProvider(keys))
      .whenData((analyses) => (keys: keys, analyses: analyses));

  Future<_WordReadings> _lookUpCandidateReadings(WorkContentsSegment segment) => _lookUpReadings(
    _providers.readRetryingFailures(
      lookupFormCandidateAnalysisKeysProvider(segment.workId, segment.idx),
    ),
  );

  Future<_WordReadings> _lookUpAllReadings(WorkContentsSegment segment, String lookupForm) =>
      _lookUpReadings(_readAnalysisKeysOf(spellingsToLookUp(lookupForm, segment.properNounState)));

  /// Returns analysis keys for exact matches to the spellings in [forms].
  Future<AnalysisKeys> _readAnalysisKeysOf(Set<String> forms) async {
    final keysByForm = await Future.wait(
      forms.map((form) => _providers.readRetryingFailures(morphologicalAnalysisKeysProvider(form))),
    );
    return AnalysisKeys(keysByForm.expand((keys) => keys));
  }

  Future<_WordReadings> _lookUpReadings(Future<AnalysisKeys> keys) async {
    final found = await keys;
    final analyses = await _providers.readRetryingFailures(
      enrichedMorphologicalAnalysesProvider(found),
    );
    return (keys: found, analyses: analyses);
  }

  ProviderContainer get _providers => ProviderScope.containerOf(context, listen: false);

  List<ContextMenuButtonItem> _buildWordLookupButtons(
    Offset anchor,
    String word,
    _WordLookups lookups,
  ) {
    final compact = _usesCompactLabels(context);
    return [
      _WordDetailsButton(
        word: word,
        lookUp: lookups.lookUpReadings,
        pageContext: context,
        compact: compact,
      ),
      if (lookups.macronComparison.showIgnoringMacrons)
        _WordDetailsButton(
          word: word,
          lookUp: lookups.lookUpCandidateReadings,
          pageContext: context,
          compact: compact,
          ignoreMacrons: true,
        ),
      ..._buildWiktionaryButtons(anchor, lookups.wiktionaryPages, compact: compact),
    ];
  }

  /// Returns a Wiktionary button, a menu for multiple pages, or no buttons for an empty set.
  List<ContextMenuButtonItem> _buildWiktionaryButtons(
    Offset anchor,
    Set<String> wiktionaryPages, {
    required bool compact,
  }) => switch (wiktionaryPages.toList()) {
    [] => const [],
    [final page] => [_WiktionaryButton(page: page, pageContext: context, compact: compact)],
    final pages => [
      LookupMenuButton(
        label: _WiktionaryButton.labelFor(compact: compact),
        anchor: anchor,
        pageContext: context,
        choices: pages
            .map((page) => (label: page, open: () => _WiktionaryButton.open(page, context)))
            .toList(),
      ),
    ],
  };

  void _rebuildOnScreenSizeChange(BuildContext context) {
    MediaQuery.of(context);
  }

  PageSegments _buildTextWithOverflowDetection(
    BuildContext context,
    BoxConstraints constraints,
    ReaderSettings settings,
  ) {
    final revision = ++_layoutRevision;
    final isMeasurable =
        widget.segments.isNotEmpty && constraints.maxWidth > 0 && constraints.maxHeight > 0;
    return isMeasurable
        ? _layOutPage(context, constraints, settings, revision)
        : const PageSegments.empty();
  }

  /// Fits as much of the buffer as the page holds and reports the range once
  /// it's on screen
  PageSegments _layOutPage(
    BuildContext context,
    BoxConstraints constraints,
    ReaderSettings settings,
    int revision,
  ) {
    final segments = widget.segments;
    final allSpans = _TextRenderer(
      Theme.of(context),
      segments,
      settings,
      widget.highlights,
      widget.frequencies?.bandsFor(
        commonPercent: settings.commonWordsPercent,
        uncommonPercent: settings.uncommonWordsPercent,
        markCommon: settings.markCommonWords,
        markUncommon: settings.markUncommonWords,
      ),
    ).createSpans();
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
    return PageSegments(
      _TextRenderer.pageSpans(allSpans, visible.first, visible.last),
      segments.sublist(visible.first, visible.last + 1),
      showMacrons: settings.showMacrons,
    );
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
