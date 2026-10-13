import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/core/search_term.dart';
import 'package:latin_reader/src/core/semivowel_search.dart';

const _neither = SemivowelSearchRules(iFindsJ: false, uFindsV: false);
const _iOnly = SemivowelSearchRules(iFindsJ: true, uFindsV: false);
const _both = SemivowelSearchRules(iFindsJ: true, uFindsV: true);

void main() {
  group('SearchTerm', () {
    test('three characters or more are found anywhere, through the full-text index', () {
      final term = SearchTerm(' amo ');

      expect(term.useLike, isFalse);
      expect(term.query, '"amo"');
    });

    test('spaces and punctuation are found anywhere, through the full-text index', () {
      expect(SearchTerm('magna gr').useLike, isFalse);
      expect(SearchTerm('magna gr').query, '"magna gr"');
      expect(SearchTerm('ha!').useLike, isFalse);
      expect(SearchTerm('ha!').query, '"ha!"');
    });

    test('FTS5 operators are searched as plain text', () {
      expect(SearchTerm('NOT').query, '"NOT"');
      expect(SearchTerm('a"b"c').query, '"a""b""c"');
    });

    test('fewer than three characters must match exactly', () {
      final term = SearchTerm('et');

      expect(term.useLike, isTrue);
      expect(term.query, 'et');
    });

    test('quotes ask for an exact match and are dropped', () {
      expect(SearchTerm('"sum"'), SearchTerm("'sum'"));
      expect(SearchTerm('"sum"').useLike, isTrue);
      expect(SearchTerm('"sum"').query, 'sum');
    });

    test('a quote on one side only is part of the text', () {
      expect(SearchTerm('"sum').query, '"""sum"');
    });

    test('* and ? become the LIKE wildcards', () {
      final term = SearchTerm('a*d?');

      expect(term.useLike, isTrue);
      expect(term.query, 'a%d_');
    });

    test('% and _ are wildcards too, however long the text', () {
      expect(SearchTerm('vid_s').useLike, isTrue);
      expect(SearchTerm('adv%').useLike, isTrue);
    });

    test('empty text, or empty quotes, searches nothing', () {
      expect(SearchTerm('  ').isEmpty, isTrue);
      expect(SearchTerm('""').isEmpty, isTrue);
    });

    test('any macron, ȳ included, sets hasMacrons', () {
      expect(SearchTerm('rosā').hasMacrons, isTrue);
      expect(SearchTerm('Lȳdia').hasMacrons, isTrue);
      expect(SearchTerm('rosa').hasMacrons, isFalse);
    });

    test('withoutMacrons removes the macrons', () {
      final term = SearchTerm('"Ātrīȳ"').withoutMacrons;

      expect(term.query, 'Atriy');
      expect(term.hasMacrons, isFalse);
      expect(term.useLike, isTrue);
    });
  });

  group('SearchTerm.inVowelLetters', () {
    test('j is written as i and v as u, in any case, the rest as it was', () {
      expect(SearchTerm('Jūv*').inVowelLetters, SearchTerm('Iūu*'));
    });
  });

  group('SearchTerm.patternWith', () {
    test('a typed i or u also matches the j or v that the settings allow', () {
      final semivowelPattern = SearchTerm('seruus').semivowelPatternWith(_both);

      expect(semivowelPattern.hasMatch('servus'), isTrue);
      expect(semivowelPattern.hasMatch('Servus'), isTrue);
      expect(SearchTerm('seruus').semivowelPatternWith(_neither).hasMatch('servus'), isFalse);
      expect(SearchTerm('iuu').semivowelPatternWith(_iOnly).hasMatch('juv'), isFalse);
    });

    test('a typed j or v only matches itself', () {
      expect(SearchTerm('jam').semivowelPatternWith(_both).hasMatch('iam'), isFalse);
      expect(SearchTerm('vir').semivowelPatternWith(_both).hasMatch('uir'), isFalse);
    });

    test('wildcards and quotes ask for the whole value, other text for a part of it', () {
      expect(SearchTerm('"iam"').semivowelPatternWith(_both).hasMatch('jamque'), isFalse);
      expect(SearchTerm('iu*').semivowelPatternWith(_both).hasMatch('jubet'), isTrue);
      expect(SearchTerm('?uuen').semivowelPatternWith(_both).hasMatch('juvenis'), isFalse);
      expect(SearchTerm('iuuen').semivowelPatternWith(_both).hasMatch('Juvenis'), isTrue);
    });

    test('other characters match literally', () {
      expect(SearchTerm('a.b').semivowelPatternWith(_both).hasMatch('axb'), isFalse);
    });
  });
}
