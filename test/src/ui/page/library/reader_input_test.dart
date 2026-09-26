import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/ui/page/library/reader_input.dart';

const _caesar =
    'Gallia est omnis divisa in partes tres, quarum unam incolunt Belgae, aliam Aquitani, '
    'tertiam qui ipsorum lingua Celtae, nostra Galli appellantur.';

const _phoneUpright = Size(390, 844);

/// An iPhone 15 on its side, less the insets on both short edges (852 − 2 × 59)
const _phoneOnItsSide = Size(734, 393);

const _desktopWindow = Size(1280, 800);

const _smallWindow = Size(500, 800);

/// The reader's page as text_page.dart puts it together, recording what it
/// asks for
Widget _reader(List<String> calls, {Key? textKey}) => MaterialApp(
  home: Scaffold(
    body: ReaderKeysAndWheel(
      onNext: () => calls.add('next'),
      onPrevious: () => calls.add('previous'),
      onOpenMenu: () async => calls.add('menu'),
      child: LayoutBuilder(
        builder: (context, constraints) => ReaderGestures(
          geometry: ReaderGeometry.inWindow(context, constraints.maxWidth),
          onNext: () => calls.add('next'),
          onPrevious: () => calls.add('previous'),
          onOpenMenu: () => calls.add('menu'),
          textArea: SizedBox.expand(child: SelectableText(_caesar, key: textKey)),
        ),
      ),
    ),
  ),
);

/// Shows the reader on a screen of [size] (the default 800 × 600 otherwise)
/// and returns what it asks for
Future<List<String>> _open(WidgetTester tester, [Size? size]) async {
  if (size != null) {
    tester.view
      ..physicalSize = size
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }
  final calls = <String>[];
  await tester.pumpWidget(_reader(calls));
  await tester.pump();
  return calls;
}

Rect _text(WidgetTester tester) => tester.getRect(find.byType(SelectableText));

Offset _firstWord(WidgetTester tester) => _text(tester).topLeft + const Offset(8, 8);

Offset _textMiddle(WidgetTester tester) => _text(tester).center;

/// Inside the text area, below the last line
Offset _blank(WidgetTester tester) => _text(tester).bottomCenter - const Offset(0, 20);

Offset _leftMargin(WidgetTester tester) {
  final text = _text(tester);
  return Offset(text.left / 2, text.center.dy);
}

Offset _rightMargin(WidgetTester tester) {
  final text = _text(tester);
  final page = tester.getRect(find.byType(ReaderGestures));
  return Offset((text.right + page.right) / 2, text.center.dy);
}

String _selected(WidgetTester tester) {
  final value = tester.state<EditableTextState>(find.byType(EditableText)).textEditingValue;
  return value.selection.isValid ? value.selection.textInside(value.text) : '';
}

bool _textHasFocus() {
  final focused = FocusManager.instance.primaryFocus?.context;
  return focused?.findAncestorWidgetOfExactType<SelectableText>() != null;
}

Finder get _textMenu => find.byType(AdaptiveTextSelectionToolbar);

/// Puts a pointer down at [from] and moves it [by], without lifting it
///
/// Moves in [move]-pixel steps every [every]. [hold] delays the first move.
/// Returns the gesture and the timestamp of its last move.
Future<({TestGesture gesture, Duration at})> _drag(
  WidgetTester tester,
  Offset from,
  Offset by, {
  required PointerDeviceKind kind,
  double move = 10,
  Duration every = const Duration(milliseconds: 8),
  Duration hold = Duration.zero,
}) async {
  final steps = (by.distance / move).ceil();
  final gesture = await tester.startGesture(from, kind: kind);
  await tester.pump(hold);
  await Future.forEach(
    List.generate(steps, (i) => i + 1),
    (step) => gesture.moveBy(by / steps.toDouble(), timeStamp: hold + every * step),
  );
  return (gesture: gesture, at: hold + every * steps);
}

/// A stroke that lifts right after its last move
Future<void> _stroke(
  WidgetTester tester,
  Offset from,
  Offset by, {
  required PointerDeviceKind kind,
  double move = 10,
  Duration every = const Duration(milliseconds: 8),
}) async {
  final drag = await _drag(tester, from, by, kind: kind, move: move, every: every);
  await drag.gesture.up(timeStamp: drag.at + const Duration(milliseconds: 8));
  // Lets a tap series the stroke started run out
  await tester.pump(kDoubleTapTimeout);
}

