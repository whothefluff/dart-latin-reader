import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/settings/general_settings_api.dart';
import '../../widget/responsive_coordinate_grid.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

class GeneralSettingsPage extends ConsumerWidget {
  const GeneralSettingsPage({
    super.key,
  });

  @override
  Widget build(context, ref) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: ref
        .watch(generalSettingsNotifierProvider)
        .when(
          loading: showLoading,
          error: showError(ref, generalSettingsNotifierProvider),
          data: (settings) {
            final notifier = ref.read(generalSettingsNotifierProvider.notifier);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ResponsiveCoordinateGrid(
                  slots: [
                    GridSlot(
                      row: 1,
                      col: 1,
                      child: _AppearanceSection(
                        themeMode: settings.themeMode,
                        onThemeModeChanged: notifier.updateThemeMode,
                      ),
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

class _AppearanceSection extends StatelessWidget {
  const _AppearanceSection({
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(context) => SettingsSection(
    title: 'Appearance',
    icon: Icons.palette,
    groups: [
      _themeModeGroup(),
    ],
  );

  SettingsGroup _themeModeGroup() => SettingsGroup(
    rows: [
      _ThemeModeSelector(current: themeMode, onChanged: onThemeModeChanged),
    ],
    fitContent: true,
  );
  //
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector({
    required this.current,
    required this.onChanged,
  });

  final ThemeMode current;
  final ValueChanged<ThemeMode> onChanged;
  static const List<({IconData icon, String label, ThemeMode mode})> _options = [
    (mode: ThemeMode.system, icon: Icons.phone_android, label: 'System'),
    (mode: ThemeMode.light, icon: Icons.light_mode, label: 'Light'),
    (mode: ThemeMode.dark, icon: Icons.dark_mode, label: 'Dark'),
  ];

  @override
  Widget build(context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _themeTiles(),
    ),
  );

  List<SizedBox> _themeTiles() => _options
      .map(
        (o) => SizedBox(
          width: 96,
          child: _ThemeTile(
            icon: o.icon,
            label: o.label,
            selected: current == o.mode,
            onTap: () => onChanged(o.mode),
          ),
        ),
      )
      .toList();
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(context) {
    final cs = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: selected ? cs.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? cs.primary : cs.outlineVariant,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant),
                const SizedBox(height: 4),
                Text(label, style: labelStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
