import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/settings/frequency_settings_api.dart'
    show
        FormTapAction,
        FrequencySettings,
        FrequencyViewSettingsNotifier,
        frequencyViewSettingsNotifierProvider;
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
  Widget build(context, ref) => Scaffold(
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
      _FormTapChoice(
        current: settings.formTapAction,
        onChanged: (action) => notifier.updateSettings(
          settings.copyWith(formTapAction: action),
        ),
      ),
    ],
  );
  //
}

/// Title, subtitle and one chip per [FormTapAction]; the chips wrap on narrow screens
class _FormTapChoice extends StatelessWidget {
  const _FormTapChoice({
    required this.current,
    required this.onChanged,
  });

  final FormTapAction current;
  final ValueChanged<FormTapAction> onChanged;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    return Padding(
      // ListTile's start padding, so the text lines up with the switch's title above
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tapping a Form Opens', style: theme.textTheme.bodyLarge),
          Text(
            'Lemma rows always open the dictionary',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _actionChips(),
          ),
        ],
      ),
    );
  }

  List<ChoiceChip> _actionChips() => FormTapAction.values
      .map(
        (action) => ChoiceChip(
          label: Text(_label(action)),
          selected: action == current,
          onSelected: (_) => onChanged(action),
        ),
      )
      .toList();

  static String _label(FormTapAction action) => switch (action) {
    FormTapAction.ask => 'Ask',
    FormTapAction.openMorphology => 'Morphology',
    FormTapAction.openDictionary => 'Dictionary',
  };

  //
}
