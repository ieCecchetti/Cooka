import 'package:cooka/models/ingredient_units.dart';
import 'package:cooka/models/measured_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/ingredient_provider.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddIngredientsPage extends ConsumerStatefulWidget {
  const AddIngredientsPage({super.key});

  @override
  ConsumerState<AddIngredientsPage> createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends ConsumerState<AddIngredientsPage> {
  final TextEditingController searchController = TextEditingController();
  final List<Ingredient> selectedIngredients = [];
  final List<MeasuredIngredient> measuredIngredients = [];
  Ingredient? currentIngredient; // Track the ingredient being edited
  final ImagePicker _picker = ImagePicker();

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
              ref.read(searchQueryProvider.notifier).state = value;
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
                final isSelected = selectedIngredients.contains(ingredient);

                return ListTile(
                  title: Text(ingredient.name),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedIngredients.remove(ingredient);
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
          if (selectedIngredients.isNotEmpty)
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
                  children: selectedIngredients.map((ingredient) {
                    return Chip(
                      label: Text(ingredient.name),
                      onDeleted: () {
                        setState(() {
                          measuredIngredients.removeWhere((measured) =>
                              measured.ingredient == ingredient.id);
                          selectedIngredients.remove(ingredient);
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
                        ingredient: ingredient.id,
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
    final TextEditingController nameController = TextEditingController();
    File? selectedImage;

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
                  if (selectedImage != null)
                  Image.file(
                    selectedImage!,
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
                    setState(() {
                      selectedImage = File(pickedFile.path);
                    });
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
              onPressed: () {
                setState(() {
                  final newIngredient = Ingredient(
                    id: DateTime.now().toString(), // Generate a unique ID
                    name: nameController.text,
                    imageUrl: selectedImage?.path ?? '',
                  );
                  selectedIngredients.add(newIngredient);
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
