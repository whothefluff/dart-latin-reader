import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../logger.dart';
import '../../../component/dictionary/lewis_and_short_api.dart';
import '../../../component/dictionary/lewis_and_short_basic_info_api.dart';
import '../../../component/library/catalog_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../../component/settings/frequency_filter_settings_api.dart';
import '../../../component/settings/frequency_settings_api.dart'
    show FormTapAction, FrequencySettings, frequencyViewSettingsNotifierProvider;
import '../../../component/word_frequency/active_frequency_filter_api.dart';
import '../../../component/word_frequency/enriched_word_frequency_api.dart';
import '../../../component/word_frequency/frequency_offset_api.dart';
import '../../../component/word_frequency/library_selection_api.dart';
import '../../../component/word_frequency/resolved_freq_morph_form_api.dart';
import '../../../component/word_frequency/word_frequency_api.dart';
import '../../router/config.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import '../settings/settings_shell_page.dart' show SettingsTab;
import 'library_filter_dialog.dart';

const BorderRadius _controlBorderRadius = BorderRadius.all(Radius.circular(8));

class WordFrequencyPage extends ConsumerWidget {
  const WordFrequencyPage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final filterAsync = ref.watch(activeFrequencyFilterProvider);
    return SafeBodyScaffold(
      appBar: AppBar(
        title: const Text('Word Frequency'),
        notificationPredicate: (_) => false, //only the table scrolls
        actions: [
          IconButton(
            tooltip: 'Frequency settings',
            icon: const Icon(Icons.settings),
            onPressed: () async =>
                const SettingsRoute(tab: SettingsTab.wordFrequency).push<void>(context),
          ),
        ],
      ),
      body: filterAsync.when(
        skipLoadingOnReload: true, // keep filter controls visible while recomputing
        loading: showLoading,
        error: showError(ref, activeFrequencyFilterProvider),
        data: (filter) => _WordFrequencyBody(filter: filter),
      ),
    );
  }

  //
}

class _WordFrequencyBody extends ConsumerWidget {
  const _WordFrequencyBody({
    required this.filter,
  });

  final FrequencyFilter filter;

