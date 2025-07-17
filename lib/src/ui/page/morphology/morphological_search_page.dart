import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../logger.dart';
import '../../../component/morph_analysis/enriched_morph_search_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../router/config.dart';
import '../../widget/show_error.dart';
import 'common.dart';

/// This page has a weird state, so much so that hot reload doesn't even work
class MorphologicalSearchPage extends ConsumerStatefulWidget {
  const MorphologicalSearchPage({
    super.key,
  });

  @override
  ConsumerState<MorphologicalSearchPage> createState() => _MorphologyPageState();
  //
}

class _MorphologyPageState extends ConsumerState<MorphologicalSearchPage> {
  //
  AnalysisKeys _selectedKeys = AnalysisKeys(const []);
  final SearchController _searchController = SearchController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Called when a search result is selected
  Future<void> _handleResultSelected(EnrichedResults results) async {
    setState(() {
      _selectedKeys = AnalysisKeys(
        results.map((r) => AnalysisKey(form: r.form, item: r.item, cnt: r.cnt)),
      );
      _searchController.closeView(_searchController.text);
    });
    log.info(() => 'MorphologyPage - selecting $_selectedKeys');
  }

  @override
  Widget build(context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final colorTheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final dictRefStyle = textTheme.bodyMedium!.copyWith(color: colorTheme.primary);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              key: ValueKey('search-anchor-${size.width}-$size.height}'),
              child: SearchAnchor.bar(
                searchController: _searchController,
                barHintText: 'Search forms (e.g., adv*, vid?s, "sum")...',
                isFullScreen: true,
                suggestionsBuilder: (context, controller) async {
                  final searchTerm = controller.text.trim();
                  // Set searching state and trigger rebuild
                  if (!_isSearching) {
                    setState(() => _isSearching = true);
                  }
                  log.info(() => 'MorphologyPage - searching for: $searchTerm');
                  try {
                    final results = await ref.watch(
                      enrichedMorphologicalSearchProvider(searchTerm).future,
                    );
                    // Reset searching state
                    if (_isSearching) {
                      setState(() => _isSearching = false);
                    }
                    // Appealing sort not easy since the results are primarily ordered by match and key
                    final groupedRes = results.groupListsBy(consolidatedForm());
                    return [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: groupedRes.length,
                        itemBuilder: (context, index) {
                          final result = groupedRes.keys.toList()[index];
                          final details = [
                            result.pos,
                            result.add,
                          ].where((e) => e != null).join(' • ');
                          return ListTile(
                            title: Text.rich(
                              TextSpan(
                                text: '${result.title} ',
                                children: [TextSpan(text: result.dictRef, style: dictRefStyle)],
                              ),
                            ),
                            subtitle: Text(details),
                            onTap: () => _handleResultSelected(
                              EnrichedResults(groupedRes[result]!),
                            ),
                          );
                        },
                      ),
                    ];
                  } on Exception catch (e, stack) {
                    return [
                      showError(ref, enrichedMorphologicalSearchProvider(searchTerm))(e, stack),
                    ];
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async => const SettingsRoute().push<void>(context),
          ),
        ],
      ),
      body: Column(
        children: [Expanded(child: MorphologicalDataView(keys: _selectedKeys))],
      ),
    );
  }

  //
}
