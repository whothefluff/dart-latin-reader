import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latin_reader/src/component/concordance/concordance_query.dart';
import 'package:latin_reader/src/component/library/catalog_api.dart';
import 'package:latin_reader/src/component/settings/concordance_settings_api.dart';
import 'package:latin_reader/src/ui/page/concordance/query_editor.dart';

const _oneWord = 'One word only. For a phrase, add a word after it';

/// Saved settings, without the platform storage behind them
class _SavedSettings extends ConcordanceSettingsNotifier {
  @override
  Future<ConcordanceSettings> build() async => const ConcordanceSettings(pageSize: 25);
  //
}

void main() {
  testWidgets('a form field takes one word, and says so until it has one', (tester) async {
    ConcordanceQuery? searched;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryCatalogProvider.overrideWith(
            (_) async => LibraryCatalog(
              authors: UnmodifiableListView([]),
              anonymousWorks: UnmodifiableListView([]),
            ),
          ),
          concordanceSettingsNotifierProvider.overrideWith(_SavedSettings.new),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: QueryEditor(initial: null, onSearch: (query) => searched = query),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final field = find.widgetWithText(TextField, 'Word form');
    final search = find.ancestor(
      of: find.text('Search'),
      matching: find.bySubtype<ButtonStyleButton>(),
    );
    bool canSearch() => tester.widget<ButtonStyleButton>(search).enabled;

    await tester.enterText(field, 'puellam videt');
    await tester.pump();
    expect(find.text(_oneWord), findsOneWidget);
    expect(canSearch(), isFalse);

    await tester.enterText(field, 'puellam');
    await tester.pump();
    expect(find.text(_oneWord), findsNothing);
    expect(canSearch(), isTrue);
    await tester.ensureVisible(search);
    await tester.pumpAndSettle();
    await tester.tap(search);
    expect(searched?.slots, [const FormCriterion('puellam')]);
  });
}
