import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/dictionary/dictionary_alphabets_api.dart';
import '../../../component/dictionary/dictionary_entries_api.dart';
import '../../router/config.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';
import '../../widget/searchable_app_bar.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';

class DictionaryEntriesPage extends ConsumerStatefulWidget {
  const DictionaryEntriesPage(
    this.dictionary, {
    super.key,
  });

  final String dictionary;

  @override
  ConsumerState<DictionaryEntriesPage> createState() => _DictionaryEntriesPageState();
  //
}

class _DictionaryEntriesPageState extends ConsumerState<DictionaryEntriesPage> {
  //
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(context) => Scaffold(
    appBar: SearchableAppBar(
      onSortPressed: () {},
      onSettingsPressed: () async {
        await const SettingsRoute().push<void>(context);
      },
      searchSuggestionsBuilder: (context, controller) async => [],
    ),
    body: entriesList(ref, context),
  );

  Widget entriesList(WidgetRef ref, BuildContext context) => ref
      .watch(dictionaryEntriesProvider(widget.dictionary))
      .when(
        data: (entries) => Row(
          children: [
            ScrollableEntries(
              dictId: widget.dictionary,
              data: entries,
              scrollController: _scrollController,
            ),
            AlphabetNavigation(
              dictId: widget.dictionary,
              scrollController: _scrollController,
            ),
          ],
        ),
        loading: showLoading,
        error: error(ref),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget Function(Object error, StackTrace _) error(WidgetRef ref) =>
      showError(ref, dictionaryEntriesProvider(widget.dictionary));
  //
}

class ScrollableEntries extends ConsumerStatefulWidget {
  const ScrollableEntries({
    super.key,
    required this.dictId,
    required this.data,
    required this.scrollController,
  });

  final String dictId;
  final DictionaryEntries data;
  final ScrollController scrollController;

  @override
  ConsumerState<ScrollableEntries> createState() => _ScrollableEntriesState();
  //
}

class _ScrollableEntriesState extends ConsumerState<ScrollableEntries> {
  //
  @override
  Widget build(context) => Expanded(
    child: ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.data.length,
      prototypeItem: ListTile(
        title: Text(widget.data.first.lemma),
      ),
      addAutomaticKeepAlives: false,
      itemBuilder: tile(),
    ),
  );

  Widget Function(BuildContext, int) tile() => (context, index) {
    final subtitleStyleBecauseFuckFlutter = subtitleTextStyle(context);
    final entry = widget.data[index];
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
              text: entry.inflection,
              style: subtitleStyleBecauseFuckFlutter,
            ),
          ],
        ),
      ),
      onTap: () async {
        await DictionaryEntryRoute(widget.dictId, entry.lemma).push<void>(context);
      },
    );
  };

  String removeDigits(String original) => original.replaceAll(RegExp(r'\d'), '');
  //
}

class AlphabetNavigation extends ConsumerStatefulWidget {
  const AlphabetNavigation({
    super.key,
    required this.dictId,
    required this.scrollController,
  });

  final String dictId;
  final ScrollController scrollController;

  @override
  ConsumerState<AlphabetNavigation> createState() => _AlphabetNavigationState();
  //
}

class _AlphabetNavigationState extends ConsumerState<AlphabetNavigation> {
  //
  @override
  Widget build(context) => LayoutBuilder(
    builder: (context, constraints) => this.fits(context, constraints)
        ? sidebar(constraints)
        : AlphabetDropdown(alphabet, onLetterSelected: scrollToLetter),
  );

  Widget sidebar(BoxConstraints constraints) =>
      constraints.maxHeight < Breakpoints.large.beginHeight!
      ? MagnifiableAlphabetSidebar(alphabet, constraints, onLetterSelected: scrollToLetter)
      : TappableAlphabetSidebar(alphabet, onLetterSelected: scrollToLetter);

  bool fits(BuildContext context, BoxConstraints constraints) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: '', style: TextTheme.of(context).bodyMedium),
    )..layout(maxWidth: constraints.maxWidth);
    final letterHeight = textPainter.height;
    final totalHeightNeeded = letterHeight * alphabet.length;
    return constraints.maxHeight >= totalHeightNeeded;
  }

  Future<void> scrollToLetter(String letter) async {
    const listTileHeight = 48.0;
    final index = await ref.read(
      dictionaryAlphabetLetterPositionProvider(widget.dictId, letter).future,
    );
    await widget.scrollController.animateTo(
      index.calculateHeight(listTileHeight),
      duration: const Duration(milliseconds: 100),
      curve: Easing.linear,
    );
    // _scrollController.jumpTo((index * listTileHeight).toDouble());
  }

  //
}

