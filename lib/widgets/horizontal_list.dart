import 'package:flutter/material.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:cooka/theme/app_theme.dart';

class HorizontalList extends StatelessWidget {
  final List<Ingredient> ingredients;
  final String title;
  final bool showTitle;
  final int? maxItems;
  final double maxHeight;

  const HorizontalList({
    super.key,
    required this.ingredients,
    required this.title,
    this.showTitle = true,
    this.maxItems,
    this.maxHeight = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight, // Set a fixed height for the horizontal list
      child: Column(
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: maxItems != null && (maxItems ?? 0) < ingredients.length ? maxItems : ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                final tilt = ((index % 4) - 1.5) * 0.02;
                return Container(
                  width: 104, // Set a fixed width for each item
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Transform.rotate(
                    angle: tilt,
                    child: Column(
                      children: [
                        Expanded(
                          // A little photo print pinned to the page.
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF6E9),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 5,
                                  offset: Offset(1, 3),
                                ),
                              ],
                            ),
                            child: ingredient.imageUrl.isNotEmpty
                                ? Image.network(
                                    ingredient.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const _IngredientFallback(),
                                    loadingBuilder: (context, child, p) =>
                                        p == null
                                            ? child
                                            : const _IngredientFallback(),
                                  )
                                : const _IngredientFallback(),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ingredient.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: handwritten(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientFallback extends StatelessWidget {
  const _IngredientFallback();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.paperDeep,
      alignment: Alignment.center,
      child: const Icon(Icons.egg_alt, size: 34, color: AppColors.inkSoft),
    );
  }
}
