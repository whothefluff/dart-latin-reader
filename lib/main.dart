import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_config.dart';
import 'logger.dart';
import 'src/core/licenses.dart';
import 'src/external/provider_failure_logger.dart';
import 'src/ui/app.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.load();
  registerLicenses();
  configureLogging();
  log.info(() => 'calling runApp');
  runApp(
    const ProviderScope(
      observers: [ProviderFailureLogger()],
      child: App(),
    ),
  );
  //
}
