import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/ui/widget/lemma_text.dart';

void main() {
  group('lemmaLabel', () {
    test('two sublemmas spelled alike are labeled apart, each with its entry', () {
      final city = lemmaLabel('Dardanus1', 'Dardania');
      final country = lemmaLabel('Dardani', 'Dardania');

      expect(city, isNot(country));
      expect(city, contains('Dardania'));
      expect(country, contains('Dardania'));
      expect(city.replaceFirst('Dardania', ''), contains(entryRefText('Dardanus1')));
      expect(country.replaceFirst('Dardania', ''), contains(entryRefText('Dardani')));
    });

    test("an entry's own lemma is labeled by its entry alone", () {
      expect(lemmaLabel('sum1', ''), entryRefText('sum1'));
    });
  });
}
