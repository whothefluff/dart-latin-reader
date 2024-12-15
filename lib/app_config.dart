import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig _instance = AppConfig._();
  static late final YamlMap _config;

  static AppConfig get instance => _instance;

  Future<void> load() async {
    final configString = await rootBundle.loadString('config.yaml');
    _config = loadYaml(configString) as YamlMap;
  }

  bool get logDbStatements =>
      _config.nodes['database.log_statements']?.value as bool? ?? false;
//
}
