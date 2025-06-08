import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/src/component/dictionary/dictionaries_api.dart';
import 'package:latin_reader/src/component/morph_analysis/enriched_morph_details_api.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/ui/page/morphology/common.dart';
import 'package:latin_reader/src/ui/router/config.dart';
import 'package:latin_reader/src/ui/widget/show_error.dart';
import 'package:latin_reader/src/ui/widget/show_loading.dart';

///While in theory any number of keys would work, the assumption is that all
///share the same form. This is relevant for example when showing the title of
///the page
class MorphologicalDataPage extends ConsumerWidget {
  const MorphologicalDataPage(
    this.keys, {
    super.key,
  });

  final AnalysisKeys keys;

  @override
  Widget build(context, ref) => Scaffold(
        appBar: AppBar(title: Text(keys.first.form)),
        body: _details(ref),
      );

  Widget? _details(WidgetRef ref) =>
      ref.watch(enrichedMorphologicalAnalysesProvider(keys)).when(
            data: (data) => MorphDataSlides(analyses: data),
            error: showError(ref, enrichedMorphologicalAnalysesProvider(keys)),
            loading: showLoading,
          );

//
}

/// There will be one "slide" for each entry in the grouping logic, which is
/// the the same grouping used to display entries when searching for analyses
///
/// That means, when coming from the search page, there will only be one slide.
/// Only when coming from other sources (like the reader), there will be
/// several slides potentially
///
/// On mobile, the user should drag to navigate between slides, while on other
/// platforms the user will use the buttons
class MorphDataSlides extends StatefulWidget {
  const MorphDataSlides({
    super.key,
    required this.analyses,
  });

  final EnrichedAnalyses analyses;

  @override
  State<MorphDataSlides> createState() => _MorphDataSlidesState();
//
}

class _MorphDataSlidesState extends State<MorphDataSlides>
    with TickerProviderStateMixin {
//
  /// Each entry will correspond to a slide
  late final Map<({String? add, String dictRef, String? pos, String title}),
                 List<EnrichedAnalysis>> 
      _groupedAnalyses;
  final _animationDuration = kTabScrollDuration;
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: _currentPageIndex);
    _groupedAnalyses = widget.analyses.groupListsBy(consolidatedForm());
    _tabController = TabController(
      length: _groupedAnalyses.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    if (_groupedAnalyses.isEmpty) {
      return const Center(child: Text('No entries to display'));
    }
    final analysisCards = _groupedAnalyses.values
        .map((value) => MorphEntryCard(analyses: EnrichedAnalyses(value)))
        .toList();
    final cardInsets =
        const EdgeInsets.all(16.0).add(const EdgeInsets.only(bottom: 12));
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          // Each MorphEntryCard is a page
          // Some padding so it doesn't fill the entire screen
          // Wrapped in Align to make the card only as tall as its contents
          children: analysisCards
              .map((c) => Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: cardInsets,
                      child: c,
                    ),
                  ))
              .toList(),
        ),
        PageIndicator(
          tabController: _tabController,
          currentPageIndex: _currentPageIndex,
          onPageChangeRequestedByButton: _onPageChangeRequestedByButton,
          isOnDesktopOrWeb: _isOnDesktopOrWeb(),
          totalPages: analysisCards.length,
        ),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _updateDotsState(currentPageIndex);
  }

  /// Prevents multiple simultaneous animations (i.e. changes of PageView)
  void _onPageChangeRequestedByButton(int index) {
    if (!_isAnimating) {
      _isAnimating = true;
      _updateDotsState(index);
      // Synchronously mark _isAnimating only when the animation finishes
      unawaited(() async {
        try {
          await _pageViewController.animateToPage(
            index,
            duration: _animationDuration,
            curve: Curves.easeInOut,
          );
        } finally {
          _isAnimating = false;
        }
      }());
    }
  }

  void _updateDotsState(int index) {
    if (_currentPageIndex != index) {
      setState(() {
        _currentPageIndex = index;
      });
      _tabController.animateTo(index, duration: _animationDuration);
    }
  }
//
}

