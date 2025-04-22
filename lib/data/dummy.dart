import 'package:cooka/data/difficulty.dart';
import 'package:cooka/data/icons.dart';

import 'package:cooka/models/user.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:cooka/models/prep_step.dart';
import 'package:cooka/models/meal_category.dart';
import 'package:cooka/models/recipe.dart';

import 'package:flutter/material.dart';

final dummyUser = [
  User(id: '1', name: 'John Doe', email: 'johndoe@example.com'),
  User(
    id: '2',
    name: 'Jane Smith',
    email: 'janesmith@example.com',
  ),
];

final List<MealCategory> dummyCategories = [
  MealCategory(
    id: '1',
    title: 'Fish',
    iconCodePoint: mealCategoryIcons['Seafood']!.codePoint,
    color: Colors.blueAccent,
  ),
  MealCategory(
    id: '2',
    title: 'Meat',
    iconCodePoint: mealCategoryIcons['Meat']!.codePoint,
    color: Colors.redAccent,
  ),
  MealCategory(
    id: '3',
    title: 'Vegetarian',
    iconCodePoint: mealCategoryIcons['Vegetarian']!.codePoint,
    color: Colors.green,
  ),
  MealCategory(
    id: '4',
    title: 'Vegan',
    iconCodePoint: mealCategoryIcons['Vegan']!.codePoint,
    color: Colors.orange,
  ),
  MealCategory(
    id: '5',
    title: 'Desserts',
    iconCodePoint: mealCategoryIcons['Desserts']!.codePoint,
    color: Colors.brown,
  ),
  MealCategory(
    id: '6',
    title: 'Snacks',
    iconCodePoint: mealCategoryIcons['Snacks']!.codePoint,
    color: Colors.purple,
  ),
  MealCategory(
    id: '7',
    title: 'Drinks',
    iconCodePoint: mealCategoryIcons['Drinks']!.codePoint,
    color: Colors.teal,
  ),
  MealCategory(
    id: '8',
    title: 'Pasta',
    iconCodePoint: mealCategoryIcons['Pasta']!.codePoint,
    color: Colors.yellow,
  ),
];

final List<Ingredient> dummyIngredients = [
  Ingredient(
    id: '1',
    name: 'Eggs',
    quantity: 2,
    unit: 'pieces',
  ),
  Ingredient(
    id: '2',
    name: 'Milk',
    quantity: 1,
    unit: 'cup',
  ),
  Ingredient(
    id: '3',
    name: 'Flour',
    quantity: 2,
    unit: 'cups',
  ),
  Ingredient(
    id: '4',
    name: 'Sugar',
    quantity: 1,
    unit: 'cup',
  ),
];

final recipeList = [
  Recipe(
    id: '1',
    authorId: 1,
    prepTime: 30,
    difficulty: Difficulty.easy,
    servings: 4,
    category: dummyCategories[4],
    name: 'Pancakes',
    shortDescription: 'Fluffy pancakes for breakfast',
    description:
        'These fluffy pancakes are perfect for a quick and delicious breakfast.',
    imageUrl:
        'https://www.onceuponachef.com/images/2009/08/pancakes-01-760x1040.jpg',
    ingredients: dummyIngredients,
    steps: [
      PrepStep(
        id: 1,
        description: 'Mix all ingredients together.',
      ),
      PrepStep(
        id: 2,
        description: 'Cook on a hot griddle until golden brown.',
      ),
    ],
  ),
  Recipe(
    id: '2',
    authorId: 1,
    prepTime: 45,
    difficulty: Difficulty.medium,
    servings: 4,
    category: dummyCategories[0],
    name: 'Grilled Salmon',
    shortDescription: 'Healthy grilled salmon with lemon',
    description:
        'This grilled salmon is marinated in lemon and herbs for a fresh flavor.',
    imageUrl:
        'https://www.giallozafferano.it/images/10-1041/Salmone-grigliato-con-salsa-al-prezzemolo_780x520_wm.jpg',
    ingredients: dummyIngredients,
    steps: [
      PrepStep(
        id: 1,
        description: 'Marinate salmon in lemon juice and herbs.',
      ),
      PrepStep(
        id: 2,
        description: 'Grill until cooked through.',
      ),
    ],
  ),
  Recipe(
    id: '3',
    authorId: 2,
    prepTime: 60,
    difficulty: Difficulty.hard,
    servings: 4,
    category: dummyCategories[2],
    name: 'Risotto allo Zafferano',
    shortDescription: 'Classic Italian saffron risotto',
    description:
        'Risotto allo Zafferano is a traditional Italian dish made with saffron, giving it a vibrant yellow color and rich flavor.',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-8-7N-De4Arg9552Zer1dyiBCzSZeN-hRGQ&s',
    ingredients: [
      Ingredient(
        id: '5',
        name: 'Arborio rice',
        quantity: 1,
        unit: 'cup',
      ),
      Ingredient(
        id: '6',
        name: 'Saffron threads',
        quantity: 1,
        unit: 'pinch',
      ),
      Ingredient(
        id: '7',
        name: 'Chicken broth',
        quantity: 4,
        unit: 'cups',
      ),
      Ingredient(
        id: '8',
        name: 'Parmesan cheese',
        quantity: 0.5,
        unit: 'cup',
      ),
      Ingredient(
        id: '9',
        name: 'Butter',
        quantity: 2,
        unit: 'tablespoons',
      ),
      Ingredient(
        id: '10',
        name: 'Onion',
        quantity: 1,
        unit: 'small',
      ),
    ],
    steps: [
      PrepStep(
        id: 1,
        description: 'Heat the broth and keep it warm.',
      ),
      PrepStep(
        id: 2,
        description: 'Sauté finely chopped onion in butter until translucent.',
      ),
      PrepStep(
        id: 3,
        description: 'Add the rice and toast it for a few minutes.',
      ),
      PrepStep(
        id: 4,
        description: 'Dissolve saffron in a small amount of warm broth.',
      ),
      PrepStep(
        id: 5,
        description: 'Gradually add broth to the rice, stirring constantly.',
      ),
      PrepStep(
        id: 6,
        description: 'Stir in the saffron-infused broth.',
      ),
      PrepStep(
        id: 7,
        description: 'Cook until the rice is creamy and al dente.',
      ),
      PrepStep(
        id: 8,
        description: 'Stir in Parmesan cheese and adjust seasoning.',
      ),
    ],
  ),
];

