import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';
import '../../presentation/views/views.dart';
import '../../presentation/widgets/widgets.dart';

final GlobalKey<NavigatorState> mainTabsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'mainTabsNavigator');

final mainTabsRouter = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return MainTabs(navigationShell: navigationShell);
  },
  branches: <StatefulShellBranch>[
    // * MainTab: Home
    StatefulShellBranch(
      navigatorKey: mainTabsNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          // Vista principal del TabHome:
          builder: (context, state) => const HomeView(),
          // Rutas hijas del TabHome:
          routes: [
            GoRoute(
              path: 'movie/:id',
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              },
            ),
          ],
        ),
      ],
    ),

    // * MainTab: Categories
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/categories',
          builder: (context, state) => const CategoriesView(),
        ),
      ],
    ),

    // * MainTab: Favorites
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesView(),
        ),
      ],
    ),
  ],
);
