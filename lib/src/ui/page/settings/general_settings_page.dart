import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../logger.dart';
import '../../../component/settings/general_settings_api.dart';
import '../../../core/image_colors.dart';
import '../../app.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/responsive_coordinate_grid.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

class GeneralSettingsPage extends ConsumerWidget {
  const GeneralSettingsPage({
    super.key,
  });

  @override
  Widget build(context, ref) => SafeBodyScaffold(
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
                        onThemeModeChanged: (mode) =>
                            notifier.updateSettings(settings.copyWith(themeMode: mode)),
                        accentColor: settings.accentColor,
                        onAccentColorChanged: (color) =>
                            notifier.updateSettings(settings.copyWith(accentColor: color)),
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
    required this.accentColor,
    required this.onAccentColorChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final Color? accentColor;
  final ValueChanged<Color?> onAccentColorChanged;

  @override
  Widget build(context) => SettingsSection(
    title: 'Appearance',
    icon: Icons.palette,
    groups: [
      _themeModeGroup(),
      _accentColorGroup(),
    ],
  );

  SettingsGroup _themeModeGroup() => SettingsGroup(
    rows: [
      _ThemeModeSelector(current: themeMode, onChanged: onThemeModeChanged),
    ],
    fitContent: true,
  );

  SettingsGroup _accentColorGroup() => SettingsGroup(
    rows: [
      _AccentColorSelector(current: accentColor, onChanged: onAccentColorChanged),
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
  //
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

  //
}

class _AccentColorSelector extends StatelessWidget {
  const _AccentColorSelector({
    required this.current,
    required this.onChanged,
  });

  final Color? current;
  final ValueChanged<Color?> onChanged;

  /// The seed colors from Flutter's Material 3 demo.
  /// `null` is the baseline scheme.
  ///
  /// Keep these as plain `Color(0x…)` instead of [MaterialColor], as dart only
  /// counts two colors as equal when they are of the same class and tbe accent
  /// color loaded from the settings is a [Color].
  ///
  /// See [the Flutter sample](https://github.com/flutter/samples/blob/a05867daaad66d9b89609b5eeb766acb0ac4e76c/material_3_demo/lib/src/constants.dart#L20-L34).
  static const List<({String label, Color? seed})> _presets = [
    (seed: null, label: 'Baseline'),
    (seed: Color(0xFF3F51B5), label: 'Indigo'),
    (seed: Color(0xFF2196F3), label: 'Blue'),
    (seed: Color(0xFF009688), label: 'Teal'),
    (seed: Color(0xFF4CAF50), label: 'Green'),
    (seed: Color(0xFFFFEB3B), label: 'Yellow'),
    (seed: Color(0xFFFF9800), label: 'Orange'),
    (seed: Color(0xFFFF5722), label: 'Deep Orange'),
    (seed: Color(0xFFE91E63), label: 'Pink'),
  ];

  @override
  Widget build(context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ..._presetSwatches(Theme.of(context).brightness),
        _imageSwatch(context),
      ],
    ),
  );

  Iterable<_ColorSwatch> _presetSwatches(Brightness brightness) => _presets.map((p) {
    final appScheme = appTheme(p.seed, brightness).colorScheme;
    return _ColorSwatch(
      color: appScheme.primary,
      iconColor: appScheme.onPrimary,
      label: p.label,
      selected: current == p.seed,
      onTap: () => onChanged(p.seed),
    );
  });

  _ColorSwatch _imageSwatch(BuildContext context) {
    final currentIsFromImage = _presets.every((p) => p.seed != current);
    final scheme = currentIsFromImage
        ? appTheme(current, Theme.of(context).brightness).colorScheme
        : ColorScheme.of(context);
    return _ColorSwatch(
      color: currentIsFromImage ? scheme.primary : scheme.surfaceContainerHighest,
      iconColor: currentIsFromImage ? scheme.onPrimary : scheme.onSurfaceVariant,
      label: 'Colors From an Image',
      selected: currentIsFromImage,
      icon: Icons.image_outlined,
      onTap: () => _pickAccentFromImage(context),
    );
  }

  Future<void> _pickAccentFromImage(BuildContext context) async {
    log.entry<void>();
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        final colors = await colorsOfImage(bytes);
        if (context.mounted) {
          final chosen = await showDialog<Color>(
            context: context,
            builder: (context) => _ImageColorsDialog(image: bytes, colors: colors),
          );
          if (chosen != null) {
            onChanged(chosen);
          }
        }
      }
    } on Exception catch (e, st) {
      log.catching(e, stackTrace: st);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not read that image')),
        );
      }
    }
    log.exit<void>();
  }

  //
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.color,
    required this.iconColor,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final Color color;
  final Color iconColor;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(context) {
    final shownIcon = icon ?? (selected ? Icons.check : null);
    return Tooltip(
      message: label,
      child: Semantics(
        selected: selected,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? ColorScheme.of(context).primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Material(
            color: color,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: shownIcon != null ? Icon(shownIcon, size: 20, color: iconColor) : null,
            ),
          ),
        ),
      ),
    );
  }

  //
}

/// Shows an image and its colors, and lets the user choose one of them.
///
/// The dialog takes on the chosen color, as a preview. Pressing Apply returns the color to the
/// caller; closing the dialog any other way returns nothing.
class _ImageColorsDialog extends StatefulWidget {
  const _ImageColorsDialog({
    required this.image,
    required this.colors,
  });

  final Uint8List image;
  final RankedColors colors;

  @override
  State<_ImageColorsDialog> createState() => _ImageColorsDialogState();
  //
}

class _ImageColorsDialogState extends State<_ImageColorsDialog> {
  //
  static const _shownImageHeight = 140.0;
  late Color _chosen = widget.colors.best;

  @override
  Widget build(context) {
    final brightness = Theme.of(context).brightness;
    return AnimatedTheme(
      data: appTheme(_chosen, brightness),
      child: AlertDialog(
        title: const Text('Which color?'),
        // The image and the colors don't fit a phone on its side
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                widget.image,
                height: _shownImageHeight,
                cacheHeight: (_shownImageHeight * MediaQuery.devicePixelRatioOf(context)).round(),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [..._swatches(brightness)],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, _chosen),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Iterable<_ColorSwatch> _swatches(Brightness brightness) => widget.colors.indexed.map((entry) {
    final (i, color) = entry;
    final appScheme = appTheme(color, brightness).colorScheme;
    return _ColorSwatch(
      color: appScheme.primary,
      iconColor: appScheme.onPrimary,
      label: 'Color ${i + 1}',
      selected: color == _chosen,
      onTap: () => setState(() => _chosen = color),
    );
  });

  //
}