  @override
  Widget build(context, ref) {
    final reportAsync = ref.watch(enrichedFrequencyReportProvider(filter));
    final layout = _Layout.of(context, groupByLemma: filter.groupByLemma);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FilterBar(filter: filter, layout: layout),
        const Divider(height: 1),
        Expanded(
          child: reportAsync.when(
            data: (report) => _ReportView(filter: filter, report: report, layout: layout),
            loading: showLoading,
            error: showError(ref, enrichedFrequencyReportProvider(filter)),
          ),
        ),
      ],
    );
  }

  //
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar({
    required this.filter,
    required this.layout,
  });

  final FrequencyFilter filter;
  final _Layout layout;
  static const List<int> _presetPageSizes = [10, 100, 1000];

  /// Dropdown value of the "Custom…" entry (real page sizes are always positive)
  static const int _customPageSizeSentinel = -1;

  @override
  Widget build(context, ref) {
    final selection = ref.watch(librarySelectionNotifierProvider);
    final settings =
        ref.watch(frequencyFilterSettingsNotifierProvider).valueOrNull ??
        const FrequencyFilterSettings();
    final notifier = ref.read(frequencyFilterSettingsNotifierProvider.notifier);
    final catalog = ref.watch(libraryCatalogProvider).valueOrNull;
    final count = _Formats(Localizations.localeOf(context)).count;
    final atDefaults = selection.isEmpty && settings == const FrequencyFilterSettings();
    // include the current custom size so the dropdown can display it
    final pageSizes = {..._presetPageSizes, settings.pageSize}.sorted((a, b) => a.compareTo(b));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          // Clear's TextButton supplies the final 8 px of the end margin
          padding: EdgeInsetsDirectional.fromSTEB(layout.margin, 12, layout.margin - 8, 12),
          child: Row(
            children: [
              Expanded(
                child: _LibraryFilterField(
                  summary: _selectionSummary(selection, count),
                  onTap: catalog == null
                      ? null
                      : () => _pickWorks(context, ref, catalog, selection),
                ),
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: 'Reset all filters to their defaults',
                child: TextButton(
                  onPressed: atDefaults
                      ? null
                      : () async {
                          ref
                              .read(librarySelectionNotifierProvider.notifier)
                              .updateSelection(const LibrarySelection.empty());
                          await notifier.updateSettings(const FrequencyFilterSettings());
                        },
                  child: const Text('Clear'),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: layout.margin, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _OptionRow(
                start: _LabeledDropdown<int>(
                  label: 'Per page:',
                  value: settings.pageSize,
                  items: [
                    for (final size in pageSizes)
                      DropdownMenuItem(value: size, child: Text(count.format(size))),
                    const DropdownMenuItem(value: _customPageSizeSentinel, child: Text('Custom…')),
                  ],
                  // Exclude "Custom…" so the button width follows the numeric entries
                  selectedItemBuilder: (_) => [
                    for (final size in pageSizes) Text(count.format(size)),
                    const SizedBox.shrink(),
                  ],
                  onChanged: (v) async {
                    final size = v == _customPageSizeSentinel
                        ? await _promptCustomPageSize(context, settings.pageSize)
                        : v;
                    if (size != null && size > 0) {
                      await notifier.updateSettings(settings.copyWith(pageSize: size));
                    }
                  },
                ),
                end: _LabeledCheckbox(
                  label: 'Group by Lemma',
                  value: settings.groupByLemma,
                  onChanged: (v) => notifier.updateSettings(settings.copyWith(groupByLemma: v)),
                ),
              ),
              _OptionRow(
                start: _LabeledDropdown<bool>(
                  label: 'Order:',
                  value: settings.ascending,
                  items: const [
                    DropdownMenuItem(value: false, child: Text('Descending')),
                    DropdownMenuItem(value: true, child: Text('Ascending')),
                  ],
                  onChanged: (v) async {
                    if (v != null) {
                      await notifier.updateSettings(settings.copyWith(ascending: v));
                    }
                  },
                ),
                end: _LabeledCheckbox(
                  label: 'Consider Macrons',
                  //lemmas don't have macrons, so display that (the saved choice is kept)
                  value: settings.showMacrons && !settings.groupByLemma,
                  disabledReason: 'Macrons do not change lemma counts',
                  onChanged: settings.groupByLemma
                      ? null
                      : (v) => notifier.updateSettings(settings.copyWith(showMacrons: v)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Opens the library filter dialog and applies the selection returned by Done
  Future<void> _pickWorks(
    BuildContext context,
    WidgetRef ref,
    LibraryCatalog catalog,
    LibrarySelection current,
  ) async {
    final picked = await showDialog<LibrarySelection>(
      context: context,
      builder: (context) => LibraryFilterDialog(catalog: catalog, selection: current),
    );
    if (picked != null) {
      ref.read(librarySelectionNotifierProvider.notifier).updateSelection(picked);
    }
  }

  Future<int?> _promptCustomPageSize(BuildContext context, int current) => showDialog<int>(
    context: context,
    builder: (context) => _CustomPageSizeDialog(initial: current),
  );

  String _selectionSummary(LibrarySelection selection, NumberFormat count) {
    final sources = selection.sourceCount;
    final works = selection.allWorkIds.length;
    return selection.isEmpty
        ? 'All authors & works'
        : '${count.format(sources)} source${sources == 1 ? '' : 's'}, '
              '${count.format(works)} work${works == 1 ? '' : 's'}';
  }

  //
}

/// Opens the [LibraryFilterDialog] from a dropdown-style field
class _LibraryFilterField extends StatelessWidget {
  const _LibraryFilterField({
    required this.summary,
    required this.onTap,
  });

  final String summary;

  /// Null while the catalog is loading
  final VoidCallback? onTap;

  @override
  Widget build(context) => InkWell(
    onTap: onTap,
    borderRadius: const BorderRadius.all(Radius.circular(4)), // OutlineInputBorder's default
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: 'Library Filter',
        enabled: onTap != null,
        isDense: true,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.filter_alt_outlined),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      child: Text(summary, maxLines: 1, overflow: TextOverflow.ellipsis),
    ),
  );

  //
}

/// One row of options: [start] stays left and [end] stays right.
///
/// If they no longer fit side by side, [end] wraps below [start].
class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.start,
    required this.end,
  });

  final Widget start;
  final Widget end;

  @override
  Widget build(context) => Wrap(
    alignment: WrapAlignment.spaceBetween,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 16,
    children: [start, end],
  );

  //
}

/// Dropdown with a label beside the selected value
///
/// Focus highlighting is shown only during keyboard navigation
class _LabeledDropdown<T> extends StatelessWidget {
  const _LabeledDropdown({
    required this.label,
    required this.value,
    required this.items,
    required ValueChanged<T?> onChanged,
    this.selectedItemBuilder,
  }) : _onChanged = onChanged;

  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;

  // Safe because this field is only read through this instance, with its original T
  // ignore: unsafe_variance
  final ValueChanged<T?> _onChanged;

  final DropdownButtonBuilder? selectedItemBuilder;

  @override
  Widget build(context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label),
      const SizedBox(width: 4),
      DropdownButtonHideUnderline(
        child: ValueListenableBuilder(
          valueListenable: _keyboardNavigation,
          builder: (_, keyboard, _) => DropdownButton<T>(
            value: value,
            items: items,
            selectedItemBuilder: selectedItemBuilder,
            onChanged: _onChanged,
            isDense: true,
            borderRadius: _controlBorderRadius,
            // Padding keeps the highlight clear of the text
            padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 4, 4),
            focusColor: keyboard ? null : Colors.transparent,
          ),
        ),
      ),
    ],
  );

  //
}

