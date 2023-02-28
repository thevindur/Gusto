import 'package:flutter/material.dart';
import 'package:gusto/pages/home.dart';
import 'package:gusto/pages/recipe_generation.dart';
import 'package:gusto/pages/scan.dart';
import 'package:gusto/pages/profile.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int index = 0;
  final screens = [
    Home(),
    RecipeGeneration(),
    Scan(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        backgroundColor: const Color(0xFFFFE9C8),
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            indicatorColor: Color(0xFFFF8A00),
            backgroundColor: Color(0xFFFDC36D),
            labelTextStyle: MaterialStatePropertyAll(
                TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                )
            ),
            height: 60.0,
          ),
          child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index)=>setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.food_bank_outlined),
                  selectedIcon: Icon(Icons.food_bank),
                  label: 'Recipes'),
              NavigationDestination(
                  icon: Icon(Icons.camera_alt_outlined),
                  selectedIcon: Icon(Icons.camera_alt),
                  label: 'Scan'),
              NavigationDestination(
                  icon: Icon(Icons.person_2_outlined),
                  selectedIcon: Icon(Icons.person_2),
                  label: 'Profile'),
            ],),)
    );
  }
}

