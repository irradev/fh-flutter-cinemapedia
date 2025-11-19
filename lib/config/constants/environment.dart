import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tmdbApiToken = dotenv.env['TMDB_API_TOKEN'] ?? 'No API Token';
}