/// Checkbox with a tappable label
class _LabeledCheckbox extends StatelessWidget {
  const _LabeledCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
    this.disabledReason,
  });

  final String label;
  final bool value;

  /// Null disables the checkbox
  final ValueChanged<bool>? onChanged;

  /// Tooltip shown while disabled
  final String? disabledReason;

  @override
  Widget build(context) {
    final onChanged = this.onChanged;
    final disabledReason = this.disabledReason;
    final control = InkWell(
      onTap: onChanged == null ? null : () => onChanged(!value),
      borderRadius: _controlBorderRadius,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8),
            child: Text(
              label,
              style: onChanged == null ? TextStyle(color: Theme.of(context).disabledColor) : null,
            ),
          ),
          Checkbox(
            value: value,
            onChanged: onChanged == null ? null : (v) => onChanged(v ?? false),
          ),
        ],
      ),
    );
    return onChanged == null && disabledReason != null
        ? Tooltip(message: disabledReason, child: control)
        : control;
  }

  //
}

/// Keeps its text controller alive until the dialog finishes closing
class _CustomPageSizeDialog extends StatefulWidget {
  const _CustomPageSizeDialog({
    required this.initial,
  });

  final int initial;

  @override
  State<_CustomPageSizeDialog> createState() => _CustomPageSizeDialogState();
  //
}

class _CustomPageSizeDialogState extends State<_CustomPageSizeDialog> {
  //
  late final _controller = TextEditingController(text: '${widget.initial}');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => AlertDialog(
    title: const Text('Rows per page'),
    content: TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autofocus: true,
      onSubmitted: (_) => _apply(),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
      FilledButton(onPressed: _apply, child: const Text('Apply')),
    ],
  );

  void _apply() => Navigator.pop(context, int.tryParse(_controller.text));

  //
}

/// Locale-aware number formats for counts and relative frequencies
class _Formats {
  _Formats(
    Locale locale,
  ) : count = NumberFormat.decimalPattern(locale.toString()),
      frequency = NumberFormat('#,##0.0', locale.toString());

  final NumberFormat count;
  final NumberFormat frequency;
  //
}

class _ReportView extends ConsumerWidget {
  const _ReportView({
    required this.filter,
    required this.report,
    required this.layout,
  });

  final FrequencyFilter filter;
  final EnrichedFrequencyReport report;
  final _Layout layout;

