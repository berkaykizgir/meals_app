import 'package:flutter/material.dart';
import 'package:meals_app/categories_screen.dart';
import 'package:meals_app/category_meals_screen.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/filters_screen.dart';
import 'package:meals_app/meal_detail_screen.dart';
import 'package:meals_app/tabs_screen.dart';

import 'models/meals.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoritedMeals = [];

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;
      _availableMeals = dummyMeals.where((meal) {
        if (_filter['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filter['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filter['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        if (_filter['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealID) {
    final existingIndex = _favoritedMeals.indexWhere((element) => element.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals.add(dummyMeals.firstWhere((element) => element.id == mealID));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CookieMeal',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          canvasColor: const Color.fromRGBO(255, 224, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline1: const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold, color: Colors.black))),
      //home: const CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(listOfMeals: _favoritedMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailsScreen.routeName: (context) => MealDetailsScreen(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isMealFavorite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(saveFilters: _setFilter, currentFilters: _filter),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const CategoriesScreen()),
    );
  }
}
