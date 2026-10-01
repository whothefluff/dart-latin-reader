import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/settings/reader_settings_api.dart';
import '../../../component/word_frequency/lookup_frequency_api.dart' show FrequencyScope;
import '../../../core/bundled_fonts.dart';
import '../../../core/contains_text.dart';
import '../../../core/latin_ext_fonts.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/responsive_coordinate_grid.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';

/// Displays the reader typography settings.
///
/// When a user changes a setting, the [ReaderSettingsNotifier] is updated and
/// widgets that listen to [readerSettingsNotifierProvider] are rebuilt.
class LibrarySettingsPage extends ConsumerWidget {
  const LibrarySettingsPage({
    super.key,
  });

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: AppBar(title: const Text('Library Settings')),
    body: ref
        .watch(readerSettingsNotifierProvider)
        .when(
          loading: showLoading,
          error: showError(ref, readerSettingsNotifierProvider),
          data: (settings) {
            final notifier = ref.read(readerSettingsNotifierProvider.notifier);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ResponsiveCoordinateGrid(
                  slots: [
                    GridSlot(
                      row: 1,
                      col: 1,
                      child: _ReaderSettingsSection(settings: settings, notifier: notifier),
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

class _ReaderSettingsSection extends StatelessWidget {
  const _ReaderSettingsSection({
    required this.settings,
    required this.notifier,
  });

  final ReaderSettings settings;
  final ReaderSettingsNotifier notifier;
  static const _defaults = ReaderSettings.defaults();
  static const double _fontSizeMin = 12.0;
  static const double _fontSizeMax = 40.0;
  static const double _fontSizeStep = 1.0;
  static const int _fontSizeDivisions = (_fontSizeMax - _fontSizeMin) ~/ _fontSizeStep;
  static const double _lineHeightMin = 0.5;
  static const double _lineHeightMax = 3.0;
  static const double _lineHeightStep = 0.1;
  static const int _lineHeightDivisions = (_lineHeightMax - _lineHeightMin) ~/ _lineHeightStep;
  static const double _letterSpaceMin = -1.0;
  static const double _letterSpaceMax = 5.0;
  static const double _letterSpaceStep = 0.1;
  static const int _letterSpaceDivisions = (_letterSpaceMax - _letterSpaceMin) ~/ _letterSpaceStep;
  static const double _commonPercentMin = 10;
  static const double _commonPercentMax = 60;
  static const double _uncommonPercentMin = 5;
  static const double _uncommonPercentMax = 30;
  static const double _freqPercentStep = 5;

  @override
  Widget build(context) => SettingsSection(
    title: 'Reader Settings',
    icon: Icons.my_library_books,
    groups: [
      _readerMacrons(),
      _readerTypography(context),
      _readerFrequencies(context),
    ],
  );

  SettingsGroup _readerMacrons() => SettingsGroup(
    rows: [
      _macronsToggle(),
    ],
  );

  SettingsGroup _readerFrequencies(BuildContext context) => SettingsGroup(
    rows: [
      _frequenciesHeader(context),
      const Divider(height: 1),
      _commonWordsToggle(),
      if (settings.markCommonWords) _commonWordsSlider(),
      _uncommonWordsToggle(),
      if (settings.markUncommonWords) _uncommonWordsSlider(),
      if (settings.marksFrequencies) _frequencyScopeChoice(),
    ],
  );

  SettingsGroup _readerTypography(BuildContext context) => SettingsGroup(
    rows: [
      _typographyHeader(context),
      const Divider(height: 1),
      _fontFamilyPicker(),
      const SizedBox(height: 8),
      _fontSizeSlider(),
      _lineHeightSlider(),
      _letterSpaceSlider(),
      const SizedBox(height: 12),
    ],
  );

  SwitchListTile _macronsToggle() => SwitchListTile(
    title: const Text('Show Macrons'),
    value: settings.showMacrons,
    onChanged: (val) => notifier.updateSettings(
      settings.copyWith(showMacrons: val),
    ),
  );

  Widget _frequenciesHeader(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorScheme.surfaceContainer,
    child: ListTile(
      leading: const Icon(Icons.bar_chart),
      title: const Text('Word Frequency', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: const Text('Mark words by how much of the text their lemma covers'),
      trailing: IconButton(
        tooltip: 'How it works',
        icon: const Icon(Icons.info_outline),
        onPressed: () => _showFrequencyNotes(context),
      ),
    ),
  );

  Future<void> _showFrequencyNotes(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Common and uncommon words'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'The percentages measure how much of the selected texts to mark, counting '
              'repeated words each time. For example, Common 50% colors the most frequent '
              'words that together cover at least half the text. Uncommon 10% fades the '
              'rarest words that together cover at least a tenth. Words in between stay '
              'unmarked, even at the highest settings.',
            ),
            SizedBox(height: 12),
            Text(
              'Inflected forms (ignoring macrons) are counted together under their lemma. If a '
              'form has several possible lemmas, like \'est\' (sum "is" or edo "eats"), the most '
              "frequent one is used. It's the same data the 'COVER.' column shows in the "
              'frequency report when grouped by lemma.',
            ),
            SizedBox(height: 12),
            Text(
              'Because words with the same frequency are marked together, the marked share may '
              'be larger than the percentage you set. For example, if words occurring only once '
              'make up 15% of the text, setting Uncommon to 10% still fades all of them. '
              'Frequent words behave the same way.',
            ),
            SizedBox(height: 12),
            Text(
              'If the common/uncommon groups overlap (which would only happen in very short '
              'works), common takes priority. Words without an identified lemma stay unmarked.',
            ),
            SizedBox(height: 12),
            Text(
              "'Counted Within' chooses which texts to use for the frequencies: the current "
              'work, all works by its author, or the whole library.',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    ),
  );

  SwitchListTile _commonWordsToggle() => SwitchListTile(
    title: const Text('Mark Common Words'),
    subtitle: const Text(
      'Color the most frequent lemmas that together make up at least this share of the text',
    ),
    value: settings.markCommonWords,
    onChanged: (val) => notifier.updateSettings(
      settings.copyWith(markCommonWords: val),
    ),
  );

  SwitchListTile _uncommonWordsToggle() => SwitchListTile(
    title: const Text('Mark Uncommon Words'),
    subtitle: const Text(
      'Fade the rarest lemmas that together make up at least this share of the text',
    ),
    value: settings.markUncommonWords,
    onChanged: (val) => notifier.updateSettings(
      settings.copyWith(markUncommonWords: val),
    ),
  );

  _LabeledSliderRow _commonWordsSlider() => _LabeledSliderRow(
    label: 'Common Words: ${settings.commonWordsPercent}%',
    icon: Icons.trending_up,
    value: settings.commonWordsPercent.toDouble().clamp(_commonPercentMin, _commonPercentMax),
    defaultValue: _defaults.commonWordsPercent.toDouble(),
    min: _commonPercentMin,
    max: _commonPercentMax,
    divisions: (_commonPercentMax - _commonPercentMin) ~/ _freqPercentStep,
    divisionLabelFormatter: (v) => '${v.round()}%',
    onChangeEnd: (val) => notifier.updateSettings(
      settings.copyWith(commonWordsPercent: val.round()),
    ),
    onReset: () => notifier.updateSettings(
      settings.copyWith(commonWordsPercent: _defaults.commonWordsPercent),
    ),
  );

  _LabeledSliderRow _uncommonWordsSlider() => _LabeledSliderRow(
    label: 'Uncommon Words: ${settings.uncommonWordsPercent}%',
    icon: Icons.trending_down,
    value: settings.uncommonWordsPercent.toDouble().clamp(
      _uncommonPercentMin,
      _uncommonPercentMax,
    ),
    defaultValue: _defaults.uncommonWordsPercent.toDouble(),
    min: _uncommonPercentMin,
    max: _uncommonPercentMax,
    divisions: (_uncommonPercentMax - _uncommonPercentMin) ~/ _freqPercentStep,
    divisionLabelFormatter: (v) => '${v.round()}%',
    onChangeEnd: (val) => notifier.updateSettings(
      settings.copyWith(uncommonWordsPercent: val.round()),
    ),
    onReset: () => notifier.updateSettings(
      settings.copyWith(uncommonWordsPercent: _defaults.uncommonWordsPercent),
    ),
  );

  ChipChoice _frequencyScopeChoice() => ChipChoice(
    title: 'Counted Within',
    subtitle: 'Choose which texts to use for the counts',
    chips: choiceChips(
      values: FrequencyScope.values,
      current: settings.frequencyScope,
      label: _frequencyScopeLabel,
      onChanged: (scope) => notifier.updateSettings(
        settings.copyWith(frequencyScope: scope),
      ),
    ),
  );

  static String _frequencyScopeLabel(FrequencyScope scope) => switch (scope) {
    FrequencyScope.work => 'This Work',
    FrequencyScope.author => 'Its Author',
    FrequencyScope.library => 'Whole Library',
  };

  Widget _typographyHeader(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorScheme.surfaceContainer,
    child: const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.font_download),
          title: Text('Typography', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Font family, size, and spacing options'),
        ),
        Divider(height: 1),
      ],
    ),
  );

  _FontPicker _fontFamilyPicker() => _FontPicker(
    currentFont: settings.fontFamily,
    onFontSelected: (font) => notifier.updateSettings(
      settings.copyWith(fontFamily: font),
    ),
  );

  _LabeledSliderRow _fontSizeSlider() => _LabeledSliderRow(
    label: 'Font Size',
    icon: Icons.format_size,
    value: settings.fontSize.clamp(_fontSizeMin, _fontSizeMax),
    defaultValue: _defaults.fontSize,
    min: _fontSizeMin,
    max: _fontSizeMax,
    divisions: _fontSizeDivisions,
    divisionLabelFormatter: (v) => v.toStringAsFixed(0),
    onChangeEnd: (val) => notifier.updateSettings(
      settings.copyWith(fontSize: val),
    ),
    onReset: () => notifier.updateSettings(
      settings.copyWith(fontSize: _defaults.fontSize),
    ),
  );

  _LabeledSliderRow _lineHeightSlider() => _LabeledSliderRow(
    label: 'Line Height',
    icon: Icons.height,
    value: settings.lineHeight.clamp(_lineHeightMin, _lineHeightMax),
    defaultValue: _defaults.lineHeight,
    min: _lineHeightMin,
    max: _lineHeightMax,
    divisions: _lineHeightDivisions,
    divisionLabelFormatter: (v) => v.toStringAsFixed(1),
    onChangeEnd: (val) => notifier.updateSettings(
      settings.copyWith(lineHeight: val),
    ),
    onReset: () => notifier.updateSettings(
      settings.copyWith(lineHeight: _defaults.lineHeight),
    ),
  );

  _LabeledSliderRow _letterSpaceSlider() => _LabeledSliderRow(
    label: 'Letter Spacing',
    icon: Icons.space_bar,
    value: settings.letterSpacing.clamp(_letterSpaceMin, _letterSpaceMax),
    defaultValue: _defaults.letterSpacing,
    min: _letterSpaceMin,
    max: _letterSpaceMax,
    divisions: _letterSpaceDivisions,
    divisionLabelFormatter: (v) => v.toStringAsFixed(1),
    onChangeEnd: (val) => notifier.updateSettings(
      settings.copyWith(letterSpacing: val),
    ),
    onReset: () => notifier.updateSettings(
      settings.copyWith(letterSpacing: _defaults.letterSpacing),
    ),
  );
  //
}

class _FontPicker extends StatefulWidget {
  const _FontPicker({
    required this.currentFont,
    required this.onFontSelected,
  });

  final String? currentFont;
  final ValueChanged<String?> onFontSelected;

  @override
  State<_FontPicker> createState() => _FontPickerState();
  //
}

class _FontPickerState extends State<_FontPicker> {
  //
  late final Set<String> _supportedByPackage = GoogleFonts.asMap().keys.toSet();
  late final List<String> _safeLatinExtFonts = latinExtFonts
      .where((font) => _supportedByPackage.contains(font))
      .toList();
  static const _minQueryLength = 3;
  static final Set<String> _curatedDefaults = bundledFonts.map((f) => f.family).toSet();

  @override
  Widget build(context) => SearchAnchor(
    viewHintText: 'Select recommended or search Google fonts...',
    builder: (context, controller) => ListTile(
      title: const Text('Font Family'),
      subtitle: Text(
        widget.currentFont ?? 'System Default',
        style: widget.currentFont != null ? GoogleFonts.getFont(widget.currentFont!) : null,
      ),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () => controller
        ..clear()
        ..openView(),
    ),
    suggestionsBuilder: (context, controller) {
      final query = controller.text.trim().toLowerCase();
      final List<String> results;
      if (query.isEmpty) {
        results = ['System Default', ..._curatedDefaults];
      } else if (query.length < _minQueryLength) {
        results = [];
      } else {
        results = _safeLatinExtFonts.where((font) => containsText([font], query)).toList();
      }
      return [_buildListView(results, query, controller)];
    },
  );

  Widget _buildListView(List<String> results, String query, SearchController controller) =>
      results.isEmpty
      ? ListTile(
          title: Text(
            query.isNotEmpty && query.length < _minQueryLength ? 'Keep typing…' : 'No fonts found',
          ),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final fontName = results[index];
            return ListTile(
              title: Text(
                fontName,
                style: fontName == 'System Default' ? null : GoogleFonts.getFont(fontName),
              ),
              onTap: () {
                widget.onFontSelected(fontName == 'System Default' ? null : fontName);
                controller.closeView(fontName);
                FocusScope.of(context).unfocus();
              },
            );
          },
        );

  //
}

class _LabeledSliderRow extends StatefulWidget {
  const _LabeledSliderRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.defaultValue,
    required this.min,
    required this.max,
    this.divisions,
    required this.divisionLabelFormatter,
    required this.onChangeEnd,
    required this.onReset,
  });

