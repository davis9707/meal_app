import 'package:flutter/material.dart';

import 'package:meals/pages/categories.dart';
import 'package:meals/pages/filters.dart';
import 'package:meals/pages/meals.dart';

import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMeals);
    Widget activePage = Categories(availabledMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    void onSelectScreen(String identifier) async {
      // Close the drawer
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        // Go to Filters screen
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
      } else if (identifier == 'meals') {
        // Go to TabsScreen
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: onSelectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
