import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';
import 'dictionaries_api.dart';

part 'lewis_and_short_api.g.dart';

//infrastructure

/// The Lewis & Short dictionary row.
///
/// Any client that needs the L&S uses this provider
@riverpod
Future<Dictionary> lewisAndShortDictionary(Ref ref) async {
  log.info(() => '@riverpod');
  ref.cacheFor(const Duration(minutes: 120));
  final db = await ref.watch(dbProvider.future);
  log.fine('reading the Lewis & Short dictionary from db');
  return db.dictionaryDrift.getLewisAndShortDictionary().getSingle();
}
