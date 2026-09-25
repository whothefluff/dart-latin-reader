import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../logger.dart';
import '../../widget/custom_adaptive_scaffold/breakpoints.dart';

/// Calculates the text and margin widths for a reader page.
///
/// With margins, the text is capped at A4 width and each margin keeps at least
/// the minimum interactive width. Without margins, the text uses the full page.
@immutable
class ReaderGeometry {
  factory ReaderGeometry(
    double pageWidth, {
    required bool withMargins,
  }) {
    final textWidth = withMargins ? min(_maxTextWidth, pageWidth - 2 * _minMarginWidth) : pageWidth;
    return ReaderGeometry._(textWidth: textWidth, marginWidth: (pageWidth - textWidth) / 2);
  }

  const ReaderGeometry._({
    required this.textWidth,
    required this.marginWidth,
  });

  /// Uses margins from the medium breakpoint up, matching the navigation rail
  /// and contents dialog.
  factory ReaderGeometry.inWindow(BuildContext context, double pageWidth) =>
      ReaderGeometry(pageWidth, withMargins: Breakpoints.mediumAndUp.isActive(context));

  /// Matches an A4 page at 72 dpi
  static const _maxTextWidth = 595.0;

  static const double _minMarginWidth = kMinInteractiveDimension;

  final double textWidth;

  /// Zero when the text takes the whole page
  final double marginWidth;

  bool get hasMargins => marginWidth > 0;

  //
}

/// Handles pointer gestures (touch, stylus, trackpad and mouse input) for
/// [textArea] and its page-turn margins.
///
/// Margins turn pages on tap/click and open the navigation menu on
/// long-press/right-click. Touch, stylus and trackpad swipes turn pages, and a
/// touch or stylus double-tap on the text opens the menu; mouse drags and
/// double-clicks remain available for text selection.
class ReaderGestures extends StatelessWidget {
  const ReaderGestures({
    super.key,
    required this.geometry,
    required this.onNext,
    required this.onPrevious,
    required this.onOpenMenu,
    required this.textArea,
  });

  /// Pointers whose drags and double-taps are gestures. A mouse drags and
  /// double-clicks to select text instead
  static const Set<PointerDeviceKind> _touchDevices = {
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
  };
  final ReaderGeometry geometry;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onOpenMenu;
  final Widget textArea;

  @override
  Widget build(context) {
    final claimSettings = _claimSettings(context);
    return _Swipes(
      onNext: onNext,
      onPrevious: onPrevious,
      child: RawGestureDetector(
        behavior: HitTestBehavior.opaque,
        gestures: {
          //no-op on purpose: wins the drag from the text's caret/magnifier; _Swipes turns pages
          HorizontalDragGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
                () => HorizontalDragGestureRecognizer(supportedDevices: _touchDevices),
                (recognizer) => recognizer
                  ..gestureSettings = claimSettings
                  ..onStart = (_) {},
              ),
        },
        child: geometry.hasMargins ? _withMargins() : SizedBox.expand(child: _menuOnDoubleTap()),
      ),
    );
  }

  Widget _withMargins() => Row(
    children: [
      _margin(onTap: onPrevious),
      SizedBox(width: geometry.textWidth, child: _menuOnDoubleTap()),
      _margin(onTap: onNext),
    ],
  );

  /// A margin turns the page on tap/click and opens the menu on touch/stylus
  /// long-press or right-click.
  ///
  /// There is no double-tap handler because it would delay every page-turn tap.
  Widget _margin({required VoidCallback onTap}) => SizedBox(
    width: geometry.marginWidth,
    child: GestureDetector(
      //the childless inner detector never reports a hit, so this one must be opaque
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onSecondaryTap: onOpenMenu,
      child: GestureDetector(
        supportedDevices: _touchDevices,
        onLongPress: onOpenMenu,
      ),
    ),
  );

  Widget _menuOnDoubleTap() => GestureDetector(
    behavior: HitTestBehavior.opaque,
    supportedDevices: _touchDevices,
    onDoubleTap: onOpenMenu,
    child: textArea,
  );

  /// Claims touch/stylus horizontal drags before SelectableText starts selection.
  ///
  /// Raw stroke tracking still handles a large first move that this recognizer
  /// loses to the text.
  DeviceGestureSettings _claimSettings(BuildContext context) {
    final platformSlop = MediaQuery.maybeGestureSettingsOf(context)?.touchSlop ?? kTouchSlop;
    return DeviceGestureSettings(touchSlop: min(platformSlop, kTouchSlop / 2));
  }

  //
}

