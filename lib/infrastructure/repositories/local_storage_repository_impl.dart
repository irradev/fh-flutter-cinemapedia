import '../../domain/datasources/local_storage_datasource.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalStorageDatasource localStorageDatasource;

  LocalStorageRepositoryImpl({required this.localStorageDatasource});

  @override
  Future<bool> isFavoriteMovie(int movieId) {
    return localStorageDatasource.isFavoriteMovie(movieId);
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) {
    return localStorageDatasource.loadFavoriteMovies(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return localStorageDatasource.toggleFavorite(movie);
  }
}
