import 'package:ecommerce_app/core/widgets/bottom_nav_widget.dart';
import 'package:ecommerce_app/features/account/presentation/screens/account_screen.dart';
import 'package:ecommerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce_app/features/saved/presentation/screens/saved_screen.dart';
import 'package:ecommerce_app/features/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const SearchScreen(),
      const SavedScreen(),
      const CartScreen(),
      const AccountScreen(),
    ];
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: bottomNavIndexNotifier,
        builder: (context, value, child) {
          return pages[value];
        },
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}
