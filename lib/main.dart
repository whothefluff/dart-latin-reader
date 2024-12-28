import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/app_config.dart';
import 'package:latin_reader/logger.dart';

import 'src/ui/app.dart';
import 'src/ui/settings/settings_controller.dart';
import 'src/ui/settings/settings_service.dart';

void main() async {
//
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.load();
  configureLogging();
  log.info(() => 'main() - loading settings');
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  log.info(() => 'main() - calling first widget');
  runApp(
    ProviderScope(
      child: MyApp(settingsController: settingsController),
    ),
  );
//
}
