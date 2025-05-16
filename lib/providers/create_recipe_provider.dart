import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cooka/data/difficulty.dart';

import 'package:cooka/models/meal_category.dart';
import 'package:cooka/models/measured_ingredient.dart';
import 'package:cooka/models/prep_step.dart';
import 'package:cooka/models/recipe.dart';

class CreateRecipeNotifier extends StateNotifier<Recipe> {
  CreateRecipeNotifier() : super(Recipe.empty()) {
    print('RecipeNotifier initialized with: ${state.toString()}');
  }

  void updateName(String name) => state = state..name = name;
  void updateDescription(String description) =>
      state = state..description = description;
  void updateAuthorId(int authorId) =>
      state = state..authorId = authorId;
  void updatePrepTime(int prepTime) => state = state..prepTime = prepTime;
  void updateDifficulty(Difficulty difficulty) =>
      state = state..difficulty = difficulty;
  void updateServings(int servings) => state = state..servings = servings;
  void updateCategories(List<MealCategory> categories) =>
      state = state..category = categories;
  void updateImageUrl(List<String> imageUrl) =>
      state = state..imagesUrl = imageUrl;
  void updateIngredients(List<String> ingredients) =>
      state = state..ingredientIds = ingredients;
  void updateMeasuredIngredients(
          Map<String, MeasuredIngredient> measuredIngredients) =>
      state = state..measuredIngredients = measuredIngredients;
  void updateSteps(List<PrepStep> steps) =>
      state = state..steps = steps;
  void updateLastUpdated(DateTime lastUpdated) =>
      state = state..lastUpdated = lastUpdated;

  bool isRecipeValid() {
    return state.name.isNotEmpty &&
        state.description.isNotEmpty &&
        state.prepTime > 0 &&
        state.servings > 0 &&
        state.category.isNotEmpty &&
        state.imagesUrl.isNotEmpty &&
        state.ingredientIds.isNotEmpty &&
        state.measuredIngredients.isNotEmpty &&
        state.steps.isNotEmpty;
  }

  void resetRecipe() {
    state = Recipe.empty();
  }
}

final createRecipesProvider =
    StateNotifierProvider<CreateRecipeNotifier, Recipe>((ref) {
  return CreateRecipeNotifier();
});
