
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final Map<String, IconData> mealCategoryIcons = {
  "Breakfast": FontAwesomeIcons.egg,
  "Lunch": FontAwesomeIcons.burger,
  "Dinner": FontAwesomeIcons.utensils, 
  "Snacks": FontAwesomeIcons.cookie, 
  "Desserts": FontAwesomeIcons.iceCream, 
  "Drinks": FontAwesomeIcons.mugHot,
  "Vegetarian": FontAwesomeIcons.carrot, 
  "Vegan": FontAwesomeIcons.leaf, 
  "Seafood": FontAwesomeIcons.fish, 
  "Pasta": FontAwesomeIcons.bowlFood, 
  "Pizza": FontAwesomeIcons.pizzaSlice, 
  "Grill/BBQ": FontAwesomeIcons.fireBurner, 
  "Salads": FontAwesomeIcons.seedling, 
  "Soups": FontAwesomeIcons.bowlRice, 
  "Baking": FontAwesomeIcons.breadSlice, 
  "Fast Food": FontAwesomeIcons.hotdog, 
  "Asian": FontAwesomeIcons.shrimp,
  "Mexican": FontAwesomeIcons.pepperHot, 
  "Healthy": FontAwesomeIcons.appleWhole,
  "Kids": FontAwesomeIcons.candyCane,
  "Meat": FontAwesomeIcons.drumstickBite,
};


/// Function to get IconData by integer (codePoint)
IconData getIconByCodePoint(int iconCodePoint) {
  for (var icon in mealCategoryIcons.values) {
    if (icon.codePoint == iconCodePoint) {
      return icon;
    }
  }
  throw ArgumentError("No IconData found for codePoint: $iconCodePoint");
}
