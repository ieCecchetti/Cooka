import 'package:cooka/models/prep_step.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:cooka/models/meal_category.dart';
import 'package:cooka/data/difficulty.dart';

class Recipe {
  String id;
  int authorId;
  int prepTime;
  Difficulty difficulty;
  int servings; // The number of servings the recipe is designed to make.

  MealCategory category;
  String name;
  String shortDescription;
  String description;
  String imageUrl;

  List<Ingredient> ingredients;
  List<PrepStep> steps;

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
    required this.shortDescription,
    required this.description,
    required this.imageUrl,
    // deep dive
    required this.ingredients,
    required this.steps,
  });
  

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, description: $description, imageUrl: $imageUrl, ingredients: $ingredients, steps: $steps}';
  }

}