class TappableAlphabetSidebar extends StatelessWidget {
  const TappableAlphabetSidebar(
    this.alphabet, {
    super.key,
    required this.onLetterSelected,
  });

  final Alphabet alphabet;
  final void Function(String letter) onLetterSelected;

  @override
  Widget build(context) => SizedBox(
    width: 30,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: alphabet
          .map(
            (letter) => Expanded(
              child: InkWell(
                onTap: () => onLetterSelected(letter),
                customBorder: const CircleBorder(),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(letter),
                ),
              ),
            ),
          )
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
    required this.onLetterSelected,
  });

  final BoxConstraints constraints;
  final Alphabet alphabet;
  final void Function(String letter) onLetterSelected;

  @override
  State<MagnifiableAlphabetSidebar> createState() => _MagnifiableAlphabetSidebarState();
  //
}

class _MagnifiableAlphabetSidebarState extends State<MagnifiableAlphabetSidebar> {
  //
  late final double totalHeight = widget.constraints.maxHeight;
  late final double letterHeight = totalHeight / widget.alphabet.length;
  Offset _magnifierPosition = Offset.zero;
  var _currentLetter = '';
  OverlayEntry? _overlayEntry;

  @override
  Widget build(context) => SizedBox(
    width: 30,
    child: GestureDetector(
      onLongPressStart: (details) => showMagnifier(details.localPosition),
      onLongPressMoveUpdate: (det) => updateMagnifier(det.localPosition),
      onLongPressEnd: (_) => hideMagnifier(and: widget.onLetterSelected),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.alphabet
            .map(
              (letter) => Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(letter),
                ),
              ),
            )
            .toList(),
      ),
    ),
  );

  OverlayEntry createOverlayEntry() => OverlayEntry(
    builder: (context) => Positioned(
      right: 0,
      top: _magnifierPosition.dy,
      child: const Magnifier(
        additionalFocalPointOffset: Offset(25, -5),
        clipBehavior: Clip.antiAlias,
      ),
    ),
  );

  void showMagnifier(Offset position) {
    setState(() {
      _currentLetter = getLetterAtPosition(position.dy);
      _magnifierPosition = position;
      _overlayEntry = createOverlayEntry();
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  void updateMagnifier(Offset position) {
    setState(() {
      _currentLetter = getLetterAtPosition(position.dy);
      _magnifierPosition = position;
      _overlayEntry?.markNeedsBuild();
    });
  }

  void hideMagnifier({required void Function(String letter) and}) {
    setState(() {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
    and(_currentLetter);
  }

  String getLetterAtPosition(double yPosition) {
    final index = (yPosition / letterHeight).clamp(0, widget.alphabet.length - 1).toInt();
    return widget.alphabet[index];
  }

  //
}

class AlphabetDropdown extends StatelessWidget {
  const AlphabetDropdown(
    this.alphabet, {
    super.key,
    required this.onLetterSelected,
  });

  final Alphabet alphabet;
  final void Function(String letter) onLetterSelected;

  @override
  Widget build(context) => Align(
    alignment: Alignment.bottomRight,
    child: PopupMenuButton<String>(
      icon: const Icon(Icons.sort_by_alpha),
      itemBuilder: (_) => alphabet
          .map(
            (letter) => PopupMenuItem(
              value: letter,
              child: Text(letter),
            ),
          )
          .toList(),
      onSelected: onLetterSelected,
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
  'Z',
]);

/// stupid ass class copied from list_tile.dart because hiding implementation details is so dope
class _LisTileDefaultsM3 extends ListTileThemeData {
  _LisTileDefaultsM3(this.context)
    : super(
        contentPadding: const EdgeInsetsDirectional.only(start: 16.0, end: 24.0),
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
  TextStyle? get titleTextStyle => _textTheme.bodyLarge!.copyWith(color: _colors.onSurface);

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

TextStyle subtitleTextStyle(BuildContext context) =>
    ListTileTheme.of(context).subtitleTextStyle ?? _LisTileDefaultsM3(context).subtitleTextStyle!;
