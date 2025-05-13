import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/breadcrum_provider.dart';

class AddIngredientsPage extends ConsumerStatefulWidget {
  const AddIngredientsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddIngredientsPage> createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends ConsumerState<AddIngredientsPage> {

  @override
  Widget build(BuildContext context) {
    final List<String> ingredients = [
      "Flour",
      "Sugar",
      "Eggs",
      "Milk",
      "Butter",
    ];
    final List<String> selectedIngredients = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Ingredients",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: ingredients.map((ingredient) {
            final isSelected = selectedIngredients.contains(ingredient);
            return FilterChip(
              label: Text(ingredient),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedIngredients.add(ingredient);
                  } else {
                    selectedIngredients.remove(ingredient);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

