class IngredientUnit {
  final String name;
  final String abbreviation;

  const IngredientUnit._(this.name, this.abbreviation);

  static const IngredientUnit grams = IngredientUnit._('Grams', 'g');
  static const IngredientUnit kilograms = IngredientUnit._('Kilograms', 'kg');
  static const IngredientUnit liters = IngredientUnit._('Liters', 'l');
  static const IngredientUnit milliliters = IngredientUnit._('Milliliters', 'ml');
  static const IngredientUnit teaspoons = IngredientUnit._('Teaspoons', 'tsp');
  static const IngredientUnit tablespoons = IngredientUnit._('Tablespoons', 'tbsp');
  static const IngredientUnit cups = IngredientUnit._('Cups', 'cup');
  static const IngredientUnit pieces = IngredientUnit._('Pieces', 'pcs');
  static const IngredientUnit unit = IngredientUnit._('Units', 'unit');
  static const IngredientUnit pinch = IngredientUnit._('Pinches', 'pinch');

  static const List<IngredientUnit> values = [
    grams,
    kilograms,
    liters,
    milliliters,
    teaspoons,
    tablespoons,
    cups,
    pieces,
  ];

  @override
  String toString() => '$name ($abbreviation)';
}