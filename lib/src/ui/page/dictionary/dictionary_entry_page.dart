import 'dart:collection';
import 'dart:math' show max;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/dictionary/dictionary_entry_senses_api.dart';
import '../../../component/settings/dictionary_settings_api.dart';
import '../../router/config.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import '../settings/settings_shell_page.dart' show SettingsTab;

class DictionaryEntryPage extends ConsumerWidget {
  const DictionaryEntryPage(
    this.dictionary,
    this.lemma, {
    super.key,
  });

  final String dictionary;
  final String lemma;

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: AppBar(
      title: Text(lemma),
      actions: [
        IconButton(
          tooltip: 'Dictionary settings',
          icon: const Icon(Icons.settings),
          onPressed: () async =>
              const SettingsRoute(tab: SettingsTab.dictionaries).push<void>(context),
        ),
      ],
    ),
    body: entriesList(ref, context),
  );

  Widget entriesList(WidgetRef ref, BuildContext context) => ref
      .watch(dictionaryEntrySensesProvider(dictionary, lemma))
      .when(
        data: (senses) => SingleChildScrollView(
          child: _senses(ref, senses),
        ),
        loading: showLoading,
        error: showError(ref, dictionaryEntrySensesProvider(dictionary, lemma)),
      );

  _Senses _senses(WidgetRef ref, List<EntrySense> senses) {
    final settings =
        ref.watch(dictionarySettingsNotifierProvider).valueOrNull ?? const DictionarySettings();
    return _Senses(
      _groupSenses(senses),
      // The settings can load after the senses, and a new value has to start them over
      key: ValueKey(settings.openFirstSense),
      openFirstSense: settings.openFirstSense,
    );
  }

  //
}

LinkedHashMap<String, List<EntrySense>> _groupSenses(List<EntrySense> senses) =>
    LinkedHashMap.fromEntries(
      groupBy(
        senses,
        (sense) => sense.prettyLevel.split('.').first,
      ).entries.toList()..sort(
        (a, b) => int.parse(a.key).compareTo(int.parse(b.key)),
      ),
    );

/// The top-level senses of an entry, with at most one of them open
class _Senses extends StatefulWidget {
  const _Senses(
    this.groupedSenses, {
    super.key,
    required this.openFirstSense,
  });

  final LinkedHashMap<String, List<EntrySense>> groupedSenses;

  /// Whether the first sense starts open, when it has anything to open
  final bool openFirstSense;

  @override
  State<_Senses> createState() => _SensesState();
  //
}

class _SensesState extends State<_Senses> {
  //
  String? _openLevel;

  @override
  void initState() {
    super.initState();
    _openLevel = widget.openFirstSense ? widget.groupedSenses.keys.firstOrNull : null;
  }

  @override
  Widget build(context) => LayoutBuilder(
    builder: (context, constraints) => MergeableMaterial(
      hasDividers: true,
      children: _items(_tiles(context, constraints.maxWidth)),
    ),
  );

  List<_SenseTile> _tiles(BuildContext context, double width) => widget.groupedSenses.entries
      .map((group) => _tile(context, width, group.key, group.value))
      .toList();

  _SenseTile _tile(BuildContext context, double width, String level, List<EntrySense> hierarchy) {
    final top = TabulatedText(
      prettyLevel: hierarchy.first.prettyLevel,
      content: hierarchy.first.content,
    );
    final collapsible =
        widget.groupedSenses.length > 1 &&
        (hierarchy.length > 1 || !top.fitsOneLine(context, width - _SenseTile.arrowWidth));
    return _SenseTile(
      hierarchy,
      collapsible: collapsible,
      open: collapsible && _openLevel == level,
      onToggle: () => setState(() => _openLevel = _openLevel == level ? null : level),
    );
  }

  List<MergeableMaterialItem> _items(List<_SenseTile> tiles) => tiles
      .expandIndexed(
        (index, tile) => [
          if (tile.open && index > 0) MaterialGap(key: ValueKey('gap ${index - 1}')),
          MaterialSlice(key: ValueKey(tile.hierarchy.first.prettyLevel), child: tile),
          if (tile.open && index < tiles.length - 1) MaterialGap(key: ValueKey('gap $index')),
        ],
      )
      .toList();
  //
}

