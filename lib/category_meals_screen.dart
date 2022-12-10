import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  const CategoryMealsScreen({super.key});
  /* final String categoryID;
  final String categoryTitle;
  const CategoryMealsScreen({super.key, required this.categoryID, required this.categoryTitle}); */

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title']!;
    final categoryID = routeArgs['id']!;
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle)),
        body: const Center(
          child: Text('Recipes'),
        ));
  }
}
