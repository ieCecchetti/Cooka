import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/category_provider.dart';


class AddCategoriesPage extends ConsumerStatefulWidget {
  const AddCategoriesPage({super.key});

  @override
  ConsumerState<AddCategoriesPage> createState() => _AddIngredientsPageState();
}

class _AddIngredientsPageState extends ConsumerState<AddCategoriesPage> {
  final List<String> selectedCategories = [];

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
}

