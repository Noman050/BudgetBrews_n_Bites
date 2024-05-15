// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import 'favoritesScreen.dart';
import 'categoriesScreen.dart';
import '../widgets/customRecipeDrawer.dart';
import '../models/meals.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoritesMeals;
  const TabsScreen(this.favoritesMeals, {super.key});
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoritesMeals),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'].toString()),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.restaurant),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: buttonColor,
          unselectedItemColor: white30Color,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: bgColor,
              icon: Icon(Icons.list),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: bgColor,
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
