import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latin_reader/src/component/dictionary/dictionary_entries_api.dart';
import 'package:latin_reader/src/ui/widget/searchable_app_bar.dart';
import 'package:latin_reader/src/ui/widget/show_error.dart';
import 'package:latin_reader/src/ui/widget/show_loading.dart';

class DictionaryEntriesPage extends ConsumerWidget {
  const DictionaryEntriesPage({super.key, required this.dictionaryId});

  final String dictionaryId;

  @override
  Widget build(context, ref) => Scaffold(
        appBar: SearchableAppBar(
          onSortPressed: () {},
          onSettingsPressed: () async => context.push('/settings'),
          searchSuggestionsBuilder: (context, controller) async => [],
        ),
        body: entriesList(ref),
      );

  Widget entriesList(WidgetRef ref) =>
      ref.watch(dictionaryEntriesProvider(dictionaryId)).when(
            data: (entries) => Row(children: [
              ScrollableEntries(dictionaryId: dictionaryId, data: entries),
              const AlphabetNavigation(),
            ]),
            loading: showLoading,
            error: showError(ref, dictionaryEntriesProvider(dictionaryId)),
          );
//
}

class ScrollableEntries extends StatelessWidget {
  const ScrollableEntries({
    super.key,
    required this.dictionaryId,
    required this.data,
  });

  final String dictionaryId;
  final UnmodifiableListView<Entry> data;
  @override
  Widget build(context) => Expanded(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final entry = data[index];
            final entryPage =
                '/dictionaries/$dictionaryId/entries/${entry.lemma}';
            final inflection =
                entry.inflection != null ? removeQuotes(entry.inflection!) : '';
            final subtitleStyleBecauseFuckFlutter =
                ListTileTheme.of(context).subtitleTextStyle ??
                    _LisTileDefaultsM3(context).subtitleTextStyle!;
            return ListTile(
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: removeDigits(entry.lemma),
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: inflection,
                      style: subtitleStyleBecauseFuckFlutter,
                    ),
                  ],
                ),
              ),
              onTap: () async => context.push(entryPage),
            );
          },
        ),
      );

  String removeDigits(String original) =>
      original.replaceAll(RegExp(r'\d'), '');

  String removeQuotes(String original) => original.replaceAll(RegExp('"'), '');
//
}

class AlphabetNavigation extends StatelessWidget {
  const AlphabetNavigation({super.key});

  @override
  Widget build(context) => LayoutBuilder(
        builder: (context, constraints) => this.fits(context, constraints)
            ? sidebar(constraints)
            : const AlphabetDropdown(alphabet),
      );

  Widget sidebar(BoxConstraints constraints) =>
      constraints.maxHeight < Breakpoints.large.beginHeight!
          ? MagnifiableAlphabetSidebar(alphabet, constraints)
          : const TappableAlphabetSidebar(alphabet);

  bool fits(BuildContext context, BoxConstraints constraints) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '',
        style: textStyle,
      ),
    )..layout(maxWidth: constraints.maxWidth);
    final letterHeight = textPainter.height;
    final totalHeightNeeded = letterHeight * alphabet.length;
    return constraints.maxHeight >= totalHeightNeeded;
  }
//
}

class TappableAlphabetSidebar extends StatelessWidget {
  const TappableAlphabetSidebar(this.alphabet, {super.key});

  final Alphabet alphabet;

  @override
  Widget build(context) => SizedBox(
        width: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: alphabet
              .map((letter) => Expanded(
                    child: InkWell(
                      // onTap: () => _browseTo(letter),
                      onLongPress: () => const Magnifier(),
                      customBorder: const CircleBorder(),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(letter),
                      ),
                    ),
                  ))
              .toList(),
        ),
      );
//
}

class MagnifiableAlphabetSidebar extends StatefulWidget {
  const MagnifiableAlphabetSidebar(
    this.alphabet,
    this.constraints, {
    super.key,
  });

  final BoxConstraints constraints;
  final Alphabet alphabet;

