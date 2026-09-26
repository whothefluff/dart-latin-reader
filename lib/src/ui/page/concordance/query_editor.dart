import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../component/concordance/concordance_query.dart';
import '../../../component/concordance/grammar_values_api.dart';
import '../../../component/concordance/lemma_choices_api.dart';
import '../../../component/library/catalog_api.dart';
import '../../../component/settings/concordance_settings_api.dart';
import '../../../component/word_frequency/library_selection_api.dart';
import '../../widget/library_filter_dialog.dart';
import '../library/work_index_sheet.dart';
import 'common.dart';

/// Opens [QueryEditor] in a dialog over the page and returns the query to
/// search, or null when closed
Future<ConcordanceQuery?> showQueryEditorDialog(BuildContext context, ConcordanceQuery query) =>
    showDialog<ConcordanceQuery>(
      context: context,
      builder: (dialogContext) => _QueryDialog(
        title: 'Edit search',
        child: QueryEditor(
          initial: query,
          onSearch: (edited) => Navigator.pop(dialogContext, edited),
        ),
      ),
    );

/// Shows all of [query] in the editor, every control disabled
Future<void> showQueryDetails(BuildContext context, ConcordanceQuery query) => showDialog<void>(
  context: context,
  builder: (_) => _QueryDialog(
    title: 'Search',
    child: QueryEditor(initial: query, onSearch: null),
  ),
);

/// A dialog with a title and a close button over a scrolling [child]
class _QueryDialog extends StatelessWidget {
  const _QueryDialog({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(context) => Dialog(
    insetPadding: const EdgeInsets.all(24),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 12, 0),
            child: Row(
              children: [
                Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
                IconButton(
                  tooltip: 'Close',
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: child,
            ),
          ),
        ],
      ),
    ),
  );

  //
}

/// Edits a draft of a query: up to [ConcordanceQuery.maxSlots] words, each a
/// form, a lemma or a grammatical description, and where to look for them
///
/// Nothing is searched until [onSearch]; without it, the query can only be seen
class QueryEditor extends ConsumerStatefulWidget {
  const QueryEditor({
    super.key,
    required this.initial,
    required this.onSearch,
  });

  /// Null for a new search
  final ConcordanceQuery? initial;

  /// Null disables every control
  final ValueChanged<ConcordanceQuery>? onSearch;

  @override
  ConsumerState<QueryEditor> createState() => _QueryEditorState();
  //
}

class _QueryEditorState extends ConsumerState<QueryEditor> {
  //
  late List<_SlotDraft> _slots = _initialSlots(widget.initial);
  late int _nextSlotId = _slots.length;
  late bool _matchMacrons = widget.initial?.matchMacrons ?? false;
  late LibrarySelection _selection = widget.initial?.selection ?? const LibrarySelection.empty();
  late WorkPart? _part = widget.initial?.part;
  late ConcordanceTitles _titles = widget.initial?.titles ?? ConcordanceTitles.included;
  late ConcordanceSort _sort = widget.initial?.sort ?? ConcordanceSort.textOrder;

  /// Hits per page.
  /// Not part of the query.
  int? _pageSize;

  static List<_SlotDraft> _initialSlots(ConcordanceQuery? query) => switch (query) {
    final query? =>
      query.slots
          .mapIndexed(
            // the first slot's distance is never used
            (i, criterion) => _SlotDraft.of(i, criterion, i == 0 ? 1 : query.distanceBefore(i)),
          )
          .toList(),
    null => [const _SlotDraft(id: 0)],
  };

  /// What the draft searches for, or null while a slot has nothing in it
  ConcordanceQuery? get _query {
    final criteria = _slots.map((slot) => slot.criterion).toList();
    final query = ConcordanceQuery(
      slots: criteria.nonNulls,
      distances: _slots.skip(1).map((slot) => slot.distance),
      matchMacrons: _matchMacrons,
      selection: _selection,
      part: _part,
      titles: _titles,
      sort: _sort,
    );
    return criteria.contains(null) || !query.isComplete ? null : query;
  }

