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

  /// Stored by name; a renamed value falls back to the default
  static final Map<String, FormTapAction> _formTapActionsByName = FormTapAction.values.asNameMap();

  @override
  Future<FrequencySettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedShowSummary = await repo.get(_showSummary, PrefBool.hint);
    final savedFormTapAction = await repo.get(_formTapAction, PrefString.hint);
    final settings = FrequencySettings(
      showSummary: savedShowSummary?.value ?? FrequencySettings._defaultShowSummary,
      formTapAction:
          _formTapActionsByName[savedFormTapAction?.value] ??
          FrequencySettings._defaultFormTapAction,
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
/// Lemma rows always open the dictionary
enum FormTapAction { ask, openMorphology, openDictionary }

/// Holds the settings for the word frequency
///
/// All fields have defaults and can be reset to them by omitting the parameter
/// in [copyWith].
@immutable
class FrequencySettings {
  const FrequencySettings({
    this.showSummary = _defaultShowSummary,
    this.formTapAction = _defaultFormTapAction,
  });

  /// Whether the notes between the filters and the table are shown
  final bool showSummary;
  final FormTapAction formTapAction;
  static const bool _defaultShowSummary = true;
  static const FormTapAction _defaultFormTapAction = FormTapAction.ask;

  /// Returns a copy with the given fields replaced.
  FrequencySettings copyWith({
    bool? showSummary,
    FormTapAction? formTapAction,
  }) => FrequencySettings(
    showSummary: showSummary ?? this.showSummary,
    formTapAction: formTapAction ?? this.formTapAction,
  );

  @override
  String toString() =>
      'FrequencySettings{'
      'showSummary: $showSummary, '
      'formTapAction: $formTapAction}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencySettings &&
          other.showSummary == showSummary &&
          other.formTapAction == formTapAction);

  @override
  int get hashCode => Object.hash(showSummary, formTapAction);
  //
}
