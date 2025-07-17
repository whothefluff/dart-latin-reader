import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'app_config.dart';

final Logger log = Logger('');

void configureLogging() {
  var writeSuccessful = true;
  Logger.root.onRecord.listen((r) async {
    final identifier = '${r.time} | ${r.level.name}';
    final content = '${r.loggerName}: ${r.message}';
    final message = '$identifier$content';
    if (kDebugMode) {
      print(message);
      if (r.error != null) {
        print('Error: ${r.error}');
      }
      if (r.stackTrace != null) {
        print('StackTrace: ${r.stackTrace}');
      }
    }
    if (writeSuccessful) {
      try {
        final d = await getApplicationDocumentsDirectory();
        final file = File('${d.path}${Platform.pathSeparator}latin_reader.log');
        final optError = r.error != null ? '\n${r.error}' : '';
        final optStackTrace = r.stackTrace != null ? '\n${r.stackTrace}' : '';
        await file.writeAsString('$message$optError$optStackTrace\n');
      } on Exception catch (e) {
        if (kDebugMode) {
          print('Failed to write file log: $e');
        }
        writeSuccessful = false;
      }
    }
  });
  Logger.root.level = kDebugMode
      ? AppConfig.instance.consoleLogLevel
      : AppConfig.instance.fileLogLevel;
}
