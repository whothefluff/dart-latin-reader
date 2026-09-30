import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/library/catalog_api.dart';
import 'package:latin_reader/src/external/database.dart';

import 'library_fixture.dart';

Future<LibraryCatalog> _catalog(AppDb db) {
  final container = ProviderContainer(overrides: [dbProvider.overrideWith((_) => db)]);
  addTearDown(container.dispose);
  return container.listen(libraryCatalogProvider.future, (_, _) {}).read();
}

void main() {
  group('libraryCatalogProvider', () {
    test('authors and works carry their abbreviations', () async {
      final catalog = await _catalog(await smallLibrary());
      final author = catalog.authors.singleWhere((author) => author.id == phaedrus);
      final works = [...author.works, ...catalog.anonymousWorks];

      expect(author.abbreviations, unorderedEquals(['Phaedr.', 'Phaed.']));
      expect(works.singleWhere((work) => work.id == duties).abbreviations, ['Off.']);
      expect(works.singleWhere((work) => work.id == fables).abbreviations, isEmpty);
      expect(works.singleWhere((work) => work.id == anonymous).abbreviations, isEmpty);
    });
  });
}
