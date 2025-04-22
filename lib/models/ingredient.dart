class Ingredient {
  final String id;
  final String name;
  final double quantity;
  final String unit;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  @override
  String toString() {
    return '[$id] $quantity $unit of $name';
  }
}