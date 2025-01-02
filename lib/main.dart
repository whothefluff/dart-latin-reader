import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latin_reader/app_config.dart';
import 'package:latin_reader/logger.dart';

import 'src/ui/app.dart';

void main() async {
//
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.load();
  configureLogging();
  log.info(() => 'main() - calling runApp');
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
//
}
