import 'package:cooka/models/ingredient.dart';
import 'package:cooka/models/measured_ingredient.dart';
import 'package:cooka/models/prep_step.dart';
import 'package:cooka/models/meal_category.dart';
import 'package:cooka/data/difficulty.dart';
import 'package:uuid/uuid.dart';

class Recipe {
  String id;
  int authorId;
  int prepTime;
  Difficulty difficulty;
  int servings;
  List<MealCategory> category;
  String name;
  String description;
  List<String> imagesUrl;
  List<String> ingredientIds;
  Map<String, MeasuredIngredient> measuredIngredients;
  List<PrepStep> steps;
  DateTime lastUpdated;

  // Main constructor
  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.authorId,
    required this.prepTime,
    required this.difficulty,
    required this.servings,
    required this.category,
    required this.imagesUrl,
    required this.ingredientIds,
    required this.measuredIngredients,
    required this.steps,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  // Empty constructor
  Recipe.empty()
      : id = const Uuid().v4(),
        authorId = 0,
        prepTime = 0,
        difficulty = Difficulty.easy,
        servings = 0,
        category = [],
        name = '',
        description = '',
        imagesUrl = [''],
        ingredientIds = [],
        measuredIngredients = {},
        steps = [],
        lastUpdated = DateTime.now();

  // Setters
  set setId(String value) => id = value;
  set setAuthorId(int value) => authorId = value;
  set setPrepTime(int value) => prepTime = value;
  set setDifficulty(Difficulty value) => difficulty = value;
  set setServings(int value) => servings = value;
  set setCategory(List<MealCategory> value) => category = value;
  set setName(String value) => name = value;
  set setDescription(String value) => description = value;
  set setImageUrl(List<String> value) => imagesUrl = value;
  set setIngredients(List<String> value) => ingredientIds = value;
  set setMeasuredIngredients(Map<String, MeasuredIngredient> value) =>
      measuredIngredients = value;
  set setSteps(List<PrepStep> value) => steps = value;
  set setLastUpdated(DateTime value) => lastUpdated = value;

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, description: $description, imageUrl: $imagesUrl, ingredients: $ingredientIds, steps: $steps}';
  }


}
