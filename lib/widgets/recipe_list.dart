import 'package:cooka/widgets/recipe_item.dart';
import 'package:flutter/material.dart';

import 'package:cooka/models/recipe.dart';

class RecipListTile extends StatelessWidget {
  const RecipListTile({
    super.key,
    required this.title,
    required this.recipes,
    this.showTitle = true,
  });

  final String title;
  final List<Recipe> recipes;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.left,
          ),
        const SizedBox(height: 8),
        Column(
          children: List.generate(
            recipes.length > 3 ? 3 : recipes.length,
            (index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              child: RecipeItem(
                recipe: recipes[index]
            ),
          ),
        )),
        const SizedBox(height: 8), // Adjust spacing if needed
        Row(
          mainAxisAlignment:
              MainAxisAlignment.end, // Aligns the button to the right
          children: [
            TextButton(
              onPressed: () {
                // Add your navigation or action logic here
              },
              child: Text(
                'See Other',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
