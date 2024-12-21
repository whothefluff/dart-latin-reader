import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/app_config.dart';
import 'package:latin_reader/logger.dart';

import 'src/ui/app.dart';
import 'src/ui/settings/settings_controller.dart';
import 'src/ui/settings/settings_service.dart';

void main() async {
//
  configureLogging();
  log.info(() => 'main() - loading settings');
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.load();
  log.info(() => 'main() - calling first widget');
  runApp(
    ProviderScope(
      child: MyApp(settingsController: settingsController),
    ),
  );
//
}

//implement dictionary page
//  update loading and error handling in providers 
//  design
//    entry page that mimicks reader navigation (swipe on small screens, tap on bigger screens)
//  look into parameterizing log bool
//  feature prefixes for all views
//  update dependencies
// "Bundling sqlite with your app" necessary?
// convert classes to const classes where possible
//  eliminate private shit before merging branch

//standardize GoRoute names
//the pseudo-schema should be named the same as the drift file
//PRAGMA foreign_keys = ON; necessary?
//usar Value.absentIfNull( ) en vez de null checks al informar tablas

//check errorBuilder for GoRouter and error for Riverpod (both needed?)

// TODO(whothefluff): optimizations
//delete superfluous repository methods
//create db indexes

// TODO(whothefluff): do I need to create Intent(s) for my buttons?

//secondary
// TODO(whothefluff): add go router type-safe navigation https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html
// TODO(whothefluff): make state restorable (example RestorableStatefulShellRouteExampleApp)

//maybe someday
//add wfs (and builds) for iOS and web
//use https://pub.dev/packages/flutter_platform_widgets to make the app design platform-dependent

// * adapt
//
// Permanent Search Bar:
//    Keep the search bar at the top, similar to the homepage, but make it "sticky" so it remains visible when scrolling. 
// Sidebar Navigation:
//    Implement an expandable sidebar with an alphabetical index (A-Z). Sync it to the currently open word
// Tabs for Word Information:
// Within each expanded word entry, use "cards" to organize different aspects
//    Inflection
//    Senses
//    Quotes
// Filters and Advanced Search: 
//    For parts of speech and for entry patterns, maybe for definition content too 
// Integration with Reader: 
//    Allow users to tap on words in texts to quickly look them up in the dictionary.
// Multi-pane Layout:
//    On larger screens, use a split-view with the word list on one side and details on the other.
// Gesture Navigation:
//    Implement swipe gestures to navigate between words or sections. 
// Customization:
//    Let users customize the dictionary view (e.g., card size, font size, dark mode).
