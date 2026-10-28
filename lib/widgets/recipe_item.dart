import 'package:cooka/screens/show_recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cooka/models/recipe.dart';
import 'package:cooka/providers/ingredient_provider.dart';
import 'package:cooka/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A recipe shown as an old handwritten recipe card: a slightly tilted piece
/// of aged paper with a taped-in photo, as if it had been copied out and
/// handed to a friend.
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

    // Deterministic tiny tilt per recipe, so the stack looks hand-placed.
    final tilt = ((recipe.id.hashCode % 5) - 2) * 0.008;

    return GestureDetector(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: Transform.rotate(
          angle: tilt,
          child: Container(
            decoration: paperDecoration(radius: 4),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TapedPhoto(recipe: recipe),
                      const SizedBox(width: 14),
                      Expanded(child: _CardText(recipe: recipe)),
                    ],
                  ),
                ),
                // A strip of masking tape across the top-left corner.
                Positioned(
                  top: -6,
                  left: 24,
                  child: Transform.rotate(
                    angle: -0.12,
                    child: Container(
                      width: 46,
                      height: 16,
                      decoration: const BoxDecoration(color: AppColors.tape),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TapedPhoto extends StatelessWidget {
  const _TapedPhoto({required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        recipe.imagesUrl.isNotEmpty && recipe.imagesUrl.first.isNotEmpty;
    return Container(
      // White border = an old photo print pasted onto the card.
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6E9),
        border: Border.all(color: Colors.white),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 4, offset: Offset(1, 2)),
        ],
      ),
      child: Stack(
        children: [
          SizedBox(
            width: 84,
            height: 84,
            child: hasImage
                ? Image.network(
                    recipe.imagesUrl.first,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const _PhotoFallback(),
                    loadingBuilder: (context, child, progress) =>
                        progress == null ? child : const _PhotoFallback(),
                  )
                : const _PhotoFallback(),
          ),
          if (recipe.category.isNotEmpty)
            Positioned(
              top: 2,
              right: 2,
              child: CircleAvatar(
                backgroundColor: recipe.category[0].color,
                radius: 12,
                child: FaIcon(
                  recipe.category[0].icon,
                  size: 13,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.paperDeep,
      alignment: Alignment.center,
      child: const Icon(Icons.restaurant_menu, color: AppColors.inkSoft, size: 32),
    );
  }
}

class _CardText extends StatelessWidget {
  const _CardText({required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: handwritten(fontSize: 26),
        ),
        // Hand-drawn red underline, like an index card's margin rule.
        Container(
          margin: const EdgeInsets.only(top: 1, bottom: 6),
          height: 2,
          width: 120,
          color: AppColors.accent,
        ),
        Text(
          recipe.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.5,
            color: AppColors.inkSoft,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.schedule, size: 15, color: AppColors.inkSoft),
            const SizedBox(width: 4),
            Text('${recipe.prepTime} min', style: _meta),
            const SizedBox(width: 14),
            const Icon(Icons.local_fire_department,
                size: 15, color: AppColors.accent),
            const SizedBox(width: 4),
            Text(recipe.difficulty.name, style: _meta),
          ],
        ),
      ],
    );
  }

  static const _meta = TextStyle(fontSize: 12, color: AppColors.inkSoft);
}
