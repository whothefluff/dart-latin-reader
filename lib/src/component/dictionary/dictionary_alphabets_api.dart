import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../logger.dart';
import '../../external/database.dart';
import '../../external/provider_ext.dart';

part 'dictionary_alphabets_api.g.dart';

//infrastructure

@riverpod
Future<DictionaryAlphabetLetterPosition> dictionaryAlphabetLetterPosition(
  Ref ref,
  String dictionary,
  String letter,
) async {
  log.info(() => '@riverpod - dictionaryAlphabetLetterPosition');
  ref.cacheFor(const Duration(minutes: 120));
  final db = await ref.watch(dbProvider.future);
  final dbData = await db.dictionaryDrift
      .getDictionaryAlphabetLetterPosition(dictionary, letter)
      .getSingle();
  return DictionaryAlphabetLetterPosition(dbData);
  //
}

//domain

extension type const DictionaryAlphabetLetterPosition(int index) {
  double calculateHeight(double height) => index * height;
}
