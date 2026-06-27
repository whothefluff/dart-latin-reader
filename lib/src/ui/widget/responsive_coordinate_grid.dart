import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import 'custom_adaptive_scaffold/breakpoints.dart';

@immutable
class GridSlot {
  const GridSlot({
    required this.row,
    required this.col,
    required this.child,
  });

  final int row;
  final int col;
  final Widget child;
  //
}

class ResponsiveCoordinateGrid extends StatelessWidget {
  const ResponsiveCoordinateGrid({
    super.key,
    required this.slots,
    // Breakpoint scaffold uses to extend the rail (labels next to icons)
    this.twoColumnBreakpoint = Breakpoints.mediumLargeAndUp,
  });

  final List<GridSlot> slots;
  final Breakpoint twoColumnBreakpoint;

  @override
  Widget build(context) {
    final twoColumns = twoColumnBreakpoint.isActive(context);
    final numColumns = twoColumns ? 2 : 1;
    final spacing = twoColumnBreakpoint.spacing;
    final sorted = [...slots]
      ..sort((a, b) {
        final r = a.row.compareTo(b.row);
        return r != 0 ? r : a.col.compareTo(b.col);
      });
    if (numColumns == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sorted.map((s) => s.child).toList(),
      );
    } else {
      final columns = sorted.fold(
        List<List<Widget>>.generate(numColumns, (_) => []),
        (columnAccumulator, slot) {
          columnAccumulator[(slot.col - 1).clamp(0, numColumns - 1)].add(slot.child);
          return columnAccumulator;
        },
      );
      final rowChildren = columns
          .expandIndexed(
            (i, column) => [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: column,
                ),
              ),
              if (i < numColumns - 1) SizedBox(width: spacing),
            ],
          )
          .toList();
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowChildren,
      );
    }
  }

  //
}
