#!/usr/bin/env python3
"""
Script per arricchire il JSON degli ingredienti con dati da Open Food Facts.
Aggiunge immagini e valori nutrizionali.
"""

import json
import requests
import time
import random
from typing import Optional, Dict, Any

# Rate limiting: Open Food Facts consiglia max 1 richiesta al secondo
REQUEST_DELAY = 1.5  # secondi tra una richiesta e l'altra (aumentato per evitare timeout)

def search_openfoodfacts(ingredient_name: str, max_retries: int = 3) -> Optional[Dict[str, Any]]:
    """
    Cerca un ingrediente su Open Food Facts e restituisce i dati del primo risultato.
    Implementa retry con backoff esponenziale per gestire timeout e errori di rete.
    """
    
    for attempt in range(max_retries):
        try:
            # API di Open Food Facts per la ricerca
            url = "https://it.openfoodfacts.org/cgi/search.pl"
            params = {
                'search_terms': ingredient_name,
                'search_simple': 1,
                'action': 'process',
                'json': 1,
                'page_size': 1,  # Prendiamo solo il primo risultato
            }
            
            # Timeout più lungo e aumenta con i retry
            timeout = 20 + (attempt * 10)  # 20s, 30s, 40s
            
            response = requests.get(url, params=params, timeout=timeout)
            response.raise_for_status()
            
            data = response.json()
            
            if data.get('products') and len(data['products']) > 0:
                product = data['products'][0]
                return product
            
            return None
            
        except requests.exceptions.Timeout:
            if attempt < max_retries - 1:
                wait_time = (2 ** attempt) + random.uniform(0, 1)  # Backoff esponenziale con jitter
                print(f"  ⏳ Timeout, riprovo tra {wait_time:.1f}s...", end=" ", flush=True)
                time.sleep(wait_time)
            else:
                print(f"  ⚠️  Timeout dopo {max_retries} tentativi")
                return None
                
        except requests.exceptions.RequestException as e:
            if attempt < max_retries - 1:
                wait_time = (2 ** attempt) + random.uniform(0, 1)
                print(f"  ⏳ Errore di rete, riprovo tra {wait_time:.1f}s...", end=" ", flush=True)
                time.sleep(wait_time)
            else:
                print(f"  ⚠️  Errore dopo {max_retries} tentativi: {type(e).__name__}")
                return None
                
        except Exception as e:
            print(f"  ⚠️  Errore imprevisto: {e}")
            return None
    
    return None

def extract_nutritional_data(product: Dict[str, Any]) -> Dict[str, Any]:
    """
    Estrae i dati nutrizionali da un prodotto Open Food Facts.
    I valori sono per 100g.
    """
    nutriments = product.get('nutriments', {})
    
    return {
        'calories': nutriments.get('energy-kcal_100g') or nutriments.get('energy-kcal'),
        'proteins': nutriments.get('proteins_100g') or nutriments.get('proteins'),
        'fats': nutriments.get('fat_100g') or nutriments.get('fat'),
        'carbohydrates': nutriments.get('carbohydrates_100g') or nutriments.get('carbohydrates'),
        'fiber': nutriments.get('fiber_100g') or nutriments.get('fiber'),
        'sugars': nutriments.get('sugars_100g') or nutriments.get('sugars'),
        'salt': nutriments.get('salt_100g') or nutriments.get('salt'),
    }

def get_image_url(product: Dict[str, Any]) -> str:
    """
    Estrae l'URL dell'immagine del prodotto.
    """
    # Open Food Facts fornisce URL delle immagini in vari formati
    image_url = product.get('image_url') or product.get('image_front_url') or product.get('image_small_url')
    
    if image_url:
        return image_url
    
    # Se non c'è un URL diretto, costruiamo l'URL dall'immagine ID
    image_id = product.get('image_front_id') or product.get('image_id')
    code = product.get('code')
    
    if image_id and code:
        return f"https://images.openfoodfacts.org/images/products/{code}/{image_id}.jpg"
    
    return ""

