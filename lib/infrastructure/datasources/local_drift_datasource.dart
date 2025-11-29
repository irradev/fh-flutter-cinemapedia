import 'package:drift/drift.dart' as drift;

import '../../config/database/drift/database.dart';
import '../../domain/datasources/local_storage_datasource.dart';
import '../../domain/entities/movie.dart';

class LocalDriftDatasource implements LocalStorageDatasource {
  final AppDatabase database;

  LocalDriftDatasource([AppDatabase? databaseToUse])
    : database = databaseToUse ?? db;

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    // Construir el query
    final query = database.select(database.favoriteMovies)
      ..where((table) => table.movieId.equals(movieId));

    // Ejecutar el query
    final favoriteMovie = await query.getSingleOrNull();

    // Devolver el resultado
    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({
    int limit = 10,
    int offset = 0,
  }) async {
    // Construir el query
    final query = database.select(database.favoriteMovies)
      ..limit(limit, offset: offset);

    // Ejecutar el query
    final favoriteMovies = await query.get();

    // Devolver el resultado
    return favoriteMovies
        .map(
          (movie) => Movie(
            adult: false,
            backdropPath: movie.backdropPath,
            genreIds: [],
            id: movie.id,
            originalLanguage: '',
            originalTitle: movie.originalTitle,
            overview: '',
            popularity: 0,
            posterPath: movie.posterPath,
            releaseDate: null,
            title: movie.title,
            video: false,
            voteAverage: movie.voteAverage,
            voteCount: 0,
          ),
        )
        .toList();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isFavorite = await isFavoriteMovie(movie.id);
    if (isFavorite) {
      final deleteQuery = database.delete(database.favoriteMovies)
        ..where((table) => table.movieId.equals(movie.id));
      await deleteQuery.go();
    } else {
      database
          .into(database.favoriteMovies)
          .insert(
            FavoriteMoviesCompanion.insert(
              movieId: movie.id,
              backdropPath: movie.backdropPath,
              posterPath: movie.posterPath,
              originalTitle: movie.originalTitle,
              title: movie.title,
              overview: movie.overview,
              voteAverage: drift.Value(movie.voteAverage),
            ),
          );
    }
  }
}
