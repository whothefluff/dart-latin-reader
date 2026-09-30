import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as int;

import '../../../component/dictionary/dictionaries_api.dart';
import '../../../core/contains_text.dart';
import '../../router/config.dart';
import '../../widget/page_scaffold.dart';
import '../../widget/search_results.dart';
import '../../widget/searchable_app_bar.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';
import '../settings/settings_shell_page.dart' show SettingsTab;

class DictionariesPage extends ConsumerWidget {
  const DictionariesPage({
    super.key,
  });

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: SearchableAppBar(
      onFilterPressed: () {},
      onSortPressed: () {},
      onSettingsPressed: () async {
        await const SettingsRoute(tab: SettingsTab.dictionaries).push<void>(context);
      },
      searchHintText: 'Search dictionaries...',
      searchSuggestionsBuilder: (_, controller) {
        final text = controller.text.trim();
        return [
          if (text.isNotEmpty)
            SearchResults(
              provider: dictionariesProvider,
              tiles: (all) => all
                  .where((dictionary) => containsText([dictionary.name], text))
                  .map(
                    (dictionary) => ListTile(
                      title: Text(dictionary.name),
                      onTap: () async {
                        controller.closeView(controller.text);
                        await DictionaryEntriesRoute(dictionary.id).push<void>(context);
                      },
                    ),
                  ),
            ),
        ];
      },
    ),
    body: dictionariesList(ref),
  );

  Widget dictionariesList(WidgetRef ref) => ref
      .watch(dictionariesProvider)
      .when(
        data: (dictionaries) => ListView.builder(
          itemCount: dictionaries.length,
          itemBuilder: (context, index) {
            final entriesData = Text(
              '${dictionaries[index].numberOfEntries} entries',
              style: TextTheme.of(context).labelLarge,
            );
            final nameAndEntries = _row(context, dictionaries[index].name, entriesData);
            final publisherData = _row(
              context,
              '${dictionaries[index].publisher} (${int.DateFormat.yMMMMd().format(dictionaries[index].publicationDate.toLocal())})',
              SizedBox(width: _tWidth(entriesData.data!, entriesData.style!)),
            );
            final dict = dictionaries[index];
            return ListTile(
              title: nameAndEntries,
              subtitle: publisherData,
              isThreeLine: true,
              onTap: () async {
                await DictionaryEntriesRoute(dict.id).push<void>(context);
              },
            );
          },
        ),
        loading: showLoading,
        error: showError(ref, dictionariesProvider),
      );

  double _tWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  Row _row(BuildContext context, String left, Widget right) => Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Expanded(child: Text(left)),
      right,
    ],
  );
  //
}
