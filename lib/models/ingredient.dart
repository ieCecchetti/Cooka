class Ingredient {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;
  
  // Dati nutrizionali (per 100g)
  final double? calories; // kcal
  final double? proteins; // g
  final double? fats; // g
  final double? carbohydrates; // g
  final double? fiber; // g
  final double? sugars; // g
  final double? salt; // g

  Ingredient({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    this.calories,
    this.proteins,
    this.fats,
    this.carbohydrates,
    this.fiber,
    this.sugars,
    this.salt,
  });

  // Convert from JSON
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String,
      calories: json['calories'] != null ? (json['calories'] as num).toDouble() : null,
      proteins: json['proteins'] != null ? (json['proteins'] as num).toDouble() : null,
      fats: json['fats'] != null ? (json['fats'] as num).toDouble() : null,
      carbohydrates: json['carbohydrates'] != null ? (json['carbohydrates'] as num).toDouble() : null,
      fiber: json['fiber'] != null ? (json['fiber'] as num).toDouble() : null,
      sugars: json['sugars'] != null ? (json['sugars'] as num).toDouble() : null,
      salt: json['salt'] != null ? (json['salt'] as num).toDouble() : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'calories': calories,
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'fiber': fiber,
      'sugars': sugars,
      'salt': salt,
    };
  }

  @override
  String toString() {
    return '[$id]: $name';
  }
}