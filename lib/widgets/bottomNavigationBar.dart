import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sklepik/const.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      borderRadius: 20,
      backgroundColor: primaryColor,
      selectedBackgroundColor: primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white24,
      onTap: (int val) {},
      currentIndex: 0,
      items: [
        FloatingNavbarItem(icon: Icons.home, title: 'Home'),
        FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
        FloatingNavbarItem(icon: Icons.shopping_cart, title: 'Cart'),
        FloatingNavbarItem(icon: Icons.person, title: 'Account'),
      ],
    );
  }
}
