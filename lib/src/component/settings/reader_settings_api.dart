import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';

part 'reader_settings_api.g.dart';

@Riverpod(keepAlive: true)
class ReaderSettingsNotifier extends _$ReaderSettingsNotifier {
  //
  static const _prefix = 'reader.';
  static const _macronsOn = '${_prefix}showMacrons';
  static const _fontFamily = '${_prefix}fontFamily';
  static const _fontSize = '${_prefix}fontSize';
  static const _lineHeight = '${_prefix}lineHeight';
  static const _letterSpacing = '${_prefix}letterSpacing';
  static const _wordSpacing = '${_prefix}wordSpacing';

  @override
  Future<ReaderSettings> build() async {
    log.entry<void>();
    final repo = ref.watch(settingsRepositoryProvider);
    final savedShowMacrons = await repo.get(_macronsOn, PrefBool.hint);
    final savedFontFamily = await repo.get(_fontFamily, PrefString.hint);
    final savedFontSize = await repo.get(_fontSize, PrefDouble.hint);
    final savedLineHeight = await repo.get(_lineHeight, PrefDouble.hint);
    final savedLetterSpacing = await repo.get(_letterSpacing, PrefDouble.hint);
    final savedWordSpacing = await repo.get(_wordSpacing, PrefDouble.hint);
    final settings = ReaderSettings(
      showMacrons: savedShowMacrons?.value ?? ReaderSettings._defaultShowMacrons,
      fontFamily: savedFontFamily?.value,
      fontSize: savedFontSize?.value ?? ReaderSettings._defaultFontSize,
      lineHeight: savedLineHeight?.value ?? ReaderSettings._defaultLineHeight,
      letterSpacing: savedLetterSpacing?.value ?? ReaderSettings._defaultLetterSpacing,
      wordSpacing: savedWordSpacing?.value ?? ReaderSettings._defaultWordSpacing,
    );
    return log.exit(r: settings)!;
  }

  Future<void> updateSettings(ReaderSettings newSettings) async {
    log.entry(args: [newSettings]);
    final previous = state.valueOrNull;
    if (previous != null && previous != newSettings) {
      // Optimistic update: state reflects the change before persistence completes
      state = AsyncData(newSettings);
      // Persist (with rollback on failure)
      try {
        final repo = ref.read(settingsRepositoryProvider);
        await repo.set(_macronsOn, PrefBool(newSettings.showMacrons));
        await repo.set(_fontFamily, _fontFamilyValue(newSettings));
        await repo.set(_fontSize, PrefDouble(newSettings.fontSize));
        await repo.set(_lineHeight, PrefDouble(newSettings.lineHeight));
        await repo.set(_letterSpacing, PrefDouble(newSettings.letterSpacing));
        await repo.set(_wordSpacing, PrefDouble(newSettings.wordSpacing));
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

  PrefString? _fontFamilyValue(ReaderSettings newSettings) =>
      newSettings.fontFamily != null ? PrefString(newSettings.fontFamily!) : null;

  //
}

/// Holds the settings for the reader.
///
/// All fields have defaults and can be reset to them by omitting the parameter
/// in [copyWith]. [fontFamily] is the exception: null means "use the system
/// default font" and can be restored by passing null explicitly via [copyWith].
@immutable
class ReaderSettings {
  const ReaderSettings({
    this.showMacrons = _defaultShowMacrons,
    this.fontFamily = _defaultFontFamily,
    this.fontSize = _defaultFontSize,
    this.lineHeight = _defaultLineHeight,
    this.letterSpacing = _defaultLetterSpacing,
    this.wordSpacing = _defaultWordSpacing,
  });

  /// The font family to use in the reader, or null to use the system default.
  final String? fontFamily;
  final bool showMacrons;
  final double fontSize;
  final double lineHeight;
  final double letterSpacing;
  final double wordSpacing;
  static const _unset = Object();
  static const bool _defaultShowMacrons = true;
  static const String? _defaultFontFamily = null;
  static const double _defaultFontSize = 20.0;
  static const double _defaultLineHeight = 1.5;
  static const double _defaultLetterSpacing = 0.0;
  static const double _defaultWordSpacing = 0.0;

  /// Returns a copy with the given fields replaced.
  ///
  /// [fontFamily] uses a sentinel default so that null can be passed explicitly
  /// to reset the font to the system default, distinguishing it from "not
  /// provided".
  ReaderSettings copyWith({
    bool? showMacrons,
    Object? fontFamily = _unset,
    double? fontSize,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
  }) => ReaderSettings(
    showMacrons: showMacrons ?? this.showMacrons,
    fontFamily: fontFamily == _unset ? this.fontFamily : fontFamily as String?,
    fontSize: fontSize ?? this.fontSize,
    lineHeight: lineHeight ?? this.lineHeight,
    letterSpacing: letterSpacing ?? this.letterSpacing,
    wordSpacing: wordSpacing ?? this.wordSpacing,
  );

  @override
  @override
  String toString() =>
      'ReaderSettings{'
      'showMacrons: $showMacrons, '
      'fontFamily: $fontFamily, '
      'fontSize: $fontSize, '
      'lineHeight: $lineHeight, '
      'letterSpacing: $letterSpacing, '
      'wordSpacing: $wordSpacing}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReaderSettings &&
          other.showMacrons == showMacrons &&
          other.fontFamily == fontFamily &&
          other.fontSize == fontSize &&
          other.lineHeight == lineHeight &&
          other.letterSpacing == letterSpacing &&
          other.wordSpacing == wordSpacing);

  @override
  int get hashCode =>
      Object.hash(showMacrons, fontFamily, fontSize, lineHeight, letterSpacing, wordSpacing);
  //
}
