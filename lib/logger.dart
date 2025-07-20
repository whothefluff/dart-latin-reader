import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'app_config.dart';

final Logger log = Logger('');

void configureLogging() {
  var writeSuccessful = true;
  Logger.root.onRecord.listen((r) async {
    final trace = r.stackTrace ?? StackTrace.current;
    if (kDebugMode) {
      if (AppConfig.instance.logUsesPrint) {
        print(r.formattedMessage(trace));
      }
      if (AppConfig.instance.logUsesApi) {
        developer.log(
          '${r.message}\n ${Logger.root._caller(trace).location}',
          time: r.time,
          sequenceNumber: r.sequenceNumber,
          level: r.level.value,
          name: r.loggerName,
          error: r.error,
          stackTrace: r.stackTrace,
        );
      }
    }
    if (writeSuccessful) {
      try {
        final d = await getApplicationDocumentsDirectory();
        final file = File('${d.path}${Platform.pathSeparator}latin_reader.log');
        final optError = r.error != null ? '\n${r.error}' : '';
        final optStackTrace = r.stackTrace != null ? '\n${r.stackTrace}' : '';
        await file.writeAsString('${r.formattedMessage}$optError$optStackTrace\n');
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

/// An extension on the [Logger] class that adds methods similar to those
/// in `org.slf4j.ext.XLogger` for logging method entry/exit and exceptions
extension XLogger on Logger {
  /// For stack lines of form *#n      Class.method (package:relative_file_path:Ln:Col)*
  static final _callerRegex = RegExp(r'^#\d+\s+(.+?)\s(\(.+\))$');
  static const _entry = 'entry';
  static const _exit = 'exit';
  static const _throwing = 'throwing';
  static const _catching = 'catching';

  /// Logs a method entry, with optional arguments.
  ///
  /// The log level is [Level.FINE]. If logging is enabled for this level,
  /// it constructs a message "entry" or "entry with (arg1, arg2, ...)" if
  /// [args] are provided.
  void entry<T>({Iterable<T> args = const [], Level level = Level.FINE, StackTrace? stackTrace}) {
    this.log(
      level,
      () => args.isEmpty ? _entry : '$_entry with $args',
      null,
      stackTrace ?? StackTrace.current,
    );
  }

  /// Logs a method exit with a potential result
  ///
  /// The log level is [Level.FINE]. The [r] is returned, which allows
  /// for chaining this call.
  T? exit<T>({T? r, Level level = Level.FINE, StackTrace? stackTrace}) {
    this.log(
      level,
      () => r == null ? _exit : '$_exit with ($r)',
      null,
      stackTrace ?? StackTrace.current,
    );
    return r;
  }

  /// Logs that an exception is being thrown.
  ///
  /// The default log level is [Level.SEVERE], but can be customized via the
  /// [level] parameter. The [error] object is returned, allowing this to be
  /// used directly in a `throw` statement (e.g., `throw log.throwing(e);`).
  T throwing<T extends Object>(T error, {Level level = Level.SEVERE, StackTrace? stackTrace}) {
    this.log(
      level,
      _throwing,
      error,
      stackTrace ?? StackTrace.current,
    );
    return error;
  }

  /// Logs that an exception has been caught.
  ///
  /// The default log level is [Level.SEVERE], but can be customized via the
  /// [level] parameter. This is typically used in a `catch` block.
  void catching(Object error, {Level level = Level.SEVERE, StackTrace? stackTrace}) {
    this.log(
      level,
      _catching,
      error,
      stackTrace ?? StackTrace.current,
    );
  }

  /// Gets caller information from the stack
  ({String? classAndMethod, String? location}) _caller(StackTrace stack) {
    final stackLines = stack.toString().split('\n');
    final callerLine = stackLines
        .skip(1)
        .firstWhere(
          (e) => e.contains('package:latin_reader'),
          orElse: () => '',
        );
    final match = _callerRegex.firstMatch(callerLine);
    final unnamed = ('${match?.group(1)}()', match?.group(2));
    return (
      classAndMethod: unnamed.$1.replaceFirst('.<anonymous closure>', '').trim(),
      location: unnamed.$2?.trim(), // If printed in the console, provides navigation
    );
  }

  //
}

extension FormattedLogRecord on LogRecord {
  //
  static const _escape = '\x1B';
  static const reset = '$_escape[0m';
  static const bright = '$_escape[1m';
  static const dim = '$_escape[2m';
  static const cursive = '$_escape[3m';
  static const underscore = '$_escape[4m';
  static const blink = '$_escape[5m';
  static const reverse = '$_escape[7m';
  static const hidden = '$_escape[8m';

  static const red = '$_escape[31m';
  static const yellow = '$_escape[33m';
  static const white = '$_escape[37m';
  static const bgRed = '$_escape[41m';

  Map<Level, String> get _colors => {
    Level.FINEST: reset,
    Level.FINER: reset,
    Level.FINE: reset,
    Level.CONFIG: reset,
    Level.INFO: white,
    Level.WARNING: yellow,
    Level.SEVERE: red,
    Level.SHOUT: '$white$bgRed',
  };

  /// Returns the message formatted according to the provided trace
  String formattedMessage(StackTrace trace) {
    final logIdentifier = '${loggerName.isNotEmpty ? '($loggerName)' : ''}${level.name}';
    final caller = Logger.root._caller(trace);
    return (StringBuffer()..writeAll([
          '\n$dim${caller.location}',
          '\n${_colors[level]}$logIdentifier$reset $time',
          '\n${caller.classAndMethod}',
          '\n$bright$message',
        ]))
        .toString();
  }

  //
}
