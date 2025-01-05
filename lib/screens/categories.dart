import 'package:flutter/material.dart';

import '../components/category_grid_item.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';
import 'meals.dart';

///animations require StatefulWidgets
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

///explicit animations requires mixins
class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  ///late tells Flutter that this variable will have a value later when it is first used
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    ///animationController must be assigned inside initState because vsync is available here
    _animationController = AnimationController(
      vsync: this,

      ///duration of animation
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    ///prevents memory overflows
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          ///2 columns
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          ///finetune how the animation feels using a Curves object
          CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
        ),
        child: child,
      ),
    );
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals =
        widget.availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }
}