bool _isOnDesktopOrWeb() {
  const desktopPlatforms = {
    TargetPlatform.macOS,
    TargetPlatform.linux,
    TargetPlatform.windows,
  };
  return kIsWeb || desktopPlatforms.contains(defaultTargetPlatform);
}

/// One will be used inside each PageView element
class MorphEntryCard extends ConsumerWidget {
  const MorphEntryCard({
    super.key,
    required this.analyses,
    this.cardContentAlignment = CrossAxisAlignment.start,
  });

  final EnrichedAnalyses analyses;
  final CrossAxisAlignment cardContentAlignment;

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final groupedData = _GroupedAnalysisData(analyses);
    return Card(
      child: SingleChildScrollView(
        // add some padding so that the contents don't touch the borders
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: cardContentAlignment,
          children: [
            _header(context, theme, ref),
            const SizedBox(height: 10),
            const Divider(thickness: 3),
            _commonSection(theme, groupedData.commonProperties),
            _differencesSection(theme, groupedData),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context, ThemeData theme, WidgetRef ref) {
    final themeTextStyle = theme.textTheme.titleMedium!;
    final themeColor = theme.colorScheme;
    final textStyle = themeTextStyle.copyWith(color: themeColor.tertiary);
    final firstAnalysis = analyses.first;
    return Column(
      crossAxisAlignment: cardContentAlignment,
      children: [
        ..._styledGroup(textStyle, [
          Text(_lexicalForm(firstAnalysis)),
          Text(firstAnalysis.partOfSpeech),
          // TODO(whothefluff): change for null-aware element when possible (next dart v)
          if (firstAnalysis.additional != null) Text(firstAnalysis.additional!),
        ]),
        ...[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: dictButton(themeColor, firstAnalysis, context, ref),
          )
        ]
      ],
    );
  }

  ActionChip dictButton(
    ColorScheme themeColor,
    EnrichedAnalysis firstAnalysis,
    BuildContext context,
    WidgetRef ref,
  ) =>
      ActionChip(
        avatar: Icon(
          Icons.translate,
          color: themeColor.secondary,
        ),
        label: const Text('View in Dictionary'),
        onPressed: () async {
          // We could create a provider specifically for this but this call
          // should remain extremely fast forever
          final dictionaries = await ref.read(dictionariesProvider.future);
          final lns = dictionaries.singleWhere(
            (d) => d.name == 'Lewis & Short',
          );
          if (context.mounted) {
            await DictionaryEntryRoute(
              lns.id,
              firstAnalysis.lnsLemma,
            ).push<void>(context);
          }
        },
      );

  String _lexicalForm(EnrichedAnalysis analysis) =>
      '${analysis.dictionaryRef.replaceAll(RegExp(r'\d'), '')}${analysis.lnsInflection != null ? ', ${analysis.lnsInflection}' : ''}';

  Widget _commonSection(
    ThemeData theme,
    Map<String, String> commonProperties,
  ) =>
      Column(
        crossAxisAlignment: cardContentAlignment,
        children: commonProperties.entries
            .map((e) => _detailRow(theme, e.key, e.value))
            .toList(),
      );

  Widget _differencesSection(
    ThemeData theme,
    _GroupedAnalysisData groupedData,
  ) {
    // TODO(whothefluff): change method usage for null-aware element when possible (next dart v)
    final themeTextStyle = theme.textTheme.titleSmall;
    final themeColor = theme.colorScheme;
    final textStyle = themeTextStyle?.copyWith(color: themeColor.secondary);
    final content = groupedData.differences
        .where((diffMap) => diffMap.isNotEmpty)
        .mapIndexed((index, diffMap) => [
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                child: Text('Reading ${index + 1}', style: textStyle),
              ),
              ...diffMap.entries.map((entry) => _detailRow(
                    theme,
                    entry.key,
                    entry.value,
                  )),
            ])
        // Flatten List<List<Widget>> into List<Widget>
        .expand((widgets) => widgets)
        .toList();
    return Column(
      crossAxisAlignment: cardContentAlignment,
      children: content,
    );
  }

