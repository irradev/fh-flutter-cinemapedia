import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/movies_datasource.dart';
import '../../domain/entities/movie.dart';
import '../mappers/tmdb_mapper.dart';
import '../models/tmdb/tmdb_response.dart';

class TmdbDatasource implements MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',

      queryParameters: {'language': 'es-MX'},

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Environment.tmdbApiToken}',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    final TmdbResponse tmdbResponse = TmdbResponse.fromJson(response.data);

    final List<Movie> movies = tmdbResponse.results
        .where((tmdbMovie) => tmdbMovie.posterPath != 'no-poster')
        .map((e) => TmdbMapper.toEntity(e))
        .toList();

    return movies;
  }
}
