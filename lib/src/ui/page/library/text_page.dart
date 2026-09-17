import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../logger.dart';
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

/// Line terminator that will be stable across all platforms even after rendering
const _lineTerminator = '\n';
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
  static const _pageSize = 250;
  late int _lastIndex; // Highest token index, punctuation included
  var _currentFirstVisibleIndex = 0;
  var _currentLastVisibleIndex = 0;
  var _fromIndex = 0;
  int _toIndex = _pageSize;
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
      body: segmentsProvider.when(
        data: _buildResponsiveContent,
        loading: showLoading,
        error: showError(ref, workContentsProvider(widget.workId, _fromIndex, _toIndex)),
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
    if (_currentLastVisibleIndex < _lastIndex) {
      setState(() {
        _pageFlow = _PageFlow.next;
        _fromIndex = _currentLastVisibleIndex + 1;
        _toIndex = min(_currentLastVisibleIndex + _pageSize, _lastIndex);
      });
    }
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
  static const _empty = '';

  TextTheme get textTheme => theme.textTheme;

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
    final baseTextStyle = TextStyle(
      fontFamily: readerSettings.fontFamily,
      fontSize: readerSettings.fontSize,
      height: readerSettings.lineHeight,
      letterSpacing: readerSettings.letterSpacing,
      wordSpacing: readerSettings.wordSpacing,
    );
    return workSegments.mapIndexed<InlineSpan>((i, segment) {
      final previousSegment = i > 0 ? workSegments[i - 1] : null;
      final prevStyle = previousSegment?.typ;
      final prevNode = previousSegment?.node;
      final currStyle = segment.typ;
      final currNode = segment.node;
      // Merge the theme style for this block (e.g. TITLE vs VERS) with the user settings
      final blockThemeStyle = styles[currStyle] ?? styles['default']!;
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
    bool ignoreMacrons = false,
  }) : super(
         label: ignoreMacrons ? 'See details ignoring macrons' : 'See details for "$word"',
         onPressed: () => _onPressed(
           ignoreMacrons ? _withoutMacrons(word) : word,
           ref,
           context,
         ),
       );

  final WidgetRef ref;
  final BuildContext context;

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
  }) : super(
         label: 'Look up in Wiktionary',
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
        // If we're in the middle of a verse, move forward to the start of the next verse
        if (currentNode == previousNode) {
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
        // If we're in the middle of a verse, move back to the end of the previous verse
        if (currentNode == nextNode) {
          while (lastFittingIndex > 0 && segments[lastFittingIndex - 1].node == currentNode) {
            lastFittingIndex--;
          }
          // Now lastFittingIndex is at the start of the current verse
          // Move it back one more to get to the end of the previous verse
          if (lastFittingIndex > 0) {
            lastFittingIndex--;
          }
        }
      } else if (lastFittingIndex < segments.length &&
          _isPunctuation(segments[lastFittingIndex + 1].word)) {
        lastFittingIndex--;
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
  late _GestureHandler _gestureHandler;

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
    final mainBranchesNames = mainBranches.map((e) => e.id).toList();
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Theme.of(context).bottomSheetTheme.modalBarrierColor ?? Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, animation, secondaryAnimation) => _NavMenuModal(
        scaffoldKey: customAdaptiveScaffoldKey,
        //animation: animation,
        onNavigate: (index) {
          Navigator.of(ctx).pop();
          context.go(mainBranchesNames[index]);
        },
        onSettings: () async {
          Navigator.of(ctx).pop();
          await const SettingsRoute(tab: SettingsTab.library).push<void>(context);
        },
        onBack: () {
          Navigator.of(ctx).pop();
          context.pop();
        },
      ),
    );
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
      onSelectionChanged: (selection, _) => _preloadSelectionLookups(
        selection,
        visibleTextSpan.toPlainText(),
      ),
      contextMenuBuilder: _buildContextMenu,
      // The scrollbar may appear when resizing with the default physics
      scrollPhysics: const NeverScrollableScrollPhysics(),
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
            buttonItems: [
              ...state.contextMenuButtonItems,
              if (selectedWord != null)
                ..._buildWordLookupButtons(
                  readerContext,
                  selectedWord,
                  showIgnoringMacrons: comparison.showIgnoringMacrons,
                ),
            ],
          );
  }

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
  }) => [
    _WordDetailsButton(
      word: word,
      ref: ref,
      context: readerContext,
    ),
    if (showIgnoringMacrons)
      _WordDetailsButton(
        word: word,
        ref: ref,
        context: readerContext,
        ignoreMacrons: true,
      ),
    _WiktionaryButton(
      word: word,
      ref: ref,
      context: readerContext,
    ),
  ];

  void _rebuildOnScreenSizeChange(BuildContext context) {
    MediaQuery.of(context);
  }

  TextSpan _buildTextWithOverflowDetection(
    BuildContext context,
    BoxConstraints constraints,
    ReaderSettings settings,
  ) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final allSpans = _TextRenderer(Theme.of(context), widget.segments, settings).createSpans();
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

class _NavMenuModal extends StatelessWidget {
  const _NavMenuModal({
    required this.scaffoldKey,
    required this.onNavigate,
    required this.onSettings,
    required this.onBack,
  });

  final GlobalKey<CustomAdaptiveScaffoldState> scaffoldKey;
  final ValueChanged<int> onNavigate;
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
    final appBarLeft = isBottom
        ? 0.0
        : (isUnextended ? w.navigationRailWidth : w.extendedNavigationRailWidth);
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
          child: Material(color: Colors.transparent, child: _appBar(context)),
        ),
      ],
    );
  }

  Widget _appBar(BuildContext context) => AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
    elevation: 4,
    leading: BackButton(onPressed: onBack),
    actions: [
      IconButton(icon: const Icon(Icons.settings), onPressed: onSettings),
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
