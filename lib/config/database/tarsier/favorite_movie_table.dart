import 'package:tarsier_local_storage/tarsier_local_storage.dart';

import 'favorite_movie_model.dart';

class FavoriteMovieTable extends BaseTable<FavoriteMovie> {
  FavoriteMovieTable()
    : super(
        tableName: FavoriteMovie.tableName,
        schema: FavoriteMovie.schema,
        fromMap: (map) => FavoriteMovie.fromMap(map),
        toMap: (model) => model.toMap(),
      );
}
