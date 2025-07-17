import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/dictionary/dictionary_entry_senses_api.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';

class DictionaryEntryPage extends ConsumerWidget {
  const DictionaryEntryPage(
    this.dictionary,
    this.lemma, {
    super.key,
  });

  final String dictionary;
  final String lemma;
  // dart format off
  static final Map<bool, 
                   ({int? maxLines, TextOverflow textOverflow})> 
      _toggle = {
    true: (textOverflow: TextOverflow.visible, maxLines: null),
    false: (textOverflow: TextOverflow.ellipsis, maxLines: 1),
  };
  // dart format on

  @override
  Widget build(context, ref) => Scaffold(
    appBar: AppBar(title: Text(lemma)),
    body: entriesList(ref, context),
  );

  Widget entriesList(WidgetRef ref, BuildContext context) => ref
      .watch(dictionaryEntrySensesProvider(dictionary, lemma))
      .when(
        data: (senses) => SingleChildScrollView(
          child: ExpansionPanelList.radio(
            children: hierarchicalSenses(groupSenses(senses)),
          ),
        ),
        loading: showLoading,
        error: error(ref),
      );

  LinkedHashMap<String, List<EntrySense>> groupSenses(List<EntrySense> senses) =>
      LinkedHashMap.fromEntries(
        groupBy(
          senses,
          (sense) => sense.prettyLevel.split('.').first,
        ).entries.toList()..sort(
          (a, b) => int.parse(a.key).compareTo(int.parse(b.key)),
        ),
      );

  List<ExpansionPanelRadio> hierarchicalSenses(
    LinkedHashMap<String, List<EntrySense>> groupedSenses,
  ) => groupedSenses
      .map(
        (level, hierarchy) => MapEntry(
          level,
          ExpansionPanelRadio(
            canTapOnHeader: true,
            value: level,
            headerBuilder: topSense(hierarchy.first),
            body: subsenses(hierarchy.sublist(1)),
          ),
        ),
      )
      .values
      .toList();

  ExpansionPanelHeaderBuilder topSense(EntrySense topSense) =>
      (_, isExpanded) => TabulatedText(
        textOverflow: _toggle[isExpanded]!.textOverflow,
        prettyLevel: topSense.prettyLevel,
        content: topSense.content,
        maxLines: _toggle[isExpanded]!.maxLines,
      );

  Widget subsenses(List<EntrySense> senses) {
    final subsenses = groupSenses(senses).values.toList();
    const interline = EdgeInsets.symmetric(vertical: 8.0);
    return Container(
      alignment: Alignment.centerLeft,
      child: SelectionArea(
        child: Column(
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
        ),
      ),
    );
  }

  Widget Function(Object error, StackTrace _) error(WidgetRef ref) =>
      showError(ref, dictionaryEntrySensesProvider(dictionary, lemma));
  //
}

class TabulatedText extends StatelessWidget {
  const TabulatedText({
    required this.prettyLevel,
    required this.content,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    super.key,
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
}
