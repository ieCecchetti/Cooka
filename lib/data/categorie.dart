import 'package:cooka/data/icons.dart';
import 'package:cooka/data/constants.dart';
import 'package:cooka/models/meal_category.dart';
import 'package:flutter/material.dart';

// Helper function to create a category with auto-generated color
MealCategory _createCategory(
    String id, String title, String iconKey, Color color) {
  return MealCategory(
    id: id,
    title: title,
    iconCodePoint: mealCategoryIcons[iconKey]?.codePoint ??
        mealCategoryIcons['Desserts']!.codePoint,
    color: color,
  );
}

// Tipologia di piatti
final List<MealCategory> _tipologiaPiatti = [
  _createCategory('tp1', 'Antipasti', 'Antipasti', Colors.amber),
  _createCategory('tp2', 'Primi piatti', 'Primi piatti', Colors.orange),
  _createCategory('tp3', 'Secondi piatti', 'Secondi piatti', Colors.redAccent),
  _createCategory('tp4', 'Contorni', 'Contorni', Colors.green),
  _createCategory('tp5', 'Dolci', 'Desserts', Colors.pink),
  _createCategory(
      'tp6', 'Snack & street food', 'Snack & street food', Colors.deepPurple),
  _createCategory('tp7', 'Pasta', 'Pasta', Colors.yellow.shade700),
  _createCategory('tp8', 'Pizza', 'Pizza', Colors.red.shade600),
  _createCategory('tp9', 'Pesce', 'Pesce', Colors.blue),
  _createCategory('tp10', 'Carne', 'Carne', Colors.red.shade800),
  _createCategory('tp11', 'Pollo', 'Pollo', Colors.orange.shade700),
  _createCategory(
      'tp12', 'Pesce e frutti di mare', 'Pesce e frutti di mare', Colors.cyan),
  _createCategory('tp13', 'Hamburger', 'Hamburger', Colors.brown),
  _createCategory('tp14', 'Panificati', 'Panificati', Colors.amber.shade800),
  _createCategory('tp15', 'Zuppe', 'Zuppe', Colors.orange.shade300),
  _createCategory('tp16', 'Insalate', 'Insalate', Colors.green.shade400),
  _createCategory('tp17', 'Riso', 'Riso', Colors.white70),
];

// Cucine del mondo
final List<MealCategory> _cucineMondo = [
  _createCategory(
      'cm1', 'Cucina italiana', 'Cucina italiana', Colors.green.shade700),
  _createCategory(
      'cm2', 'Cucina francese', 'Cucina francese', Colors.blue.shade700),
  _createCategory(
      'cm3', 'Cucina asiatica', 'Cucina asiatica', Colors.red.shade700),
  _createCategory(
      'cm4', 'Cucina mediterranea', 'Cucina mediterranea', Colors.cyan),
  _createCategory(
      'cm5', 'Cucina americana', 'Cucina americana', Colors.blueAccent),
  _createCategory('cm6', 'Cucina vegetariana / vegana',
      'Cucina vegetariana / vegana', Colors.lightGreen),
];

// Tempo di preparazione
final List<MealCategory> _tempoPreparazione = [
  _createCategory(
      'tdp1', 'Ricette veloci (≤ 15 min)', 'Ricette veloci', Colors.lightGreen),
  _createCategory('tdp2', 'Ricette facili', 'Ricette facili', Colors.green),
  _createCategory('tdp3', 'Ricette per tutti i giorni',
      'Ricette per tutti i giorni', Colors.blue),
  _createCategory(
      'tdp4', 'Ricette elaborate', 'Ricette elaborate', Colors.deepPurple),
];

// Stili alimentari
final List<MealCategory> _stiliAlimentari = [
  _createCategory('sa1', 'Vegetariano', 'Vegetarian', Colors.green),
  _createCategory('sa2', 'Vegano', 'Vegan', Colors.lightGreen),
  _createCategory('sa3', 'Senza glutine', 'Senza glutine', Colors.amber),
  _createCategory(
      'sa4', 'Senza lattosio', 'Senza lattosio', Colors.blue.shade300),
  _createCategory('sa5', 'Low carb', 'Low carb', Colors.purple),
  _createCategory('sa6', 'Proteico', 'Proteico', Colors.red),
];

