import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../component/morph_analysis/enriched_morph_details_api.dart';
import '../../../component/morph_analysis/morphological_details_api.dart';
import '../../widget/page_scaffold.dart';
import 'common.dart';

class MorphologicalDataPage extends ConsumerWidget {
  const MorphologicalDataPage(
    this.keys, {
    super.key,
  });

  final AnalysisKeys keys;

  @override
  Widget build(context, ref) => SafeBodyScaffold(
    appBar: AppBar(title: _title(ref)),
    body: MorphologicalDataView(keys: keys),
  );

  /// A key can read "magnoque" when the word is "magnō", so the title comes
  /// from the analyses (no analyses, no title)
  Text? _title(WidgetRef ref) => ref
      .watch(enrichedMorphologicalAnalysesProvider(keys))
      .whenOrNull(data: (analyses) => Text(_titleOf(analyses.map((a) => a.macronizedForm))));

  /// Covers navigating from something like "Venere" at sentence start,
  /// which would show both "Venere" (Venus) and "venere" (venio).
  static String _titleOf(Iterable<String> forms) {
    final distinct = {...forms};
    return distinct.length <= 3 ? distinct.join(', ') : '${distinct.length} forms';
  }

  //
}
