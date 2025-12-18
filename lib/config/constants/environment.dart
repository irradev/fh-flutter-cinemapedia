class Environment {
  // Use --dart-define values passed at compile time
  // Build command: flutter build web --dart-define=TMDB_API_TOKEN=your_token
  static const String tmdbApiToken = String.fromEnvironment(
    'TMDB_API_TOKEN',
    defaultValue: 'No API Token',
  );
}