// Metodo di cottura
final List<MealCategory> _metodoCottura = [
  _createCategory('mc1', 'Al forno', 'Al forno', Colors.orange),
  _createCategory('mc2', 'In padella', 'In padella', Colors.amber.shade700),
  _createCategory('mc3', 'A vapore', 'A vapore', Colors.cyan),
  _createCategory('mc4', 'Alla griglia', 'Alla griglia', Colors.red.shade700),
  _createCategory(
      'mc5', 'Senza cottura', 'Senza cottura', Colors.blue.shade300),
];

// Occasioni
final List<MealCategory> _occasioni = [
  _createCategory('oc1', 'Colazione', 'Colazione', Colors.yellow.shade700),
  _createCategory('oc2', 'Pranzo', 'Pranzo', Colors.orange),
  _createCategory('oc3', 'Cena', 'Cena', Colors.indigo),
  _createCategory('oc4', 'Aperitivo', 'Aperitivo', Colors.purple),
  _createCategory(
      'oc5', 'Feste e ricorrenze', 'Feste e ricorrenze', Colors.pink),
  _createCategory('oc6', 'Meal prep', 'Meal prep', Colors.teal),
];

// Target
final List<MealCategory> _target = [
  _createCategory('tg1', 'Ricette per bambini', 'Ricette per bambini',
      Colors.pink.shade300),
  _createCategory('tg2', 'Ricette light', 'Ricette light', Colors.lightGreen),
  _createCategory(
      'tg3', 'Ricette tradizionali', 'Ricette tradizionali', Colors.brown),
  _createCategory(
      'tg4', 'Ricette gourmet', 'Ricette gourmet', Colors.amber.shade700),
];

// Extra utili
final List<MealCategory> _extraUtili = [
  _createCategory('eu1', 'Ricette con pochi ingredienti',
      'Ricette con pochi ingredienti', Colors.grey),
  _createCategory('eu2', 'Ricette anti-spreco', 'Ricette anti-spreco',
      Colors.green.shade700),
  _createCategory('eu3', 'Ricette di stagione', 'Ricette di stagione',
      Colors.orange.shade700),
  _createCategory(
      'eu4', 'Ricette economiche', 'Ricette economiche', Colors.blue.shade600),
];

// Macro categorie
final List<MacroCategory> dummyMacroCategories = [
  MacroCategory(
    id: 'macro1',
    title: 'Tipologia di piatti',
    emoji: '🍽️',
    categories: _tipologiaPiatti,
  ),
  MacroCategory(
    id: 'macro2',
    title: 'Cucine del mondo',
    emoji: '🌍',
    categories: _cucineMondo,
  ),
  MacroCategory(
    id: 'macro3',
    title: 'Tempo di preparazione',
    emoji: '⏱️',
    categories: _tempoPreparazione,
  ),
  MacroCategory(
    id: 'macro4',
    title: 'Stili alimentari',
    emoji: '🥗',
    categories: _stiliAlimentari,
  ),
  MacroCategory(
    id: 'macro5',
    title: 'Metodo di cottura',
    emoji: '🍳',
    categories: _metodoCottura,
  ),
  MacroCategory(
    id: 'macro6',
    title: 'Occasioni',
    emoji: '🎯',
    categories: _occasioni,
  ),
  MacroCategory(
    id: 'macro7',
    title: 'Target',
    emoji: '👶👵',
    categories: _target,
  ),
  MacroCategory(
    id: 'macro8',
    title: 'Extra utili',
    emoji: '⭐',
    categories: _extraUtili,
  ),
];

// Flat list of all categories for backward compatibility
final List<MealCategory> dummyCategories = [
  ..._tipologiaPiatti,
  ..._cucineMondo,
  ..._tempoPreparazione,
  ..._stiliAlimentari,
  ..._metodoCottura,
  ..._occasioni,
  ..._target,
  ..._extraUtili,
];

