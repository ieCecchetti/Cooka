import 'package:cooka/widgets/recipe_item.dart';
import 'package:flutter/material.dart';

import 'package:cooka/models/recipe.dart';
import 'package:cooka/theme/app_theme.dart';

class RecipListTile extends StatelessWidget {
  const RecipListTile({
    super.key,
    required this.title,
    required this.recipes,
    this.showTitle = true,
    this.maxItems = 3,
  });

  final String title;
  final List<Recipe> recipes;
  final bool showTitle;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: handwritten(fontSize: 30),
                textAlign: TextAlign.left,
              ),
              TextButton(
                onPressed: () {
                  // Add your navigation or action logic here
                },
                child: const Text('See Other'),
              ),
            ],
          ),
        const SizedBox(height: 8),
        Column(
          children: List.generate(
            recipes.length > maxItems ? maxItems : recipes.length,
            (index) => RecipeItem(
              recipe: recipes[index],
            ),
          ),
        ),
        const SizedBox(height: 8), // Adjust spacing if needed
      ],
    );
  }
}
