import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/tmdb_actors_datasource.dart';
import '../../../infrastructure/repositories/actors_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(actorsDatasource: TmdbActorsDatasource());
});
