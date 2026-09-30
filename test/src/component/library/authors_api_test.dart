import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/authors_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

Future<Authors> _authors(AppDb db) {
  final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
  addTearDown(container.dispose);
  return container.listen(authorsProvider.future, (_, _) {}).read();
}

void main() {
  group('authorsProvider', () {
    test('each author carries its abbreviations', () async {
      final authors = await _authors(await smallLibrary());

      expect(
        authors.singleWhere((author) => author.id == phaedrus).abbreviations,
        unorderedEquals(['Phaedr.', 'Phaed.']),
      );
      expect(authors.singleWhere((author) => author.id == cicero).abbreviations, ['Cic.']);
    });
  });
}
