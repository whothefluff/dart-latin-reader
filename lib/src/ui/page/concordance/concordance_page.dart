import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../logger.dart';
import '../../../component/concordance/concordance_api.dart';
import '../../../component/concordance/concordance_query.dart';
import '../../../component/library/catalog_api.dart';
import '../../../component/library/reading_start_api.dart';
import '../../../component/settings/concordance_settings_api.dart';
import '../../../component/settings/reader_settings_api.dart';
import '../../router/config.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import 'common.dart';
import 'query_editor.dart';

/// Searches the library for how words are used: the search form, the tab's
/// first page
///
/// Searching goes to [ConcordanceHitsPage], over this page, so back from the
/// hits comes here to edit their search
class ConcordancePage extends StatelessWidget {
  const ConcordancePage({
    super.key,
    required this.query,
  });

  /// What the form starts with. Null for a new search
  final ConcordanceQuery? query;

  @override
  Widget build(context) => SafeBodyScaffold(
    appBar: AppBar(title: const Text('Concordance')),
    body: _Editor(initial: query),
  );

  //
}

/// A page of the hits of a search
///
/// The query and the page are part of the route, so a search is always
/// something to go to: [ConcordanceHitsRoute]
class ConcordanceHitsPage extends StatelessWidget {
  const ConcordanceHitsPage({
    super.key,
    required this.query,
    required this.offset,
  });

  final ConcordanceQuery query;
  final int offset;

  @override
  Widget build(context) => SafeBodyScaffold(
    appBar: AppBar(
      title: const Text('Concordance'),
      notificationPredicate: (_) => false, //only the hits scroll
    ),
    body: _Results(query: query, offset: offset),
  );

  //
}

/// Shows the hits over the form, which then holds [query]
void _search(BuildContext context, ConcordanceQuery query, {int offset = 0}) =>
    ConcordanceHitsRoute(search: query.toJson(), offset: offset).go(context);

/// The query editor, introduced when the search is a new one
class _Editor extends StatelessWidget {
  const _Editor({
    required this.initial,
  });

  /// Null for a new search
  final ConcordanceQuery? initial;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(Breakpoints.mediumAndUp.isActive(context) ? 24 : 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (initial == null) ...[
                Text(
                  'Find how words are used in the library. A word can be a form as '
                  'written, any form of a lemma, or a grammatical description. Add '
                  'more words to find them together in a sentence.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
              ],
              QueryEditor(
                // Starts over when the hits above are of another search (from
                // Frequency, sorted another way), not for another page of them
                key: ValueKey(initial?.toJson()),
                initial: initial,
                onSearch: (query) => _search(context, query),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
}

class _Results extends ConsumerWidget {
  const _Results({
    required this.query,
    required this.offset,
  });

  final ConcordanceQuery query;
  final int offset;

  @override
  Widget build(context, ref) {
    final provider = concordanceSettingsNotifierProvider;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _QuerySummary(query: query),
        const Divider(height: 1),
        Expanded(
          child: ref
              .watch(provider)
              .when(
                data: (settings) => _Page(query: query, offset: offset, size: settings.pageSize),
                loading: showLoading,
                error: showError(ref, provider),
              ),
        ),
      ],
    );
  }

  //
}

/// [size] hits from [offset] on
class _Page extends ConsumerWidget {
  const _Page({
    required this.query,
    required this.offset,
    required this.size,
  });

  final ConcordanceQuery query;
  final int offset;
  final int size;

  @override
  Widget build(context, ref) {
    final provider = concordanceHitsProvider(query, offset, size);
    return ref
        .watch(provider)
        .when(
          data: (hits) => _HitList(query: query, hits: hits, pageSize: size),
          loading: showLoading,
          error: showError(ref, provider),
        );
  }

  //
}

/// The searched phrase and scope; tapping it edits the query, over the hits on
/// wide windows (back is for editing it alone)
class _QuerySummary extends StatelessWidget {
  const _QuerySummary({
    required this.query,
  });

  final ConcordanceQuery query;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final margin = _margin(context);
    return InkWell(
      onTap: () => _edit(context),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(margin, 8, margin - 8, 8),
        child: Row(
          children: [
            const Icon(Icons.manage_search),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(describePhrase(query), maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text(
                    describeScope(query),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Edit the search',
              icon: const Icon(Icons.edit),
              onPressed: () => _edit(context),
            ),
          ],
        ),
      ),
    );
  }

  /// In a dialog on wide windows. On narrow ones, where it would cover the
  /// hits anyway, back on the form under them, which holds their query
  Future<void> _edit(BuildContext context) async {
    if (Breakpoints.mediumAndUp.isActive(context)) {
      final edited = await showQueryEditorDialog(context, query);
      if (edited != null && context.mounted) {
        _search(context, edited);
      }
    } else {
      await Navigator.maybePop(context);
    }
  }

  //
}

class _HitList extends ConsumerWidget {
  const _HitList({
    required this.query,
    required this.hits,
    required this.pageSize,
  });

  final ConcordanceQuery query;
  final ConcordanceHits hits;
  final int pageSize;

