import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'meal_item_trait.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meal);
        },
        child: Stack(
          children: [
            ///background image first in a stack
            Hero(
              ///"Hero" needs a unique tag id
              tag: meal.id,
              child: FadeInImage(
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),

            ///lower bottom container
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(icon: Icons.schedule, label: "${meal.duration} min"),
                          const SizedBox(width: 12),
                          MealItemTrait(icon: Icons.work, label: meal.complexityText),
                          const SizedBox(width: 12),
                          MealItemTrait(icon: Icons.attach_money, label: meal.affordabilityText)
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