  @override
  Widget build(context, ref) {
    final offsetNotifier = ref.read(frequencyOffsetNotifierProvider.notifier);
    final view =
        ref.watch(frequencyViewSettingsNotifierProvider).valueOrNull ?? const FrequencySettings();
    final total = filter.groupByLemma ? report.totalLemmas : report.totalForms;
    final hasNextPage = filter.offset + report.rows.length < total;
    final formats = _Formats(Localizations.localeOf(context));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (view.showSummary) ...[
          _ReportSummary(filter: filter, report: report, formats: formats, layout: layout),
          const Divider(height: 1),
        ],
        _TableHeader(
          layout: layout,
          ascending: filter.ascending,
          onToggleOrder: () => _toggleOrder(ref),
        ),
        const Divider(height: 1),
        Expanded(
          //keep row hover/press ink clipped to the scrolling list
          child: Material(
            type: MaterialType.transparency,
            child: report.rows.isEmpty
                ? const Center(child: Text('No results for this filter.'))
                : ListView.builder(
                    itemCount: report.rows.length,
                    itemBuilder: (context, index) {
                      final row = report.rows[index];
                      return _PointerWhenFullyVisible(
                        child: _TableRow(
                          layout: layout,
                          formats: formats,
                          rank: report.offset + index + 1,
                          row: row,
                          frequency: report.relativeFrequency(row.occurrences),
                          onTap: () => _onRowTapped(context, ref, filter, row),
                        ),
                      );
                    },
                  ),
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous page',
                onPressed: filter.offset > 0 ? () => _loadPrevPage(offsetNotifier) : null,
              ),
              Text(_pageRange(formats.count, total)),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next page',
                onPressed: hasNextPage ? () => _loadNextPage(offsetNotifier) : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// "1–100 of 12,345 forms", or "No forms" when the report is empty
  String _pageRange(NumberFormat count, int total) {
    final noun = filter.groupByLemma ? 'lemma' : 'form';
    final plural = total == 1 ? '' : 's';
    final first = count.format(filter.offset + 1);
    final last = count.format(filter.offset + report.rows.length);
    return report.rows.isEmpty
        ? 'No ${noun}s'
        : '$first–$last of ${count.format(total)} $noun$plural';
  }

  Future<void> _toggleOrder(WidgetRef ref) async {
    final settings = ref.read(frequencyFilterSettingsNotifierProvider).valueOrNull;
    if (settings != null) {
      await ref
          .read(frequencyFilterSettingsNotifierProvider.notifier)
          .updateSettings(settings.copyWith(ascending: !settings.ascending));
    }
  }

  void _loadNextPage(FrequencyOffsetNotifier notifier) {
    // dart format off
    log.info(() => 'attempting to navigate to next frequency page (limit: ${filter.pageSize}, offset: ${filter.offset})');
    // dart format on
    notifier.next(filter.pageSize);
  }

  void _loadPrevPage(FrequencyOffsetNotifier notifier) {
    // dart format off
    log.info(() => 'attempting to navigate to previous frequency page (limit: ${filter.pageSize}, offset: ${filter.offset})');
    // dart format on
    notifier.prev(filter.pageSize);
  }

  //
}

/// The centered notes between the filters and the table.
///
/// Hidden when [FrequencySettings.showSummary] is off
class _ReportSummary extends StatelessWidget {
  const _ReportSummary({
    required this.filter,
    required this.report,
    required this.formats,
    required this.layout,
  });

  final FrequencyFilter filter;
  final EnrichedFrequencyReport report;
  final _Formats formats;
  final _Layout layout;

  @override
  Widget build(context) {
    final count = formats.count;
    final theme = Theme.of(context);
    final note = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final coverage = report.base.coverage;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: layout.margin, vertical: 8),
      child: Column(
        children: [
          if (!filter.groupByLemma)
            Text(
              'Showing ${count.format(report.rows.length)} of '
              '${count.format(report.totalForms)} unique forms',
              textAlign: TextAlign.center,
            ),
          Text(
            'Representing ${count.format(report.representedLemmas)} of '
            '${count.format(report.totalLemmas)} possible lemmas',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            '${count.format(coverage.totalTokens)} counted units: '
            '${count.format(coverage.noCandidateTokens)} with no candidate lemma, '
            '${count.format(coverage.singleCandidateTokens)} with one, '
            '${count.format(coverage.multipleCandidateTokens)} with several.',
            style: note,
            textAlign: TextAlign.center,
          ),
          if (filter.groupByLemma)
            Text(
              'Counts are possible occurrences: the same occurrence can count '
              'towards more than one lemma. SINGLE counts the occurrences where '
              'this was the only candidate in the available analyses.',
              style: note,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  //
}

/// Responsive report geometry based on the scaffold's [Breakpoints]
class _Layout {
  _Layout.of(BuildContext context, {required this.groupByLemma})
    : _withRail = Breakpoints.mediumAndUp.isActive(context);

  final bool groupByLemma;

  final bool _withRail;

  Breakpoint get _breakpoint => _withRail ? Breakpoints.mediumAndUp : Breakpoints.small;

  /// Start and end margin of every section
  double get margin => _breakpoint.margin;

  /// Space between the FORM and LEMMA columns
  double get columnSpacing => _breakpoint.spacing;

  // Fixed columns leave extra room as the layout widens
  double get rankWidth => _withRail ? 48 : 40;
  double get frequencyWidth => _withRail ? 72 : 56;
  double get singleWidth => _withRail ? 80 : 64;
  double get countWidth => _withRail ? 96 : 80;

  /// Whether candidate lemmas use a separate column
  bool get lemmaColumn => !groupByLemma && _withRail;

  /// Whether candidate lemmas appear below the form
  bool get lemmaUnderForm => !groupByLemma && !_withRail;

  /// Whether SINGLE is shown
  bool get singleColumn => groupByLemma;

  //
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({
    required this.layout,
    required this.ascending,
    required this.onToggleOrder,
  });

  final _Layout layout;

  /// Rows are always sorted by COUNT
  final bool ascending;
  final VoidCallback onToggleOrder;

  static const EdgeInsets _sortPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    Widget cell(String text, [String? tooltip]) {
      final label = Text(text, style: style, maxLines: 1, overflow: TextOverflow.ellipsis);
      return tooltip == null ? label : Tooltip(message: tooltip, child: label);
    }

    return _TableLine(
      layout: layout,
      // Account for the sort button's own vertical padding
      verticalPadding: _TableLine.rowPadding - _sortPadding.vertical / 2,
      countOverhang: _sortPadding.horizontal / 2,
      rank: cell('#'),
      main: cell(switch (layout) {
        _Layout(groupByLemma: true) => 'LEMMA',
        _Layout(lemmaUnderForm: true) => 'FORM / LEMMA',
        _Layout() => 'FORM',
      }),
      lemma: layout.lemmaColumn
          ? cell('LEMMA', 'Candidate lemmas in the available analyses')
          : null,
      frequency: cell(
        'FREQ.',
        layout.groupByLemma
            ? 'Possible occurrences per 1,000 words in the selected works'
            : 'Occurrences per 1,000 words in the selected works',
      ),
      single: layout.singleColumn
          ? cell('SINGLE', 'Occurrences where this was the only candidate lemma')
          : null,
      count: _sortedCell(style),
    );
  }

  /// COUNT with an arrow for the current order; tapping it reverses the order
  Widget _sortedCell(TextStyle? style) {
    final description = layout.groupByLemma
        ? 'Possible occurrences: an occurrence can count towards several lemmas'
        : 'Occurrences in the selected works';
    final order = ascending ? 'ascending' : 'descending';
    return Tooltip(
      message: '$description\nSorted $order, tap to reverse',
      child: InkWell(
        onTap: onToggleOrder,
        borderRadius: _controlBorderRadius,
        child: Padding(
          padding: _sortPadding,
          //keep the arrow and COUNT aligned with the values below
          child: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    ascending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 14,
                    color: style?.color,
                  ),
                ),
                const TextSpan(text: ' COUNT'),
              ],
            ),
            style: style,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  //
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.layout,
    required this.formats,
    required this.rank,
    required this.row,
    required this.frequency,
    required this.onTap,
  });

  final _Layout layout;
  final _Formats formats;
  final int rank;
  final EnrichedFrequencyRow row;
  final double frequency;
  final VoidCallback onTap;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final muted = theme.colorScheme.onSurfaceVariant;
    final numberStyle = textTheme.bodyMedium?.copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    final count = formats.count;
    final lemmas = row.lemmaDisplay;
    final base = row.base;
    return InkWell(
      onTap: onTap,
      child: _TableLine(
        layout: layout,
        rank: Text('${count.format(rank)}.', style: numberStyle?.copyWith(color: muted)),
        main: layout.lemmaUnderForm && lemmas != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(row.displayForm, style: textTheme.bodyLarge),
                  Text(lemmas, style: textTheme.bodySmall?.copyWith(color: muted)),
                ],
              )
            : Text(row.displayForm, style: textTheme.bodyLarge),
        lemma: layout.lemmaColumn
            ? Text(lemmas ?? '—', style: textTheme.bodyMedium?.copyWith(color: muted))
            : null,
        frequency: Text(formats.frequency.format(frequency), style: numberStyle),
        single: layout.singleColumn
            ? Text(
                base is LemmaFrequencyRow ? count.format(base.singleCandidateOccurrences) : '—',
                style: numberStyle,
              )
            : null,
        count: Text(count.format(row.occurrences), style: numberStyle),
      ),
    );
  }

  //
}

