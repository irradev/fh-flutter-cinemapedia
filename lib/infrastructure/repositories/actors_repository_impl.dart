import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../../domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl implements ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorsRepositoryImpl({required this.actorsDatasource});

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) {
    return actorsDatasource.getActorsByMovieId(movieId);
  }
}
