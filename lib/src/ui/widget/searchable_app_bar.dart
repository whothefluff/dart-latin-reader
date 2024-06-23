import 'dart:async';
import 'package:flutter/material.dart';

class SearchableAppBar extends AppBar {
  SearchableAppBar({
    super.key,
    required this.onFilterPressed,
    required this.searchSuggestionsBuilder,
    required this.onSortPressed,
    required this.onSettingsPressed,
  }) : super(
          leading: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterPressed,
          ),
          title: Row(
            children: [
              Expanded(
                child: SearchAnchor.bar(
                  suggestionsBuilder: searchSuggestionsBuilder,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sort),
              onPressed: onSortPressed,
            ),
            const VerticalDivider(),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: onSettingsPressed,
            ),
          ],
        );

  final VoidCallback onFilterPressed;
  final VoidCallback onSortPressed;
  final VoidCallback onSettingsPressed;
  final FutureOr<Iterable<Widget>> Function(BuildContext, SearchController)
      searchSuggestionsBuilder;
//
}