/// Blocks pointer events while [child] is only partly visible in the viewport
///
/// This prevents clipped table rows from reacting to hover or taps
class _PointerWhenFullyVisible extends StatefulWidget {
  const _PointerWhenFullyVisible({
    required this.child,
  });

  final Widget child;

  @override
  State<_PointerWhenFullyVisible> createState() => _PointerWhenFullyVisibleState();
  //
}

class _PointerWhenFullyVisibleState extends State<_PointerWhenFullyVisible> {
  //
  ScrollableState? _scrollable;
  ScrollPosition? _position;
  var _fullyVisible = true;
  var _checkScheduled = false;

  @override
  void initState() {
    super.initState();
    _scheduleCheck();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollable = Scrollable.maybeOf(context);
    final position = _scrollable?.position;
    if (position != _position) {
      _position?.removeListener(_scheduleCheck);
      _position = position?..addListener(_scheduleCheck);
    }
  }

  @override
  void didUpdateWidget(_PointerWhenFullyVisible oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleCheck(); // a rebuild (resize, new layout) can move the row without scrolling
  }

  @override
  void dispose() {
    _position?.removeListener(_scheduleCheck);
    super.dispose();
  }

  @override
  Widget build(context) => IgnorePointer(ignoring: !_fullyVisible, child: widget.child);

