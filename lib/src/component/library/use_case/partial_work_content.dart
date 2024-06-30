import 'package:latin_reader/src/component/library/use_case/entity/work.dart';

abstract interface class PartialWorkContent {
  PartialWorkContent({
    required this.work,
    required this.fromIndex,
    required this.size,
  });

  final Work work;
  final BigInt fromIndex;
  final int size;
//
}
