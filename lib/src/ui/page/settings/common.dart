import 'package:flutter/material.dart';

/// A settings page section with a titled header and one or more grouped cards.
///
/// Renders a circular icon + bold title header followed by each [groups] entry
/// separated by vertical spacing. Intended as the top-level organiser on a
/// settings page: wrap one or more [SettingsGroup] widgets in [groups].
///
/// ```dart
/// SettingsSection(
///   title: '...',
///   icon: Icons.icon,
///   groups: [
///     SettingsGroup(children: [...]),
///   ],
/// )
/// ```
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.icon,
    required this.groups,
  });

  final String title;
  final IconData icon;
  final List<SettingsGroup> groups;

  @override
  Widget build(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      _header(context),
      ..._cards(),
    ],
  );

  Widget _header(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  // Cards are padded individually rather than using Column's mainAxisSpacing
  // so the last card doesn't get trailing space
  Iterable<Widget> _cards() => groups.map(
    (card) => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: card,
    ),
  );

  //
}

/// A visually grouped container for related settings rows.
///
/// Wraps [rows] in a [Card] with clipped corners so that the first and
/// last children inherit the card's border radius cleanly.
///
/// ### Width behavior
///
/// By default the card **stretches** to fill the available width (normal card
/// look). Set [fitContent] to `true` to make it instead **shrink** to the
/// intrinsic width of its widest row, while still being capped at the available
/// width. If the content would exceed that, it wraps rather than overflowing.
///
/// #### ⚠️ `fitContent` only works with content-sized rows
///
/// Shrink-to-fit relies on every descendant being happy with *loose* width
/// constraints. Any child that greedily expands to fill the available width
/// will defeat the shrink and snap the card back to full width
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    super.key,
    required this.rows,
    this.fitContent = false,
  });

  final List<Widget> rows;

  /// When true, the card shrinks to the intrinsic width of its widest row
  /// (still capped at the available width). When false (default) it stretches
  /// to fill the available width.
  final bool fitContent;

  /// Column hugs its widest child so the surrounding Align can shrink the card
  static const CrossAxisAlignment _hugWidestRow = CrossAxisAlignment.start;

  static const CrossAxisAlignment _fillCardWidth = CrossAxisAlignment.stretch;

  // Align gives the Card loose constraints (0..maxWidth) so it can shrink,
  // while still being bounded by the available width
  @override
  Widget build(context) => fitContent
      ? Align(
          alignment: Alignment.centerLeft,
          child: _card(),
        )
      : _card();

  Card _card() => Card(
    margin: EdgeInsets.zero, // flush with section column; Card default adds unwanted margin
    clipBehavior: Clip.antiAlias, // clips children (e.g. ColoredBox headers) to rounded corners
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: fitContent ? _hugWidestRow : _fillCardWidth,
      children: rows,
    ),
  );
  //
}
