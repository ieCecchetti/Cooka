import 'package:flutter/material.dart';
import 'package:cooka/data/icons.dart';

class MealCategory {
  final String id;
  final String title;
  final int iconCodePoint;
  final Color color;

  // Constructor with a fixed fontFamily value
  MealCategory({
    required this.id,
    required this.title,
    required this.iconCodePoint,
    required this.color,
  });

  @override
  String toString() {
    return 'TransactionCategory{id: $id, title: $title, iconCodePoint: $iconCodePoint, color: $color}';
  }

  // Convert a TransactionCategory into a Map
  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'iconCodePoint': iconCodePoint,
      'color': color.value,
    };
  }

  // Convert a Map into a TransactionCategory
  factory MealCategory.fromMap(Map<String, Object?> map) {
    return MealCategory(
      id: map['id'] as String,
      title: map['title'] as String,
      iconCodePoint: map['iconCodePoint'] as int,
      color: Color(map['color'] as int),
    );
  }

  // Get the IconData by rebuilding it from the code point and font family
  IconData get icon {
    return getIconByCodePoint(iconCodePoint);
  }
}