  Widget _detailRow(ThemeData theme, String label, String value) {
    final textTheme = theme.textTheme;
    final themeColor = theme.colorScheme;
    final labelStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: themeColor.primary,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: cardContentAlignment,
        children: [
          Text('$label: ', style: labelStyle),
          Expanded(child: Text(value, style: textTheme.bodyMedium)),
        ],
      ),
    );
  }

  List<Widget> _styledGroup(TextStyle style, List<Widget> childrenToStyle) =>
      childrenToStyle
          .map((child) => DefaultTextStyle.merge(
                style: style,
                child: child,
              ))
          .toList();
//
}

/// Helper class to encapsulate the grouping logic *within* a PageView Card
///
/// Meant to be used inside independent PageView elements
class _GroupedAnalysisData {
  _GroupedAnalysisData(
    this.analyses,
  ) {
    _computeGroupedProperties();
  }

  final EnrichedAnalyses analyses;
  late final Map<String, String> commonProperties;
  late final List<Map<String, String>> differences;

  bool get hasDifferences => differences.any((d) => d.isNotEmpty);

  static final _propertyExtractors = [
    (label: 'Stem', value: (EnrichedAnalysis a) => a.stem),
    (label: 'Suffix', value: (EnrichedAnalysis a) => a.suffix),
    (label: 'Segments', value: (EnrichedAnalysis a) => a.segmentsInfo),
    (label: 'Gender', value: (EnrichedAnalysis a) => a.gender),
    (label: 'Number', value: (EnrichedAnalysis a) => a.number),
    (label: 'Declension', value: (EnrichedAnalysis a) => a.declension),
    (label: 'Case', value: (EnrichedAnalysis a) => a.gramCase),
    (label: 'Form', value: (EnrichedAnalysis a) => a.verbForm),
    (label: 'Tense', value: (EnrichedAnalysis a) => a.tense),
    (label: 'Voice', value: (EnrichedAnalysis a) => a.voice),
    (label: 'Person', value: (EnrichedAnalysis a) => a.person),
  ];

  void _computeGroupedProperties() {
    final common = <String, String>{};
    final differencesList = List<Map<String, String>>.generate(
      analyses.length,
      (_) => {},
    );
    // Iterate over each property label once only
    for (final e in _propertyExtractors) {
      final label = e.label;
      final extractor = e.value;
      final nonNullValues = analyses.map(extractor).whereType<String>().toSet();
      if (nonNullValues.length == 1) {
        common[label] = nonNullValues.first;
      } else if (nonNullValues.length > 1) {
        // Fill the differences for this property
        for (var i = 0; i < analyses.length; i++) {
          final val = extractor(analyses[i]);
          if (val != null && val.isNotEmpty) {
            differencesList[i][label] = val;
          }
        }
      }
    }
    commonProperties = common;
    differences = differencesList;
  }
//
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onPageChangeRequestedByButton,
    required this.isOnDesktopOrWeb,
    required this.totalPages,
  });

  /// To handle page boundaries
  final int totalPages;
  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onPageChangeRequestedByButton;
  final bool isOnDesktopOrWeb;

  @override
  Widget build(context) {
    // Hide if only one page or not on desktop/web
    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }
    final themeColor = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TODO(whothefluff): change method usage for null-aware element when possible (next dart v)
        if (isOnDesktopOrWeb) _goLeftButton(),
        // Use Flexible to allow TabPageSelector to take necessary space but not more
        Flexible(
          child: TabPageSelector(
            controller: tabController,
            selectedColor: themeColor.primary,
          ),
        ),
        if (isOnDesktopOrWeb) _goRightButton(),
      ],
    );
  }

  IconButton _goRightButton() => IconButton(
        tooltip: 'Next',
        onPressed: () {
          // Use totalPages for the upper bound check
          if (currentPageIndex != totalPages - 1) {
            onPageChangeRequestedByButton(currentPageIndex + 1);
          }
        },
        icon: const Icon(Icons.arrow_right_rounded),
      );

  IconButton _goLeftButton() => IconButton(
        tooltip: 'Previous',
        onPressed: () {
          // First page has constant index
          if (currentPageIndex != 0) {
            onPageChangeRequestedByButton(currentPageIndex - 1);
          }
        },
        icon: const Icon(Icons.arrow_left_rounded),
      );
//
}
