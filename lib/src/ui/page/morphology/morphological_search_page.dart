import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../logger.dart';
import '../../../component/morph_analysis/enriched_morph_search_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../router/config.dart';
import '../../widget/keyboard_closing_search_bar.dart';
import '../../widget/lemma_text.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/search_results.dart';
import '../settings/settings_shell_page.dart' show SettingsTab;
import 'common.dart';

/// Searches forms and shows the analyses of the one picked
class MorphologicalSearchPage extends ConsumerStatefulWidget {
  const MorphologicalSearchPage({
    super.key,
    required this.keys,
  });

  /// The analyses under the search bar. Null for a clean search
  final AnalysisKeys? keys;

  @override
  ConsumerState<MorphologicalSearchPage> createState() => _MorphologyPageState();
  //
}

class _MorphologyPageState extends ConsumerState<MorphologicalSearchPage> {
  //
  final SearchController _searchController = SearchController();

  @override
  void didUpdateWidget(MorphologicalSearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.keys == null && oldWidget.keys != null) {
      _searchController.clear();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Called when a search result is selected
  void _handleResultSelected(EnrichedResults results) {
    final keys = AnalysisKeys(
      results.map((r) => AnalysisKey(form: r.form, item: r.item, cnt: r.cnt)),
    );
    log.info(() => 'selecting $keys');
    _searchController.closeView(_searchController.text);
    MorphologicalSearchRoute(keys: keys.toJson()).go(context);
  }

  @override
  Widget build(context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final colorTheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final dictRefStyle = textTheme.bodyMedium!.copyWith(color: colorTheme.primary);
    return SafeBodyScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              key: ValueKey('search-anchor-${size.width}-$size.height}'),
              child: KeyboardClosingSearchBar(
                searchController: _searchController,
                barHintText: 'Search forms (e.g., adv*, vid?s, "sum")...',
                isFullScreen: true,
                barTrailing: [
                  if (widget.keys != null)
                    IconButton(
                      tooltip: 'Clear the search',
                      icon: const Icon(Icons.close),
                      onPressed: () => const MorphologicalSearchRoute().go(context),
                    ),
                ],
                viewBuilder: searchResultsView,
                suggestionsBuilder: (_, controller) => [
                  SearchResults(
                    provider: enrichedMorphologicalSearchProvider(controller.text.trim()),
                    tiles: (found) => found.groupListsBy(consolidatedForm()).entries.map((group) {
                      final result = group.key;
                      final details = [
                        result.pos,
                        result.add,
                      ].where((e) => e != null).join(' • ');
                      return ListTile(
                        title: Text.rich(
                          TextSpan(
                            text: '${result.title} ',
                            children: [
                              TextSpan(text: lemmaText(result.dictRef), style: dictRefStyle),
                            ],
                          ),
                        ),
                        subtitle: Text(details),
                        onTap: () => _handleResultSelected(EnrichedResults(group.value)),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async =>
                const SettingsRoute(tab: SettingsTab.morphAnalysis).push<void>(context),
          ),
        ],
      ),
      body: switch (widget.keys) {
        final keys? => MorphologicalDataView(keys: keys),
        null => const _SearchHelp(),
      },
    );
  }

  //
}

class _SearchHelp extends StatelessWidget {
  const _SearchHelp();

  static const List<(String, String)> _examples = [
    ('adv*', 'forms starting with adv: * (or %) stands for any letters'),
    ('vid?s', 'vides: ? (or _) stands for one letter'),
    ('"sum"', 'exactly this form'),
    ('rosā', 'typed macrons must match; without them, macrons are ignored'),
  ];

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Search a form to see how it can be analyzed',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              ..._examples.map(
                (example) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(example.$1, style: theme.textTheme.bodyLarge),
                      ),
                      Expanded(child: Text(example.$2, style: muted)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
}
