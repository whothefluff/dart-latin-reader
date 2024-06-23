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
  final db = AppDb();
  // await db.into(db.authors).insert(
  //       AuthorsCompanion.insert(
  //         id: '1',
  //         name: 'Cicero',
  //       ),
  //     );
  runApp(
    ProviderScope(
      child: MyApp(settingsController: settingsController),
    ),
  );
//
}

//TODO: load asset .csv files into existing .sqlite with empty tables
//TODO: load info from db
//TODO: how to ship the db with the app and/or overwrite it

//TODO: do I need to create Intent(s) for my buttons?

//secondary
//TODO: add go router type-safe navigation https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html
//TODO: make state restorable (example RestorableStatefulShellRouteExampleApp)
//TODO: add adaptive scaffold