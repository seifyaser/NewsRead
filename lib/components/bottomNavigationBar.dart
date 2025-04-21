import 'package:flutter/material.dart';
import 'package:project/generated/l10n.dart';
import 'package:project/screens/DiscoverPage.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _currentIndex = 1;

  final List<Widget> _pages = [DiscoverPage(), const Home(), SettingsPage()];

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              screenWidth > 600 ? 24.0 : 14.0, // زيادة الهامش للأجهزة الأكبر
          vertical:
              screenWidth > 600 ? 10.0 : 2.0, // زيادة الهامش للأجهزة الأكبر
        ),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            /// Discover
            SalomonBottomBarItem(
              icon: const Icon(Icons.auto_awesome),
              title:  Text(S.of(context).discover),
              selectedColor: Colors.pink,
            ),

            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title:  Text(S.of(context).home),
              selectedColor: Colors.purple,
            ),

            /// Settings
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: Text(S.of(context).Settings),
              selectedColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