Future<void> _swipe(
  WidgetTester tester,
  Offset from,
  Offset by, {
  double move = 10,
  Duration every = const Duration(milliseconds: 8),
}) => _stroke(tester, from, by, kind: PointerDeviceKind.touch, move: move, every: every);

const _phones = TargetPlatformVariant({TargetPlatform.android, TargetPlatform.iOS});

Future<void> _doubleTap(
  WidgetTester tester,
  Offset at, {
  PointerDeviceKind kind = PointerDeviceKind.touch,
}) async {
  await tester.tapAt(at, kind: kind);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tapAt(at, kind: kind);
  await tester.pump(kDoubleTapTimeout);
}

Future<void> _scroll(WidgetTester tester, double dy, {required int atMs}) {
  final wheel = TestPointer(1, PointerDeviceKind.mouse)..hover(_textMiddle(tester));
  return tester.sendEventToBinding(
    wheel.scroll(Offset(0, dy), timeStamp: Duration(milliseconds: atMs)),
  );
}

void _escOpensTheMenu(Size size, {TargetPlatformVariant? variant}) => testWidgets(
  'Esc opens the menu',
  (tester) async {
    final calls = await _open(tester, size);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    expect(calls, ['menu']);
  },
  variant: variant ?? TargetPlatformVariant.only(TargetPlatform.android),
);

/// Runs the mouse/text tests shared by layouts with and without margins.
void _mouseOnTheText(Size window) {
  testWidgets('a double-click on a word selects it', (tester) async {
    final calls = await _open(tester, window);
    await _doubleTap(tester, _firstWord(tester), kind: PointerDeviceKind.mouse);
    expect(_selected(tester), 'Gallia');
    expect(calls, isEmpty);
  }, variant: TargetPlatformVariant.desktop());

  testWidgets(
    'a double-click away from the words does not open the menu',
    (tester) async {
      final calls = await _open(tester, window);
      await _doubleTap(tester, _blank(tester), kind: PointerDeviceKind.mouse);
      expect(calls, isEmpty);
    },
    variant: TargetPlatformVariant.desktop(),
  );

  testWidgets('a drag selects text instead of turning the page', (tester) async {
    final calls = await _open(tester, window);
    await _stroke(tester, _firstWord(tester), const Offset(200, 0), kind: PointerDeviceKind.mouse);
    expect(_selected(tester), isNotEmpty);
    expect(calls, isEmpty);
  }, variant: TargetPlatformVariant.desktop());

  testWidgets('a long press on the text does nothing', (tester) async {
    final calls = await _open(tester, window);
    await tester.longPressAt(_firstWord(tester), kind: PointerDeviceKind.mouse);
    await tester.pump(kDoubleTapTimeout);
    expect(_selected(tester), isEmpty);
    expect(_textMenu, findsNothing);
    expect(calls, isEmpty);
  }, variant: TargetPlatformVariant.desktop());

  testWidgets("a right-click on a word opens the text's context menu", (tester) async {
    final calls = await _open(tester, window);
    await tester.tapAt(
      _firstWord(tester),
      kind: PointerDeviceKind.mouse,
      buttons: kSecondaryMouseButton,
    );
    await tester.pumpAndSettle(kDoubleTapTimeout);
    expect(_textMenu, findsOneWidget);
    expect(calls, isEmpty);
  }, variant: TargetPlatformVariant.desktop());

  testWidgets('the wheel turns pages', (tester) async {
    final calls = await _open(tester, window);
    await _scroll(tester, 50, atMs: 1000);
    await _scroll(tester, -50, atMs: 2000);
    expect(calls, ['next', 'previous']);
  }, variant: TargetPlatformVariant.desktop());

  _escOpensTheMenu(window, variant: TargetPlatformVariant.desktop());
}

