import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/core/search_term.dart';

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
}
