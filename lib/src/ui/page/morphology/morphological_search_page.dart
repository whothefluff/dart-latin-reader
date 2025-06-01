import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_search_api.dart';
import 'package:latin_reader/src/ui/page/morphology/common.dart';
import 'package:latin_reader/src/ui/router/config.dart';
import 'package:latin_reader/src/ui/widget/show_error.dart';
import 'package:latin_reader/src/ui/widget/show_loading.dart';

class MorphologicalSearchPage extends ConsumerStatefulWidget {
  const MorphologicalSearchPage({
    super.key,
  });

  @override
  ConsumerState<MorphologicalSearchPage> createState() =>
      _MorphologyPageState();
//
}

class _MorphologyPageState extends ConsumerState<MorphologicalSearchPage> {
//
  final SearchController _searchController = SearchController();
  Results? _selectedResults;
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Called when a search result is selected
  Future<void> _handleResultSelected(Results results) async {
    setState(() {
      _selectedResults = results;
      _searchController.closeView(_searchController.text);
    });
    log.info(() => 'MorphologyPage - selecting $_selectedResults');
    final k = AnalysisKeys(results.map((r) => AnalysisKey(
          form: r.form,
          item: r.item,
          cnt: r.cnt,
        )));
    await MorphologicalDataRoute(k.toJson()).push<void>(context);
  }

  @override
  Widget build(context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final dictRefStyle =
        theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              key: ValueKey('search-anchor-${size.width}-$size.height}'),
              child: SearchAnchor.bar(
                searchController: _searchController,
                barHintText:
                    'Search specific forms (e.g., "adv", "am*", "sum")...',
                isFullScreen: true,
                suggestionsBuilder: (context, controller) async {
                  final searchTerm = controller.text.trim();
                  if (searchTerm.isEmpty) {
                    return [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Enter a Latin form to search'),
                        ),
                      ),
                    ];
                  }
                  // Set searching state and trigger rebuild
                  if (!_isSearching) {
                    setState(() => _isSearching = true);
                  }
                  log.info(() => 'MorphologyPage - searching for: $searchTerm');
                  try {
                    final results = await ref
                        .watch(morphologicalSearchProvider(searchTerm).future);
                    // Reset searching state
                    if (_isSearching) {
                      setState(() => _isSearching = false);
                    }
                    if (results.isEmpty) {
                      return [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('No results found'),
                          ),
                        ),
                      ];
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
                            title: Text.rich(TextSpan(
                              text: '${result.title} ',
                              children: [
                                TextSpan(
                                  text: result.dictRef,
                                  style: dictRefStyle,
                                )
                              ],
                            )),
                            subtitle: Text(details),
                            onTap: () => _handleResultSelected(
                              Results(groupedRes[result]!),
                            ),
                          );
                        },
                      ),
                    ];
                  } on Exception catch (e, stack) {
                    return [
                      showError(ref, morphologicalSearchProvider(searchTerm))(
                        e,
                        stack,
                      ),
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
              onPressed: () async => const SettingsRoute().push<void>(context)),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching) showLoading(),
          // Content area (shows selected result or placeholder)
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Search for a Latin form and select a result',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
//
}
