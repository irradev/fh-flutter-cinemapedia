import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart' show Movie;

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  final String lastQuery;
  List<Movie> initialMovies = [];
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.lastQuery,
    required this.initialMovies,
  });

  void clearStreams() {
    debouncedMovies.close();
    isLoadingMovies.close();
    _debounceTimer?.cancel();
  }

  void _onQueryChanged(String query) {
    if (lastQuery.isNotEmpty && lastQuery == query) {
      debouncedMovies.add(initialMovies);
      isLoadingMovies.add(false);
      return;
    }
    isLoadingMovies.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      searchMovies(query).then((movies) {
        initialMovies = movies;
        debouncedMovies.add(movies);
        isLoadingMovies.add(false);
      });
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        }

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        if (movies.isEmpty) {
          return const Center(child: Text('No se encontraron películas'));
        }
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onSelect: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    clearStreams();
    super.dispose();
  }

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: isLoadingMovies.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;

          if (!isLoading) {
            return FadeIn(
              animate: query.isNotEmpty,
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.clear),
              ),
            );
          }

          return SpinPerfect(
            duration: const Duration(seconds: 2),
            spins: 10,
            infinite: true,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.refresh_rounded),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext context, Movie movie) onSelect;
  const _MovieItem({required this.movie, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final grayColor = const Color(0xFF7A7A7A);

    return GestureDetector(
      onTap: () => onSelect(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return FadeIn(child: child);
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FadeIn(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (movie.title.isNotEmpty)
                      Text(
                        movie.title,
                        style: textStyles.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (movie.overview.isNotEmpty) const SizedBox(height: 2),
                    if (movie.overview.isNotEmpty)
                      Text(
                        movie.overview,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.bodyMedium?.copyWith(
                          color: grayColor,
                        ),
                      ),

                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow.shade900,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: textStyles.bodyMedium?.copyWith(
                            color: Colors.yellow.shade900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
