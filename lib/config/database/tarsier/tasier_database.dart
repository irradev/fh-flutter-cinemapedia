import 'package:tarsier_local_storage/tarsier_local_storage.dart';

import 'favorite_movie_table.dart';

Future<void> initializeTarsier() async {
  await TarsierLocalStorage().init('app.db', [
    FavoriteMovieTable(),
    // agrega más tablas si las tienes
  ]);
}