  /// Checks once per frame, after layout, so the row's position matches the scroll offset
  void _scheduleCheck() {
    if (!_checkScheduled) {
      _checkScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkScheduled = false;
        if (mounted) {
          final fullyVisible = _isFullyVisible();
          if (fullyVisible != _fullyVisible) {
            setState(() => _fullyVisible = fullyVisible);
          }
        }
      });
    }
  }

  bool _isFullyVisible() {
    final row = context.findRenderObject();
    final viewport = _scrollable?.context.findRenderObject();
    final bool fullyVisible;
    if (row is RenderBox && viewport is RenderBox && row.attached && row.hasSize) {
      final top = row.localToGlobal(Offset.zero, ancestor: viewport).dy;
      // Allow for fractional scroll positions
      fullyVisible = top >= -0.5 && top + row.size.height <= viewport.size.height + 0.5;
    } else {
      fullyVisible = true;
    }
    return fullyVisible;
  }

  //
}

/// Lays out one table line. The header and every row use it, so the columns always line up.
///
/// Cells share the first text baseline; omit [lemma] or [single] to hide that column
class _TableLine extends StatelessWidget {
  const _TableLine({
    required this.layout,
    required this.rank,
    required this.main,
    required this.lemma,
    required this.frequency,
    required this.single,
    required this.count,
    this.verticalPadding = rowPadding,
    this.countOverhang = 0,
  });

  final _Layout layout;
  final Widget rank;

  /// FORM, or LEMMA when grouping by lemma
  final Widget main;
  final Widget? lemma;
  final Widget frequency;
  final Widget? single;
  final Widget count;
  final double verticalPadding;

  /// Extra width allowed past the normal end margin
  final double countOverhang;

  static const double rowPadding = 8;

  @override
  Widget build(context) {
    final lemma = this.lemma;
    final single = this.single;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        layout.margin,
        verticalPadding,
        layout.margin - countOverhang,
        verticalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          _fixed(layout.rankWidth, AlignmentDirectional.centerStart, rank),
          Expanded(child: main),
          if (lemma != null) ...[SizedBox(width: layout.columnSpacing), Expanded(child: lemma)],
          _fixed(layout.frequencyWidth, AlignmentDirectional.centerEnd, frequency),
          if (single != null) _fixed(layout.singleWidth, AlignmentDirectional.centerEnd, single),
          _fixed(layout.countWidth + countOverhang, AlignmentDirectional.centerEnd, count),
        ],
      ),
    );
  }

  /// Fixed-width cell that shrinks oversized content instead of wrapping
  Widget _fixed(double width, AlignmentDirectional alignment, Widget cell) => SizedBox(
    width: width,
    child: Align(
      alignment: alignment,
      child: FittedBox(fit: BoxFit.scaleDown, alignment: alignment, child: cell),
    ),
  );

  //
}

