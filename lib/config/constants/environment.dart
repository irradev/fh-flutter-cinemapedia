import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  // static String tmdbApiToken = dotenv.env['TMDB_API_TOKEN'] ?? 'No API Token';
  static String get tmdbApiToken {
    if (kIsWeb) {
      return const String.fromEnvironment('TMDB_API_KEY');
    }
    return dotenv.env['TMDB_API_KEY'] ?? 'No API Token';
  }
}
