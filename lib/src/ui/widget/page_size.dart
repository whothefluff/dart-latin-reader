import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show NumberFormat;

/// Every page size offered, smallest first.
const List<int> pageSizes = [25, 50, 100, 250, 500];

/// Dropdown value of the "Custom…" entry (real page sizes are always positive)
const int _customPageSize = -1;

/// A page size dropdown's entries:
/// - the [offered] sizes,
/// - [current] if it's another,
/// - and "Custom…"
List<DropdownMenuItem<int>> pageSizeItems(
  Iterable<int> offered,
  int current,
  NumberFormat count,
) => [
  ..._sizes(offered, current).map(
    (size) => DropdownMenuItem(value: size, child: Text(count.format(size))),
  ),
  const DropdownMenuItem(value: _customPageSize, child: Text('Custom…')),
];

/// The size [picked] in [pageSizeItems].
///
/// Null when the dialog is cancelled
Future<int?> pickPageSize(
  BuildContext context,
  int? picked, {
  required int current,
  required String title,
}) async {
  final size = picked == _customPageSize
      ? await showDialog<int>(
          context: context,
          builder: (_) => _CustomPageSizeDialog(title: title, initial: current),
        )
      : picked;
  return size != null && size > 0 ? size : null;
}

List<int> _sizes(Iterable<int> offered, int current) =>
    {...offered, current}.sorted((a, b) => a - b);

/// Keeps its text controller alive until the dialog finishes closing
class _CustomPageSizeDialog extends StatefulWidget {
  const _CustomPageSizeDialog({
    required this.title,
    required this.initial,
  });

  final String title;
  final int initial;

  @override
  State<_CustomPageSizeDialog> createState() => _CustomPageSizeDialogState();
  //
}

class _CustomPageSizeDialogState extends State<_CustomPageSizeDialog> {
  //
  late final _controller = TextEditingController(text: '${widget.initial}');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autofocus: true,
      onSubmitted: (_) => _apply(),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
      FilledButton(onPressed: _apply, child: const Text('Apply')),
    ],
  );

  void _apply() => Navigator.pop(context, int.tryParse(_controller.text));

  //
}
