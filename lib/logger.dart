import 'dart:async';
import 'dart:collection';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'app_config.dart';

final Logger log = Logger('');

typedef CallerInfo = ({String classAndMethod, String location});

IOSink? _fileSink;

/// True if file logging has been permanently disabled due to an init or write failure.
bool _fileLoggingDisabled = false;

/// Shutdown flag
bool _isClosing = false;

/// Bounded queue limit to prevent OOM
const int _maxQueueSize = 500;

final _fileWriteQueue = Queue<({LogRecord record, CallerInfo caller})>();

final _wakeChannel = StreamController<void>();

Future<void>? _loopFuture;

/// Tracks logs dropped due to backpressure to prevent silent data loss
int _droppedLogsCount = 0;

Future<void> _initFileLogging() async {
  try {
    final d = await getApplicationSupportDirectory();
    final basePath = '${d.path}${Platform.pathSeparator}app';
    final currentFile = File('$basePath.log');
    final previousFile = File('$basePath.1.log');
    final oldestFile = File('$basePath.2.log');
    // ignore: avoid_slow_async_io because this is a one-time startup operation
    if (await oldestFile.exists()) {
      await oldestFile.delete();
    }
    // ignore: avoid_slow_async_io because this is a one-time startup operation
    if (await previousFile.exists()) {
      await previousFile.rename(oldestFile.path);
    }
    // ignore: avoid_slow_async_io because this is a one-time startup operation
    if (await currentFile.exists()) {
      await currentFile.rename(previousFile.path);
    }
    // Open a fresh file for the current session with FileMode.append just in case
    _fileSink = currentFile.openWrite(mode: FileMode.append);
    unawaited(
      _fileSink?.done.catchError((Object e) {
        if (kDebugMode) {
          print('Async Disk write error: $e');
        }
        _fileLoggingDisabled = true;
        _fileWriteQueue.clear();
      }),
    );
  } on Exception catch (e) {
    if (kDebugMode) {
      print('Failed to open or rotate file logs: $e');
    }
    _fileLoggingDisabled = true;
  }
}

/// Single-writer loop. Guarantees chronological FIFO ordering
/// and prevents interleaving by ensuring only one write operation happens at a time.
Future<void> _runWriteLoop() async {
  await _initFileLogging();
  if (_fileLoggingDisabled) {
    if (kDebugMode) {
      print('File logging disabled, write loop exiting.');
    }
    _fileWriteQueue.clear();
  } else {
    await for (final _ in _wakeChannel.stream) {
      while (_fileWriteQueue.isNotEmpty) {
        // Alert if we had to drop logs to save memory
        if (_droppedLogsCount > 0) {
          final dropped = _droppedLogsCount;
          _droppedLogsCount = 0;
          _fileSink?.writeln(
            '\n--- WARNING: $dropped log records dropped due to backpressure ---\n',
          );
        }
        final item = _fileWriteQueue.removeFirst();
        try {
          _writeItem(item);
        } on Exception catch (e) {
          if (kDebugMode) {
            print('Error writing log to disk: $e');
          }
          // Stop trying to write if the disk is full/failing
          _fileWriteQueue.clear();
          _fileLoggingDisabled = true;
          // Clean up resources on disk failure
          await _fileSink?.close();
          _fileSink = null;
          return;
        }
      }
      if (_isClosing) {
        return;
      }
    }
  }
}

void _writeItem(({LogRecord record, CallerInfo caller}) item) {
  final optError = item.record.error != null ? '\n${item.record.error}' : '';
  final optTrace = item.record.stackTrace != null ? '\n${item.record.stackTrace}' : '';
  _fileSink?.writeln('${item.record.formattedMessage(item.caller)}$optError$optTrace');
}

void configureLogging() {
  // 1. Set the level
  Logger.root.level = kDebugMode
      ? AppConfig.instance.consoleLogLevel
      : AppConfig.instance.fileLogLevel;
  // 2. Initialize before attaching listeners
  _loopFuture = _runWriteLoop();
  // 3. Attach the listener
  Logger.root.onRecord.listen((r) {
    // Don't accept logs if shutting down
    if (!_isClosing) {
      final trace = r.stackTrace ?? StackTrace.current;
      final callerInfo = _logCaller(trace);
      if (kDebugMode) {
        if (AppConfig.instance.logUsesPrint) {
          print(r.formattedMessage(callerInfo, useColor: true));
        }
        if (AppConfig.instance.logUsesApi) {
          developer.log(
            '${r.message}\n ${callerInfo.location}',
            time: r.time,
            sequenceNumber: r.sequenceNumber,
            level: r.level.value,
            name: r.loggerName,
            error: r.error,
            stackTrace: r.stackTrace,
          );
        }
      }
      // Handle File Logging safely
      if (!_fileLoggingDisabled) {
        // Backpressure / Memory safeguard
        if (_fileWriteQueue.length >= _maxQueueSize) {
          _fileWriteQueue.removeFirst(); // Drop the oldest to make room for the next
          _droppedLogsCount++;
        }
        _fileWriteQueue.add((record: r, caller: callerInfo));
        _wakeChannel.add(null);
      }
    }
  });
  // 4. Ensure we flush file on app exit
  AppLifecycleListener(
    onExitRequested: () async {
      await closeLogging();
      return AppExitResponse.exit;
    },
  );
}

/// Safe, deterministic shutdown sequence
Future<void> closeLogging() async {
  if (!_isClosing) {
    _isClosing = true;
    _wakeChannel.add(null); // One last wake to let the loop drain the queue, then exit
    await _loopFuture;
    await _fileSink?.flush();
    await _fileSink?.close();
    _fileSink = null;
    await _wakeChannel.close();
  }
}

final _callerRegex = RegExp(r'^#\d+\s+(.+?)\s(\(.+\))$');

CallerInfo _logCaller(StackTrace stack) {
  // WARN: caller info (class and location) will be unavailable in obfuscated release builds
  final callerLine = stack
      .toString()
      .split('\n')
      .skip(1)
      .firstWhere((e) => e.contains('package:latin_reader'), orElse: () => '');
  final match = callerLine.isNotEmpty ? _callerRegex.firstMatch(callerLine) : null;
  return (
    classAndMethod: match != null
        ? '${match.group(1)}()'.replaceFirst('.<anonymous closure>', '').trim()
        : '',
    location: match?.group(2)?.trim() ?? '',
  );
}

extension XLogger on Logger {
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

  /// Returns the message formatted according to the provided trace, optionally with ANSI colors
  String formattedMessage(CallerInfo caller, {bool useColor = false}) {
    final logId = '${loggerName.isNotEmpty ? '($loggerName)' : ''}${level.name}';
    return useColor
        ? (StringBuffer()..writeAll([
                if (caller.location.isNotEmpty) '\n$dim${caller.location}',
                '\n${_colors[level]}$logId$reset $time',
                if (caller.classAndMethod.isNotEmpty) '\n${caller.classAndMethod}',
                '\n$bright$message',
              ]))
              .toString()
        : [
            '',
            if (caller.location.isNotEmpty) caller.location,
            '$logId $time',
            if (caller.classAndMethod.isNotEmpty) caller.classAndMethod,
            message,
          ].join('\n');
  }

  //
}
