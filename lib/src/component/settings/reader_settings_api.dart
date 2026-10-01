import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/settings.dart';
import '../word_frequency/lookup_frequency_api.dart' show FrequencyScope;

part 'reader_settings_api.g.dart';

//infrastructure

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
  static const _markCommonWords = '${_prefix}markCommonWords';
  static const _commonWordsPercent = '${_prefix}commonWordsPercent';
  static const _markUncommonWords = '${_prefix}markUncommonWords';
  static const _uncommonWordsPercent = '${_prefix}uncommonWordsPercent';
  static const _frequencyScope = '${_prefix}frequencyScope';

  /// Stored by name.
  /// A renamed value falls back to the default.
  static final Map<String, FrequencyScope> _frequencyScopesByName = FrequencyScope.values
      .asNameMap();

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
    final savedMarkCommonWords = await repo.get(_markCommonWords, PrefBool.hint);
    final savedCommonWordsPercent = await repo.get(_commonWordsPercent, PrefInt.hint);
    final savedMarkUncommonWords = await repo.get(_markUncommonWords, PrefBool.hint);
    final savedUncommonWordsPercent = await repo.get(_uncommonWordsPercent, PrefInt.hint);
    final savedFrequencyScope = await repo.get(_frequencyScope, PrefString.hint);
    final settings = ReaderSettings(
      showMacrons: savedShowMacrons?.value ?? ReaderSettings._defaultShowMacrons,
      fontFamily: savedFontFamily?.value,
      fontSize: savedFontSize?.value ?? ReaderSettings._defaultFontSize,
      lineHeight: savedLineHeight?.value ?? ReaderSettings._defaultLineHeight,
      letterSpacing: savedLetterSpacing?.value ?? ReaderSettings._defaultLetterSpacing,
      wordSpacing: savedWordSpacing?.value ?? ReaderSettings._defaultWordSpacing,
      markCommonWords: savedMarkCommonWords?.value ?? ReaderSettings._defaultMarkCommonWords,
      commonWordsPercent:
          savedCommonWordsPercent?.value ?? ReaderSettings._defaultCommonWordsPercent,
      markUncommonWords: savedMarkUncommonWords?.value ?? ReaderSettings._defaultMarkUncommonWords,
      uncommonWordsPercent:
          savedUncommonWordsPercent?.value ?? ReaderSettings._defaultUncommonWordsPercent,
      frequencyScope:
          _frequencyScopesByName[savedFrequencyScope?.value] ??
          ReaderSettings._defaultFrequencyScope,
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
        await repo.set(_markCommonWords, PrefBool(newSettings.markCommonWords));
        await repo.set(_commonWordsPercent, PrefInt(newSettings.commonWordsPercent));
        await repo.set(_markUncommonWords, PrefBool(newSettings.markUncommonWords));
        await repo.set(_uncommonWordsPercent, PrefInt(newSettings.uncommonWordsPercent));
        await repo.set(_frequencyScope, PrefString(newSettings.frequencyScope.name));
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

//domain

/// Holds the settings for the reader.
@immutable
class ReaderSettings {
  const ReaderSettings({
    required this.showMacrons,
    required this.fontFamily,
    required this.fontSize,
    required this.lineHeight,
    required this.letterSpacing,
    required this.wordSpacing,
    required this.markCommonWords,
    required this.commonWordsPercent,
    required this.markUncommonWords,
    required this.uncommonWordsPercent,
    required this.frequencyScope,
  });

  const ReaderSettings.defaults()
    : this(
        showMacrons: _defaultShowMacrons,
        fontFamily: _defaultFontFamily,
        fontSize: _defaultFontSize,
        lineHeight: _defaultLineHeight,
        letterSpacing: _defaultLetterSpacing,
        wordSpacing: _defaultWordSpacing,
        markCommonWords: _defaultMarkCommonWords,
        commonWordsPercent: _defaultCommonWordsPercent,
        markUncommonWords: _defaultMarkUncommonWords,
        uncommonWordsPercent: _defaultUncommonWordsPercent,
        frequencyScope: _defaultFrequencyScope,
      );

  /// The font family to use in the reader, or null to use the system default.
  final String? fontFamily;

  final bool markUncommonWords;

  /// The share of the text the uncommon words make up, from their rarest lemma up
  final int uncommonWordsPercent;

  /// The share of the text the common words make up, from their most frequent lemma down
  final int commonWordsPercent;

  /// The works a word is common or uncommon in
  final FrequencyScope frequencyScope;

  final bool showMacrons;
  final double fontSize;
  final double lineHeight;
  final double letterSpacing;
  final double wordSpacing;
  final bool markCommonWords;
  static const _unset = Object();
  static const bool _defaultShowMacrons = true;
  static const String? _defaultFontFamily = null;
  static const double _defaultFontSize = 20.0;
  static const double _defaultLineHeight = 1.5;
  static const double _defaultLetterSpacing = 0.0;
  static const double _defaultWordSpacing = 0.0;
  static const bool _defaultMarkCommonWords = false;
  static const int _defaultCommonWordsPercent = 25;
  static const bool _defaultMarkUncommonWords = true;
  static const int _defaultUncommonWordsPercent = 5;
  static const FrequencyScope _defaultFrequencyScope = FrequencyScope.library;

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
    bool? markCommonWords,
    int? commonWordsPercent,
    bool? markUncommonWords,
    int? uncommonWordsPercent,
    FrequencyScope? frequencyScope,
  }) => ReaderSettings(
    showMacrons: showMacrons ?? this.showMacrons,
    fontFamily: fontFamily == _unset ? this.fontFamily : fontFamily as String?,
    fontSize: fontSize ?? this.fontSize,
    lineHeight: lineHeight ?? this.lineHeight,
    letterSpacing: letterSpacing ?? this.letterSpacing,
    wordSpacing: wordSpacing ?? this.wordSpacing,
    markCommonWords: markCommonWords ?? this.markCommonWords,
    commonWordsPercent: commonWordsPercent ?? this.commonWordsPercent,
    markUncommonWords: markUncommonWords ?? this.markUncommonWords,
    uncommonWordsPercent: uncommonWordsPercent ?? this.uncommonWordsPercent,
    frequencyScope: frequencyScope ?? this.frequencyScope,
  );

  /// `true` when the reader uses the words' frequencies in any way
  bool get marksFrequencies => markCommonWords || markUncommonWords;

  @override
  String toString() =>
      'ReaderSettings{'
      'showMacrons: $showMacrons, '
      'fontFamily: $fontFamily, '
      'fontSize: $fontSize, '
      'lineHeight: $lineHeight, '
      'letterSpacing: $letterSpacing, '
      'wordSpacing: $wordSpacing, '
      'markCommonWords: $markCommonWords, '
      'commonWordsPercent: $commonWordsPercent, '
      'markUncommonWords: $markUncommonWords, '
      'uncommonWordsPercent: $uncommonWordsPercent, '
      'frequencyScope: $frequencyScope}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReaderSettings &&
          other.showMacrons == showMacrons &&
          other.fontFamily == fontFamily &&
          other.fontSize == fontSize &&
          other.lineHeight == lineHeight &&
          other.letterSpacing == letterSpacing &&
          other.wordSpacing == wordSpacing &&
          other.markCommonWords == markCommonWords &&
          other.commonWordsPercent == commonWordsPercent &&
          other.markUncommonWords == markUncommonWords &&
          other.uncommonWordsPercent == uncommonWordsPercent &&
          other.frequencyScope == frequencyScope);

  @override
  int get hashCode => Object.hash(
    showMacrons,
    fontFamily,
    fontSize,
    lineHeight,
    letterSpacing,
    wordSpacing,
    markCommonWords,
    commonWordsPercent,
    markUncommonWords,
    uncommonWordsPercent,
    frequencyScope,
  );
  //
}
