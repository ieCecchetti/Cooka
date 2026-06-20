import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cooka/models/ingredient.dart';

/// Carica gli ingredienti dal file JSON
Future<List<Ingredient>> loadIngredientsFromJson() async {
  try {
    final String jsonString = await rootBundle.loadString('lib/data/ingredienti.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    
    return jsonList.map((json) => Ingredient.fromJson(json as Map<String, dynamic>)).toList();
  } catch (e) {
    print('Errore nel caricamento degli ingredienti: $e');
    return [];
  }
}

