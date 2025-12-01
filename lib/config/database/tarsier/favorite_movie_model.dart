import 'package:tarsier_local_storage/tarsier_local_storage.dart';

class FavoriteMovie extends BaseTableModel {
  final int id;
  final int movieId;
  final String backdropPath;
  final String posterPath;
  final String originalTitle;
  final String title;
  final String overview;
  final double voteAverage;

  FavoriteMovie({
    required this.id,
    required this.movieId,
    required this.backdropPath,
    required this.posterPath,
    required this.originalTitle,
    required this.title,
    required this.overview,
    required this.voteAverage,
  });

  factory FavoriteMovie.fromMap(Map<String, dynamic> map) {
    return FavoriteMovie(
      id: map['id'],
      movieId: map['movie_id'],
      backdropPath: map['backdrop_path'],
      posterPath: map['poster_path'],
      originalTitle: map['original_title'],
      title: map['title'],
      overview: map['overview'],
      voteAverage: map['vote_average'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'movie_id': movieId,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'original_title': originalTitle,
      'title': title,
      'overview': overview,
      'vote_average': voteAverage,
    };
  }

  static const String tableName = 'favorite_movies';

  static Map<String, String> get schema => {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'movie_id': 'INTEGER NOT NULL',
    'backdrop_path': 'TEXT NOT NULL',
    'poster_path': 'TEXT NOT NULL',
    'original_title': 'TEXT NOT NULL',
    'title': 'TEXT NOT NULL',
    'overview': 'TEXT NOT NULL',
    'vote_average': 'REAL NOT NULL DEFAULT 0.0',
  };
}
