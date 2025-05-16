import 'package:cooka/models/recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/data/dummy.dart';


class RecipeNotifier extends StateNotifier<List<Recipe>> {
  RecipeNotifier() : super([]) {
    _initializeTransactions();
  }


  /// Initialize transactions from the database
  Future<void> _initializeTransactions() async {
    print("Initializing transactions");
    // TODO : Implement the logic to fetch recipes from the database
    final recipes = recipeList; // Replace with actual database fetching logic
    state = recipes;
  }

  // Add a new transaction
  void addRecipe(Recipe transaction) async {
    state = [...state, transaction];
  }

  // Remove a transaction
  void removeRecipe(Recipe transaction) async {
    // Remove from the database
    // await _dbHelper.delete('financial_record', transaction.id);
    recipeList.remove(transaction);
    state = state.where((element) => element.id != transaction.id).toList();
  }

  // Update an existing transaction
  void updateRecipe(Recipe transaction) async {
    // Update the transaction in the database
    // await _dbHelper.update('financial_record', transaction.toMap());
    // Update the transaction in the state
    recipeList[recipeList
        .indexWhere((element) => element.id == transaction.id)] = transaction;
    state = state.map((item) => item.id == transaction.id ? transaction : item).toList();
  }

  void rebuildRecipe(Recipe transaction) {
    // Re-add the item to the state
    state = [...state, transaction];
  }

  // Refresh (reload) the categories from db (case de-sync with db)
  Future<void> refreshRecipe() async {
    await _initializeTransactions();
  }
}

final recipesProvider =
    StateNotifierProvider<RecipeNotifier, List<Recipe>>((ref) {
  return RecipeNotifier();
});


// Holds search query string
final searchRecipeQueryProvider = StateProvider<String>((ref) => '');

// Filters recipes based on search query
final filteredRecipesProvider = Provider<List<Recipe>>((ref) {
  final query = ref.watch(searchRecipeQueryProvider).toLowerCase();
  final recipes = ref.watch(recipesProvider);

  if (query.isEmpty) return recipes;

  return recipes
      .where((recipe) => recipe.name.toLowerCase().contains(query))
      .toList();
});
