import 'package:flutter/foundation.dart';

import 'constants/environment.dart';

enum AppEnv { demo, prod }

class AppConfig {
  static AppEnv env = _env;

  static final AppEnv _env = _parseEnv(
    const String.fromEnvironment('APP_ENV', defaultValue: 'prod'),
  );

  static AppEnv _parseEnv(String value) {
    switch (value) {
      case 'demo':
        return AppEnv.demo;
      case 'prod':
      default:
        return AppEnv.prod;
    }
  }

  /// Inicializa variables según plataforma + entorno
  static Future<void> init() async {
    if (!kIsWeb && env == AppEnv.prod) {
      await Environment.init();
    }
  }

  static bool get isDemo => env == AppEnv.demo;
  static bool get isProd => env == AppEnv.prod;
}
