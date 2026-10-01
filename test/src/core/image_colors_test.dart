import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/core/image_colors.dart';

const _red = ui.Color(0xFFD32F2F);
const _blue = ui.Color(0xFF1976D2);
const _seeThroughGreen = 0x004CAF50;

Future<Uint8List> _solidPng(int width, int height, ui.Color color) async {
  final recorder = ui.PictureRecorder();
  ui.Canvas(recorder).drawRect(
    ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    ui.Paint()..color = color,
  );
  final image = await recorder.endRecording().toImage(width, height);
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return png!.buffer.asUint8List();
}

void main() {
  group('colorsOfPixels', () {
    test('puts the color that covers more of the image first', () async {
      final pixels = [
        ...List.filled(700, _red.toARGB32()),
        ...List.filled(300, _blue.toARGB32()),
      ];

      expect(await colorsOfPixels(pixels), [_red, _blue]);
    });

    test('ignores pixels that are not fully opaque', () async {
      final pixels = [
        ...List.filled(900, _seeThroughGreen),
        ...List.filled(100, _blue.toARGB32()),
      ];

      expect(await colorsOfPixels(pixels), [_blue]);
    });
  });

  test('colorsOfImage reads the colors of a PNG larger than it scales images down to', () async {
    expect(await colorsOfImage(await _solidPng(300, 200, _red)), [_red]);
  });
}
