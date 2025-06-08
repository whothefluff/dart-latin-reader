import 'package:flutter/material.dart';
import 'package:latin_reader/src/component/morph_analysis/morphological_details_api.dart';
import 'package:latin_reader/src/ui/page/morphology/common.dart';

///While in theory any number of keys would work, the assumption is that all
///share the same form. This is relevant for example when showing the title of
///the page
class MorphologicalDataPage extends StatelessWidget {
  const MorphologicalDataPage(
    this.keys, {
    super.key,
  });

  final AnalysisKeys keys;

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(title: Text(keys.first.form)),
        body: MorphologicalDataView(keys: keys),
      );
//
}
