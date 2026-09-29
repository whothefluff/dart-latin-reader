import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/word_frequency/resolved_freq_morph_form_api.dart'
    show WorkIds;
import 'package:latin_reader/src/component/word_frequency/text_coverage_api.dart'
    show CoverageBasis;
import 'package:latin_reader/src/component/word_frequency/word_frequency_api.dart';

void main() {
  group('FrequencyFilter coverage bases', () {
    const cases = [
      (groupByLemma: false, showMacrons: false, basis: CoverageBasis.form, certain: null),
      (groupByLemma: false, showMacrons: true, basis: CoverageBasis.macronForm, certain: null),
      (
        groupByLemma: true,
        showMacrons: false,
        basis: CoverageBasis.anyCandidateLemma,
        certain: CoverageBasis.allCandidateLemmas,
      ),
      (
        groupByLemma: true,
        showMacrons: true,
        basis: CoverageBasis.anyCandidateLemma,
        certain: CoverageBasis.allCandidateLemmas,
      ),
    ];

    for (final (:groupByLemma, :showMacrons, :basis, :certain) in cases) {
      test('by lemma: $groupByLemma, macrons: $showMacrons -> ${basis.name}, '
          'certain: ${certain?.name}', () {
        final filter = FrequencyFilter(
          workIds: WorkIds(const []),
          pageSize: 50,
          groupByLemma: groupByLemma,
          showMacrons: showMacrons,
        );

        expect(filter.coverageBasis, basis);
        expect(filter.certainCoverageBasis, certain);
      });
    }
  });
}