/// A top-level sense over its subsenses.
///
/// When [collapsible], its header opens and closes it on tap, and copies the
/// sense on long-press or right-click.
/// Otherwise all of it is selectable
class _SenseTile extends StatelessWidget {
  const _SenseTile(
    this.hierarchy, {
    required this.collapsible,
    required this.open,
    required this.onToggle,
  });

  static const _arrowEndPadding = 8.0;
  // dart format off
  static final Map<bool,
                   ({int? maxLines, TextOverflow textOverflow})>
      _toggle = {
    true: (textOverflow: TextOverflow.visible, maxLines: null),
    false: (textOverflow: TextOverflow.ellipsis, maxLines: 1),
  };
  // dart format on

  /// What the expand icon takes at the end of a header
  static const double arrowWidth = kMinInteractiveDimension + _arrowEndPadding;

  final List<EntrySense> hierarchy;
  final bool collapsible;
  final bool open;
  final VoidCallback onToggle;

  @override
  Widget build(context) => collapsible
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context),
            body(),
          ],
        )
      : SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topSense(),
              subsenses(),
            ],
          ),
        );

  Widget header(BuildContext context) => MergeSemantics(
    child: InkWell(
      onTap: onToggle,
      onLongPress: () async => copy(context),
      onSecondaryTap: () async => copy(context),
      child: Row(
        children: [
          Expanded(child: topSense()),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: _arrowEndPadding),
            child: IgnorePointer(
              child: SizedBox.square(
                dimension: kMinInteractiveDimension,
                child: ExpandIcon(
                  isExpanded: open,
                  padding: const EdgeInsets.all(12),
                  onPressed: (_) => onToggle(),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget body() => AnimatedSize(
    duration: kThemeAnimationDuration,
    curve: Curves.fastOutSlowIn,
    alignment: Alignment.topCenter,
    child: open
        ? Align(
            alignment: AlignmentDirectional.centerStart,
            child: SelectionArea(child: subsenses()),
          )
        : const SizedBox(width: double.infinity),
  );

  Widget topSense() => ConstrainedBox(
    constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TabulatedText(
          textOverflow: _toggle[!collapsible || open]!.textOverflow,
          prettyLevel: hierarchy.first.prettyLevel,
          content: hierarchy.first.content,
          maxLines: _toggle[!collapsible || open]!.maxLines,
        ),
      ),
    ),
  );

  Widget subsenses() {
    final subsenses = _groupSenses(hierarchy.sublist(1)).values.toList();
    const interline = EdgeInsets.symmetric(vertical: 8.0);
    return Column(
      children: subsenses
          .map(
            (senses) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: senses
                  .map(
                    (sense) => Padding(
                      padding: interline,
                      child: TabulatedText(
                        prettyLevel: sense.prettyLevel,
                        content: sense.content,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Future<void> copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: hierarchy.first.content));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sense copied')));
    }
  }

  //
}

class TabulatedText extends StatelessWidget {
  const TabulatedText({
    super.key,
    required this.prettyLevel,
    required this.content,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
  });

  final String prettyLevel;
  final String content;
  final TextOverflow textOverflow;
  final int? maxLines;

  double _indentation() => prettyLevel.split('.').length * 20;

  @override
  Widget build(context) => Padding(
    padding: EdgeInsets.only(left: _indentation()),
    child: text(context),
  );

  Text text(BuildContext context) => Text.rich(
    TextSpan(children: _textContent(context)),
    overflow: textOverflow,
    maxLines: maxLines,
  );

  /// Whether all of it fits in one line of [width], indentation included
  bool fitsOneLine(BuildContext context, double width) {
    final painter = TextPainter(
      text: TextSpan(style: DefaultTextStyle.of(context).style, children: _textContent(context)),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout(maxWidth: max(0.0, width - _indentation()));
    final fits = !painter.didExceedMaxLines;
    painter.dispose();
    return fits;
  }

  List<TextSpan> _textContent(BuildContext context) => [
    TextSpan(
      text: '$prettyLevel. ',
      style: TextStyle(fontWeight: FontWeight.bold, color: ColorScheme.of(context).primary),
    ),
    TextSpan(
      text: content,
      style: TextStyle(color: ColorScheme.of(context).secondary),
    ),
  ];
  //
}
