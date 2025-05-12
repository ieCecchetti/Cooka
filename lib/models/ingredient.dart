class Ingredient {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final String imageUrl;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.imageUrl,
  });

  @override
  String toString() {
    return '[$id] $quantity $unit of $name';
  }
}