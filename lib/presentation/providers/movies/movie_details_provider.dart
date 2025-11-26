import 'package:flutter_riverpod/legacy.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

final movieDetailsProvider =
    StateNotifierProvider<MovieDetailsMapNotifier, Map<String, Movie>>((ref) {
      final moviesRepository = ref.watch(moviesRepositoryProvider);
      return MovieDetailsMapNotifier(
        getMovieDetails: moviesRepository.getMovieById,
      );
    });

typedef GetMovieDetailsCallback = Future<Movie> Function(String movieId);

class MovieDetailsMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieDetailsCallback getMovieDetails;

  MovieDetailsMapNotifier({required this.getMovieDetails}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovieDetails(movieId);
    state = {...state, movieId: movie};
  }
}
