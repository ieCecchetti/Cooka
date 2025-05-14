import 'package:cooka/models/ingredient.dart';
import 'package:cooka/models/prep_step.dart';
import 'package:cooka/models/meal_category.dart';
import 'package:cooka/data/difficulty.dart';

class Recipe {
  String id;
  int authorId;
  int prepTime;
  Difficulty difficulty;
  int servings; // The number of servings the recipe is designed to make.

  List<MealCategory> category;
  String name;
  String description;
  String imageUrl;

  List<Ingredient> ingredients; // A list of all ingredients used in the recipe.
  Map<String, dynamic>
      measuredIngredients; // A list of ingredients with their quantities and units.
  List<PrepStep> steps;

  DateTime lastUpdated; // The last update timestamp for the recipe.

  Recipe({
    // general
    required this.id,
    required this.authorId,
    required this.prepTime,
    required this.difficulty,
    required this.servings,
    // dish
    required this.category,
    required this.name,
    required this.description,
    required this.imageUrl,
    // deep dive
    required this.ingredients,
    required this.measuredIngredients,
    required this.steps,

    // optional
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, description: $description, imageUrl: $imageUrl, ingredients: $ingredients, steps: $steps}';
  }
}