enum _RowDestination { morphology, dictionary }

Future<void> _onRowTapped(
  BuildContext context,
  WidgetRef ref,
  FrequencyFilter filter,
  EnrichedFrequencyRow row,
) async {
  // The lemma's dictionary form may have no stored morphological analysis
  if (filter.groupByLemma) {
    // We can't show the choice for the morphology page because we
    // cannot guarantee that we have the analysis for the form that
    // matches the lemma
    // TODO(whothefluff): create aware bottom sheet instead of circuit-breaking here
    await _goToDictionaryForLemma(context, ref, row.displayForm);
  } else {
    final view =
        ref.read(frequencyViewSettingsNotifierProvider).valueOrNull ?? const FrequencySettings();
    final choice = switch (view.formTapAction) {
      FormTapAction.ask => await _askDestination(context),
      FormTapAction.openMorphology => _RowDestination.morphology,
      FormTapAction.openDictionary => _RowDestination.dictionary,
    };
    if (choice != null && context.mounted) {
      switch (choice) {
        case _RowDestination.morphology:
          //if (filter.groupByLemma) {
          //await _goToMorphologyForLemma(context, ref, filter, row.displayForm);
          //} else {
          await _goToMorphologyForForm(context, ref, filter, row);
        //}
        case _RowDestination.dictionary:
          //if (filter.groupByLemma) {
          //await _goToDictionaryForLemma(context, ref, row.displayForm);
          //} else {
          await _goToDictionaryForForm(context, ref, row);
        //}
      }
    }
  }
}

Future<_RowDestination?> _askDestination(BuildContext context) =>
    showModalBottomSheet<_RowDestination>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.auto_stories_outlined),
              title: const Text('Morphology'),
              onTap: () => Navigator.pop(context, _RowDestination.morphology),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: const Text('Dictionary'),
              onTap: () => Navigator.pop(context, _RowDestination.dictionary),
            ),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
    );

Future<void> _goToMorphologyForForm(
  BuildContext context,
  WidgetRef ref,
  FrequencyFilter filter,
  EnrichedFrequencyRow row,
) async {
  final candidates = await ref.read(
    resolvedFreqMorphFormsProvider(
      filter.workIds,
      row.lookupForm,
      macronForm: filter.showMacrons ? row.displayForm : null,
    ).future,
  );
  if (context.mounted) {
    if (candidates.isEmpty) {
      _notFound(context, message: 'No morphology is available for this form.');
    } else {
      final lemmas = candidates.map((c) => c.dictionaryRef).toSet().toList()..sort();
      final chosen = await _pickLemma(context, lemmas);
      if (chosen != null && context.mounted) {
        /// Opens the morphological analyses identified by the supplied candidates
        await _openFrequencyMorphology(
          context,
          ref,
          candidates.where((c) => c.dictionaryRef == chosen),
        );
      }
    }
  }
}

/*
I might change my mind and generate the lemma form analysis at the same time,
so not deleted

Future<void> _goToMorphologyForLemma(
  BuildContext context,
  WidgetRef ref,
  FrequencyFilter filter,
  String dictionaryRef,
) async {
  final candidates = await ref.read(
    resolvedFreqMorphFormsOfLemmaProvider(WorkIds(filter.workIds), dictionaryRef).future,
  );
  if (context.mounted) {
    // Lemmas are counted under every form they appear as, so we need this variable
    final citation = dictionaryRef.replaceAll(RegExp(r'\d+$'), '');
    final own = candidates.where((c) => c.morphForm.toLowerCase() == citation.toLowerCase());
    if (own.isEmpty) {
      _notFound(context, message: 'No morphology is available for $citation.');
    } else {
      await _openFrequencyMorphology(context, ref, own);
    }
  }
} */