  @override
  State<MagnifiableAlphabetSidebar> createState() =>
      _MagnifiableAlphabetSidebarState();
//
}

class _MagnifiableAlphabetSidebarState
    extends State<MagnifiableAlphabetSidebar> {
//
  late final totalHeight = widget.constraints.maxHeight;
  late final letterHeight = totalHeight / widget.alphabet.length;
  var _magnifierPosition = Offset.zero;
  var _currentLetter = '';
  OverlayEntry? _overlayEntry;

  @override
  Widget build(context) => SizedBox(
        width: 30,
        child: GestureDetector(
          onLongPressStart: (details) {
            _showMagnifier(details.localPosition);
          },
          onLongPressMoveUpdate: (details) {
            _updateMagnifierPosition(details.localPosition);
          },
          onLongPressEnd: (details) {
            _hideMagnifier();
            // _browseTo(_currentLetter);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.alphabet
                .map((letter) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(letter),
                      ),
                    ))
                .toList(),
          ),
        ),
      );

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (context) => Positioned(
          right: 0,
          top: _magnifierPosition.dy,
          child: const Magnifier(
            additionalFocalPointOffset: Offset(25, -5),
            clipBehavior: Clip.antiAlias,
          ),
        ),
      );

  void _showMagnifier(Offset position) {
    setState(() {
      _currentLetter = _getLetterAtPosition(position.dy);
      _magnifierPosition = position;
      _overlayEntry = _createOverlayEntry();
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateMagnifierPosition(Offset position) {
    setState(() {
      _currentLetter = _getLetterAtPosition(position.dy);
      _magnifierPosition = position;
      _overlayEntry?.markNeedsBuild();
    });
  }

  void _hideMagnifier() {
    setState(() {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  String _getLetterAtPosition(double yPosition) {
    final index =
        (yPosition / letterHeight).clamp(0, widget.alphabet.length - 1).toInt();
    return widget.alphabet[index];
  }
  //
}

class AlphabetDropdown extends StatelessWidget {
  const AlphabetDropdown(this.alphabet, {super.key});

  final Alphabet alphabet;

  @override
  Widget build(context) => Align(
        alignment: Alignment.bottomRight,
        child: PopupMenuButton<String>(
          icon: const Icon(Icons.sort_by_alpha),
          itemBuilder: (_) => alphabet
              .map((letter) => PopupMenuItem(
                    value: letter,
                    child: Text(letter),
                  ))
              .toList(),
          onSelected: (letter) {
            //_browseTo(letter);
          },
        ),
      );
//
}

extension type const Alphabet(List<String> letters) {
  String operator [](int index) => letters[index];
  Iterable<T> map<T>(T Function(String e) toElement) => letters.map(toElement);
  int get length => letters.length;
  int indexOf(String letter) => letters.indexOf(letter);
}

const alphabet = Alphabet([
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'X',
  'Y',
  'Z'
]);

/// stupid ass class copied from list_tile.dart because hiding implementation details is so dope
class _LisTileDefaultsM3 extends ListTileThemeData {
  _LisTileDefaultsM3(this.context)
      : super(
          contentPadding:
              const EdgeInsetsDirectional.only(start: 16.0, end: 24.0),
          minLeadingWidth: 24,
          minVerticalPadding: 8,
          shape: const RoundedRectangleBorder(),
        );

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;
  late final TextTheme _textTheme = _theme.textTheme;

  @override
  Color? get tileColor => Colors.transparent;

  @override
  TextStyle? get titleTextStyle =>
      _textTheme.bodyLarge!.copyWith(color: _colors.onSurface);

  @override
  TextStyle? get subtitleTextStyle =>
      _textTheme.bodyMedium!.copyWith(color: _colors.onSurfaceVariant);

  @override
  TextStyle? get leadingAndTrailingTextStyle =>
      _textTheme.labelSmall!.copyWith(color: _colors.onSurfaceVariant);

  @override
  Color? get selectedColor => _colors.primary;

  @override
  Color? get iconColor => _colors.onSurfaceVariant;
}
