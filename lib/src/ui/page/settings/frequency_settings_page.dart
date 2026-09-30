import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/settings/frequency_settings_api.dart'
    show
        FormTapAction,
        FrequencySettings,
        FrequencyViewSettingsNotifier,
        NarrowLemmaCoverage,
        frequencyViewSettingsNotifierProvider;
import '../../widget/page_scaffold.dart';
import '../../widget/responsive_coordinate_grid.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

/// Displays the word frequency preferences
///
/// When a user changes a setting, the [FrequencyViewSettingsNotifier] is updated and
/// widgets that listen to [frequencyViewSettingsNotifierProvider] are rebuilt.
class FrequencySettingsPage extends ConsumerWidget {
  const FrequencySettingsPage({
    super.key,
  });

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: AppBar(title: const Text('Frequency Settings')),
    body: ref
        .watch(frequencyViewSettingsNotifierProvider)
        .when(
          loading: showLoading,
          error: showError(ref, frequencyViewSettingsNotifierProvider),
          data: (settings) {
            final notifier = ref.read(frequencyViewSettingsNotifierProvider.notifier);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ResponsiveCoordinateGrid(
                  slots: [
                    GridSlot(
                      row: 1,
                      col: 1,
                      child: _ReportSettingsSection(settings: settings, notifier: notifier),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
  );
  //
}

class _ReportSettingsSection extends StatelessWidget {
  const _ReportSettingsSection({
    required this.settings,
    required this.notifier,
  });

  final FrequencySettings settings;
  final FrequencyViewSettingsNotifier notifier;

  @override
  Widget build(context) => SettingsSection(
    //generic title and icon because there are no proper subsections here
    title: 'Preferences',
    icon: Icons.tune,
    groups: [
      _summaryGroup(),
      _formTapGroup(),
      _narrowLemmaCoverageGroup(),
    ],
  );

  SettingsGroup _summaryGroup() => SettingsGroup(
    rows: [
      _summaryToggle(),
    ],
  );

  SwitchListTile _summaryToggle() => SwitchListTile(
    title: const Text('Show Report Summary'),
    subtitle: const Text('Coverage counts and notes between the filters and the table'),
    value: settings.showSummary,
    onChanged: (val) => notifier.updateSettings(
      settings.copyWith(showSummary: val),
    ),
  );

  SettingsGroup _formTapGroup() => SettingsGroup(
    rows: [
      ChipChoice(
        title: 'Tapping a Form Opens',
        subtitle: 'Lemma rows never navigate to morphology',
        chips: choiceChips(
          values: FormTapAction.values,
          current: settings.formTapAction,
          label: _formTapLabel,
          onChanged: (action) => notifier.updateSettings(
            settings.copyWith(formTapAction: action),
          ),
        ),
      ),
    ],
  );

  SettingsGroup _narrowLemmaCoverageGroup() => SettingsGroup(
    rows: [
      ChipChoice(
        title: 'Lemma Coverage on Small Screens',
        subtitle:
            'Larger screens show both. On small screens, long-press or hover over a row '
            'for the other',
        chips: choiceChips(
          values: NarrowLemmaCoverage.values,
          current: settings.narrowLemmaCoverage,
          label: _narrowLemmaCoverageLabel,
          onChanged: (coverage) => notifier.updateSettings(
            settings.copyWith(narrowLemmaCoverage: coverage),
          ),
        ),
      ),
    ],
  );

  static String _formTapLabel(FormTapAction action) => switch (action) {
    FormTapAction.ask => 'Ask',
    FormTapAction.openMorphology => 'Morphology',
    FormTapAction.openDictionary => 'Dictionary',
    FormTapAction.openConcordance => 'Concordance',
  };

  static String _narrowLemmaCoverageLabel(NarrowLemmaCoverage coverage) => switch (coverage) {
    NarrowLemmaCoverage.anyCandidate => 'Any Candidate',
    NarrowLemmaCoverage.certain => 'Certain',
  };
  //
}
