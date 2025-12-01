import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainTabs extends StatelessWidget {
  static const String routeName = 'main-tabs-screen';

  final StatefulNavigationShell navigationShell;

  const MainTabs({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _CustomBottomNavigationBar(
        navigationShell: navigationShell,
      ),
    );
  }
}

class _CustomBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const _CustomBottomNavigationBar({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      elevation: 0,
      onTap: (index) {
        const initLocationIndexes = [0, 2];
        navigationShell.goBranch(
          index,
          initialLocation: initLocationIndexes.contains(index),
        );
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
