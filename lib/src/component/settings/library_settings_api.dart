import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'library_settings_api.g.dart';

//infrastructure

@Riverpod(keepAlive: true)
class LibrarySettingsNotifier extends _$LibrarySettingsNotifier {
  //
  static const _prefix = 'library.';
  static const _view = '${_prefix}view';

  /// Stored by name.
  /// A renamed value falls back to the default.
  static final Map<String, LibraryView> _viewsByName = LibraryView.values.asNameMap();

  @override
  Future<LibrarySettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedView = await repo.get(_view, PrefString.hint);
    final settings = LibrarySettings(
      view: _viewsByName[savedView?.value] ?? LibrarySettings._defaultView,
    );
    return log.exit(r: settings)!;
  }

  Future<void> updateSettings(LibrarySettings newSettings) async {
    log.entry(args: [newSettings]);
    final previous = state.valueOrNull;
    if (previous != null && previous != newSettings) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(newSettings);
      // Persist (with rollback on failure)
      try {
        await ref.read(settingsRepositoryProvider).set(_view, PrefString(newSettings.view.name));
      } on Exception catch (e, st) {
        log
          ..catching(e, stackTrace: st)
          ..warning(() => 'Rolling back settings to $previous');
        state = AsyncData(previous);
      }
    } else {
      log.fine('no-op: settings unchanged');
    }
    log.exit<void>();
  }

  //
}

//domain

/// Whether the library shows a list of authors or a list of works
enum LibraryView {
  authors,
  works,
}

/// Holds the settings for the library's lists
@immutable
class LibrarySettings {
  const LibrarySettings({
    required this.view,
  });

  const LibrarySettings.defaults()
    : this(
        view: _defaultView,
      );

  /// Current library view.
  ///
  /// The button in the app bar saves it, so the library opens with whichever was shown last
  final LibraryView view;

  static const LibraryView _defaultView = LibraryView.authors;

  LibrarySettings copyWith({LibraryView? view}) => LibrarySettings(
    view: view ?? this.view,
  );

  @override
  String toString() => 'LibrarySettings{view: $view}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LibrarySettings && other.view == view);

  @override
  int get hashCode => view.hashCode;
  //
}
