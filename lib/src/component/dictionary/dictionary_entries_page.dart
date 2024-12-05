import 'dart:collection';

import 'package:flutter/material.dart';
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
  Widget build(context, ref) {
    return Scaffold(
      appBar: SearchableAppBar(
        onSortPressed: () {},
        onSettingsPressed: () => context.push('/settings'),
        searchSuggestionsBuilder: (context, controller) async => [],
      ),
      body: entriesList(ref),
    );
  }

  Widget entriesList(WidgetRef ref) {
    return ref.watch(dictionaryEntriesProvider(dictionaryId)).when(
          data: (entries) {
            return Row(children: [
              ScrollableEntries(dictionaryId: dictionaryId, data: entries),
              AlphabetSidebar(),
            ]);
          },
          loading: showLoading,
          error: showError(ref, dictionaryEntriesProvider(dictionaryId)),
        );
  }
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
  Widget build(context) {
    return Expanded(
        child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final entry = data[index];
        final entryPage = '/dictionaries/$dictionaryId/entries/${entry.lemma}';
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
                TextSpan(text: ' '),
                TextSpan(
                  text: inflection,
                  style: subtitleStyleBecauseFuckFlutter,
                ),
              ],
            ),
          ),
          onTap: () => context.push(entryPage),
        );
      },
    ));
  }

  String removeDigits(String original) =>
      original.replaceAll(RegExp(r'\d'), '');

  String removeQuotes(String original) => original.replaceAll(RegExp(r'"'), '');
//
}

class AlphabetSidebar extends StatelessWidget {
  AlphabetSidebar({super.key});

  final alphabet =
      List<String>.unmodifiable('ABCDEFGHIJKLMNOPQRSTUVXYZ'.split(''));

  @override
  Widget build(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ignore: unnecessary_this
        return this.fits(context, constraints) ? sidebar() : dropdown(context);
      },
    );
  }

  Widget sidebar() {
    return SizedBox(
      width: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: alphabet.map((letter) {
          return Expanded(
            child: GestureDetector(
              // onTap: () => _onLetterTap(letter),
              onLongPress: () => Magnifier(),
              child: Container(
                alignment: Alignment.center,
                child: Text(letter),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget dropdown(BuildContext context) {
    return Align(
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
          // Handle selection
        },
      ),
    );
  }

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
