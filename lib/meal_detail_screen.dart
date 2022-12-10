import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((element) => element.id == mealID);
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Ingredients',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                );
              },
              itemCount: selectedMeal.ingredients.length,
              shrinkWrap: true,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Steps',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                );
              },
              itemCount: selectedMeal.steps.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
