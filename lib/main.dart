import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  log.info(() => 'main() - calling first widget');
  runApp(
    ProviderScope(
      child: MyApp(settingsController: settingsController),
    ),
  );
//
}

//implement dictionary page
//  update py to add empty file AND hardcoded date
//  design dictionary page with focus on navigability (permanent search bar? index on side bar? more ideas?)
//  look into parameterizing log bool
//  update dependencies
// "Bundling sqlite with your app" necessary?

//check errorBuilder for GoRouter and error for Riverpod (both needed?)

//TODO: optimizations
//delete superfluous repository methods
//create db indexes

//TODO: do I need to create Intent(s) for my buttons?

//secondary
//TODO: add go router type-safe navigation https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html
//TODO: make state restorable (example RestorableStatefulShellRouteExampleApp)

//maybe someday
//add wfs (and builds) for iOS and web