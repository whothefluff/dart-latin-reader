import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/src/external/database.dart';

import 'src/ui/app.dart';
import 'src/ui/settings/settings_controller.dart';
import 'src/ui/settings/settings_service.dart';

void main() async {
//
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  await AppDb.initialize();
  runApp(
    ProviderScope(
      child: MyApp(settingsController: settingsController),
    ),
  );
//
}

//check calls (look for redundancy)
//load works from author in author page
//load work about in .csv

//TODO: optimizations
//when loading authors, works are being loaded at the same time only to show a count
//create db indexes

//TODO: do I need to create Intent(s) for my buttons?

//secondary
//TODO: add go router type-safe navigation https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html
//TODO: make state restorable (example RestorableStatefulShellRouteExampleApp)
//TODO: add adaptive scaffold