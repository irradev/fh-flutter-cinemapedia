import '../../domain/entities/movie.dart';
import '../models/tmdb/tmdb_movie.dart' show TmdbMovie;

class TmdbMapper {
  static Movie toEntity(TmdbMovie tmdbMovie) {
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
      posterPath: tmdbPosterUrl(tmdbMovie.posterPath),
      backdropPath: tmdbPosterUrl(tmdbMovie.backdropPath, backdrop: true),
      voteAverage: tmdbMovie.voteAverage,
      voteCount: tmdbMovie.voteCount,
      adult: tmdbMovie.adult,
    );
  }
}

String tmdbPosterUrl(String path, {bool backdrop = false}) {
  if (path.isEmpty) {
    if (backdrop) {
      return 'https://tse1.mm.bing.net/th/id/OIP.Lr_j_PgqTGzKxJTeIwajVwHaLH?rs=1&pid=ImgDetMain&o=7&rm=3';
    } else {
      return 'no-poster';
    }
  } else {
    return 'https://image.tmdb.org/t/p/${backdrop ? 'w780' : 'w500'}$path';
  }
}
