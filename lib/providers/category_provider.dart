import 'package:cooka/models/meal_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/data/dummy.dart';


class CategoryNotifier extends StateNotifier<List<MealCategory>> {
  CategoryNotifier() : super([]) {
    _initializeTransactions();
  }


  /// Initialize transactions from the database
  Future<void> _initializeTransactions() async {
    // TODO : Implement the logic to fetch recipes from the database
    final meals_categories = dummyCategories; // Replace with actual database fetching logic
    state = meals_categories;
  }

  // Add a new transaction
  void addCategory(MealCategory category) async {
    // Insert into the database
    // await _dbHelper.insert('financial_record', transaction.toMap());
    state = [...state, category];
  }

  // Remove a transaction
  void removeIngredient(MealCategory category) async {
    // Remove from the database
    // await _dbHelper.delete('financial_record', transaction.id);
    state = state.where((element) => element.id != category.id).toList();
  }

  // Update an existing transaction
  void updateIngredient(MealCategory category) async {
    // Update the transaction in the database
    // await _dbHelper.update('financial_record', transaction.toMap());
    // Update the transaction in the state
    state = state.map((item) => item.id == category.id ? category : item).toList();
  }
}

final recipesProvider =
    StateNotifierProvider<CategoryNotifier, List<MealCategory>>((ref) {
  return CategoryNotifier();
});


// Holds search query string
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filters recipes based on search query
final filteredCategoriesProvider = Provider<List<MealCategory>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final categories = ref.watch(recipesProvider);

  if (query.isEmpty) return categories;

  return categories
      .where((category) => category.title.toLowerCase().contains(query))
      .toList();
});
