import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dropdown with a label beside the selected value
///
/// Focus highlighting is shown only during keyboard navigation
class LabeledDropdown<T> extends StatelessWidget {
  const LabeledDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required ValueChanged<T?>? onChanged,
  }) : _onChanged = onChanged;

  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;

  /// Null disables the dropdown
  // Safe because this field is only read through this instance, with its original T
  // ignore: unsafe_variance
  final ValueChanged<T?>? _onChanged;

  @override
  Widget build(context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label),
      const SizedBox(width: 4),
      DropdownButtonHideUnderline(
        child: ValueListenableBuilder(
          valueListenable: _keyboardNavigation,
          builder: (_, keyboard, _) => DropdownButton<T>(
            value: value,
            items: items,
            onChanged: _onChanged,
            isDense: true,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            // Padding keeps the highlight clear of the text
            padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 4, 4),
            focusColor: keyboard ? null : Colors.transparent,
          ),
        ),
      ),
    ],
  );

  //
}

/// Whether focus highlights should be shown for keyboard navigation.
///
/// Some Flutter controls retain focus after mouse input or Alt+Tab, leaving
/// their focus highlight visible. Pointer input hides it; keyboard navigation
/// restores it.
final _InputModality _keyboardNavigation = _InputModality();

class _InputModality extends ValueNotifier<bool> {
  _InputModality() : super(false) {
    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_onPointer);
    HardwareKeyboard.instance.addHandler(_onKey);
  }

  /// Keys that only modify others: pressing them alone isn't navigating
  static final Set<LogicalKeyboardKey> _modifiers = {
    ...LogicalKeyboardKey.expandSynonyms({
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.meta,
    }),
    LogicalKeyboardKey.altGraph,
    LogicalKeyboardKey.capsLock,
    LogicalKeyboardKey.fn,
  };

  void _onPointer(PointerEvent event) {
    if (event is PointerDownEvent) {
      value = false;
    }
  }

  /// Only observes, so it never claims the event
  bool _onKey(KeyEvent event) {
    final keyboard = HardwareKeyboard.instance;
    if (event is KeyDownEvent &&
        !event.synthesized &&
        !_modifiers.contains(event.logicalKey) &&
        !keyboard.isControlPressed &&
        !keyboard.isAltPressed &&
        !keyboard.isMetaPressed) {
      value = true;
    }
    return false;
  }

  //
}
