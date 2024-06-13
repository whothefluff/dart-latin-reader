import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
//
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MyApp(settingsController: settingsController));
//
}

//TODO: ask about db and parse
//TODO: load authors and books from db
//TODO: do I need to create Intent(s) for my buttons?

//secondary
//TODO: add go router type-safe navigation https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html
//TODO: make state restorable (example RestorableStatefulShellRouteExampleApp)
//TODO: add adaptive scaffold