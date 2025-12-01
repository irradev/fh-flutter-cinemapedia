import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../domain/entities/movie.dart';
import 'movie_poster_link.dart';

class MoviesMasonry extends StatefulWidget {
  final List<Movie> movies;
  final Future<List<Movie>> Function()? loadNextPage;

  const MoviesMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  bool isLastPage = false;
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      // Si el scroll está cerca o a 200 pixels de llegar al final
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels + 200;

      if (currentScroll >= maxScroll) {
        loadNextPageMovies();
      }
    });
  }

  void loadNextPageMovies() async {
    if (isLoading || isLastPage) return;
    if (widget.loadNextPage == null) return;

    isLoading = true;
    final newMovies = await widget.loadNextPage!();
    isLoading = false;

    if (newMovies.isEmpty) {
      isLastPage = true;
    }
    // setState(() {
    //   widget.movies.addAll(newMovies);
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 20),
                MoviePosterLink(movie: movie),
              ],
            );
          }

          return MoviePosterLink(movie: movie);
        },
      ),
    );
  }
}