  @override
  Widget build(context) {
    final catalog = ref.watch(libraryCatalogProvider).valueOrNull;
    final settings =
        ref.watch(concordanceSettingsNotifierProvider).valueOrNull ?? const ConcordanceSettings();
    final pageSize = _pageSize ?? settings.pageSize;
    final pageSizes = {...ConcordanceSettings.pageSizes, pageSize}.sorted((a, b) => a - b);
    final count = NumberFormat.decimalPattern(Localizations.localeOf(context).toString());
    final query = _query;
    final enabled = widget.onSearch != null;
    final singleWork = catalog == null ? null : _onlyWork(catalog);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._slots.mapIndexed(
          (i, slot) => _SlotEditor(
            key: ValueKey(slot.id),
            number: i + 1,
            draft: slot,
            onChanged: enabled
                ? (edited) => setState(() => _slots = [..._slots]..[i] = edited)
                : null,
            onRemove: _slots.length == 1
                ? null
                : () => setState(() => _slots = [..._slots]..removeAt(i)),
            onSubmitted: enabled && query != null ? () async => _search(query) : null,
          ),
        ),
        if (_slots.length < ConcordanceQuery.maxSlots)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: enabled ? _addSlot : null,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Add a word after it'),
            ),
          ),
        const Divider(height: 24),
        _FieldButton(
          label: 'Works',
          icon: Icons.filter_alt_outlined,
          value: selectionSummary(_selection),
          onTap: enabled && catalog != null ? () => _pickWorks(catalog) : null,
        ),
        if (singleWork != null) ...[
          const SizedBox(height: 12),
          _FieldButton(
            label: 'Part',
            icon: workIndexIcon,
            value: _part?.label ?? 'The whole work',
            onTap: enabled ? () => _pickPart(singleWork) : null,
            onClear: enabled && _part != null ? () => setState(() => _part = null) : null,
          ),
        ],
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Tooltip(
              message: 'A typed word only matches the same macrons (rosa is not rosā)',
              child: InkWell(
                onTap: enabled ? () => setState(() => _matchMacrons = !_matchMacrons) : null,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _matchMacrons,
                      onChanged: enabled
                          ? (value) => setState(() => _matchMacrons = value ?? false)
                          : null,
                    ),
                    const Text('Match macrons'),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Titles'),
                const SizedBox(width: 8),
                DropdownButton<ConcordanceTitles>(
                  value: _titles,
                  isDense: true,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  items: ConcordanceTitles.values
                      .map(
                        (titles) =>
                            DropdownMenuItem(value: titles, child: Text(titlesLabel(titles))),
                      )
                      .toList(),
                  onChanged: enabled
                      ? (titles) => setState(() => _titles = titles ?? _titles)
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Sort by'),
                const SizedBox(width: 8),
                DropdownButton<ConcordanceSort>(
                  value: _sort,
                  isDense: true,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  items: ConcordanceSort.values
                      .map((sort) => DropdownMenuItem(value: sort, child: Text(sortLabel(sort))))
                      .toList(),
                  onChanged: enabled ? (sort) => setState(() => _sort = sort ?? _sort) : null,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Per page'),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: pageSize,
                  isDense: true,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  items: pageSizes
                      .map((size) => DropdownMenuItem(value: size, child: Text(count.format(size))))
                      .toList(),
                  onChanged: enabled
                      ? (size) => setState(() => _pageSize = size ?? _pageSize)
                      : null,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        OverflowBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: enabled ? _clear : null,
              child: const Text('Clear'),
            ),
            FilledButton.icon(
              onPressed: enabled && query != null ? () async => _search(query) : null,
              icon: const Icon(Icons.search),
              label: const Text('Search'),
            ),
          ],
        ),
      ],
    );
  }

  /// The one work that can be searched, if there's only one, so that a part of
  /// it can be picked
  CatalogWork? _onlyWork(LibraryCatalog catalog) {
    final works = catalog.authors
        .expand((author) => author.works)
        .followedBy(catalog.anonymousWorks)
        .where((work) => _selection.isEmpty || _selection.allWorkIds.contains(work.id))
        .toSet();
    return works.length == 1 ? works.single : null;
  }

  void _addSlot() => setState(() {
    _slots = [..._slots, _SlotDraft(id: _nextSlotId)];
    _nextSlotId++;
  });

  void _clear() => setState(() {
    _slots = [_SlotDraft(id: _nextSlotId)];
    _nextSlotId++;
    _matchMacrons = false;
    _selection = const LibrarySelection.empty();
    _part = null;
    _titles = ConcordanceTitles.included;
    _sort = ConcordanceSort.textOrder;
    _pageSize = const ConcordanceSettings().pageSize;
  });

  /// Keeps a page size picked here, then searches. The size is set before
  /// [QueryEditor.onSearch] goes to the hits, so they're read once, at that size
  Future<void> _search(ConcordanceQuery query) async {
    final pageSize = _pageSize;
    final settings = ref.read(concordanceSettingsNotifierProvider).valueOrNull;
    final saving = pageSize == null || settings == null
        ? null
        : ref
              .read(concordanceSettingsNotifierProvider.notifier)
              .updateSettings(settings.copyWith(pageSize: pageSize));
    widget.onSearch?.call(query);
    await saving;
  }

  Future<void> _pickWorks(LibraryCatalog catalog) async {
    final picked = await showDialog<LibrarySelection>(
      context: context,
      builder: (_) => LibraryFilterDialog(catalog: catalog, selection: _selection),
    );
    if (picked != null && mounted) {
      setState(() {
        _selection = picked;
        // A part only makes sense while its work is the only one searched
        final part = _part;
        _part = part != null && _onlyWork(catalog)?.id == part.workId ? part : null;
      });
    }
  }

  Future<void> _pickPart(CatalogWork work) async {
    final entry = await showWorkIndex(
      context: context,
      workId: work.id,
      workName: work.name,
      currentIndex: _part?.fromIndex ?? -1,
    );
    if (entry != null && mounted) {
      setState(
        () => _part = WorkPart(
          workId: entry.workId,
          fromIndex: entry.fromIndex,
          toIndex: entry.toIndex,
          label: '${entry.label} (${entry.referenceLabel})',
        ),
      );
    }
  }

  //
}

