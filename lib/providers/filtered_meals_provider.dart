import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'filters_provider.dart';
import 'meals_provider.dart';

final filteredMealsProvider = Provider((ref) {
  ///using other providers
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  ///getting available meals based on filters
  return meals.where((meal) {
    ///if glutenFree filter is checked && meal is NOT gluten free, exclude meal
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    ///if lactoseFree filter is checked && meal is NOT lactose free, exclude meal
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    ///if vegan filter is checked && meal is vegan, exclude meal
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    ///if vegetarian filter is checked && meal is vegetarian, exclude meal
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    ///else include meal
    return true;
  }).toList();
});
