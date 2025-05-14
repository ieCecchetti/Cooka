import 'package:cooka/models/ingredient_units.dart';

class MeasuredIngredient {
  final String ingredient;
  final double quantity;
  final IngredientUnit unit;

  MeasuredIngredient({
    required this.ingredient,
    required this.quantity,
    required this.unit,
  });

  @override
  String toString() {
    return '$quantity $unit of $ingredient';
  }
}
