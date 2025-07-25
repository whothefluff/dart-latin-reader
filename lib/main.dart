import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_config.dart';
import 'logger.dart';
import 'src/ui/app.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.load();
  configureLogging();
  log.info(() => 'calling runApp');
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
  //
}
