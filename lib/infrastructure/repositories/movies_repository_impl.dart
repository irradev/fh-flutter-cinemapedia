import '../../domain/datasources/movies_datasource.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesDatasource moviesDatasource;

  MoviesRepositoryImpl({required this.moviesDatasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDatasource.getNowPlaying(page: page);
  }
}
