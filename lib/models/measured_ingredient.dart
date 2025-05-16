import 'package:cooka/models/ingredient_units.dart';

class MeasuredIngredient {
  final String ingredientId;
  final double quantity;
  final IngredientUnit unit;

  MeasuredIngredient({
    required this.ingredientId,
    required this.quantity,
    required this.unit,
  });

  @override
  String toString() {
    return '$quantity $unit of $ingredientId';
  }
}
