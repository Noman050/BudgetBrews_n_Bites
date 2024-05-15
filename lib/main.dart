import 'package:flutter/material.dart';
import 'package:foodies/models/screenRoutes.dart';
import 'package:foodies/screens/categoriesScreen.dart';
import 'package:foodies/screens/expanseHomeScreen.dart';
import 'package:foodies/screens/optionScreen.dart';
import 'constants/recipeData.dart';
import 'screens/categoryMealsScreen.dart';
import 'screens/splashScreen.dart';
import 'screens/tabsScreen.dart';
import 'screens/mealDetailScreen.dart';
import 'screens/filtersScreen.dart';
import 'models/meals.dart';
import 'constants/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeal = RECIPE_MEALS;
  final List<Meal> _favoritedMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = RECIPE_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isNonVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(RECIPE_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: buttonColor,
            opacity: 90,
            size: 27,
          ),
          backgroundColor: bgColor,
          centerTitle: true,
          elevation: 0,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: buttonColor,
        ),
        fontFamily: 'RobotoCondensed-Regular',
        scaffoldBackgroundColor: bgColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Foodies',
      initialRoute: '/',
      routes: {
        '/': (ctx) => const CustomSplashScreen(),
        ScreenRoutes.expenseScreen: (context) => const ExpanseHomeScreen(),
        ScreenRoutes.categoriesScreen: (context) => const CategoriesScreen(),
        ScreenRoutes.recipeScreen: (context) => TabsScreen(_favoritedMeals),
        ScreenRoutes.optionScreen: (context) => const OptionScreen(),
        ScreenRoutes.categoryMealsScreen: (context) =>
            CategoryMealsScreen(_availableMeal),
        ScreenRoutes.mealDetailScreen: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        ScreenRoutes.filterScreen: (context) =>
            FilterScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const OptionScreen());
      },
    );
  }
}
