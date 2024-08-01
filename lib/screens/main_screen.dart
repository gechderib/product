import 'package:aevue_technical/providers/ui_provider.dart';
import 'package:aevue_technical/screens/favorite_screen.dart';
import 'package:aevue_technical/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({super.key});

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    return SafeArea(
      child: Scaffold(
        body: _screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(bottomNavIndexProvider.notifier).changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
