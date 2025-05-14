import 'package:flutter/material.dart';
import 'package:cooka/models/ingredient.dart';

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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.left,
                ),
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
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: maxItems != null && (maxItems ?? 0) < ingredients.length ? maxItems : ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                return Container(
                  width: 100, // Set a fixed width for each item
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[200],
                            image: DecorationImage(
                              image: NetworkImage(ingredient.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ingredient.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
