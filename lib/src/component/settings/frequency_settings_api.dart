import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';
import 'frequency_filter_settings_api.dart' show FrequencyFilterSettingsNotifier;

part 'frequency_settings_api.g.dart';

//infrastructure

/// Deliberately separate from [FrequencyFilterSettingsNotifier]
@Riverpod(keepAlive: true)
class FrequencyViewSettingsNotifier extends _$FrequencyViewSettingsNotifier {
  //
  static const _prefix = 'frequency.';
  static const _showSummary = '${_prefix}showSummary';
  static const _formTapAction = '${_prefix}formTapAction';
  static const _narrowLemmaCoverage = '${_prefix}narrowLemmaCoverage';

  /// Stored by name.
  /// A renamed value falls back to the default.
  static final Map<String, FormTapAction> _formTapActionsByName = FormTapAction.values.asNameMap();

  /// Stored by name.
  /// A renamed value falls back to the default.
  static final Map<String, NarrowLemmaCoverage> _narrowLemmaCoveragesByName = NarrowLemmaCoverage
      .values
      .asNameMap();

  @override
  Future<FrequencySettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedShowSummary = await repo.get(_showSummary, PrefBool.hint);
    final savedFormTapAction = await repo.get(_formTapAction, PrefString.hint);
    final savedNarrowLemmaCoverage = await repo.get(_narrowLemmaCoverage, PrefString.hint);
    final settings = FrequencySettings(
      showSummary: savedShowSummary?.value ?? FrequencySettings._defaultShowSummary,
      formTapAction:
          _formTapActionsByName[savedFormTapAction?.value] ??
          FrequencySettings._defaultFormTapAction,
      narrowLemmaCoverage:
          _narrowLemmaCoveragesByName[savedNarrowLemmaCoverage?.value] ??
          FrequencySettings._defaultNarrowLemmaCoverage,
    );
    return log.exit(r: settings)!;
  }

  Future<void> updateSettings(FrequencySettings newSettings) async {
    log.entry(args: [newSettings]);
    final previous = state.valueOrNull;
    if (previous != null && previous != newSettings) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(newSettings);
      // Persist (with rollback on failure)
      try {
        final repo = ref.read(settingsRepositoryProvider);
        await repo.set(_showSummary, PrefBool(newSettings.showSummary));
        await repo.set(_formTapAction, PrefString(newSettings.formTapAction.name));
        await repo.set(_narrowLemmaCoverage, PrefString(newSettings.narrowLemmaCoverage.name));
      } on Exception catch (e, st) {
        log
          ..catching(e, stackTrace: st)
          ..warning(() => 'Rolling back settings to $previous');
        state = AsyncData(previous);
      }
    } else {
      log.fine('no-op: settings unchanged');
    }
    log.exit<void>();
  }

  //
}

//domain

/// What tapping a row opens while the report lists forms.
///
/// Lemma rows have no morphology to open
enum FormTapAction { ask, openMorphology, openDictionary, openConcordance }

/// Which lemma coverage the report shows when only one column fits
enum NarrowLemmaCoverage { anyCandidate, certain }

/// Holds the settings for the word frequency
@immutable
class FrequencySettings {
  const FrequencySettings({
    this.showSummary = _defaultShowSummary,
    this.formTapAction = _defaultFormTapAction,
    this.narrowLemmaCoverage = _defaultNarrowLemmaCoverage,
  });

  /// Whether the notes between the filters and the table are shown
  final bool showSummary;
  final FormTapAction formTapAction;
  final NarrowLemmaCoverage narrowLemmaCoverage;
  static const bool _defaultShowSummary = true;
  static const FormTapAction _defaultFormTapAction = FormTapAction.ask;
  static const NarrowLemmaCoverage _defaultNarrowLemmaCoverage = NarrowLemmaCoverage.anyCandidate;

  /// Returns a copy with the given fields replaced.
  FrequencySettings copyWith({
    bool? showSummary,
    FormTapAction? formTapAction,
    NarrowLemmaCoverage? narrowLemmaCoverage,
  }) => FrequencySettings(
    showSummary: showSummary ?? this.showSummary,
    formTapAction: formTapAction ?? this.formTapAction,
    narrowLemmaCoverage: narrowLemmaCoverage ?? this.narrowLemmaCoverage,
  );

  @override
  String toString() =>
      'FrequencySettings{'
      'showSummary: $showSummary, '
      'formTapAction: $formTapAction, '
      'narrowLemmaCoverage: $narrowLemmaCoverage}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencySettings &&
          other.showSummary == showSummary &&
          other.formTapAction == formTapAction &&
          other.narrowLemmaCoverage == narrowLemmaCoverage);

  @override
  int get hashCode => Object.hash(showSummary, formTapAction, narrowLemmaCoverage);
  //
}
