import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../library/catalog_api.dart';
import '../settings/frequency_filter_settings_api.dart';
import 'frequency_offset_api.dart';
import 'library_selection_api.dart';
import 'resolved_freq_morph_form_api.dart' show WorkIds;
import 'word_frequency_api.dart';

part 'active_frequency_filter_api.g.dart';

//infrastructure

/// The [FrequencyFilter] the report is currently showing.
///
/// Builds the word frequency filter from the library selection, settings,
/// and current page offset.
///
/// An empty selection includes all works in the library.
@riverpod
Future<FrequencyFilter> activeFrequencyFilter(Ref ref) async {
  log.info(() => '@riverpod');
  final selection = ref.watch(librarySelectionNotifierProvider);
  final offset = ref.watch(frequencyOffsetNotifierProvider);
  final catalog = await ref.watch(libraryCatalogProvider.future);
  final settings = await ref.watch(frequencyFilterSettingsNotifierProvider.future);
  // Sort and deduplicate work IDs so selection order does not affect filter equality
  final workIds = (selection.isEmpty ? catalog.allWorkIds : selection.allWorkIds).toSet().toList()
    ..sort();
  return FrequencyFilter(
    workIds: WorkIds(workIds),
    pageSize: settings.pageSize,
    offset: offset,
    ascending: settings.ascending,
    groupByLemma: settings.groupByLemma,
    showMacrons: settings.showMacrons,
  );
}
