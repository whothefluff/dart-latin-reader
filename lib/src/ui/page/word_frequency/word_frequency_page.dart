import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../logger.dart';
import '../../../component/dictionary/lewis_and_short_api.dart';
import '../../../component/dictionary/lewis_and_short_basic_info_api.dart';
import '../../../component/library/catalog_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../../component/settings/frequency_settings_api.dart';
import '../../../component/word_frequency/active_frequency_filter_api.dart';
import '../../../component/word_frequency/enriched_word_frequency_api.dart';
import '../../../component/word_frequency/frequency_offset_api.dart';
import '../../../component/word_frequency/library_selection_api.dart';
import '../../../component/word_frequency/resolved_freq_morph_form_api.dart';
import '../../../component/word_frequency/word_frequency_api.dart';
import '../../router/config.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'library_filter_dialog.dart';

class WordFrequencyPage extends ConsumerWidget {
  const WordFrequencyPage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final filterAsync = ref.watch(activeFrequencyFilterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Word Frequency')),
      body: filterAsync.when(
        skipLoadingOnReload: true, // keep filter controls visible while recomputing
        loading: showLoading,
        error: showError(ref, activeFrequencyFilterProvider),
        data: (filter) => _WordFrequencyBody(filter: filter),
      ),
    );
  }

  //
}

class _WordFrequencyBody extends ConsumerWidget {
  const _WordFrequencyBody({
    required this.filter,
  });

  final FrequencyFilter filter;

  @override
  Widget build(context, ref) {
    final reportAsync = ref.watch(enrichedFrequencyReportProvider(filter));
    return Column(
      children: [
        _FilterBar(filter: filter),
        Expanded(
          child: reportAsync.when(
            data: (report) => _ReportView(filter: filter, report: report),
            loading: showLoading,
            error: showError(ref, enrichedFrequencyReportProvider(filter)),
          ),
        ),
      ],
    );
  }

  //
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar({
    required this.filter,
  });

  final FrequencyFilter filter;
  static const List<int> _presetPageSizes = [10, 100, 1000];

  @override
  Widget build(context, ref) {
    final selection = ref.watch(librarySelectionNotifierProvider);
    final settings =
        ref.watch(frequencySettingsNotifierProvider).valueOrNull ?? const FrequencySettings();
    final notifier = ref.read(frequencySettingsNotifierProvider.notifier);
    final catalog = ref.watch(libraryCatalogProvider).valueOrNull;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.filter_alt_outlined),
                  label: Text(_selectionSummary(selection)),
                  onPressed: catalog == null
                      ? null
                      : () => _pickWorks(context, ref, catalog, selection),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.restart_alt),
                tooltip: 'Reset filters',
                onPressed: () async {
                  ref
                      .read(librarySelectionNotifierProvider.notifier)
                      .updateSelection(const LibrarySelection.empty());
                  await notifier.updateSettings(const FrequencySettings());
                },
              ),
            ],
          ),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DropdownButton<int>(
                value: _presetPageSizes.contains(settings.pageSize) ? settings.pageSize : null,
                hint: Text('${settings.pageSize} per page'),
                items: _presetPageSizes
                    .map(
                      (pageSize) => DropdownMenuItem(
                        value: pageSize,
                        child: Text('$pageSize per page'),
                      ),
                    )
                    .toList(),
                onChanged: (v) async {
                  if (v != null) {
                    await notifier.updateSettings(settings.copyWith(pageSize: v));
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Custom page size',
                onPressed: () => _promptCustomPageSize(context, notifier, settings),
              ),
              IconButton(
                icon: Icon(settings.ascending ? Icons.arrow_upward : Icons.arrow_downward),
                tooltip: settings.ascending ? 'Ascending' : 'Descending',
                onPressed: () =>
                    notifier.updateSettings(settings.copyWith(ascending: !settings.ascending)),
              ),
              ChoiceChip(
                label: const Text('Group by Lemma'),
                selected: settings.groupByLemma,
                onSelected: (v) => notifier.updateSettings(settings.copyWith(groupByLemma: v)),
              ),
              ChoiceChip(
                label: const Text('Macrons'),
                selected: settings.showMacrons,
                onSelected: settings.groupByLemma
                    ? null
                    : (v) => notifier.updateSettings(settings.copyWith(showMacrons: v)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Opens the library filter dialog and applies the selection returned by Done.
  Future<void> _pickWorks(
    BuildContext context,
    WidgetRef ref,
    LibraryCatalog catalog,
    LibrarySelection current,
  ) async {
    final picked = await showDialog<LibrarySelection>(
      context: context,
      builder: (context) => LibraryFilterDialog(catalog: catalog, selection: current),
    );
    if (picked != null) {
      ref.read(librarySelectionNotifierProvider.notifier).updateSelection(picked);
    }
  }

  Future<void> _promptCustomPageSize(
    BuildContext context,
    FrequencySettingsNotifier notifier,
    FrequencySettings settings,
  ) async {
    final controller = TextEditingController(text: '${settings.pageSize}');
    try {
      final value = await showDialog<int>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Rows per page'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () => Navigator.pop(context, int.tryParse(controller.text)),
              child: const Text('Apply'),
            ),
          ],
        ),
      );
      if (value != null && value > 0) {
        await notifier.updateSettings(settings.copyWith(pageSize: value));
      }
    } finally {
      controller.dispose();
    }
  }

  String _selectionSummary(LibrarySelection selection) => selection.isEmpty
      ? 'All authors & works'
      : '${selection.sourceCount} source${selection.sourceCount == 1 ? '' : 's'}, '
            '${selection.allWorkIds.length} work${selection.allWorkIds.length == 1 ? '' : 's'}';
  //
}

