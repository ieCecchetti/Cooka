#!/usr/bin/env python3
"""
Script per estrarre ingredienti unici dal CSV di GialloZafferano
e generare un file Dart con gli ingredienti.
"""

import csv
import ast
import re
import urllib.parse
from collections import OrderedDict

def extract_ingredients_from_csv(csv_file_path):
    """Estrae tutti gli ingredienti unici dal CSV."""
    ingredients_set = OrderedDict()  # Usa OrderedDict per mantenere l'ordine
    
    with open(csv_file_path, 'r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        
        for row in reader:
            ingredients_str = row.get('Ingredienti', '')
            if not ingredients_str:
                continue
            
            try:
                # Prova a parsare come lista Python
                ingredients_list = ast.literal_eval(ingredients_str)
                
                for ingredient_data in ingredients_list:
                    if isinstance(ingredient_data, list) and len(ingredient_data) >= 1:
                        ingredient_name = ingredient_data[0].strip()
                        if ingredient_name and ingredient_name not in ingredients_set:
                            # Usa il nome dell'ingrediente come chiave
                            ingredients_set[ingredient_name] = {
                                'name': ingredient_name,
                                'id': None  # Verrà generato dopo
                            }
            except (ValueError, SyntaxError):
                # Se il parsing fallisce, prova con regex
                # Pattern per trovare nomi di ingredienti tra virgolette
                matches = re.findall(r"['\"]([^'\"]+)['\"]", ingredients_str)
                for match in matches:
                    if match.strip() and match.strip() not in ingredients_set:
                        ingredients_set[match.strip()] = {
                            'name': match.strip(),
                            'id': None
                        }
    
    return list(ingredients_set.values())

def escape_dart_string(s):
    """Escape una stringa per Dart."""
    # Sostituisce apostrofi e caratteri speciali
    s = s.replace('\\', '\\\\')  # Escape backslash per primo
    s = s.replace("'", "\\'")    # Escape apostrofi
    s = s.replace('\n', '\\n')   # Escape newline
    s = s.replace('\r', '\\r')   # Escape carriage return
    s = s.replace('\t', '\\t')   # Escape tab
    return s

def get_ingredient_image_url(ingredient_name):
    """Genera un URL immagine basato sul nome dell'ingrediente."""
    # Mappa ingredienti comuni a URL di immagini reali
    ingredient_image_map = {
        # Latticini
        'Mascarpone': 'https://images.unsplash.com/photo-1618164436264-4471c882e0e9?w=400',
        'Parmigiano Reggiano DOP': 'https://images.unsplash.com/photo-1618164436264-4471c882e0e9?w=400',
        'Pecorino romano': 'https://images.unsplash.com/photo-1618164436264-4471c882e0e9?w=400',
        'Mozzarella': 'https://images.unsplash.com/photo-1618164436264-4471c882e0e9?w=400',
        'Burro': 'https://images.unsplash.com/photo-1589985270826-4b7fe135a37c?w=400',
        'Latte': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400',
        'Panna': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400',
        # Uova
        'Uova': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=400',
        'Tuorli': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=400',
        'Albumi': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=400',
        # Farine e cereali
        'Farina': 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400',
        'Farina 00': 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400',
        'Farina Manitoba': 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400',
        'Riso': 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
        'Arborio rice': 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
        'Pasta': 'https://images.unsplash.com/photo-1551462147-6e923d2a2a0a?w=400',
        'Spaghetti': 'https://images.unsplash.com/photo-1551462147-6e923d2a2a0a?w=400',
        # Zuccheri e dolcificanti
        'Zucchero': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400',
        'Zucchero di canna': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400',
        'Zucchero a velo': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400',
        'Miele': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400',
        # Oli e grassi
        'Olio extravergine d\'oliva': 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400',
        'Olio': 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400',
        'Olio di semi': 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400',
        # Verdure
        'Pomodori': 'https://images.unsplash.com/photo-1546470427-e26264be0d91?w=400',
        'Pomodori pelati': 'https://images.unsplash.com/photo-1546470427-e26264be0d91?w=400',
        'Passata di pomodoro': 'https://images.unsplash.com/photo-1546470427-e26264be0d91?w=400',
        'Cipolle': 'https://images.unsplash.com/photo-1518977822534-7049a61ee0c2?w=400',
        'Aglio': 'https://images.unsplash.com/photo-1518977822534-7049a61ee0c2?w=400',
        'Carote': 'https://images.unsplash.com/photo-1445282768818-728615cc910a?w=400',
        'Sedano': 'https://images.unsplash.com/photo-1604977049386-4b1a8c5b5c5e?w=400',
        'Prezzemolo': 'https://images.unsplash.com/photo-1604977049386-4b1a8c5b5c5e?w=400',
        'Basilico': 'https://images.unsplash.com/photo-1604977049386-4b1a8c5b5c5e?w=400',
        'Spinaci': 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400',
        'Insalata': 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400',
        # Carne e pesce
        'Carne': 'https://images.unsplash.com/photo-1603048297172-c92544798d5e?w=400',
        'Manzo': 'https://images.unsplash.com/photo-1603048297172-c92544798d5e?w=400',
        'Pollo': 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=400',
        'Pesce': 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=400',
        'Salmone': 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=400',
        'Vongole': 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=400',
        'Guanciale': 'https://images.unsplash.com/photo-1603048297172-c92544798d5e?w=400',
        'Pancetta': 'https://images.unsplash.com/photo-1603048297172-c92544798d5e?w=400',
        # Altri
        'Caffè': 'https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=400',
        'Cacao': 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400',
        'Cioccolato': 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400',
        'Limone': 'https://images.unsplash.com/photo-1606914469633-bd5c81e3e8a4?w=400',
        'Vino': 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=400',
        'Aceto': 'https://images.unsplash.com/photo-1604977049386-4b1a8c5b5c5e?w=400',
    }
    
    # Cerca corrispondenza esatta
    if ingredient_name in ingredient_image_map:
        return ingredient_image_map[ingredient_name]
    
    # Cerca corrispondenza parziale (case insensitive)
    name_lower = ingredient_name.lower()
    for key, url in ingredient_image_map.items():
        if key.lower() in name_lower or name_lower in key.lower():
            return url
    
    # Se non trova corrispondenza, usa Unsplash Source API con query basata sul nome
    # Unsplash Source API è gratuito e non richiede API key
    query = urllib.parse.quote(ingredient_name.lower())
    return f'https://source.unsplash.com/400x400/?food,{query}'

def generate_json_file(ingredients, output_file_path):
    """Genera un file JSON con gli ingredienti."""
    import json
    
    ingredients_list = []
    for idx, ingredient in enumerate(ingredients, start=1):
        name = ingredient['name']
        
        ingredients_list.append({
            'id': str(idx),
            'name': name,
            'description': None,
            'imageUrl': ''
        })
    
    with open(output_file_path, 'w', encoding='utf-8') as file:
        json.dump(ingredients_list, file, ensure_ascii=False, indent=2)
    
    print(f"✅ Generati {len(ingredients)} ingredienti in {output_file_path}")

if __name__ == '__main__':
    import os
    
    # Ottieni il percorso assoluto dello script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(script_dir)
    
    csv_file = os.path.join(script_dir, 'gz_recipe.csv')
    output_file = os.path.join(project_root, 'lib', 'data', 'ingredienti.json')
    
    print(f"📖 Leggendo ingredienti da {csv_file}...")
    ingredients = extract_ingredients_from_csv(csv_file)
    
    print(f"📝 Generando file JSON {output_file}...")
    generate_json_file(ingredients, output_file)
    
    print(f"\n✨ Completato! Trovati {len(ingredients)} ingredienti unici.")

