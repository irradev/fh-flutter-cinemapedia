import 'package:flutter_riverpod/legacy.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/repositories/local_storage_repository.dart';
import '../providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
      final localStorageRepository = ref.watch(localStorageRepositoryProvider);
      return StorageMoviesNotifier(
        localStorageRepository: localStorageRepository,
      );
    });

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<void> toggleFavoiteMovie(Movie movie) async {
    final isFavorite = await localStorageRepository.isFavoriteMovie(movie.id);
    await localStorageRepository.toggleFavorite(movie);
    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadFavoriteMovies(
      limit: 10,
      offset: page * 10,
    );
    page++;

    if (movies.isEmpty) {
      return [];
    }

    final tempMovies = <int, Movie>{};
    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};
    return movies;
  }
}