class _ReportView extends ConsumerWidget {
  const _ReportView({
    required this.filter,
    required this.report,
  });

  final FrequencyFilter filter;
  final EnrichedFrequencyReport report;

  @override
  Widget build(context, ref) {
    final offsetNotifier = ref.read(frequencyOffsetNotifierProvider.notifier);
    final total = filter.groupByLemma ? report.totalLemmas : report.totalForms;
    final coverage = report.base.coverage;
    final hasNextPage = filter.offset + report.rows.length < total;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              if (!filter.groupByLemma)
                Text('Showing ${report.rows.length} of ${report.totalForms} unique forms'),
              Text('Selected works: ${report.totalLemmas} possible lemmas'),
              Text(
                '${coverage.totalTokens} counted units: '
                '${coverage.noCandidateTokens} with no candidate lemma, '
                '${coverage.singleCandidateTokens} with one, '
                '${coverage.multipleCandidateTokens} with several.',
              ),
              if (filter.groupByLemma)
                const Text(
                  'Counts are possible occurrences: the same occurrence can count '
                  'towards more than one lemma. The first number counts the occurrences where '
                  'this was the only candidate in the available analyses.',
                ),
            ],
          ),
        ),
        Expanded(
          child: report.rows.isEmpty
              ? const Center(child: Text('No results for this filter.'))
              : ListView.builder(
                  itemCount: report.rows.length,
                  itemBuilder: (context, index) {
                    final row = report.rows[index];
                    final rank = report.offset + index + 1;
                    final freq = report.relativeFrequency(row.occurrences);
                    return ListTile(
                      leading: SizedBox(
                        width: 48,
                        child: Text(
                          '#$rank',
                          style: TextTheme.of(
                            context,
                          ).labelLarge?.copyWith(color: ColorScheme.of(context).primary),
                        ),
                      ),
                      title: Text(row.displayForm),
                      subtitle: switch (row.base) {
                        LemmaFrequencyRow(
                          :final singleCandidateOccurrences,
                          :final possibleOccurrences,
                        ) =>
                          Text(
                            '$singleCandidateOccurrences single-candidate · $possibleOccurrences possible',
                          ),
                        FormFrequencyRow() =>
                          row.lemmaDisplay == null ? null : Text(row.lemmaDisplay!),
                      },
                      trailing: Text(
                        '${freq.toStringAsFixed(1)}‰${filter.groupByLemma ? '' : '  (${row.occurrences})'}',
                        style: TextTheme.of(context).bodySmall,
                      ),
                      onTap: () => _onRowTapped(context, ref, filter, row),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: filter.offset > 0 ? () => _loadPrevPage(offsetNotifier) : null,
              ),
              Text('${filter.offset + 1}–${filter.offset + report.rows.length} of $total'),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: hasNextPage ? () => _loadNextPage(offsetNotifier) : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _loadNextPage(FrequencyOffsetNotifier notifier) {
    // dart format off
    log.info(() => 'attempting to navigate to next frequency page (limit: ${filter.pageSize}, offset: ${filter.offset})');
    // dart format on
    notifier.next(filter.pageSize);
  }

  void _loadPrevPage(FrequencyOffsetNotifier notifier) {
    // dart format off
    log.info(() => 'attempting to navigate to previous frequency page (limit: ${filter.pageSize}, offset: ${filter.offset})');
    // dart format on
    notifier.prev(filter.pageSize);
  }

  //
}

enum _RowDestination { morphology, dictionary }

Future<void> _onRowTapped(
  BuildContext context,
  WidgetRef ref,
  FrequencyFilter filter,
  EnrichedFrequencyRow row,
) async {
  // The lemma's dictionary form may have no stored morphological analysis
  if (filter.groupByLemma) {
    // We can't show the choice for the morphology page because we
    // cannot guarantee that we have the analysis for the form that
    // matches the lemma
    // TODO(whothefluff): create aware bottom sheet instead of circuit-breaking here
    await _goToDictionaryForLemma(context, ref, row.displayForm);
  } else {
    final choice = await showModalBottomSheet<_RowDestination>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.auto_stories_outlined),
              title: const Text('Morphology'),
              onTap: () => Navigator.pop(context, _RowDestination.morphology),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: const Text('Dictionary'),
              onTap: () => Navigator.pop(context, _RowDestination.dictionary),
            ),
          ],
        ),
      ),
    );
    if (choice != null && context.mounted) {
      switch (choice) {
        case _RowDestination.morphology:
          //if (filter.groupByLemma) {
          //await _goToMorphologyForLemma(context, ref, filter, row.displayForm);
          //} else {
          await _goToMorphologyForForm(context, ref, filter, row);
        //}
        case _RowDestination.dictionary:
          //if (filter.groupByLemma) {
          //await _goToDictionaryForLemma(context, ref, row.displayForm);
          //} else {
          await _goToDictionaryForForm(context, ref, row);
        //}
      }
    }
  }
}

