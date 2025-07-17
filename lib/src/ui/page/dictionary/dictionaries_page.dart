import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as int;

import '../../../component/dictionary/dictionaries_api.dart';
import '../../router/config.dart';
import '../../widget/searchable_app_bar.dart';
import '../../widget/show_error.dart';
import '../../widget/show_loading.dart';

class DictionariesPage extends ConsumerWidget {
  const DictionariesPage({
    super.key,
  });

  @override
  Widget build(context, ref) => Scaffold(
    appBar: SearchableAppBar(
      onFilterPressed: () {},
      onSortPressed: () {},
      onSettingsPressed: () async {
        await const SettingsRoute().push<void>(context);
      },
      searchSuggestionsBuilder: (context, controller) async => [],
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
