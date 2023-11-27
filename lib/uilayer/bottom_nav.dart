import 'package:flutter/material.dart';
import 'package:interactive_cares_app/uilayer/nav_pages/category_page.dart';
import 'package:interactive_cares_app/uilayer/nav_pages/dashboard_page.dart';
import 'package:interactive_cares_app/uilayer/nav_pages/home_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _pages = [Homepage(), Category(), DashBoard()];
  var _position = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_position],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _position,
          onTap: (position) {
            setState(() {
              _position = position;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                ),
                label: 'Dashboard'),
          ]),
    );
  }
}
