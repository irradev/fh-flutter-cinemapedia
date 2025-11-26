import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/movies_datasource.dart';
import '../../domain/entities/movie.dart';
import '../mappers/tmdb_movie_mapper.dart';
import '../models/tmdb/tmdb_movie_details.dart';
import '../models/tmdb/tmdb_movies_response.dart';
import '../models/tmdb/tmdb_search_movies_response.dart';

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

  List<Movie> _processMoviesResponse(Response<dynamic> response) {
    final TmdbMoviesResponse tmdbResponse = TmdbMoviesResponse.fromJson(
      response.data,
    );

    final List<Movie> movies = tmdbResponse.results
        .where((tmdbMovie) => tmdbMovie.posterPath != '')
        .map((e) => TmdbMapper.movieToEntity(e))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _processMoviesResponse(response);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _processMoviesResponse(response);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _processMoviesResponse(response);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _processMoviesResponse(response);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie not found');

    final movieDetails = TmdbMovieDetails.fromJson(response.data);
    final movie = TmdbMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query},
    );

    // if (response.statusCode != 200) throw Exception('Movies not found');

    final searchResponse = TmdbSearchMovieResponse.fromJson(response.data);
    final List<Movie> movies = searchResponse.results
        .where((tmdbMovie) => tmdbMovie.posterPath != '')
        .map((e) => TmdbMapper.movieToEntity(e))
        .toList();

    return movies;
  }
}