enum _SlotKind { form, lemma, grammar }

/// A slot as it's being edited. Every kind keeps its input, so switching kinds
/// back and forth loses nothing
@immutable
class _SlotDraft {
  const _SlotDraft({
    required this.id,
    this.kind = _SlotKind.form,
    this.text = '',
    this.exactCase = false,
    this.lemma,
    this.grammar = const GrammarFilter.empty(),
    this.distance = 1,
  });

  factory _SlotDraft.of(int id, ConcordanceCriterion criterion, int? distance) =>
      switch (criterion) {
        FormCriterion(:final text, :final exactCase) => _SlotDraft(
          id: id,
          text: text,
          exactCase: exactCase,
          distance: distance,
        ),
        LemmaCriterion(:final lemma) => _SlotDraft(
          id: id,
          kind: _SlotKind.lemma,
          lemma: lemma,
          distance: distance,
        ),
        GrammarCriterion(:final grammar, :final lemma) => _SlotDraft(
          id: id,
          kind: _SlotKind.grammar,
          lemma: lemma,
          grammar: grammar,
          distance: distance,
        ),
      };

  /// Identifies the slot's editor while slots are added and removed
  final int id;

  final _SlotKind kind;
  final String text;
  final bool exactCase;

  /// Required for [_SlotKind.lemma], optional for [_SlotKind.grammar]
  final LemmaChoice? lemma;

  final GrammarFilter grammar;

  /// How far after the previous slot (see [ConcordanceQuery.distances])
  final int? distance;

  /// Null while there's nothing to search for
  ConcordanceCriterion? get criterion {
    final criterion = switch (kind) {
      _SlotKind.form => FormCriterion(text, exactCase: exactCase),
      _SlotKind.lemma => switch (lemma) {
        final lemma? => LemmaCriterion(lemma),
        null => null,
      },
      _SlotKind.grammar => GrammarCriterion(grammar, lemma: lemma),
    };
    return (criterion?.isComplete ?? false) ? criterion : null;
  }

