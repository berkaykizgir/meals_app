import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import 'models/meals.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritedMeals;
  const FavoritesScreen({super.key, required this.favoritedMeals});

  @override
  Widget build(BuildContext context) {
    if (favoritedMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet --- try adding some !'),
      );
    } else {
      return ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: favoritedMeals[index].id,
            title: favoritedMeals[index].title,
            imageUrl: favoritedMeals[index].imageUrl,
            duration: favoritedMeals[index].duration,
            complexity: favoritedMeals[index].complexity,
            affordability: favoritedMeals[index].affordability,
            //  removeItem: _removeMeal,
          );
        }),
        itemCount: favoritedMeals.length,
      );
    }
  }
}
