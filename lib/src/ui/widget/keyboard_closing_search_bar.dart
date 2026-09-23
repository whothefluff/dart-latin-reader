import 'package:flutter/material.dart';

/// A [SearchAnchor.bar] that prevents focus from returning to the search bar
/// when the search view closes, so the keyboard stays dismissed.
///
/// The bar remains focusable normally, including through keyboard navigation
/// on desktop.
class KeyboardClosingSearchBar extends StatefulWidget {
  const KeyboardClosingSearchBar({
    super.key,
    this.searchController,
    this.barHintText,
    this.isFullScreen,
    required this.suggestionsBuilder,
  });

  final SearchController? searchController;
  final String? barHintText;
  final bool? isFullScreen;
  final SuggestionsBuilder suggestionsBuilder;

  @override
  State<KeyboardClosingSearchBar> createState() => _KeyboardClosingSearchBarState();
  //
}

class _KeyboardClosingSearchBarState extends State<KeyboardClosingSearchBar> {
  //
  final _gate = FocusNode(
    debugLabel: 'KeyboardClosingSearchBar gate',
    canRequestFocus: false,
    skipTraversal: true,
  );

  SearchController? _ownController;

  /// [SearchAnchor.bar] takes a non-nullable controller, so one is made when none is given
  SearchController get _controller =>
      widget.searchController ?? (_ownController ??= SearchController());

  @override
  void dispose() {
    _ownController?.dispose();
    _gate.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => Focus.withExternalFocusNode(
    focusNode: _gate,
    includeSemantics: false,
    child: SearchAnchor.bar(
      searchController: _controller,
      barHintText: widget.barHintText,
      isFullScreen: widget.isFullScreen,
      suggestionsBuilder: widget.suggestionsBuilder,
      onClose: _forgetBar,
    ),
  );

  /// Temporarily prevents the search bar from receiving focus while the search
  /// view is closing
  void _forgetBar() {
    _gate.descendantsAreFocusable = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _gate.descendantsAreFocusable = true;
      }
    });
  }

  //
}