  _SlotDraft _with({
    _SlotKind? kind,
    String? text,
    bool? exactCase,
    GrammarFilter? grammar,
  }) => _SlotDraft(
    id: id,
    kind: kind ?? this.kind,
    text: text ?? this.text,
    exactCase: exactCase ?? this.exactCase,
    lemma: lemma,
    grammar: grammar ?? this.grammar,
    distance: distance,
  );

  _SlotDraft withKind(_SlotKind kind) => _with(kind: kind);

  _SlotDraft withText(String text) => _with(text: text);

  _SlotDraft withExactCase({required bool exactCase}) => _with(exactCase: exactCase);

  _SlotDraft withGrammar(GrammarFilter grammar) => _with(grammar: grammar);

  _SlotDraft withLemma(LemmaChoice? lemma) => _SlotDraft(
    id: id,
    kind: kind,
    text: text,
    exactCase: exactCase,
    lemma: lemma,
    grammar: grammar,
    distance: distance,
  );

  _SlotDraft withDistance(int? distance) => _SlotDraft(
    id: id,
    kind: kind,
    text: text,
    exactCase: exactCase,
    lemma: lemma,
    grammar: grammar,
    distance: distance,
  );

  @override
  String toString() => '_SlotDraft{id: $id, kind: ${kind.name}}';
  //
}

class _SlotEditor extends StatelessWidget {
  const _SlotEditor({
    super.key,
    required this.number,
    required this.draft,
    required this.onChanged,
    required this.onRemove,
    required this.onSubmitted,
  });

  /// Position in the phrase, from 1
  final int number;

  final _SlotDraft draft;

  /// Null disables the word
  final ValueChanged<_SlotDraft>? onChanged;

  /// Null for the only slot
  final VoidCallback? onRemove;

  /// Null while the query can't be searched
  final VoidCallback? onSubmitted;

  static const Map<int, String> _distances = {
    1: 'right after',
    2: 'within 2 words after',
    3: 'within 3 words after',
    5: 'within 5 words after',
    10: 'within 10 words after',
    // DropdownButton shows its hint for a null value, so 0 stands for null
    0: 'anywhere after, same sentence',
  };

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final onChanged = this.onChanged;
    final distance = draft.distance ?? 0;
    // A distance from elsewhere (a link) may not be one of the usual ones
    final distances = {
      ..._distances,
      distance: _distances[distance] ?? 'within $distance words after',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (number > 1)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8, bottom: 4),
            child: Row(
              children: [
                Icon(Icons.subdirectory_arrow_right, size: 18, color: theme.hintColor),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: distance,
                  isDense: true,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  items: distances.entries
                      .map((entry) => DropdownMenuItem(value: entry.key, child: Text(entry.value)))
                      .toList(),
                  onChanged: onChanged == null
                      ? null
                      : (value) => onChanged(
                          draft.withDistance(value == 0 ? null : (value ?? draft.distance)),
                        ),
                ),
              ],
            ),
          ),
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: theme.colorScheme.secondaryContainer,
              child: Text('$number', style: theme.textTheme.labelMedium),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: SegmentedButton<_SlotKind>(
                  showSelectedIcon: false,
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                  segments: const [
                    ButtonSegment(value: _SlotKind.form, label: Text('Form')),
                    ButtonSegment(value: _SlotKind.lemma, label: Text('Lemma')),
                    ButtonSegment(value: _SlotKind.grammar, label: Text('Grammar')),
                  ],
                  selected: {draft.kind},
                  onSelectionChanged: onChanged == null
                      ? null
                      : (kinds) => onChanged(draft.withKind(kinds.single)),
                ),
              ),
            ),
            if (onRemove != null)
              IconButton(
                tooltip: 'Remove word $number',
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onChanged == null ? null : onRemove,
              ),
          ],
        ),
        const SizedBox(height: 12),
        switch (draft.kind) {
          _SlotKind.form => _FormField(
            draft: draft,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
          _SlotKind.lemma => _LemmaField(
            lemma: draft.lemma,
            label: 'Lemma',
            onChanged: onChanged == null ? null : (lemma) => onChanged(draft.withLemma(lemma)),
          ),
          _SlotKind.grammar => _GrammarFields(draft: draft, onChanged: onChanged),
        },
        const SizedBox(height: 16),
      ],
    );
  }

  //
}

