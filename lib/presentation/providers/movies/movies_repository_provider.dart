import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/tmdb_datasource.dart';
import '../../../infrastructure/repositories/movies_repository_impl.dart';

// Este repositorio es inmutable
final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(moviesDatasource: TmdbDatasource());
});
