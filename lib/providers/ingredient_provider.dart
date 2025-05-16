import 'package:cooka/models/ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/data/dummy.dart';


class IngredientNotifier extends StateNotifier<List<Ingredient>> {
  IngredientNotifier() : super([]) {
    _initializeTransactions();
  }


  /// Initialize transactions from the database
  Future<void> _initializeTransactions() async {
    // TODO : Implement the logic to fetch recipes from the database
    final ingredients = dummyIngredients; // Replace with actual database fetching logic
    state = ingredients;
  }

  // Add a new transaction
  void addIngredient(Ingredient ingredient) async {
    // Insert into the database
    // await _dbHelper.insert('financial_record', transaction.toMap());
    state = [...state, ingredient];
  }

  // Remove a transaction
  void removeIngredient(Ingredient ingredient) async {
    // Remove from the database
    // await _dbHelper.delete('financial_record', transaction.id);
    state = state.where((element) => element.id != ingredient.id).toList();
  }

  // Update an existing transaction
  void updateIngredient(Ingredient ingredient) async {
    // Update the transaction in the database
    // await _dbHelper.update('financial_record', transaction.toMap());
    // Update the transaction in the state
    state = state.map((item) => item.id == ingredient.id ? ingredient : item).toList();
  }

  void rebuildIngredient(Ingredient ingredient) {
    // Re-add the item to the state
    state = [...state, ingredient];
  }

  // Refresh (reload) the categories from db (case de-sync with db)
  Future<void> refreshIngredients() async {
    await _initializeTransactions();
  }
}

final ingredientsProvider =
    StateNotifierProvider<IngredientNotifier, List<Ingredient>>((ref) {
  return IngredientNotifier();
});


// Holds search query string
final searchIngredientQueryProvider = StateProvider<String>((ref) => '');

// Filters recipes based on search query
final filteredIngredientProvider = Provider<List<Ingredient>>((ref) {
  final query = ref.watch(searchIngredientQueryProvider).toLowerCase();
  final ingredients = ref.watch(ingredientsProvider);

  if (query.isEmpty) return ingredients;

  return ingredients
      .where((ingredient) => ingredient.name.toLowerCase().contains(query))
      .toList();
});
