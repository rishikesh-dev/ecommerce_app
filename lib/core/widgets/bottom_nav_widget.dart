import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

ValueNotifier<int> bottomNavIndexNotifier = ValueNotifier<int>(0);

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bottomNavIndexNotifier,
      builder: (context, value, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: value,
          onTap: (index) {
            bottomNavIndexNotifier.value = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.heart),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.shoppingCart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.circleUser),
              label: 'Account',
            ),
          ],
        );
      },
    );
  }
}
