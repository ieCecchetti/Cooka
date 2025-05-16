import 'package:cooka/models/ingredient_units.dart';
import 'package:cooka/models/measured_ingredient.dart';
import 'package:cooka/models/recipe.dart';
import 'package:cooka/providers/create_recipe_provider.dart';
import 'package:cooka/utils/backend.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/ingredient_provider.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddIngredientsPage extends BreadCrumbPage<CreateRecipeNotifier, Recipe> {
  const AddIngredientsPage({super.key, required super.objectProvider});

  @override
  ConsumerState<AddIngredientsPage> createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState
    extends BreadCrumbPageState<AddIngredientsPage,
    CreateRecipeNotifier, Recipe> {
  final TextEditingController searchController = TextEditingController();
  final List<Ingredient> selectedIngredients = [];
  final List<MeasuredIngredient> measuredIngredients = [];
  Ingredient? currentIngredient;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final recipe = ref.read(widget.objectProvider);

    // Get all ingredients from provider
    final allIngredients = ref.read(ingredientsProvider);

    // Initialize selectedIngredients from ids
    selectedIngredients.addAll(
      allIngredients
          .where((ingredient) => recipe.ingredientIds.contains(ingredient.id)),
    );

    // Initialize measuredIngredients from map values
    measuredIngredients.addAll(recipe.measuredIngredients.values);
  }

  @override
  Widget build(BuildContext context) {
    final filteredIngredients = ref.watch(filteredIngredientProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Ingredients",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Search Bar
          TextField(
            controller: searchController,
            onChanged: (value) {
              ref.read(searchIngredientQueryProvider.notifier).state = value;
            },
            decoration: const InputDecoration(
              labelText: "Search Ingredients",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          // Filtered Ingredients List
          Expanded(
            child: ListView.builder(
              itemCount: filteredIngredients.isEmpty
                  ? 1 // Show "Add New Ingredient" if no results
                  : filteredIngredients.length,
              itemBuilder: (context, index) {
                if (filteredIngredients.isEmpty) {
                  // Show "Add New Ingredient" option
                  return ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text("Add New Ingredient"),
                    onTap: () {
                      _showAddNewIngredientDialog(context);
                    },
                  );
                }

                final ingredient = filteredIngredients[index];
                final isSelected = measuredIngredients
                    .any((measured) => measured.ingredientId == ingredient.id);

                return ListTile(
                  title: Text(ingredient.name),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        measuredIngredients.removeWhere((measured) =>
                            measured.ingredientId == ingredient.id);
                        selectedIngredients
                            .removeWhere((ing) => ing.id == ingredient.id);
                      } else {
                        currentIngredient = ingredient;
                        _showIngredientDetailsDialog(context, ingredient);
                      }
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Selected Ingredients Summary
          if (measuredIngredients.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selected Ingredients:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: measuredIngredients.map((measured) {
                    final ingredient = selectedIngredients
                        .firstWhere((ing) => ing.id == measured.ingredientId);
                    return Chip(
                      label: Text("${ingredient.name}"),
                      onDeleted: () {
                        setState(() {
                          measuredIngredients.remove(measured);
                          selectedIngredients.removeWhere(
                              (ing) => ing.id == measured.ingredientId);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _showIngredientDetailsDialog(
      BuildContext context, Ingredient ingredient) {
    final TextEditingController quantityController = TextEditingController();
    IngredientUnit? selectedUnit; // Track the selected unit

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Details for ${ingredient.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quantity Input
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              // Unit Dropdown
              DropdownButtonFormField<IngredientUnit>(
                value: selectedUnit,
                items: IngredientUnit.values.map((unit) {
                  return DropdownMenuItem<IngredientUnit>(
                    value: unit,
                    child: Text(unit.toString()),
                  );
                }).toList(),
                onChanged: (unit) {
                  setState(() {
                    selectedUnit = unit;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Unit",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (selectedUnit != null) {
                  setState(() {
                    selectedIngredients.add(ingredient);
                    measuredIngredients.add(
                      MeasuredIngredient(
                        ingredientId: ingredient.id,
                        quantity: double.tryParse(quantityController.text) ?? 0,
                        unit: selectedUnit!,
                      ),
                    );
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a unit")),
                  );
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showAddNewIngredientDialog(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: searchController.text); // 1. Autocomplete
    String? imageUrl; // 2. Store network URL

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Ingredient"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Ingredient Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (imageUrl != null)
                    Image.network(
                      imageUrl!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  else
                    const Text(
                      "No image selected",
                      style: TextStyle(color: Colors.grey),
                    ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        // 2. Instantly upload and get the network URL
                        final uploadedUrl = await uploadImageToBackend(
                          File(pickedFile.path),
                          'https://your-backend.com/upload',
                        );
                        if (uploadedUrl.isNotEmpty) {
                          setState(() {
                            imageUrl = uploadedUrl;
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Pick Image"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a name")),
                  );
                  return;
                }

                // Create the ingredient object with the network image URL
                final newIngredient = Ingredient(
                  id: DateTime.now().toString(),
                  name: name,
                  imageUrl: imageUrl ?? '',
                );

                // Insert using backend (adds to dummy if mock)
                final insertedIngredient =
                    await insertIngredientToBackend(newIngredient, mock: true);

                // Update the search query to the new ingredient's name
                ref.read(searchIngredientQueryProvider.notifier).state =
                    insertedIngredient.name;

                // Only add if not already present
                if (!selectedIngredients
                    .any((i) => i.id == insertedIngredient.id)) {
                  setState(() {
                    selectedIngredients.add(insertedIngredient);
                  });
                }

                Navigator.pop(context); // Close the add dialog

                // Immediately open the details dialog for quantity/unit
                _showIngredientDetailsDialog(context, insertedIngredient);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<bool> validate(WidgetRef ref) async {
    if (selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one ingredient')),
      );
      return false;
    }
    return true;
  }

  @override
  Future<void> update(WidgetRef ref) async {
    print("Saving ingredients...");
    final notifier = ref.read(widget.objectProvider.notifier);

    // Save the selected ingredient IDs and measured ingredients to the provider
    notifier.updateIngredients(selectedIngredients.map((i) => i.id).toList());
    notifier.updateMeasuredIngredients(
        {for (var m in measuredIngredients) m.ingredientId: m});
  }
}
