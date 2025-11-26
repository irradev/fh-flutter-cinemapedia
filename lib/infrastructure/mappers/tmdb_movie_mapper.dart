import '../../domain/entities/movie.dart';
import '../models/tmdb/tmdb_movie.dart' show TmdbMovie;
import '../models/tmdb/tmdb_movie_details.dart';

class TmdbMapper {
  static Movie movieToEntity(TmdbMovie tmdbMovie) {
    return Movie(
      id: tmdbMovie.id,
      title: tmdbMovie.title,
      genreIds: tmdbMovie.genreIds.map((e) => e.toString()).toList(),
      originalLanguage: tmdbMovie.originalLanguage,
      originalTitle: tmdbMovie.originalTitle,
      popularity: tmdbMovie.popularity,
      video: tmdbMovie.video,
      overview: tmdbMovie.overview,
      releaseDate: tmdbMovie.releaseDate,
      posterPath: tmdbPosterUrl(tmdbMovie.posterPath, isPoster: true),
      backdropPath: tmdbPosterUrl(tmdbMovie.backdropPath),
      voteAverage: tmdbMovie.voteAverage,
      voteCount: tmdbMovie.voteCount,
      adult: tmdbMovie.adult,
    );
  }

  static Movie movieDetailsToEntity(TmdbMovieDetails movideDetails) {
    return Movie(
      id: movideDetails.id,
      title: movideDetails.title,
      genreIds: movideDetails.genres.map((e) => e.name.toString()).toList(),
      originalLanguage: movideDetails.originalLanguage,
      originalTitle: movideDetails.originalTitle,
      popularity: movideDetails.popularity,
      video: movideDetails.video,
      overview: movideDetails.overview,
      releaseDate: movideDetails.releaseDate,
      posterPath: tmdbPosterUrl(movideDetails.posterPath, isPoster: true),
      backdropPath: tmdbPosterUrl(movideDetails.backdropPath),
      voteAverage: movideDetails.voteAverage,
      voteCount: movideDetails.voteCount,
      adult: movideDetails.adult,
    );
  }
}

String tmdbPosterUrl(String path, {bool isPoster = false}) {
  if (path.isEmpty) {
    if (isPoster) {
      return 'https://www.movienewsletters.net/photos/000000H1.jpg';
    } else {
      return 'https://tse1.mm.bing.net/th/id/OIP.Lr_j_PgqTGzKxJTeIwajVwHaLH?rs=1&pid=ImgDetMain&o=7&rm=3';
    }
  } else {
    return 'https://image.tmdb.org/t/p/${isPoster ? 'w500' : 'w780'}$path';
  }
}
