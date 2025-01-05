import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

///dynamic data that can change
///use StateNotifier
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  ///initial data goes into "super([])" <----- List<Meal> []
  FavouriteMealsNotifier() : super([]);

  ///cannot modify list in providers
  ///for riverpod states, you have to reassign data
  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);

    ///if meal is already a favourite (true)
    if (mealIsFavourite) {
      ///find the item where item.id is NOT equal to meal.id to exclude the meal
      state = state.where((item) => item.id != meal.id).toList();
      return false;
    } else {
      ///else, add meal
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider = StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
