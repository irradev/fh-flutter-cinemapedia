import '../../domain/entities/actor.dart';
import '../models/tmdb/tmdb_credits_response.dart';

class TmdbActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: tmdbActorProfileUrl(cast.profilePath),
    character: cast.character,
  );
}

String tmdbActorProfileUrl(String? path) {
  if (path == null || path.isEmpty) {
    return 'https://static.vecteezy.com/system/resources/previews/001/840/618/original/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg';
  }
  return 'https://image.tmdb.org/t/p/w500$path';
}
