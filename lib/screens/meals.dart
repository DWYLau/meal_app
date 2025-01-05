import 'package:flutter/material.dart';

import '../components/meal_item.dart';
import '../models/meal.dart';
import 'meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
  });

  ///optional parameter "title"
  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    ///if meals is empty
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh oh... nothing here!",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting a different category.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          )
        ],
      ),
    );

    ///if meals is not empty
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (context, meal) {
            _selectMeal(context, meal);
          },
        ),
      );
    }

    ///for favourites screen (remove extra Scaffold appbar)
    if (title == null) {
      return content;
    }

    ///for just meal screen (include Scaffold appbar)
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }

  ///screen navigator
  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(meal: meal),
      ),
    );
  }
}
