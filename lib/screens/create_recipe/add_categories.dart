import 'package:cooka/models/recipe.dart';
import 'package:cooka/providers/create_recipe_provider.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/category_provider.dart';


class AddCategoriesPage extends BreadCrumbPage<CreateRecipeNotifier, Recipe> {
  const AddCategoriesPage({super.key, required super.objectProvider});

  @override
  ConsumerState<AddCategoriesPage> createState() => _AddCategoriesPageState();
}

class _AddCategoriesPageState
    extends BreadCrumbPageState<AddCategoriesPage, CreateRecipeNotifier, Recipe> {
  final List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    final recipe = ref.read(widget.objectProvider);

    selectedCategories.addAll(recipe.category.map((cat) => cat.title));
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).map((category) => category.title).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row to prevent resizing due to the wrap widget
          Row(
            children: const [
              Text(
                "Select Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16), // Ensure consistent spacing
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0, // Horizontal spacing between chips
                runSpacing: 8.0, // Vertical spacing between rows of chips
                children: categories.map((category) {
                  final isSelected = selectedCategories.contains(category);
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                    selectedColor: Colors.blueAccent.withOpacity(0.2),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> validate(WidgetRef ref) async {
    if (selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one category')),
      );
      return false;
    }
    return true;
  }

  @override
  Future<void> update(WidgetRef ref) async {
    print("Saving categories...");
    final notifier = ref.read(widget.objectProvider.notifier);

    // Get all MealCategory objects from the provider
    final allCategories = ref.read(categoriesProvider);

    // Map selected category titles to MealCategory objects
    final selectedMealCategories = allCategories
        .where((cat) => selectedCategories.contains(cat.title))
        .toList();
    
    print("Selected meal categories: $selectedMealCategories");

    notifier.updateCategories(selectedMealCategories);
  }

}

