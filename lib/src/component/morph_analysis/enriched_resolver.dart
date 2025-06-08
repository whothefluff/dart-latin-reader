// Create a new file: dictionary_ref_resolver.dart

import 'package:latin_reader/src/component/dictionary/lewis_and_short_basic_info_api.dart';

class DictionaryRefResolver {
  DictionaryRefResolver(
    this.repo,
  );

  final IDictionaryRepository repo;

  /// Resolves morphological dictionary references to actual dictionary entries
  /// 
  /// Many forms are correct but use a different way of writing the word
  /// ('adtingere' has lexical 'ad-tingo', but the L&S only contemplates 
  /// 'attingo')
  ///
  /// A few dozen entries will not be found as is, but only adding '1'
  /// E.g. 'principum' has dictionaryRef 'princeps',
  /// but the dictionary has lemma 'princeps1'
  ///
  /// A small handful of entries entries still not be found, so we delete '1'
  /// E.g. 'equus' has has dictionaryRef 'equus1',
  /// but the dictionary only has lemma 'equus'
  ///
  /// Some forms are unfixable ('adulteram' has lexical 'adultera', when it should
  /// be 'adulter')
  /// 
  /// Some forms like 'moris' contain suspicious duplicates(?)
  /// 
  /// In general, it is likely a good idea to ignore morphological analyses 
  /// without matches in this method
  Future<Map<String, LnsBasicInfoEntry>> resolveDictionaryRefs(
    Iterable<String> morphDictRefs,
  ) async {
    final pureLemmas = morphDictRefs.toSet();
    // First, look for exact lemmas but with '-' replacements (d-p = pp, etc.) TODO
    // First try to find exact matches
    final pureMatches = Map.fromEntries(
      (await repo.getLnsInfoFor(pureLemmas)).map(
        (e) => MapEntry(
          // dictionaryRef of morph data and lemma of dict data match here
          e.lemma,
          e,
        ),
      ),
    );
    // For the lemmas with no matches, look for lemma AND '1'
    final matchedPLemmas = pureMatches.keys.toSet();
    final unmatchedPLemmas = pureLemmas.difference(matchedPLemmas);
    final suffixedLemmas = unmatchedPLemmas
        .where((e) => !e.endsWith('1'))
        .map((e) => '${e}1')
        .toSet();
    final suffixedMatches = Map.fromEntries(
      (await repo.getLnsInfoFor(suffixedLemmas)).map(
        (e) => MapEntry(
          // Original morphDictRef
          e.lemma.replaceFirst(r'1$', ''),
          e,
        ),
      ),
    );
    // For lemmas still with no matches, look for lema WITHOUT trailing '1'
    final matchedSLemmas = suffixedMatches.keys.toSet();
    final unmatchedSLemmas = unmatchedPLemmas.difference(matchedSLemmas);
    final normalizedLemmas = unmatchedSLemmas
        .where((e) => e.endsWith('1'))
        .map((e) => e.replaceFirst(RegExp(r'1$'), ''))
        .toSet();
    final normalizedMatches = Map.fromEntries(
      (await repo.getLnsInfoFor(normalizedLemmas)).map(
        (e) => MapEntry(
          // Original morphDictRef
          '${e.lemma}1',
          e,
        ),
      ),
    );
    // Put all found results together
    return {...pureMatches, ...suffixedMatches, ...normalizedMatches};
  }
//
}

abstract interface class IDictionaryRepository {
//
  Future<LnsBasicInfo> getLnsInfoFor(Iterable<String> lemmas);
//
}
