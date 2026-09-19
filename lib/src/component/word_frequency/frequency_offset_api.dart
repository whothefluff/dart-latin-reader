import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../settings/frequency_filter_settings_api.dart';
import 'library_selection_api.dart';

part 'frequency_offset_api.g.dart';

//infrastructure

/// Tracks the pagination cursor for the word frequency report. Session state only.
///
/// Resets to zero when the frequency settings or library selection change.
@riverpod
class FrequencyOffsetNotifier extends _$FrequencyOffsetNotifier {
  //
  @override
  int build() {
    log.entry<void>();
    ref
      ..watch(frequencyFilterSettingsNotifierProvider)
      ..watch(librarySelectionNotifierProvider);
    return log.exit(r: 0)!;
  }

  void next(int pageSize) => state += pageSize;

  void prev(int pageSize) => state = (state - pageSize).clamp(0, state);
  //
}
