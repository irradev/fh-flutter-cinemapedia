import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../mappers/tmdb_actor_mapper.dart';
import '../models/tmdb/tmdb_credits_response.dart';

class TmdbActorsDatasource implements ActorsDatasource {
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
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(response.data);

    if (creditsResponse.cast.isEmpty) {
      return [];
    }

    return creditsResponse.cast
        .map((cast) => TmdbActorMapper.castToEntity(cast))
        .toList();
  }
}
