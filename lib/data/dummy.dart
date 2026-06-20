import 'package:cooka/data/difficulty.dart';
import 'package:cooka/data/categorie.dart';
import 'package:cooka/models/ingredient_units.dart';
import 'package:cooka/models/measured_ingredient.dart';

import 'package:cooka/models/user.dart';
import 'package:cooka/models/prep_step.dart';
import 'package:cooka/models/recipe.dart';

final dummyUser = [
  User(id: '1', name: 'John Doe', email: 'johndoe@example.com'),
  User(
    id: '2',
    name: 'Jane Smith',
    email: 'janesmith@example.com',
  ),
];

final Map<String, Map<String, dynamic>> measuredIngredients = {
  '1': {'quantity': 2, 'unit': 'pieces'},
  '2': {'quantity': 1, 'unit': 'cup'},
  '3': {'quantity': 2, 'unit': 'cups'},
  '4': {'quantity': 1, 'unit': 'cup'},
  '5': {'quantity': 1, 'unit': 'cup'},
  '6': {'quantity': 1, 'unit': 'pinch'},
  '7': {'quantity': 4, 'unit': 'cups'},
  '8': {'quantity': 0.5, 'unit': 'cup'},
  '9': {'quantity': 2, 'unit': 'tablespoons'},
  '10': {'quantity': 1, 'unit': 'small'},
  '11': {'quantity': 1, 'unit': 'ball'},
  '12': {'quantity': 0.5, 'unit': 'cup'},
  '13': {'quantity': 1, 'unit': 'cup'},
  '14': {'quantity': 5, 'unit': 'pieces'},
  '15': {'quantity': 1, 'unit': 'tablespoon'},
};

