// Will not fail
// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig _instance = AppConfig._();
  static YamlMap? _config;
  static final Map<String, Level> _logLevels = {
    'ALL': Level.ALL,
    'FINEST': Level.FINEST,
    'FINER': Level.FINER,
    'FINE': Level.FINE,
    'CONFIG': Level.CONFIG,
    'INFO': Level.INFO,
    'WARNING': Level.WARNING,
    'SEVERE': Level.SEVERE,
    'SHOUT': Level.SHOUT,
    'OFF': Level.OFF,
  };

  static AppConfig get instance => _instance;

  Future<void> load() async {
    if (_config == null) {
      final configString = await rootBundle.loadString('config.yaml');
      _config = loadYaml(configString) as YamlMap;
    }
  }

  static YamlMap get _cfg => _config ?? (throw StateError('AppConfig.load() not called'));

  bool get logDbStatements => _cfg['database']?['log_statements'] as bool? ?? false;

  Level get consoleLogLevel => _logLevels[_cfg['log']?['console']?['level']] ?? Level.ALL;

  Level get fileLogLevel => _logLevels[_cfg['log']?['file']?['level']] ?? Level.OFF;

  bool get logUsesApi => _cfg['log']?['console']?['using']?['api'] as bool? ?? false;

  bool get logUsesPrint => _cfg['log']?['console']?['using']?['print'] as bool? ?? true;
  //
}
