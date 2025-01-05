import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/main_drawer.dart';
import '../providers/favourites_provider.dart';
import '../providers/filtered_meals_provider.dart';
import '../providers/filters_provider.dart';
import 'categories.dart';
import 'filters.dart';
import 'meals.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = "Categories";

    ///favourite meals tab
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,

      ///_selectPage(index) correlates to "items" list
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          ///index 0 tab
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),

          ///index 1 tab
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.pop(context);
    if (identifier == "filters") {
      ///getting result from future "pop" method
      Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }
}