final recipeList = [
  Recipe(
    id: '1',
    authorId: 1,
    prepTime: 30,
    difficulty: Difficulty.easy,
    servings: 4,
    category: [dummyCategories[4]],
    name: 'Pancakes',
    description: 'Fluffy pancakes for breakfast',
    imagesUrl:
        [
      'https://d2sj0xby2hzqoy.cloudfront.net/kenwood_italy/attachments/data/000/008/235/original/pancake-americani.JPG'
    ],
    ingredientIds: [
      '2', // Uova
      '13', // Latte intero
      '7', // Farina 00
      '4', // Zucchero
    ],
    measuredIngredients: {
      '1': MeasuredIngredient(
        ingredientId: '2', // Uova
        quantity: 2,
        unit: IngredientUnit.pieces,
      ),
      '2': MeasuredIngredient(
        ingredientId: '13', // Latte intero
        quantity: 100,
        unit: IngredientUnit.milliliters,
      ),
      '3': MeasuredIngredient(
        ingredientId: '7', // Farina 00
        quantity: 2,
        unit: IngredientUnit.cups,
      ),
      '4': MeasuredIngredient(
        ingredientId: '4', // Zucchero
        quantity: 1,
        unit: IngredientUnit.cups,
      ),
    },
    steps: [
      PrepStep(
        id: 1,
        title: 'Mix Ingredients',
        description: 'Mix all ingredients together.',
      ),
      PrepStep(
        id: 2,
        title: 'Cook Pancakes',
        description: 'Cook on a hot griddle until golden brown.',
      ),
    ],
    lastUpdated: DateTime(2024, 9, 20),
  ),
  Recipe(
    id: '2',
    authorId: 1,
    prepTime: 45,
    difficulty: Difficulty.medium,
    servings: 4,
    category: [dummyCategories[0]],
    name: 'Grilled Salmon',
    description: 'Healthy grilled salmon with lemon',
    imagesUrl:
        [
      'https://www.giallozafferano.it/images/10-1041/Salmone-grigliato-con-salsa-al-prezzemolo_780x520_wm.jpg'
    ],
    ingredientIds: [
      '15', // Olio (assumendo che esista nel JSON)
    ],
    measuredIngredients: {
      '14': MeasuredIngredient(
        ingredientId: '15', // Olio
        quantity: 1,
        unit: IngredientUnit.tablespoons,
      ),
    },
    steps: [
      PrepStep(
        id: 1,
        title: 'Marinate Salmon',
        description: 'Marinate salmon in lemon juice and herbs.',
      ),
      PrepStep(
        id: 2,
        title: 'Grill Salmon',
        description: 'Grill until cooked through.',
      ),
    ],
    lastUpdated: DateTime(2024, 9, 18),
  ),
  Recipe(
    id: '3',
    authorId: 2,
    prepTime: 60,
    difficulty: Difficulty.hard,
    servings: 4,
    category: [dummyCategories[2]],
    name: 'Risotto allo Zafferano',
    description: 'Classic Italian saffron risotto',
    imagesUrl:
        [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-8-7N-De4Arg9552Zer1dyiBCzSZeN-hRGQ&s'
    ],
    ingredientIds: [
      '5', // Caffè (usato come placeholder per riso)
      '6', // Cacao (usato come placeholder per zafferano)
      '13', // Latte (usato come placeholder per brodo)
      '1', // Mascarpone (usato come placeholder per parmigiano)
      '8', // Burro
      '9', // Bicarbonato (usato come placeholder per cipolla)
    ],
    measuredIngredients: {
      '4': MeasuredIngredient(
        ingredientId: '5',
        quantity: 1,
        unit: IngredientUnit.cups,
      ),
      '5': MeasuredIngredient(
        ingredientId: '6',
        quantity: 1,
        unit: IngredientUnit.pinch,
      ),
      '6': MeasuredIngredient(
        ingredientId: '13',
        quantity: 4,
        unit: IngredientUnit.cups,
      ),
      '7': MeasuredIngredient(
        ingredientId: '1',
        quantity: 0.5,
        unit: IngredientUnit.cups,
      ),
      '8': MeasuredIngredient(
        ingredientId: '8',
        quantity: 2,
        unit: IngredientUnit.tablespoons,
      ),
      '9': MeasuredIngredient(
        ingredientId: '9',
        quantity: 1,
        unit: IngredientUnit.unit,
      ),
    },
    steps: [
      PrepStep(
        id: 1,
        title: 'Prepare Broth',
        description: 'Heat the broth and keep it warm.',
      ),
      PrepStep(
        id: 2,
        title: 'Sauté Onion',
        description: 'Sauté finely chopped onion in butter until translucent.',
      ),
      PrepStep(
        id: 3,
        title: 'Toast Rice',
        description: 'Add the rice and toast it for a few minutes.',
      ),
      PrepStep(
        id: 4,
        title: 'Add Broth',
        description: 'Dissolve saffron in a small amount of warm broth.',
      ),
      PrepStep(
        id: 5,
        title: 'Cook Rice',
        description: 'Gradually add broth to the rice, stirring constantly.',
      ),
      PrepStep(
        id: 6,
        title: 'Add Saffron',
        description: 'Stir in the saffron-infused broth.',
      ),
      PrepStep(
        id: 7,
        title: 'Finish Cooking',
        description: 'Cook until the rice is creamy and al dente.',
      ),
      PrepStep(
        id: 8,
        title: 'Add Cheese',
        description: 'Stir in Parmesan cheese and adjust seasoning.',
      ),
    ],
    lastUpdated: DateTime(2024, 9, 31),
  ),
];

