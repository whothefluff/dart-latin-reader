import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/settings/dictionary_settings_api.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/responsive_coordinate_grid.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

/// Displays the dictionary preferences
///
/// When a user changes a setting, the [DictionarySettingsNotifier] is updated and
/// widgets that listen to [dictionarySettingsNotifierProvider] are rebuilt.
class DictionarySettingsPage extends ConsumerWidget {
  const DictionarySettingsPage({
    super.key,
  });

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: AppBar(title: const Text('Dictionary Settings')),
    body: ref
        .watch(dictionarySettingsNotifierProvider)
        .when(
          loading: showLoading,
          error: showError(ref, dictionarySettingsNotifierProvider),
          data: (settings) {
            final notifier = ref.read(dictionarySettingsNotifierProvider.notifier);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ResponsiveCoordinateGrid(
                  slots: [
                    GridSlot(
                      row: 1,
                      col: 1,
                      child: _EntrySettingsSection(settings: settings, notifier: notifier),
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

class _EntrySettingsSection extends StatelessWidget {
  const _EntrySettingsSection({
    required this.settings,
    required this.notifier,
  });

  final DictionarySettings settings;
  final DictionarySettingsNotifier notifier;

  @override
  Widget build(context) => SettingsSection(
    //generic title and icon because there are no proper subsections here
    title: 'Preferences',
    icon: Icons.tune,
    groups: [
      _sensesGroup(),
    ],
  );

  SettingsGroup _sensesGroup() => SettingsGroup(
    rows: [
      _openFirstSenseToggle(),
    ],
  );

  SwitchListTile _openFirstSenseToggle() => SwitchListTile(
    title: const Text('Open First Sense'),
    subtitle: const Text('Entries with several senses start with the first one open'),
    value: settings.openFirstSense,
    onChanged: (val) => notifier.updateSettings(
      settings.copyWith(openFirstSense: val),
    ),
  );
  //
}
