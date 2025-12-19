import '../app_config.dart';

class Environment {
  // static String tmdbApiToken = dotenv.env['TMDB_API_TOKEN'] ?? 'No API Token';
  static String get tmdbApiToken {
    return AppConfig.tmdbApiKey;
  }
}