def enrich_ingredient(ingredient: Dict[str, Any], index: int, total: int) -> Dict[str, Any]:
    """
    Arricchisce un singolo ingrediente con dati da Open Food Facts.
    """
    name = ingredient['name']
    print(f"[{index}/{total}] Cercando: {name}...", end=" ", flush=True)
    
    product = search_openfoodfacts(name)
    
    if product:
        # Estrai dati nutrizionali
        nutritional = extract_nutritional_data(product)
        
        # Estrai immagine
        image_url = get_image_url(product)
        
        # Aggiorna l'ingrediente
        ingredient['imageUrl'] = image_url if image_url else ingredient.get('imageUrl', '')
        
        # Aggiungi dati nutrizionali solo se presenti
        if any(nutritional.values()):
            ingredient.update({k: v for k, v in nutritional.items() if v is not None})
            print(f"✅ Trovato (immagine: {'sì' if image_url else 'no'}, nutrienti: {'sì' if any(nutritional.values()) else 'no'})")
        else:
            print(f"✅ Trovato (solo immagine: {'sì' if image_url else 'no'})")
    else:
        print("❌ Non trovato")
        # Delay extra dopo un fallimento per non sovraccaricare il server
        time.sleep(REQUEST_DELAY * 0.5)
    
    # Rate limiting
    time.sleep(REQUEST_DELAY)
    
    return ingredient

def enrich_ingredients_json(input_file: str, output_file: str, limit: Optional[int] = None):
    """
    Arricchisce il JSON degli ingredienti con dati da Open Food Facts.
    
    Args:
        input_file: Path del file JSON di input
        output_file: Path del file JSON di output
        limit: Numero massimo di ingredienti da processare (None = tutti)
    """
    print(f"📖 Caricando ingredienti da {input_file}...")
    
    with open(input_file, 'r', encoding='utf-8') as f:
        ingredients = json.load(f)
    
    if limit:
        ingredients = ingredients[:limit]
        print(f"⚠️  Limitato a {limit} ingredienti per test")
    
    total = len(ingredients)
    print(f"📊 Trovati {total} ingredienti da arricchire\n")
    
    enriched = []
    for idx, ingredient in enumerate(ingredients, start=1):
        enriched_ingredient = enrich_ingredient(ingredient, idx, total)
        enriched.append(enriched_ingredient)
    
    print(f"\n💾 Salvando in {output_file}...")
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(enriched, f, ensure_ascii=False, indent=2)
    
    # Statistiche
    with_images = sum(1 for ing in enriched if ing.get('imageUrl'))
    with_nutrition = sum(1 for ing in enriched if any([
        ing.get('calories'), ing.get('proteins'), ing.get('fats'),
        ing.get('carbohydrates'), ing.get('fiber'), ing.get('sugars'), ing.get('salt')
    ]))
    
    print(f"\n✨ Completato!")
    print(f"   📸 Ingredienti con immagini: {with_images}/{total} ({with_images*100//total}%)")
    print(f"   🥗 Ingredienti con dati nutrizionali: {with_nutrition}/{total} ({with_nutrition*100//total}%)")

if __name__ == '__main__':
    import sys
    import os
    
    # Ottieni il percorso assoluto dello script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(script_dir)
    
    input_file = os.path.join(project_root, 'lib', 'data', 'ingredienti.json')
    output_file = os.path.join(project_root, 'lib', 'data', 'ingredienti.json')
    
    # Opzionale: limit per testare con pochi ingredienti
    limit = None
    if len(sys.argv) > 1:
        try:
            limit = int(sys.argv[1])
        except ValueError:
            pass
    
    if limit:
        print(f"⚠️  Modalità test: processerò solo i primi {limit} ingredienti\n")
    
    enrich_ingredients_json(input_file, output_file, limit)

