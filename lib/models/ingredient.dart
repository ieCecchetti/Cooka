class Ingredient {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;

  Ingredient({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
  });

  @override
  String toString() {
    return '[$id]: $name';
  }
}