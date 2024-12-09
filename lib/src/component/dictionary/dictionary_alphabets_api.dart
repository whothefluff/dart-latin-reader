import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/logger.dart';
import 'package:latin_reader/src/external/database.dart';
import 'package:latin_reader/src/external/provider_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_alphabets_api.g.dart';

//infrastructure

@riverpod
Future<DictionaryAlphabetLetterPosition> dictionaryAlphabetLetterPosition(
  Ref ref,
  String dictionary,
  String letter,
) async {
  log.info(() => '@riverpod - dictionaryAlphabetLetterPosition');
  final db = await ref.watch(dbProvider.future);
  ref.cacheFor(const Duration(minutes: 120));
  return db.dictionaryDrift
      .getDictionaryAlphabetLetterPosition(dictionary, letter)
      .getSingle()
      .then(DictionaryAlphabetLetterPosition.new);
//
}

//domain

extension type const DictionaryAlphabetLetterPosition(int index) {
  double calculateHeight( double height) => index * height;
}
