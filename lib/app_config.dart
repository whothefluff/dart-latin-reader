// Will not fail
// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig _instance = AppConfig._();
  static late final YamlMap _config;
  static final Map<String, Level> _levels = {
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
    final configString = await rootBundle.loadString('config.yaml');
    _config = loadYaml(configString) as YamlMap;
  }

  bool get logDbStatements => _config['database.log_statements'] as bool? ?? false;

  Level get consoleLogLevel => _levels[_config['log']['console']['level']] ?? Level.ALL;

  Level get fileLogLevel => _levels[_config['log']['file']['level']] ?? Level.OFF;
  //
}
