import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:cooka/models/prep_step.dart';
import 'package:cooka/models/recipe.dart';
import 'package:cooka/models/meal_category.dart';
import 'package:cooka/data/difficulty.dart';
import 'package:cooka/providers/ingredient_provider.dart';
import 'package:cooka/providers/category_provider.dart';

class AddRecipeScreen extends ConsumerStatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  ConsumerState<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends ConsumerState<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for recipe fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shortDescriptionController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();

  // Recipe attributes
  Difficulty selectedDifficulty = Difficulty.easy;
  MealCategory? selectedCategory; // Selected category
  final List<Ingredient> selectedIngredients = [];
  final List<PrepStep> steps = [];

  void _addStep() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController stepDescriptionController =
            TextEditingController();
        final TextEditingController stepTimeController =
            TextEditingController();
        Difficulty stepDifficulty = Difficulty.easy;

        return AlertDialog(
          title: const Text('Add Step'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: stepDescriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: stepTimeController,
                decoration: const InputDecoration(labelText: 'Time (minutes)'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<Difficulty>(
                value: stepDifficulty,
                decoration: const InputDecoration(labelText: 'Difficulty'),
                items: Difficulty.values
                    .map(
                      (difficulty) => DropdownMenuItem(
                        value: difficulty,
                        child: Text(difficulty.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  stepDifficulty = value!;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  steps.add(
                    PrepStep(
                      id: steps.length + 1,
                      description: stepDescriptionController.text,
                      time: int.tryParse(stepTimeController.text),
                      difficulty: stepDifficulty,
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final recipe = Recipe(
        id: DateTime.now().toString(),
        authorId: 1, // Replace with actual author ID
        prepTime: int.tryParse(prepTimeController.text) ?? 0,
        difficulty: selectedDifficulty,
        servings: int.tryParse(servingsController.text) ?? 0,
        category: selectedCategory!, // Use the selected category
        name: nameController.text,
        shortDescription: shortDescriptionController.text,
        description: descriptionController.text,
        imageUrl: imageUrlController.text,
        ingredients: selectedIngredients,
        steps: steps,
      );

      // Clear the form
      _formKey.currentState!.reset();
      setState(() {
        selectedIngredients.clear();
        steps.clear();
        selectedCategory = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = ref.watch(ingredientsProvider);
    final categories = ref.watch(recipesProvider); // Fetch categories from provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Recipe Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: shortDescriptionController,
                decoration:
                    const InputDecoration(labelText: 'Short Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a short description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: prepTimeController,
                decoration: const InputDecoration(labelText: 'Prep Time (min)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the preparation time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: servingsController,
                decoration: const InputDecoration(labelText: 'Servings'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of servings';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<MealCategory>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                  border: OutlineInputBorder(),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem<MealCategory>(
                    value: category,
                    child: Row(
                      children: [
                        Icon(
                          IconData(category.iconCodePoint,
                              fontFamily: 'MaterialIcons'),
                          color: category.color,
                        ),
                        const SizedBox(width: 8),
                        Text(category.title),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingredients',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: ingredients.map((ingredient) {
                  final isSelected =
                      selectedIngredients.contains(ingredient);
                  return FilterChip(
                    label: Text(ingredient.name),
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
              const SizedBox(height: 16),
              const Text(
                'Steps',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...steps.map((step) => ListTile(
                    title: Text('Step ${step.id}'),
                    subtitle: Text(step.description),
                    trailing: Text(
                      '${step.time ?? 0} min',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )),
              TextButton(
                onPressed: _addStep,
                child: const Text('Add Step'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: const Text('Save Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}