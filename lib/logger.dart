// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('MyApp');

void configureLogging() {
  if (kDebugMode) {
    Logger.root.onRecord.listen(
      (record) {
        print(
            '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
        if (record.error != null) {
          print('Error: ${record.error}');
        }
        if (record.stackTrace != null) {
          print('StackTrace: ${record.stackTrace}');
        }
      },
    );
  } else {
    Logger.root.level = Level.OFF;
  }
}