  final String label;
  final IconData icon;
  final double value;
  final double defaultValue;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double value) divisionLabelFormatter;
  final ValueChanged<double> onChangeEnd;
  final VoidCallback onReset;

  @override
  State<_LabeledSliderRow> createState() => _LabeledSliderRowState();
  //
}

class _LabeledSliderRowState extends State<_LabeledSliderRow> {
  //
  late double _localValue;

  @override
  void initState() {
    super.initState();
    _localValue = widget.value;
  }

  @override
  void didUpdateWidget(_LabeledSliderRow old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      _localValue = widget.value;
    }
  }

  @override
  Widget build(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const SizedBox(width: 16),
          Icon(widget.icon, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Text(widget.label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: SliderTheme(
              data: Theme.of(context).sliderTheme.copyWith(
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Slider(
                value: _localValue,
                min: widget.min,
                max: widget.max,
                divisions: widget.divisions,
                label: widget.divisionLabelFormatter(_localValue),
                onChanged: (val) => setState(() => _localValue = val),
                onChangeEnd: widget.onChangeEnd,
              ),
            ),
          ),
          // maintainSize/Animation/State keeps the reset button occupying space
          Visibility(
            visible: _localValue != widget.defaultValue,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IconButton(
              icon: const Icon(Icons.restart_alt),
              tooltip: 'Reset to default',
              onPressed: widget.onReset,
            ),
          ),
        ],
      ),
    ],
  );
  //
}