final friendReceipts = [
  Recipe(
    id: '4',
    authorId: 2,
    prepTime: 30,
    difficulty: Difficulty.easy,
    servings: 4,
    category: [dummyCategories[7]],
    name: 'Spaghetti Carbonara',
    description:
        'Classic Spaghetti Carbonara dish made with eggs, cheese, pancetta, and pepper.',
    imagesUrl:
        [
      'https://www.informacibo.it/wp-content/uploads/2018/04/carbonara.jpg'
    ],
    ingredientIds: [
      '2', // Uova
      '1', // Mascarpone (usato come placeholder per parmigiano)
    ],
    measuredIngredients: {
      '0': MeasuredIngredient(
        ingredientId: '2', // Uova
        quantity: 2,
        unit: IngredientUnit.pieces,
      ),
      '7': MeasuredIngredient(
        ingredientId: '1', // Mascarpone (usato come placeholder per parmigiano)
        quantity: 0.5,
        unit: IngredientUnit.cups,
      ),
    },
    steps: [
      PrepStep(
        id: 1,
        title: 'Cook Spaghetti',
        description: 'Cook spaghetti according to package instructions.',
      ),
      PrepStep(
        id: 2,
        title: 'Prepare Egg Mixture',
        description: 'In a bowl, whisk together eggs and cheese.',
      ),
      PrepStep(
        id: 3,
        title: 'Cook Pancetta',
        description: 'Sauté pancetta until crispy.',
      ),
      PrepStep(
        id: 4,
        title: 'Combine Ingredients',
        description:
            'Combine hot pasta with pancetta and egg mixture, stirring quickly.',
      ),
    ],
  ),
  Recipe(
    id: '5',
    authorId: 1,
    prepTime: 90,
    difficulty: Difficulty.medium,
    servings: 4,
    category: [dummyCategories[7]],
    name: 'Margherita Pizza',
    description: 'Classic Italian pizza with tomato, mozzarella, and basil',
    imagesUrl:
        [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg/800px-Eq_it-na_pizza-margherita_sep2005_sml.jpg'
    ],
    ingredientIds: [
      '7', // Farina 00 (usato come placeholder per impasto pizza)
      '4', // Zucchero (usato come placeholder per salsa pomodoro)
      '1', // Mascarpone (usato come placeholder per mozzarella)
      '3', // Savoiardi (usato come placeholder per basilico)
      '15', // Olio (assumendo che esista nel JSON)
    ],
    measuredIngredients: {
      '10': MeasuredIngredient(
        ingredientId: '7', // Farina 00
        quantity: 1,
        unit: IngredientUnit.unit,
      ),
      '11': MeasuredIngredient(
        ingredientId:
            '4', // Zucchero (usato come placeholder per salsa pomodoro)
        quantity: 0.5,
        unit: IngredientUnit.cups,
      ),
      '12': MeasuredIngredient(
        ingredientId: '1', // Mascarpone (usato come placeholder per mozzarella)
        quantity: 1,
        unit: IngredientUnit.cups,
      ),
      '13': MeasuredIngredient(
        ingredientId: '3', // Savoiardi (usato come placeholder per basilico)
        quantity: 5,
        unit: IngredientUnit.pieces,
      ),
      '14': MeasuredIngredient(
        ingredientId: '15', // Olio
        quantity: 1,
        unit: IngredientUnit.tablespoons,
      ),
    },
    steps: [
      PrepStep(
        id: 1,
        title: 'Preheat Oven',
        description: 'Preheat the oven to 475°F (245°C).',
      ),
      PrepStep(
        id: 2,
        title: 'Prepare Dough',
        description: 'Roll out the pizza dough on a floured surface.',
      ),
      PrepStep(
        id: 3,
        title: 'Add Sauce',
        description: 'Spread tomato sauce evenly over the dough.',
      ),
      PrepStep(
        id: 4,
        title: 'Add Toppings',
        description: 'Top with mozzarella cheese and fresh basil leaves.',
      ),
      PrepStep(
        id: 5,
        title: 'Drizzle Olive Oil',
        description: 'Drizzle olive oil over the toppings.',
      ),
      PrepStep(
        id: 6,
        title: 'Bake Pizza',
        description: 'Bake in the preheated oven for 10-12 minutes.',
      ),
      PrepStep(
        id: 7,
        title: 'Cool and Serve',
        description: 'Remove from the oven and let cool slightly before serving.',
      ),
    ],
  ),
];
