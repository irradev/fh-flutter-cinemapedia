import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:flutter_riverpod/legacy.dart';

import '../../../domain/entities/movie.dart';
import '../movies/movies_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
      final moviesRepository = ref.read(moviesRepositoryProvider);

      return SearchedMoviesNotifier(
        searchMovies: moviesRepository.searchMovies,
        ref: ref,
      );
    });

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
    : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final searchQuery = ref.read(searchQueryProvider.notifier);

    if (searchQuery.state == query && state.isNotEmpty) return state;

    searchQuery.update((state) => query);

    final List<Movie> movies = await searchMovies(query);
    state = movies;
    return movies;
  }
}