Future<void> _goToMorphologyForForm(
  BuildContext context,
  WidgetRef ref,
  FrequencyFilter filter,
  EnrichedFrequencyRow row,
) async {
  final candidates = await ref.read(
    resolvedFreqMorphFormsProvider(
      filter.workIds,
      row.lookupForm,
      macronForm: filter.showMacrons ? row.displayForm : null,
    ).future,
  );
  if (context.mounted) {
    if (candidates.isEmpty) {
      _notFound(context, message: 'No morphology is available for this form.');
    } else {
      final lemmas = candidates.map((c) => c.dictionaryRef).toSet().toList()..sort();
      final chosen = await _pickLemma(context, lemmas);
      if (chosen != null && context.mounted) {
        /// Opens the morphological analyses identified by the supplied candidates
        await _openFrequencyMorphology(
          context,
          ref,
          candidates.where((c) => c.dictionaryRef == chosen),
        );
      }
    }
  }
}

/*
I might change my mind and generate the lemma form analysis at the same time,
so not deleted

Future<void> _goToMorphologyForLemma(
  BuildContext context,
  WidgetRef ref,
  FrequencyFilter filter,
  String dictionaryRef,
) async {
  final candidates = await ref.read(
    resolvedFreqMorphFormsOfLemmaProvider(WorkIds(filter.workIds), dictionaryRef).future,
  );
  if (context.mounted) {
    // Lemmas are counted under every form they appear as, so we need this variable
    final citation = dictionaryRef.replaceAll(RegExp(r'\d+$'), '');
    final own = candidates.where((c) => c.morphForm.toLowerCase() == citation.toLowerCase());
    if (own.isEmpty) {
      _notFound(context, message: 'No morphology is available for $citation.');
    } else {
      await _openFrequencyMorphology(context, ref, own);
    }
  }
} */

