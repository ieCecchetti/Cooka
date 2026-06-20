import 'package:cooka/models/meal_category.dart';

// general
String appName = 'Cooka';
String appDescription = 'Share your dirtiest cooking tricks!';

class MacroCategory {
  final String id;
  final String title;
  final String emoji;
  final List<MealCategory> categories;

  MacroCategory({
    required this.id,
    required this.title,
    required this.emoji,
    required this.categories,
  });
}
