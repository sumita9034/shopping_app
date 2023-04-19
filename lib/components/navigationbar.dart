import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/profile_screen/profile.dart';
import '../screens/favorite_screen/favoriteview.dart';
import '../notification.dart';
import '../screens/home_screen/homescreen2.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _index = 0;
  final screen = [
    MyHomePage1(),
    FavoriteView(),
    OrderHistroy(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_index],
      bottomNavigationBar: GNav(
        color: Colors.grey.shade600,
        hoverColor: Colors.black,
        selectedIndex: _index,
        // index: _index,
        onTabChange: (value) {
          setState(() {
            _index = value;
          });
        },

        tabs: [
          GButton(
            icon: Icons.home_outlined,
            iconSize: 30,
            style: GnavStyle.google,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite_border,
            iconSize: 30,
            text: 'Favirot',
          ),
          GButton(
            icon: Icons.shopping_bag_outlined,
            iconSize: 30,
            text: 'My Bag',
          ),
          GButton(
            icon: Icons.account_circle_outlined,
            iconSize: 30,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
