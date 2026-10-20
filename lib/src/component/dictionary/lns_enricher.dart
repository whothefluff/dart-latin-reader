// lns_enrichment.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dictionary/lewis_and_short_basic_info_api.dart';

/// Zips [items] against L&S info that's already resolved
/// Items whose dictionaryRef has no match get `null`
Iterable<U> _zipWithLns<T, U>({
  required Iterable<T> items,
  required String Function(T item) getLemma,
  required U Function(T item, LnsBasicInfoEntry? lns) createEnriched,
  required LnsBasicInfoByRef resolved,
}) => items.map((i) => createEnriched(i, resolved[getLemma(i)]));

/// Enriches [items] with their L&S basic info, which is `null` for items whose
/// dictionaryRef has no match (i.e. not resolvable at data population time).
Future<Iterable<U>> enrichWithLns<T, U>({
  required Ref ref,
  required Iterable<T> items,
  required String Function(T item) getDictRef,
  required U Function(T item, LnsBasicInfoEntry? lns) createEnriched,
}) async {
  final dictRefs = items.map(getDictRef).toSet();
  final resolved = await ref.watch(lnsBasicInfoProvider(PossibleLemmas(dictRefs)).future);
  return _zipWithLns(
    items: items,
    getLemma: getDictRef,
    createEnriched: createEnriched,
    resolved: resolved,
  );
}
