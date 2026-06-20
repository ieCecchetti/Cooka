import 'package:cooka/screens/show_recipe_screen.dart';
import 'package:flutter/material.dart';

import 'package:cooka/models/recipe.dart';
import 'package:cooka/providers/ingredient_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeItem extends ConsumerWidget {
  const RecipeItem({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allIngredients = ref.read(ingredientsProvider);
    final ingredientMap = {
      for (var id in recipe.ingredientIds)
        if (allIngredients.any((element) => element.id == id))
          id: allIngredients.firstWhere((element) => element.id == id)
    };

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowRecipeScreen(
              recipe: recipe,
              ingredientMap: ingredientMap,
            ),
          ),
        );
      },
      leading: Stack(
        children: [
          if (recipe.imagesUrl.isNotEmpty && recipe.imagesUrl.first.isNotEmpty)
            Image.network(
              recipe.imagesUrl.first,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          else
            Container(
              width: 100,
              height: 100,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 40, color: Colors.white),
            ),
          if (recipe.category.isNotEmpty)
            Positioned(
              top: 0,
              right: 4,
              child: CircleAvatar(
                backgroundColor: recipe.category[0].color,
                radius: 12,
                child: Icon(
                  recipe.category[0].icon,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      title: Text(recipe.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipe.description),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.timer, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${recipe.prepTime} min',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.local_fire_department,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                recipe.difficulty.name,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
