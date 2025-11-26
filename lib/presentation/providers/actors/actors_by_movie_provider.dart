import 'package:flutter_riverpod/legacy.dart';

import '../../../domain/entities/actor.dart';
import 'actors_repository_provider.dart';

typedef Actors = Map<String, List<Actor>>;

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Actors>((ref) {
      final actorsRepository = ref.watch(actorsRepositoryProvider);
      return ActorsByMovieNotifier(
        getActorsByMovieId: actorsRepository.getActorsByMovieId,
      );
    });

typedef GetActorsByMovieIdCallback =
    Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Actors> {
  final GetActorsByMovieIdCallback getActorsByMovieId;

  ActorsByMovieNotifier({required this.getActorsByMovieId}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActorsByMovieId(movieId);
    state = {...state, movieId: actors};
  }
}
