import 'dart:collection';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart' show QuantizerCelebi, Score;

/// As in Flutter's [ColorScheme.fromImageProvider]
const _maxLongerSide = 112;

/// As in Material's own image color extraction
const _maxColorsBeforeScoring = 128;

/// Colors ranked by how well they suit a Material color scheme
@immutable
extension type const RankedColors._(UnmodifiableListView<ui.Color> unm)
    implements UnmodifiableListView<ui.Color> {
  RankedColors(
    Iterable<ui.Color> iter,
  ) : this._(UnmodifiableListView(iter));

  ui.Color get best => first;
  //
}

Future<RankedColors> colorsOfImage(Uint8List encodedImage) async {
  final codec = await ui.instantiateImageCodecWithSize(
    await ui.ImmutableBuffer.fromUint8List(encodedImage),
    getTargetSize: _scaledDownKeepingAspectRatio,
  );
  final image = (await codec.getNextFrame()).image;
  codec.dispose();
  final rgba = _Rgba((await image.toByteData())!);
  image.dispose();
  return colorsOfPixels(rgba.argbPixels);
}

/// Up to four colors, picked the way Android picks a wallpaper's colors.
///
/// Pixels that aren't fully  opaque are ignored.
///
/// When no color is colorful or common enough, the only one is Material's
/// fallback blue.
Future<RankedColors> colorsOfPixels(Iterable<int> argbPixels) async {
  final quantized = await QuantizerCelebi().quantize(
    argbPixels.where(_isOpaque).toList(),
    _maxColorsBeforeScoring,
  );
  return RankedColors(Score.score(quantized.colorToCount).map(ui.Color.new));
}

bool _isOpaque(int argb) => argb >> 24 == 0xFF;

ui.TargetImageSize _scaledDownKeepingAspectRatio(int width, int height) => width >= height
    ? ui.TargetImageSize(width: math.min(width, _maxLongerSide))
    : ui.TargetImageSize(height: math.min(height, _maxLongerSide));

/// The bytes [ui.Image.toByteData] returns by default
extension type _Rgba(ByteData bytes) {
  Iterable<int> get argbPixels => Iterable.generate(
    bytes.lengthInBytes ~/ 4,
    (i) => _toArgb(bytes.getUint32(i * 4)),
  );

  static int _toArgb(int rgbaPixel) => ((rgbaPixel & 0xFF) << 24) | (rgbaPixel >> 8);
  //
}