// A tap must resolve to the exact (form, item) identities the bridge already
// selected — not a fresh LIKE search, which can surface other case variants
// the row never actually counted.
Future<void> _openFrequencyMorphology(
  BuildContext context,
  WidgetRef ref,
  Iterable<FrequencyMorphCandidate> candidates,
) async {
  final itemsByForm = groupBy(
    candidates,
    (c) => c.morphForm,
  ).map((form, matches) => MapEntry(form, matches.map((c) => c.morphItem).toSet()));
  final batches = await Future.wait(
    // LIKE can return other spellings, keep only the exact form and item pairs of this freq. row
    itemsByForm.keys.map(
      (form) async => (await ref.read(
        morphologicalAnalysisKeysProvider(form).future,
      )).where((k) => k.form == form && itemsByForm[form]!.contains(k.item)),
    ),
  );
  if (context.mounted) {
    final keys = AnalysisKeys(batches.expand((batch) => batch));
    if (keys.isEmpty) {
      _notFound(context, message: 'No morphology is available for these analyses.');
    } else {
      await MorphologicalDataRoute(keys.toJson()).push<void>(context);
    }
  }
}

Future<void> _goToDictionaryForForm(
  BuildContext context,
  WidgetRef ref,
  EnrichedFrequencyRow row,
) async {
  final refs = row.possibleLemmas ?? const <String>[];
  if (refs.isEmpty) {
    _notFound(context);
  } else {
    final resolved = await ref.read(lnsBasicInfoProvider(PossibleLemmas(refs.toSet())).future);
    if (context.mounted) {
      final lemmas = resolved.values.map((e) => e.lemma).toSet().toList()..sort();
      if (lemmas.isEmpty) {
        _notFound(context);
      } else {
        final lns = await ref.read(lewisAndShortDictionaryProvider.future);
        final chosen = context.mounted ? await _pickLemma(context, lemmas) : null;
        if (chosen != null && context.mounted) {
          await DictionaryEntryRoute(lns.id, chosen).push<void>(context);
        }
      }
    }
  }
}

Future<String?> _pickLemma(BuildContext context, List<String> lemmas) => lemmas.length == 1
    ? Future.value(lemmas.first)
    : showModalBottomSheet<String>(
        context: context,
        builder: (context) => SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: lemmas
                .map((l) => ListTile(title: Text(l), onTap: () => Navigator.pop(context, l)))
                .toList(),
          ),
        ),
        clipBehavior: Clip.antiAlias,
      );

Future<void> _goToDictionaryForLemma(
  BuildContext context,
  WidgetRef ref,
  String dictionaryRef,
) async {
  final resolved = await ref.read(lnsBasicInfoProvider(PossibleLemmas([dictionaryRef])).future);
  if (context.mounted) {
    final entry = resolved[dictionaryRef];
    if (entry == null) {
      _notFound(context);
    } else {
      final lns = await ref.read(lewisAndShortDictionaryProvider.future);
      if (context.mounted) {
        await DictionaryEntryRoute(lns.id, entry.lemma).push<void>(context);
      }
    }
  }
}

void _notFound(
  BuildContext context, {
  String message = 'No dictionary entry found for this form.',
}) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

/// Whether focus highlights should be shown for keyboard navigation.
///
/// Some Flutter controls retain focus after mouse input or Alt+Tab, leaving
/// their focus highlight visible. Pointer input hides it; keyboard navigation
/// restores it.
final _InputModality _keyboardNavigation = _InputModality();

class _InputModality extends ValueNotifier<bool> {
  _InputModality() : super(false) {
    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_onPointer);
    HardwareKeyboard.instance.addHandler(_onKey);
  }

  /// Keys that only modify others: pressing them alone isn't navigating
  static final Set<LogicalKeyboardKey> _modifiers = {
    ...LogicalKeyboardKey.expandSynonyms({
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.meta,
    }),
    LogicalKeyboardKey.altGraph,
    LogicalKeyboardKey.capsLock,
    LogicalKeyboardKey.fn,
  };

  void _onPointer(PointerEvent event) {
    if (event is PointerDownEvent) {
      value = false;
    }
  }

  /// Only observes, so it never claims the event
  bool _onKey(KeyEvent event) {
    final keyboard = HardwareKeyboard.instance;
    if (event is KeyDownEvent &&
        !event.synthesized &&
        !_modifiers.contains(event.logicalKey) &&
        !keyboard.isControlPressed &&
        !keyboard.isAltPressed &&
        !keyboard.isMetaPressed) {
      value = true;
    }
    return false;
  }

  //
}
