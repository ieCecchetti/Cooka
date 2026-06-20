
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
  // New icons for categories
  "Antipasti": FontAwesomeIcons.plateWheat,
  "Primi piatti": FontAwesomeIcons.bowlFood,
  "Secondi piatti": FontAwesomeIcons.drumstickBite,
  "Contorni": FontAwesomeIcons.seedling,
  "Snack & street food": FontAwesomeIcons.hotdog,
  "Cucina italiana": FontAwesomeIcons.pizzaSlice,
  "Cucina francese": FontAwesomeIcons.wineGlass,
  "Cucina asiatica": FontAwesomeIcons.shrimp,
  "Cucina mediterranea": FontAwesomeIcons.fish,
  "Cucina americana": FontAwesomeIcons.burger,
  "Cucina vegetariana / vegana": FontAwesomeIcons.leaf,
  "Ricette veloci": FontAwesomeIcons.clock,
  "Ricette facili": FontAwesomeIcons.circleCheck,
  "Ricette per tutti i giorni": FontAwesomeIcons.calendarDay,
  "Ricette elaborate": FontAwesomeIcons.utensils,
  "Senza glutine": FontAwesomeIcons.wheatAwn,
  "Senza lattosio": FontAwesomeIcons.mugHot,
  "Low carb": FontAwesomeIcons.chartLine,
  "Proteico": FontAwesomeIcons.dumbbell,
  "Al forno": FontAwesomeIcons.fire,
  "In padella": FontAwesomeIcons.bowlFood,
  "A vapore": FontAwesomeIcons.cloud,
  "Alla griglia": FontAwesomeIcons.fireBurner,
  "Senza cottura": FontAwesomeIcons.snowflake,
  "Colazione": FontAwesomeIcons.egg,
  "Pranzo": FontAwesomeIcons.sun,
  "Cena": FontAwesomeIcons.moon,
  "Aperitivo": FontAwesomeIcons.wineGlass,
  "Feste e ricorrenze": FontAwesomeIcons.cakeCandles,
  "Meal prep": FontAwesomeIcons.briefcase,
  "Ricette per bambini": FontAwesomeIcons.candyCane,
  "Ricette light": FontAwesomeIcons.appleWhole,
  "Ricette tradizionali": FontAwesomeIcons.book,
  "Ricette gourmet": FontAwesomeIcons.star,
  "Ricette con pochi ingredienti": FontAwesomeIcons.list,
  "Ricette anti-spreco": FontAwesomeIcons.recycle,
  "Ricette di stagione": FontAwesomeIcons.calendar,
  "Ricette economiche": FontAwesomeIcons.coins,
  // Ingredienti/Tipologie specifiche
  "Pesce": FontAwesomeIcons.fish,
  "Carne": FontAwesomeIcons.drumstickBite,
  "Hamburger": FontAwesomeIcons.burger,
  "Panificati": FontAwesomeIcons.breadSlice,
  "Zuppe": FontAwesomeIcons.bowlRice,
  "Insalate": FontAwesomeIcons.seedling,
  "Riso": FontAwesomeIcons.bowlRice,
  "Pollo": FontAwesomeIcons.drumstickBite,
  "Pesce e frutti di mare": FontAwesomeIcons.fish,
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
