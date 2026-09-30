import 'dart:async';

import 'package:flutter/material.dart';

import 'keyboard_closing_search_bar.dart';
import 'search_results.dart';

class SearchableAppBar extends AppBar {
  SearchableAppBar({
    super.key,
    this.onFilterPressed,
    this.searchHintText,
    required this.searchSuggestionsBuilder,
    required this.onSortPressed,
    required this.onSettingsPressed,
    List<Widget> extraActions = const [],
  }) : super(
         leading: onFilterPressed != null
             ? IconButton(icon: const Icon(Icons.filter_list), onPressed: onFilterPressed)
             : null,
         title: Row(
           children: [
             Expanded(
               child: KeyboardClosingSearchBar(
                 barHintText: searchHintText,
                 viewBuilder: searchResultsView,
                 suggestionsBuilder: searchSuggestionsBuilder,
               ),
             ),
           ],
         ),
         actions: [
           ...extraActions,
           IconButton(icon: const Icon(Icons.sort), onPressed: onSortPressed),
           const VerticalDivider(),
           IconButton(icon: const Icon(Icons.settings), onPressed: onSettingsPressed),
         ],
       );

  final VoidCallback? onFilterPressed;
  final String? searchHintText;
  final VoidCallback onSortPressed;
  final VoidCallback onSettingsPressed;

  final FutureOr<Iterable<Widget>> Function(BuildContext, SearchController)
  searchSuggestionsBuilder;
  //
}