/// Turns pages on strokes of a finger, a pen or a trackpad
///
/// Raw pointer events are used because SelectableText can win the gesture arena
/// when the first move is large. A stroke that is cancelled, or that began as a
/// long press, never turns a page
class _Swipes extends StatefulWidget {
  const _Swipes({
    required this.onNext,
    required this.onPrevious,
    required this.child,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Widget child;

  @override
  State<_Swipes> createState() => _SwipesState();

  //
}

class _SwipesState extends State<_Swipes> {
  //

  static const Set<PointerDeviceKind> _strokeDevices = {
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
  };

  /// The active stroke. A second pointer cancels tracking.
  _Stroke? _stroke;

  @override
  Widget build(context) => Listener(
    behavior: HitTestBehavior.opaque,
    onPointerDown: (event) => _start(event, event.position),
    onPointerMove: (event) => _move(event, event.position),
    onPointerUp: (event) => _finish(event, event.position),
    onPointerCancel: _drop,
    onPointerPanZoomStart: (event) => _start(event, Offset.zero),
    onPointerPanZoomUpdate: (event) => _move(event, event.pan),
    onPointerPanZoomEnd: _finish,
    child: widget.child,
  );

  void _start(PointerEvent event, Offset at) {
    _stroke = _stroke == null && _strokeDevices.contains(event.kind) ? _Stroke(event, at) : null;
  }

  void _move(PointerEvent event, Offset at) {
    final stroke = _stroke;
    if (stroke != null && stroke.pointer == event.pointer) {
      stroke.moveTo(event.timeStamp, at);
    }
  }

  void _drop(PointerCancelEvent event) {
    if (_stroke?.pointer == event.pointer) {
      _stroke = null;
    }
  }

  /// Without [at], the stroke ends where it last was: a trackpad's end event
  /// carries no pan
  void _finish(PointerEvent event, [Offset? at]) {
    final stroke = _stroke;
    if (stroke != null && stroke.pointer == event.pointer) {
      _stroke = null;
      stroke.moveTo(event.timeStamp, at ?? stroke.end);
      final turnsPage = stroke.turnsPage;
      if (turnsPage && stroke.isForward) {
        log.info(() => 'handling swipe forward');
        widget.onNext();
      } else if (turnsPage) {
        log.info(() => 'handling swipe back');
        widget.onPrevious();
      }
    }
  }

  //
}

/// Tracks displacement, timing and velocity for one candidate page-turn stroke.
class _Stroke {
  _Stroke(
    PointerEvent start,
    this._origin,
  ) : pointer = start.pointer,
      _isTrackpad = start.kind == PointerDeviceKind.trackpad,
      _startTime = start.timeStamp,
      _end = _origin,
      _velocity = VelocityTracker.withKind(start.kind) {
    _velocity.addPosition(start.timeStamp, _origin);
  }

  /// Minimum travel that turns the page even when the stroke ends slowly.
  static const _pageTurnTravel = 48.0;

  final int pointer;
  final Offset _origin;
  final bool _isTrackpad;
  final Duration _startTime;
  final VelocityTracker _velocity;

  Offset _end;

  /// When the stroke first moved beyond [kTouchSlop]
  Duration? _leftTapAt;

  Offset get end => _end;

  void moveTo(Duration time, Offset at) {
    _end = at;
    _leftTapAt ??= (at - _origin).distance > kTouchSlop ? time : null;
    _velocity.addPosition(time, at);
  }

  /// Whether this stroke qualifies as a page turn.
  bool get turnsPage {
    final travel = _end - _origin;
    final along = _along;
    final speed = _speed;
    final isOnAxis = _isVertical || travel.dx.abs() > travel.dy.abs();
    final wasLongPress =
        !_isTrackpad && (_leftTapAt ?? _startTime) - _startTime >= kLongPressTimeout;
    final isFlick = speed.abs() >= kMinFlingVelocity;
    final flicksBack = isFlick && speed.sign != along.sign;
    final isFarEnough = along.abs() >= _pageTurnTravel || (isFlick && along.abs() > kTouchSlop);
    return isOnAxis && !wasLongPress && !flicksBack && isFarEnough;
  }

  /// Content follows the fingers: moving it towards the start (left or up)
  /// brings the next page
  bool get isForward => _along < 0;

  bool get _isVertical {
    final travel = _end - _origin;
    return _isTrackpad && travel.dy.abs() > travel.dx.abs();
  }

  double get _along => _isVertical ? (_end - _origin).dy : (_end - _origin).dx;

  double get _speed {
    final velocity = _velocity.getVelocity().pixelsPerSecond;
    return _isVertical ? velocity.dy : velocity.dx;
  }

  //
}

/// Adds keyboard and pointer-scroll page navigation around [child].
///
/// ←, PgUp and Shift+Space turn back; →, PgDn and Space turn forward. Esc opens
/// the reader menu after the text has no context menu left to close. Scroll
/// events are grouped into flicks so one flick turns at most one page.
class ReaderKeysAndWheel extends StatefulWidget {
  const ReaderKeysAndWheel({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.onOpenMenu,
    required this.child,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Future<void> Function() onOpenMenu;
  final Widget child;

  @override
  State<ReaderKeysAndWheel> createState() => _ReaderKeysAndWheelState();

  //
}

class _ReaderKeysAndWheelState extends State<ReaderKeysAndWheel> {
  //

  /// Scroll in one direction that turns a page
  static const _wheelStep = 20.0;

  /// Scroll events closer together than this belong to the same flick
  static const _flickGap = Duration(milliseconds: 200);

  var _wheelTravel = 0.0;

  Duration _lastScrollAt = Duration.zero;

  /// Scroll events before this continue a flick that already turned a page
  Duration _flickEnd = Duration.zero;

  @override
  Widget build(context) => Listener(
    onPointerSignal: _onPointerSignal,
    child: Actions(
      actions: {
        // the focused text passes Esc on only when it has no toolbar to close
        DismissIntent: CallbackAction<DismissIntent>(onInvoke: (_) => widget.onOpenMenu()),
      },
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.arrowLeft): widget.onPrevious,
          const SingleActivator(LogicalKeyboardKey.pageUp): widget.onPrevious,
          const SingleActivator(LogicalKeyboardKey.space, shift: true): widget.onPrevious,
          const SingleActivator(LogicalKeyboardKey.arrowRight): widget.onNext,
          const SingleActivator(LogicalKeyboardKey.pageDown): widget.onNext,
          const SingleActivator(LogicalKeyboardKey.space): widget.onNext,
        },
        // own scope under the shortcuts: focus lands here when the text unfocuses or is replaced
        child: FocusScope(autofocus: true, child: widget.child),
      ),
    ),
  );

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      //anything under the pointer that can actually scroll registers first and keeps it
      GestureBinding.instance.pointerSignalResolver.register(event, (_) => _onScroll(event));
    }
  }

  void _onScroll(PointerScrollEvent event) {
    final delta = event.scrollDelta;
    final along = delta.dy.abs() >= delta.dx.abs() ? delta.dy : delta.dx;
    final continuesTurnedFlick = event.timeStamp < _flickEnd;
    final continuesFlick =
        event.timeStamp - _lastScrollAt <= _flickGap && along.sign == _wheelTravel.sign;
    final travel = continuesTurnedFlick ? 0.0 : (continuesFlick ? _wheelTravel : 0.0) + along;
    _lastScrollAt = event.timeStamp;
    final turnsPage = travel.abs() >= _wheelStep;
    _wheelTravel = turnsPage ? 0.0 : travel;
    _flickEnd = continuesTurnedFlick || turnsPage ? event.timeStamp + _flickGap : _flickEnd;
    if (turnsPage && travel > 0) {
      widget.onNext();
    } else if (turnsPage) {
      widget.onPrevious();
    }
  }

  //
}
