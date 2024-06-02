import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:latin_reader/src/page/dictionaries_page.dart';
import 'package:latin_reader/src/page/library_page.dart';
import 'package:latin_reader/src/page/word_frequency_page.dart';

import 'page/word_lookup_page.dart';
import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  _MyAppState createState() => _MyAppState();
//
}

class _MyAppState extends State<MyApp> {
//
  static const int library = 0;
  var _selectedIndex = library;
  static const List<Widget> _widgetOptions = <Widget>[
    LibraryPage(),
    DictionariesPage(),
    WordFrequencyPage(),
    WordLookupPage(),
  ];

  void updatePageIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,
          // Define a function to handle named routes in order to support Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: widget.settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          },
          home: Scaffold(
            appBar: AppBar(
              title: const Text('placeholder'),
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: updatePageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  icon: Icon(Icons.library_books),
                  label: 'Library',
                ),
                NavigationDestination(
                  icon: Icon(Icons.book),
                  label: 'Dictionaries',
                ),
                NavigationDestination(
                  icon: Icon(Icons.format_list_numbered),
                  label: 'Word Frequency',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Word Lookup',
                ),
              ],
              selectedIndex: _selectedIndex,
            ),
          ),
        );
      },
    );
  }
}
