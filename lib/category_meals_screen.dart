import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import 'models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen({super.key, required this.availableMeals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> categoryMeals;
  var _loadedInitData = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryID = routeArgs['id']!;
      categoryMeals = widget.availableMeals
          .where(
            (element) => element.categories.contains(categoryID),
          )
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  //void _removeMeal(String mealID) {
  //  setState(() {
  //    categoryMeals.removeWhere((element) => element.id == mealID);
  //  });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle)),
        body: ListView.builder(
          itemBuilder: ((context, index) {
            return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
              // removeItem: _removeMeal,
            );
          }),
          itemCount: categoryMeals.length,
        ));
  }
}
