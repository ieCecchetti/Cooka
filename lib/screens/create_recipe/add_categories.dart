import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cooka/models/recipe.dart';
import 'package:cooka/providers/create_recipe_provider.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/category_provider.dart';
import 'package:cooka/data/categorie.dart';


class AddCategoriesPage extends BreadCrumbPage<CreateRecipeNotifier, Recipe> {
  const AddCategoriesPage({super.key, required super.objectProvider});

  @override
  ConsumerState<AddCategoriesPage> createState() => _AddCategoriesPageState();
}

class _AddCategoriesPageState
    extends BreadCrumbPageState<AddCategoriesPage, CreateRecipeNotifier, Recipe> {
  final List<String> selectedCategories = [];
  final Map<String, bool> _expandedMacroCategories = {};

  @override
  void initState() {
    super.initState();
    final recipe = ref.read(widget.objectProvider);

    selectedCategories.addAll(recipe.category.map((cat) => cat.title));
    
    // Initialize all macro categories as collapsed
    for (var macro in dummyMacroCategories) {
      _expandedMacroCategories[macro.id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: const [
              Text(
                "Select Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: dummyMacroCategories.map((macroCategory) {
                  final isExpanded =
                      _expandedMacroCategories[macroCategory.id] ?? false;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      leading: Text(
                        macroCategory.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(
                        macroCategory.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      initiallyExpanded: isExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _expandedMacroCategories[macroCategory.id] = expanded;
                        });
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide.none,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: macroCategory.categories.map((category) {
                              final isSelected =
                                  selectedCategories.contains(category.title);
                              return FilterChip(
                                avatar: CircleAvatar(
                                  backgroundColor:
                                      category.color.withOpacity(0.2),
                                  child: FaIcon(
                                    category.icon,
                                    size: 16,
                                    color: category.color,
                                  ),
                                ),
                                label: Text(category.title),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedCategories.add(category.title);
                                    } else {
                                      selectedCategories.remove(category.title);
                                    }
                                  });
                                },
                                selectedColor: category.color.withOpacity(0.2),
                                backgroundColor: Colors.grey.withOpacity(0.1),
                                checkmarkColor: category.color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: isSelected
                                        ? category.color
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
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