class _FormField extends StatefulWidget {
  const _FormField({
    required this.draft,
    required this.onChanged,
    required this.onSubmitted,
  });

  final _SlotDraft draft;

  /// Null disables the field
  final ValueChanged<_SlotDraft>? onChanged;

  final VoidCallback? onSubmitted;

  @override
  State<_FormField> createState() => _FormFieldState();
  //
}

class _FormFieldState extends State<_FormField> {
  //
  late final _controller = TextEditingController(text: widget.draft.text);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final draft = widget.draft;
    final onChanged = widget.onChanged;
    return TextField(
      controller: _controller,
      enabled: onChanged != null,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        labelText: 'Word form',
        hintText: 'e.g. puellam, Marcus, que',
        helperText: draft.exactCase
            ? 'Only this capitalization'
            : 'Capitalized (proper nouns) or not',
        border: const OutlineInputBorder(),
        isDense: true,
        suffixIcon: IconButton(
          tooltip: 'Match capitalization',
          isSelected: draft.exactCase,
          icon: const Icon(Icons.text_fields),
          selectedIcon: const Icon(Icons.text_format),
          onPressed: onChanged == null
              ? null
              : () => onChanged(draft.withExactCase(exactCase: !draft.exactCase)),
        ),
      ),
      onChanged: (text) => onChanged?.call(draft.withText(text)),
      onSubmitted: (_) => widget.onSubmitted?.call(),
    );
  }

  //
}

/// Picks a lemma among those with forms in the corpus
class _LemmaField extends ConsumerStatefulWidget {
  const _LemmaField({
    required this.lemma,
    required this.label,
    required this.onChanged,
  });

  final LemmaChoice? lemma;
  final String label;

  /// Null disables the field
  final ValueChanged<LemmaChoice?>? onChanged;

  @override
  ConsumerState<_LemmaField> createState() => _LemmaFieldState();
  //
}

