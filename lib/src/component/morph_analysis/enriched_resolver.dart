// Exception for APIs
// ignore_for_file: one_member_abstracts

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../logger.dart';
import '../dictionary/lewis_and_short_basic_info_api.dart';

//infrastructure

class RiverpodDictionaryRepository implements IDictionaryRepository {
  RiverpodDictionaryRepository(
    this._ref,
  );

  final Ref _ref;

  @override
  Future<LnsBasicInfo> getLnsInfoFor(Iterable<String> lemmas) =>
      _ref.read(lnsBasicInfoProvider(lemmas).future);
}

//domain

/// A domain service that encapsulates the business logic for resolving and enriching
/// morphological data by finding corresponding entries in a dictionary
class DictionaryRefResolver {
  DictionaryRefResolver(
    this.repo,
  );

  final IDictionaryRepository repo;
  static const Map<String, String> _assimilations = {
    'd-p': 'pp',
    'd-t': 'tt',
    'd-s': 'ss',
    'n-c': 'nc',
    'n-r': 'rr',
    'x-f': 'ff',
    'x-s': 's',
    'x-l': 'l',
  };

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
  /// Since this doesn't happen reliably, we have to perform corrections
  /// and call sequentially as fallbacks instead of one big call
  ///
  /// It will return a subset of [items] with matches in the dictionary
  Future<Iterable<U>> resolveAndEnrich<T, U>({
    required Iterable<T> items,
    required String Function(T item) getDictRef,
    required U Function(T item, LnsBasicInfoEntry lnsInfo) createEnriched,
  }) async {
    log.entry(args: items);
    // Get all unique dictionary references from the source items.
    final pureLemmas = items.map(getDictRef).toSet();
    log.fine(() => 'original lemmas: $pureLemmas');
    // First, look for exact lemmas but with '-' replacements
    final assimilated = _assimilated(pureLemmas);
    log.fine(() => 'assimilated lemmas: $assimilated');
    final assimilatedMatches = Map.fromEntries(
      (await repo.getLnsInfoFor(assimilated.lemmas)).map(
        (e) => MapEntry(
          // dictionaryRef of morph data and lemma of dict data match here
          e.lemma,
          e,
        ),
      ),
    );
    // For the lemmas with no matches, look for lemma AND '1'
    final matchedALemmas = assimilatedMatches.keys.toSet();
    // dart format off
    log.fine(() => 'assimilated lemmas found: ${assimilatedMatches.values.map((e) => e.lemma).toSet()}');
    // dart format on
    final unmatchedALemmas = assimilated.lemmas.difference(matchedALemmas);
    final suffixedLemmas = unmatchedALemmas
        .where((e) => !e.endsWith('1'))
        .map((e) => '${e}1')
        .toSet();
    log.fine(() => 'suffixed lemmas: $suffixedLemmas');
    final suffixedMatches = Map.fromEntries(
      (await repo.getLnsInfoFor(suffixedLemmas)).map(
        (e) => MapEntry(
          // Original morphDictRef
          e.lemma.replaceFirst(RegExp(r'1$'), ''),
          e,
        ),
      ),
    );
    // For lemmas still with no matches, look for lema WITHOUT trailing '1'
    final matchedSLemmas = suffixedMatches.keys.toSet();
    log.fine(() => 'suffixed lemmas found: ${suffixedMatches.values.map((e) => e.lemma).toSet()}');
    final unmatchedSLemmas = unmatchedALemmas.difference(matchedSLemmas);
    final normalizedLemmas = unmatchedSLemmas
        .where((e) => e.endsWith('1'))
        .map((e) => e.replaceFirst(RegExp(r'1$'), ''))
        .toSet();
    log.fine(() => 'normalized lemmas: $normalizedLemmas');
    final normalizedMatches = Map.fromEntries(
      (await repo.getLnsInfoFor(normalizedLemmas)).map(
        (e) => MapEntry(
          // Original morphDictRef
          '${e.lemma}1',
          e,
        ),
      ),
    );
    // dart format off
    log.fine(() => 'normalized lemmas found: ${normalizedMatches.values.map((e) => e.lemma).toSet()}');
    // dart format on
    // Put all found results together
    final allMatches = {
      ...assimilatedMatches,
      ...suffixedMatches,
      ...normalizedMatches,
    };
    // Substitute any potentially assimilated forms back to their original form
    final lnsInfoByMorphDictRef = allMatches.map(
      (key, value) => MapEntry(assimilated.toOriginal[key] ?? key, value),
    );
    return log.exit<Iterable<U>>(
      r: items
          // Filter out entries without matches
          .where((i) => lnsInfoByMorphDictRef.containsKey(getDictRef(i)))
          // Create entries with additional dict data
          .map((e) => createEnriched(e, lnsInfoByMorphDictRef[getDictRef(e)]!)),
    )!;
  }

  ({Set<String> lemmas, Map<String, String> toOriginal}) _assimilated(Set<String> originalLemmas) =>
      originalLemmas.fold(
        (lemmas: <String>{}, toOriginal: <String, String>{}),
        (acc, original) {
          final assimilated = _assimilate(original);
          // Only some forms will actually be assimilated
          acc.lemmas.add(assimilated);
          if (assimilated != original) {
            // Offer a way back to the original lemma
            acc.toOriginal[assimilated] = original;
          }
          return acc;
        },
      );

  String _assimilate(String lemma) => _assimilations.entries
      .fold(
        lemma,
        (current, a) => current.replaceAll(a.key, a.value),
      )
      .replaceAll('-', '')
      .replaceAll('_', '');
  //
}

abstract interface class IDictionaryRepository {
  //
  Future<LnsBasicInfo> getLnsInfoFor(Iterable<String> lemmas);
  //
}
