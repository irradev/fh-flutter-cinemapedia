import '../../config/database/tarsier/favorite_movie_model.dart';
import '../../config/database/tarsier/favorite_movie_table.dart';
import '../../domain/datasources/local_storage_datasource.dart';
import '../../domain/entities/movie.dart';

class LocalTasierDatasource implements LocalStorageDatasource {
  LocalTasierDatasource();

  final _favoriteMoviesTable = FavoriteMovieTable();

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isFavorite = await isFavoriteMovie(movie.id);
    if (isFavorite) {
      await _favoriteMoviesTable.delete(movie.id);
    } else {
      await _favoriteMoviesTable.createObject(
        FavoriteMovie(
          id: movie.id,
          movieId: movie.id,
          backdropPath: movie.backdropPath,
          posterPath: movie.posterPath,
          originalTitle: movie.originalTitle,
          title: movie.title,
          overview: movie.overview,
          voteAverage: movie.voteAverage,
        ),
      );
    }
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    final favoriteMovies = await _favoriteMoviesTable.all();
    return favoriteMovies.any(
      (FavoriteMovie movie) => movie.movieId == movieId,
    );
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({
    int limit = 10,
    int offset = 0,
  }) async {
    final allFavorites = await _favoriteMoviesTable.all();

    final paged = allFavorites
        .skip(offset) // salta los primeros `offset`
        .take(limit) // toma solo `limit`
        .toList();

    return paged
        .map(
          (movie) => Movie(
            adult: false,
            backdropPath: movie.backdropPath,
            genreIds: [],
            id: movie.id,
            originalLanguage: '',
            originalTitle: movie.originalTitle,
            overview: movie.overview,
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
}