class _LemmaFieldState extends ConsumerState<_LemmaField> {
  //
  late final _controller = TextEditingController(
    text: switch (widget.lemma) {
      final lemma? => lemmaText(lemma.label),
      null => '',
    },
  );
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final lemma = widget.lemma;
    return RawAutocomplete<LemmaChoice>(
      textEditingController: _controller,
      focusNode: _focusNode,
      displayStringForOption: (choice) => lemmaText(choice.label),
      optionsBuilder: (value) async => value.text.trim().isEmpty
          ? const <LemmaChoice>[]
          : await ref.read(lemmaChoicesProvider(value.text).future),
      onSelected: (choice) => widget.onChanged?.call(choice),
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => TextField(
        controller: controller,
        focusNode: focusNode,
        enabled: widget.onChanged != null,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: 'Start typing, e.g. puella',
          helperText: lemma == null ? 'Pick one of the suggestions' : lemmaDetails(lemma),
          border: const OutlineInputBorder(),
          isDense: true,
          prefixIcon: Icon(lemma == null ? Icons.search : Icons.check),
        ),
        // Editing the text drops the lemma until another is picked
        onChanged: (_) {
          if (lemma != null) {
            widget.onChanged?.call(null);
          }
        },
        onSubmitted: (_) => onFieldSubmitted(),
      ),
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Material(
          elevation: 4,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280, maxWidth: 420),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: options
                  .map(
                    (choice) => ListTile(
                      dense: true,
                      title: Text(lemmaText(choice.label)),
                      subtitle: Text(lemmaDetails(choice)),
                      onTap: () => onSelected(choice),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  //
}

/// Part of speech and the features it has in the analyses, plus a lemma
class _GrammarFields extends ConsumerWidget {
  const _GrammarFields({
    required this.draft,
    required this.onChanged,
  });

  final _SlotDraft draft;

  /// Null disables the fields
  final ValueChanged<_SlotDraft>? onChanged;

  @override
  Widget build(context, ref) {
    final values = ref.watch(grammarValuesProvider).valueOrNull;
    final onChanged = this.onChanged;
    final grammar = draft.grammar;
    final partOfSpeech = grammar.values[GrammarFeature.partOfSpeech];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _FeatureDropdown(
              feature: GrammarFeature.partOfSpeech,
              value: partOfSpeech,
              options: values?.partsOfSpeech ?? const [],
              onChanged: onChanged == null
                  ? null
                  : (value) => onChanged(draft.withGrammar(_withPartOfSpeech(value, values))),
            ),
            ...GrammarFeature.values
                .where((feature) => feature != GrammarFeature.partOfSpeech)
                .map(
                  (feature) => (
                    feature: feature,
                    options:
                        values?.valuesOf(feature, partOfSpeech: partOfSpeech) ?? const <String>{},
                  ),
                )
                .where((entry) => entry.options.isNotEmpty)
                .map(
                  (entry) => _FeatureDropdown(
                    feature: entry.feature,
                    value: grammar.values[entry.feature],
                    options: grammarOrder(entry.options),
                    onChanged: onChanged == null
                        ? null
                        : (value) =>
                              onChanged(draft.withGrammar(grammar.withValue(entry.feature, value))),
                  ),
                ),
          ],
        ),
        const SizedBox(height: 12),
        _LemmaField(
          lemma: draft.lemma,
          label: 'Lemma (optional)',
          onChanged: onChanged == null ? null : (lemma) => onChanged(draft.withLemma(lemma)),
        ),
      ],
    );
  }

  /// Sets the part of speech, dropping the values it never has
  GrammarFilter _withPartOfSpeech(String? partOfSpeech, GrammarValues? values) {
    final grammar = draft.grammar.withValue(GrammarFeature.partOfSpeech, partOfSpeech);
    return GrammarFilter(
      Map.fromEntries(
        grammar.values.entries.where(
          (entry) =>
              entry.key == GrammarFeature.partOfSpeech ||
              (values?.valuesOf(entry.key, partOfSpeech: partOfSpeech).contains(entry.value) ??
                  true),
        ),
      ),
    );
  }

  //
}

class _FeatureDropdown extends StatelessWidget {
  const _FeatureDropdown({
    required this.feature,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final GrammarFeature feature;

  /// Null for any
  final String? value;

  final List<String> options;

  /// Null disables the dropdown
  final ValueChanged<String?>? onChanged;

  /// DropdownButton shows its hint for a null value, so '' stands for any
  static const _any = '';

  @override
  Widget build(context) {
    final onChanged = this.onChanged;
    return SizedBox(
      width: 176,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: featureLabel(feature),
          enabled: onChanged != null,
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: options.contains(value) ? value : _any,
            isDense: true,
            isExpanded: true,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            items: [
              const DropdownMenuItem(value: _any, child: Text('Any')),
              ...options.map(
                (option) => DropdownMenuItem(value: option, child: Text(grammarValueLabel(option))),
              ),
            ],
            onChanged: onChanged == null
                ? null
                : (option) => onChanged(option == _any ? null : option),
          ),
        ),
      ),
    );
  }

  //
}

/// A field that opens a picker, with an optional button to clear it
class _FieldButton extends StatelessWidget {
  const _FieldButton({
    required this.label,
    required this.icon,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final IconData icon;
  final String value;

  /// Null while there's nothing to pick from
  final VoidCallback? onTap;

  /// Null when there's nothing to clear
  final VoidCallback? onClear;

  @override
  Widget build(context) {
    final onClear = this.onClear;
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(4)), // OutlineInputBorder's default
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          enabled: onTap != null,
          isDense: true,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
          suffixIcon: onClear == null
              ? const Icon(Icons.arrow_drop_down)
              : IconButton(tooltip: 'Clear', icon: const Icon(Icons.clear), onPressed: onClear),
        ),
        child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  //
}