final friendReceipts = [
  Recipe(
    id: '4',
    authorId: 2,
    prepTime: 30,
    difficulty: Difficulty.easy,
    servings: 4,
    category: dummyCategories[7],
    name: 'Spaghetti Carbonara',
    shortDescription: 'Classic Italian pasta dish',
    description:
        'Spaghetti Carbonara is a classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.',
    imageUrl:
        'https://www.informacibo.it/wp-content/uploads/2018/04/carbonara.jpg',
    ingredients: dummyIngredients,
    steps: [
      PrepStep(
        id: 1,
        description: 'Cook spaghetti according to package instructions.',
      ),
      PrepStep(
        id: 2,
        description: 'In a bowl, whisk together eggs and cheese.',
      ),
      PrepStep(
        id: 3,
        description: 'Sauté pancetta until crispy.',
      ),
      PrepStep(
        id: 4,
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
    category: dummyCategories[7],
    name: 'Margherita Pizza',
    shortDescription: 'Classic Italian pizza with tomato, mozzarella, and basil',
    description:
        'Margherita Pizza is a simple yet delicious pizza topped with fresh tomato sauce, mozzarella cheese, and basil leaves.',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg/800px-Eq_it-na_pizza-margherita_sep2005_sml.jpg',
    ingredients: [
      Ingredient(
        id: '11',
        name: 'Pizza dough',
        quantity: 1,
        unit: 'ball',
      ),
      Ingredient(
        id: '12',
        name: 'Tomato sauce',
        quantity: 0.5,
        unit: 'cup',
      ),
      Ingredient(
        id: '13',
        name: 'Mozzarella cheese',
        quantity: 1,
        unit: 'cup',
      ),
      Ingredient(
        id: '14',
        name: 'Fresh basil leaves',
        quantity: 5,
        unit: 'pieces',
      ),
      Ingredient(
        id: '15',
        name: 'Olive oil',
        quantity: 1,
        unit: 'tablespoon',
      ),
    ],
    steps: [
      PrepStep(
        id: 1,
        description: 'Preheat the oven to 475°F (245°C).',
      ),
      PrepStep(
        id: 2,
        description: 'Roll out the pizza dough on a floured surface.',
      ),
      PrepStep(
        id: 3,
        description: 'Spread tomato sauce evenly over the dough.',
      ),
      PrepStep(
        id: 4,
        description: 'Top with mozzarella cheese and fresh basil leaves.',
      ),
      PrepStep(
        id: 5,
        description: 'Drizzle olive oil over the toppings.',
      ),
      PrepStep(
        id: 6,
        description: 'Bake in the preheated oven for 10-12 minutes.',
      ),
      PrepStep(
        id: 7,
        description: 'Remove from the oven and let cool slightly before serving.',
      ),
    ],
  ),
];
