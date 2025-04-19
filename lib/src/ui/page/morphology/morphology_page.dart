import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_search_api.dart';
import 'package:latin_reader/src/ui/router/config.dart';
import 'package:latin_reader/src/ui/widget/show_error.dart';
import 'package:latin_reader/src/ui/widget/show_loading.dart';

class MorphologyPage extends ConsumerStatefulWidget {
  const MorphologyPage({
    super.key,
  });

  @override
  ConsumerState<MorphologyPage> createState() => _MorphologyPageState();
//
}

class _MorphologyPageState extends ConsumerState<MorphologyPage> {
//
  final SearchController _searchController = SearchController();
  Result? _selectedResult;
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Called when a search result is selected
  void _handleResultSelected(Result result) {
    setState(() {
      _selectedResult = result;
      _searchController.closeView(_searchController.text);
    });
    log.info(() => 'MorphologyPage - selecting $result');
  }

  @override
  Widget build(BuildContext context) {
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
                    return [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];
                          final title = result.macronizedForm ?? result.form;
                          final details = [
                            result.partOfSpeech,
                            result.additional,
                          ].where((e) => e != null).join(' • ');
                          return ListTile(
                            title: Text.rich(TextSpan(
                              text: '$title ',
                              children: [
                                TextSpan(
                                    text: result.dictionaryRef,
                                    style: dictRefStyle)
                              ],
                            )),
                            subtitle: Text(details),
                            onTap: () => _handleResultSelected(result),
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
            onPressed: () async {
              await const SettingsRoute().push<void>(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching) showLoading(),
          // Content area (shows selected result or placeholder)
          Expanded(
            child: _selectedResult == null
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Search for a Latin form and select a result',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : _buildResultContent(_selectedResult!),
          ),
        ],
      ),
    );
  }

  Widget _buildResultContent(Result result) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.macronizedForm ?? result.form,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Part of Speech: ${result.partOfSpeech}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ...[
              const SizedBox(height: 4),
              Text(
                'Dictionary Reference: ${result.dictionaryRef}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            if (result.additional != null) ...[
              const SizedBox(height: 4),
              Text(
                'Additional: ${result.additional}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '(Content would be refreshed here)',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
//
}
