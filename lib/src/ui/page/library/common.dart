import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/settings/library_settings_api.dart';
import '../../router/config.dart';
import '../../widget/searchable_app_bar.dart';

SearchableAppBar libraryListAppBar(
  BuildContext context,
  WidgetRef ref, {
  required LibraryView shown,
}) {
  final (other, icon, tooltip) = switch (shown) {
    LibraryView.authors => (LibraryView.works, Icons.my_library_books, 'List works'),
    // TODO(whothefluff): change to article_person when available
    LibraryView.works => (LibraryView.authors, Icons.people, 'List authors'),
  };
  return SearchableAppBar(
    // TODO(whothefluff): add fts5 encompasing Authors.name, AuthorAbbreviations.val, Works.name, WorkAbbreviations.val
    onFilterPressed: () {},
    onSortPressed: () {},
    onSettingsPressed: () async {
      await const SettingsRoute().push<void>(context);
    },
    searchSuggestionsBuilder: (context, controller) async => [],
    extraActions: [
      IconButton(
        tooltip: tooltip,
        icon: Icon(icon),
        onPressed: () async => _switchTo(context, ref, other),
      ),
    ],
  );
}

Future<void> _switchTo(BuildContext context, WidgetRef ref, LibraryView view) async {
  final notifier = ref.read(librarySettingsNotifierProvider.notifier);
  final settings = await ref.read(librarySettingsNotifierProvider.future);
  await notifier.updateSettings(settings.copyWith(view: view)); //saves first, so library re-uses it
  if (context.mounted) {
    libraryListRoute(view).go(context);
  }
}