// A tap must resolve to the exact (form, item) identities the bridge already
// selected — not a fresh LIKE search, which can surface other case variants
// the row never actually counted.
Future<void> _openFrequencyMorphology(
  BuildContext context,
  WidgetRef ref,
  Iterable<FrequencyMorphCandidate> candidates,
) async {
  final itemsByForm = groupBy(
    candidates,
    (c) => c.morphForm,
  ).map((form, matches) => MapEntry(form, matches.map((c) => c.morphItem).toSet()));
  final batches = await Future.wait(
    // LIKE can return other spellings, keep only the exact form and item pairs of this freq. row
    itemsByForm.keys.map(
      (form) async => (await ref.read(
        morphologicalAnalysisKeysProvider(form).future,
      )).where((k) => k.form == form && itemsByForm[form]!.contains(k.item)),
    ),
  );
  if (context.mounted) {
    final keys = AnalysisKeys(batches.expand((batch) => batch));
    if (keys.isEmpty) {
      _notFound(context, message: 'No morphology is available for these analyses.');
    } else {
      await MorphologicalDataRoute(keys.toJson()).push<void>(context);
    }
  }
}

Future<void> _goToDictionaryForForm(
  BuildContext context,
  WidgetRef ref,
  EnrichedFrequencyRow row,
) async {
  final refs = row.possibleLemmas ?? const <String>[];
  if (refs.isEmpty) {
    _notFound(context);
  } else {
    final resolved = await ref.read(lnsBasicInfoProvider(PossibleLemmas(refs.toSet())).future);
    if (context.mounted) {
      final lemmas = resolved.values.map((e) => e.lemma).toSet().toList()..sort();
      if (lemmas.isEmpty) {
        _notFound(context);
      } else {
        final lns = await ref.read(lewisAndShortDictionaryProvider.future);
        final chosen = context.mounted ? await _pickLemma(context, lemmas) : null;
        if (chosen != null && context.mounted) {
          await DictionaryEntryRoute(lns.id, chosen).push<void>(context);
        }
      }
    }
  }
}

Future<String?> _pickLemma(BuildContext context, List<String> lemmas) => lemmas.length == 1
    ? Future.value(lemmas.first)
    : showModalBottomSheet<String>(
        context: context,
        builder: (context) => SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: lemmas
                .map((l) => ListTile(title: Text(l), onTap: () => Navigator.pop(context, l)))
                .toList(),
          ),
        ),
      );

Future<void> _goToDictionaryForLemma(
  BuildContext context,
  WidgetRef ref,
  String dictionaryRef,
) async {
  final resolved = await ref.read(lnsBasicInfoProvider(PossibleLemmas([dictionaryRef])).future);
  if (context.mounted) {
    final entry = resolved[dictionaryRef];
    if (entry == null) {
      _notFound(context);
    } else {
      final lns = await ref.read(lewisAndShortDictionaryProvider.future);
      if (context.mounted) {
        await DictionaryEntryRoute(lns.id, entry.lemma).push<void>(context);
      }
    }
  }
}

void _notFound(
  BuildContext context, {
  String message = 'No dictionary entry found for this form.',
}) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
