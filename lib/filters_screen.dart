import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FiltersScreen({super.key, required this.saveFilters, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilter = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilters(selectedFilter);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                SwitchListTile(
                  title: const Text('Gluten-Free'),
                  subtitle: const Text('Only contains gluten free meals.'),
                  value: _glutenFree,
                  onChanged: (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Lactose-Free'),
                  subtitle: const Text('Only contains lactose free meals.'),
                  value: _lactoseFree,
                  onChanged: (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegan'),
                  subtitle: const Text('Only contains vegan meals.'),
                  value: _vegan,
                  onChanged: (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegetarian'),
                  subtitle: const Text('Only contains vegetarian meals.'),
                  value: _vegetarian,
                  onChanged: (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
              ],
            )
          ],
        ));
  }
}