void main() {
  // flutter_test runs as Android with touch taps unless a variant says otherwise
  group('ReaderGeometry', () {
    test('keeps an A4 column on a wide page and gives the rest to the margins', () {
      final geometry = ReaderGeometry(1000, withMargins: true);
      expect(geometry.textWidth, 595);
      expect(geometry.marginWidth, 202.5);
    });

    test('narrows the column to keep margins big enough to hit', () {
      final geometry = ReaderGeometry(600, withMargins: true);
      expect(geometry.textWidth, 504);
      expect(geometry.marginWidth, kMinInteractiveDimension);
    });

    test('gives the whole page to the text without margins', () {
      final geometry = ReaderGeometry(1000, withMargins: false);
      expect(geometry.hasMargins, isFalse);
      expect(geometry.textWidth, 1000);
    });

    testWidgets('has margins from the medium breakpoint up, like the rest of the app', (
      tester,
    ) async {
      await _open(tester, const Size(599, 800));
      expect(_text(tester).width, 599);

      await _open(tester, const Size(600, 800));
      expect(_text(tester).width, 504);
    });

    testWidgets('has no margins on a phone held upright', (tester) async {
      await _open(tester, _phoneUpright);
      expect(_text(tester).width, _phoneUpright.width);
    });

    testWidgets('keeps the margins on a phone on its side', (tester) async {
      await _open(tester, _phoneOnItsSide);
      expect(_text(tester).width, 595);
    });
  });

  group('phone held upright', () {
    testWidgets('a double-tap opens the menu', (tester) async {
      final calls = await _open(tester, _phoneUpright);
      await _doubleTap(tester, _firstWord(tester));
      expect(calls, ['menu']);
    });

    testWidgets('a swipe over the text turns pages', (tester) async {
      final calls = await _open(tester, _phoneUpright);
      await _swipe(tester, _textMiddle(tester), const Offset(-150, 0));
      await _swipe(tester, _textMiddle(tester), const Offset(150, 0));
      expect(calls, ['next', 'previous']);
    });

    testWidgets("a long-press selects a word and shows the text's menu", (tester) async {
      final calls = await _open(tester, _phoneUpright);
      await tester.longPressAt(_firstWord(tester));
      await tester.pumpAndSettle(kDoubleTapTimeout);
      expect(_selected(tester), 'Gallia');
      expect(_textMenu, findsOneWidget);
      expect(calls, isEmpty);
    });

    _escOpensTheMenu(_phoneUpright);
  });

  group('phone on its side', () {
    testWidgets('a double-tap on the text opens the menu', (tester) async {
      final calls = await _open(tester, _phoneOnItsSide);
      await _doubleTap(tester, _firstWord(tester));
      expect(calls, ['menu']);
    });

    testWidgets('a swipe turns pages, over the text or over a margin', (tester) async {
      final calls = await _open(tester, _phoneOnItsSide);
      await _swipe(tester, _textMiddle(tester), const Offset(-150, 0));
      await _swipe(tester, _textMiddle(tester), const Offset(150, 0));
      await _swipe(tester, _rightMargin(tester), const Offset(-150, 0));
      await _swipe(tester, _leftMargin(tester), const Offset(150, 0));
      expect(calls, ['next', 'previous', 'next', 'previous']);
    });

    testWidgets("a long-press on a word selects it and shows the text's menu", (tester) async {
      final calls = await _open(tester, _phoneOnItsSide);
      await tester.longPressAt(_firstWord(tester));
      await tester.pumpAndSettle(kDoubleTapTimeout);
      expect(_selected(tester), 'Gallia');
      expect(_textMenu, findsOneWidget);
      expect(calls, isEmpty);
    });

    testWidgets('a tap on a margin turns the page', (tester) async {
      final calls = await _open(tester, _phoneOnItsSide);
      await tester.tapAt(_rightMargin(tester));
      await tester.tapAt(_leftMargin(tester));
      expect(calls, ['next', 'previous']);
    });

    testWidgets('a long-press on a margin opens the menu', (tester) async {
      final calls = await _open(tester, _phoneOnItsSide);
      await tester.longPressAt(_leftMargin(tester));
      expect(calls, ['menu']);
    });

    _escOpensTheMenu(_phoneOnItsSide);
  });

  group('finger strokes', () {
    testWidgets(
      "a fast swipe turns the page even when its first move beats the text's slop",
      (tester) async {
        // 30 px moves 24 ms apart: as fast as the others, but the text's drag
        // selection sees 30 px first and claims the drag on Android
        const move = 30.0;
        const every = Duration(milliseconds: 24);
        final calls = await _open(tester, _phoneUpright);
        final start = _firstWord(tester) + const Offset(150, 0);
        await _swipe(tester, start, const Offset(-150, 0), move: move, every: every);
        await _swipe(tester, _firstWord(tester), const Offset(150, 0), move: move, every: every);
        expect(calls, ['next', 'previous']);

        final sideCalls = await _open(tester, _phoneOnItsSide);
        final sideStart = _firstWord(tester) + const Offset(150, 0);
        await _swipe(tester, sideStart, const Offset(-150, 0), move: move, every: every);
        await _swipe(tester, _firstWord(tester), const Offset(150, 0), move: move, every: every);
        expect(sideCalls, ['next', 'previous']);
      },
      variant: _phones,
    );

    testWidgets('a swipe that pauses before the finger lifts still turns the page', (
      tester,
    ) async {
      final calls = await _open(tester, _phoneOnItsSide);
      final drag = await _drag(
        tester,
        _rightMargin(tester),
        const Offset(-150, 0),
        kind: PointerDeviceKind.touch,
      );
      await tester.pump(const Duration(milliseconds: 700));
      await drag.gesture.up(timeStamp: drag.at + const Duration(milliseconds: 700));
      await tester.pump(kDoubleTapTimeout);
      expect(calls, ['next']);
    }, variant: _phones);

    testWidgets('a cancelled swipe does not turn the page', (tester) async {
      final calls = await _open(tester, _phoneOnItsSide);
      final drag = await _drag(
        tester,
        _rightMargin(tester),
        const Offset(-150, 0),
        kind: PointerDeviceKind.touch,
      );
      await drag.gesture.cancel(timeStamp: drag.at + const Duration(milliseconds: 8));
      await tester.pump(kDoubleTapTimeout);
      expect(calls, isEmpty);
    }, variant: _phones);

    testWidgets('a short quick flick turns the page, a short slow drag does not', (
      tester,
    ) async {
      final calls = await _open(tester, _phoneOnItsSide);
      await _swipe(tester, _rightMargin(tester), const Offset(-30, 0));
      expect(calls, ['next']);

      await _swipe(
        tester,
        _rightMargin(tester),
        const Offset(-30, 0),
        every: const Duration(milliseconds: 100),
      );
      expect(calls, ['next']);
    }, variant: _phones);

    testWidgets('a drag after a long-press on a word selects instead of turning the page', (
      tester,
    ) async {
      final calls = await _open(tester, _phoneUpright);
      final drag = await _drag(
        tester,
        _firstWord(tester),
        const Offset(150, 0),
        kind: PointerDeviceKind.touch,
        hold: kLongPressTimeout + kPressTimeout,
      );
      await drag.gesture.up(timeStamp: drag.at + const Duration(milliseconds: 8));
      await tester.pumpAndSettle(kDoubleTapTimeout);
      expect(_selected(tester), isNotEmpty);
      expect(calls, isEmpty);
    });
  });

  group('desktop window with margins', () {
    _mouseOnTheText(_desktopWindow);

    testWidgets(
      'a click on a margin turns the page, a right-click opens the menu',
      (tester) async {
        final calls = await _open(tester, _desktopWindow);
        await tester.tapAt(_rightMargin(tester), kind: PointerDeviceKind.mouse);
        await tester.tapAt(
          _leftMargin(tester),
          kind: PointerDeviceKind.mouse,
          buttons: kSecondaryMouseButton,
        );
        expect(calls, ['next', 'menu']);
      },
      variant: TargetPlatformVariant.desktop(),
    );

    testWidgets(
      'a mouse held down on a margin is a click, not the menu',
      (tester) async {
        final calls = await _open(tester, _desktopWindow);
        await tester.longPressAt(_leftMargin(tester), kind: PointerDeviceKind.mouse);
        expect(calls, ['previous']);
      },
      variant: TargetPlatformVariant.desktop(),
    );
  });

  group('small desktop window', () {
    testWidgets('has no margins', (tester) async {
      await _open(tester, _smallWindow);
      expect(_text(tester).width, _smallWindow.width);
    });

    _mouseOnTheText(_smallWindow);
  });

  group('on any platform', () {
    testWidgets(
      'a margin turns the page on the tap, without waiting to see if it is a double-tap',
      (tester) async {
        final calls = await _open(tester);
        await tester.tapAt(_rightMargin(tester));
        expect(calls, ['next']);
        await tester.tapAt(_leftMargin(tester), kind: PointerDeviceKind.mouse);
        expect(calls, ['next', 'previous']);
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      'a long-press or a right-click on a margin opens the menu',
      (tester) async {
        final calls = await _open(tester);
        await tester.longPressAt(_leftMargin(tester));
        await tester.tapAt(
          _rightMargin(tester),
          kind: PointerDeviceKind.mouse,
          buttons: kSecondaryMouseButton,
        );
        expect(calls, ['menu', 'menu']);
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      'a trackpad swipes pages sideways or up and down, a mouse drag does not',
      (tester) async {
        final calls = await _open(tester);
        final middle = _textMiddle(tester);
        await _stroke(tester, middle, const Offset(-300, 0), kind: PointerDeviceKind.trackpad);
        await _stroke(tester, middle, const Offset(0, 300), kind: PointerDeviceKind.trackpad);
        await _stroke(tester, middle, const Offset(-300, 0), kind: PointerDeviceKind.mouse);
        expect(calls, ['next', 'previous']);
      },
      variant: TargetPlatformVariant.all(),
    );

    testWidgets(
      'a double-click on the text never opens the menu',
      (tester) async {
        final calls = await _open(tester);
        await _doubleTap(tester, _firstWord(tester), kind: PointerDeviceKind.mouse);
        expect(calls, isEmpty);
      },
      variant: TargetPlatformVariant.all(),
    );
  });

  group('ReaderKeysAndWheel', () {
    testWidgets('arrows, page keys and space turn pages', (tester) async {
      final calls = await _open(tester);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.sendKeyEvent(LogicalKeyboardKey.pageDown);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.pageUp);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);

      expect(calls, ['next', 'next', 'next', 'previous', 'previous', 'previous']);
    });

    testWidgets(
      'keys still reach the reader after the next page replaces the focused text',
      (tester) async {
        final calls = <String>[];
        await tester.pumpWidget(_reader(calls, textKey: const ValueKey(1)));
        await tester.tapAt(_firstWord(tester), kind: PointerDeviceKind.mouse);
        await tester.pump();
        expect(_textHasFocus(), isTrue);

        await tester.pumpWidget(_reader(calls, textKey: const ValueKey(2)));
        await tester.pump();
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);

        expect(calls, ['next']);
        await tester.pump(kDoubleTapTimeout);
      },
      variant: TargetPlatformVariant.desktop(),
    );

    testWidgets(
      'keys still reach the reader after a click outside the focused text',
      (tester) async {
        final calls = await _open(tester);
        await tester.tapAt(_firstWord(tester), kind: PointerDeviceKind.mouse);
        await tester.pump();
        expect(_textHasFocus(), isTrue);

        await tester.tapAt(_leftMargin(tester), kind: PointerDeviceKind.mouse);
        await tester.pump();
        expect(_textHasFocus(), isFalse);
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);

        expect(calls, ['previous', 'next']);
        await tester.pump(kDoubleTapTimeout);
      },
      variant: TargetPlatformVariant.desktop(),
    );

    testWidgets("Esc closes the text's own menu first, then opens the reader's", (tester) async {
      final calls = await _open(tester);
      await tester.longPressAt(_firstWord(tester));
      await tester.pumpAndSettle();
      expect(_textMenu, findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(_textMenu, findsNothing);
      expect(calls, isEmpty);

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      expect(calls, ['menu']);
    });

    testWidgets('a wheel turns one page per flick', (tester) async {
      final calls = await _open(tester);

      await _scroll(tester, 50, atMs: 1000);
      await _scroll(tester, 50, atMs: 1050);
      await _scroll(tester, 50, atMs: 1100);
      expect(calls, ['next']);

      await _scroll(tester, 50, atMs: 1400);
      await _scroll(tester, -50, atMs: 1700);
      expect(calls, ['next', 'next', 'previous']);
    });

    testWidgets('small scrolls with pauses between them do not add up', (tester) async {
      final calls = await _open(tester);

      await _scroll(tester, 8, atMs: 1000);
      await _scroll(tester, 8, atMs: 5000);
      await _scroll(tester, 8, atMs: 9000);

      expect(calls, isEmpty);
    });

    testWidgets('small scroll events add up before they turn a page', (tester) async {
      final calls = await _open(tester);

      await _scroll(tester, 8, atMs: 1000);
      await _scroll(tester, 8, atMs: 1016);
      expect(calls, isEmpty);

      await _scroll(tester, 8, atMs: 1032);
      expect(calls, ['next']);
    });
  });
}