  @override
  Widget build(context, ref) {
    final catalog = ref.watch(libraryCatalogProvider).valueOrNull;
    final labels = catalog == null ? const <String, String>{} : workLabels(catalog);
    final showMacrons =
        (ref.watch(readerSettingsNotifierProvider).valueOrNull ?? const ReaderSettings())
            .showMacrons;
    final count = NumberFormat.decimalPattern(Localizations.localeOf(context).toString());
    final wide = Breakpoints.mediumAndUp.isActive(context);
    final margin = _margin(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(margin, 0, margin - 8, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _range(hits, count),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              PopupMenuButton<ConcordanceSort>(
                tooltip: 'Sort',
                icon: const Icon(Icons.sort),
                initialValue: query.sort,
                onSelected: (sort) => _search(context, query.withSort(sort)),
                itemBuilder: (_) => ConcordanceSort.values
                    .map((sort) => PopupMenuItem(value: sort, child: Text(sortLabel(sort))))
                    .toList(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: hits.hits.isEmpty
              ? const Center(child: Text('No hits for this search.'))
              : Material(
                  //keep row hover/press ink clipped to the scrolling list
                  type: MaterialType.transparency,
                  child: ListView.separated(
                    itemCount: hits.hits.length,
                    separatorBuilder: (_, _) => wide ? const SizedBox.shrink() : const Divider(),
                    itemBuilder: (context, index) {
                      final hit = hits.hits[index];
                      final work = labels[hit.workId] ?? '';
                      final text = _HitText(hit, showMacrons: showMacrons);
                      return InkWell(
                        onTap: () => _openInReader(context, ref, hit),
                        child: wide
                            ? _KwicLine(work: work, hit: hit, text: text, margin: margin)
                            : _HitCard(work: work, hit: hit, text: text, margin: margin),
                      );
                    },
                  ),
                ),
        ),
        const Divider(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              tooltip: 'Previous page',
              visualDensity: VisualDensity.compact,
              onPressed: hits.offset > 0
                  ? () => _search(
                      context,
                      query,
                      offset: max(0, hits.offset - pageSize),
                    )
                  : null,
            ),
            Text(_range(hits, count)),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              tooltip: 'Next page',
              visualDensity: VisualDensity.compact,
              onPressed: hits.hasNextPage
                  ? () => _search(context, query, offset: hits.offset + pageSize)
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  /// "1–50 of 1,234 hits", or "No hits"
  String _range(ConcordanceHits hits, NumberFormat count) {
    final first = count.format(hits.offset + 1);
    final last = count.format(hits.offset + hits.hits.length);
    final total = hits.total;
    return hits.hits.isEmpty
        ? 'No hits'
        : '$first–$last of ${count.format(total)} hit${total == 1 ? '' : 's'}';
  }

  /// Opens the reader where the hit can be seen, with its words marked
  Future<void> _openInReader(BuildContext context, WidgetRef ref, ConcordanceHit hit) async {
    log.info(() => 'opening $hit in the reader');
    final start = await ref.read(readingStartProvider(hit.workId, hit.firstIdx).future);
    if (context.mounted) {
      await ReaderRoute(
        hit.workId,
        startingPoint: start,
        highlights: hit.slotIndices,
      ).push<void>(context);
    }
  }

  //
}

double _margin(BuildContext context) => Breakpoints.mediumAndUp.isActive(context)
    ? Breakpoints.mediumAndUp.margin
    : Breakpoints.small.margin;

/// The text of a hit, split around its words and spaced like the reader, with
/// a slash where a line (a verse, a title...) ends, as when quoting verse
class _HitText {
  _HitText(
    this.hit, {
    required this.showMacrons,
  });

  final ConcordanceHit hit;
  final bool showMacrons;

  static const _closingSigns = ['.', ',', '!', '?', ':', ';', ')', ']'];
  static const _openingSigns = ['(', '['];
  static const _lineBreak = ' / ';

  /// Each token of the context as shown, and what separates it from the one
  /// before: a line break, a space, or nothing before punctuation
  late final Map<int, ({String gap, String text})> _shown = Map.fromEntries(
    hit.context.indexed.map((entry) {
      final (i, token) = entry;
      final gap = switch (i == 0 ? null : hit.context[i - 1]) {
        null => '',
        final previous when previous.reference != token.reference => _lineBreak,
        final previous
            when _closingSigns.any(token.word.startsWith) ||
                _openingSigns.any(previous.word.endsWith) =>
          '',
        _ => ' ',
      };
      final text = showMacrons ? token.macronizedWord : token.word;
      return MapEntry(token.idx, (gap: gap, text: text));
    }),
  );

  /// The text before the hit, at most [words] tokens of it. Ends with a slash
  /// when the hit starts a line
  List<TextSpan> before(TextStyle lineBreakStyle, {int? words}) {
    final tokens = hit.before.toList();
    final shown = words == null ? tokens : tokens.sublist(max(0, tokens.length - words));
    final hitStartsLine = _shown[hit.firstIdx]?.gap == _lineBreak;
    return [
      ..._spans(shown, lineBreakStyle),
      if (hitStartsLine && shown.isNotEmpty)
        TextSpan(text: _lineBreak.trimRight(), style: lineBreakStyle),
    ];
  }

  /// Whether there are more than [words] tokens before the hit
  bool moreBefore(int words) => hit.before.length > words;

  /// Whether there are more than [words] tokens after the hit
  bool moreAfter(int words) => hit.after.length > words;

  /// The hit, its slots emphasized, followed by at most [words] tokens
  List<TextSpan> matchAndAfter(TextStyle slotStyle, TextStyle lineBreakStyle, {int? words}) {
    final after = hit.after.toList();
    return _spans(
      [...hit.match, ...(words == null ? after : after.take(words))],
      lineBreakStyle,
      style: (token) => hit.isSlot(token) ? slotStyle : null,
    );
  }

  /// [tokens] with what separates them, except before the first one
  List<TextSpan> _spans(
    List<ConcordanceToken> tokens,
    TextStyle lineBreakStyle, {
    TextStyle? Function(ConcordanceToken token)? style,
  }) => tokens.indexed.expand((entry) {
    final (i, token) = entry;
    final shown = _shown[token.idx]!;
    final gap = i == 0 ? '' : shown.gap;
    return [
      if (gap.isNotEmpty) TextSpan(text: gap, style: gap == _lineBreak ? lineBreakStyle : null),
      TextSpan(text: shown.text, style: style?.call(token)),
    ];
  }).toList();

  //
}

/// The work (author · title), cut short if needed, then the hit's reference,
/// always whole
class _Source extends StatelessWidget {
  const _Source({
    required this.work,
    required this.reference,
  });

  final String work;
  final String reference;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    return Row(
      children: [
        Flexible(
          child: Text(work, maxLines: 1, overflow: TextOverflow.ellipsis, style: style),
        ),
        Text(' · $reference', maxLines: 1, style: style),
      ],
    );
  }

  //
}

/// On wide windows: the source, then the hit's words lined up with every other
/// hit's, the text before them to the left and after them to the right
class _KwicLine extends StatelessWidget {
  const _KwicLine({
    required this.work,
    required this.hit,
    required this.text,
    required this.margin,
  });

  final String work;
  final ConcordanceHit hit;
  final _HitText text;
  final double margin;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final body = theme.textTheme.bodyLarge;
    final slotStyle = TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary);
    final lineBreakStyle = TextStyle(color: theme.colorScheme.outline);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 200,
            child: _Source(work: work, reference: hit.reference),
          ),
          SizedBox(width: margin),
          Expanded(
            flex: 2,
            child: _FadingEdge(
              atStart: true,
              child: ClipRect(
                child: OverflowBox(
                  alignment: AlignmentDirectional.centerEnd,
                  // Only the text's own width: a short one ends at the hit too
                  minWidth: 0,
                  maxWidth: double.infinity,
                  fit: OverflowBoxFit.deferToChild,
                  child: Text.rich(
                    TextSpan(children: text.before(lineBreakStyle)),
                    maxLines: 1,
                    softWrap: false,
                    style: body,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: _FadingEdge(
              atStart: false,
              child: Text.rich(
                TextSpan(children: text.matchAndAfter(slotStyle, lineBreakStyle)),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.clip,
                style: body,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
}

/// On narrow windows: the source above a few lines of text around the hit
class _HitCard extends StatelessWidget {
  const _HitCard({
    required this.work,
    required this.hit,
    required this.text,
    required this.margin,
  });

  final String work;
  final ConcordanceHit hit;
  final _HitText text;
  final double margin;

  /// Tokens of context on each side
  static const _before = 6;
  static const _after = 10;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final slotStyle = TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary);
    final lineBreakStyle = TextStyle(color: theme.colorScheme.outline);
    final before = text.before(lineBreakStyle, words: _before);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Source(work: work, reference: hit.reference),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                if (text.moreBefore(_before)) const TextSpan(text: '… '),
                ...before,
                if (before.isNotEmpty) const TextSpan(text: ' '),
                ...text.matchAndAfter(slotStyle, lineBreakStyle, words: _after),
                if (text.moreAfter(_after)) const TextSpan(text: ' …'),
              ],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  //
}

/// Fades [child] out towards its start or end edge, where the text is cut
class _FadingEdge extends StatelessWidget {
  const _FadingEdge({
    required this.atStart,
    required this.child,
  });

  final bool atStart;
  final Widget child;

  static const double _fade = 24;

  @override
  Widget build(context) => ShaderMask(
    blendMode: BlendMode.dstIn,
    shaderCallback: (bounds) {
      final stop = min(1, _fade / max(bounds.width, 1)).toDouble();
      return LinearGradient(
        begin: atStart ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd,
        end: atStart ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
        colors: const [Colors.transparent, Colors.black],
        stops: [0, stop],
      ).createShader(bounds, textDirection: Directionality.of(context));
    },
    child: child,
  );

  //
}
