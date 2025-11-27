import 'package:go_router/go_router.dart';

import 'main_tabs_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    mainTabsRouter,
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.routeName,
    //   builder: (context, state) => const HomeScreen(childView: FavoritesView()),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.routeName,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //   ],
    // ),
  ],
);
