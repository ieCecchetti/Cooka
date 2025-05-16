import 'package:cooka/data/difficulty.dart';
import 'package:cooka/data/icons.dart';
import 'package:cooka/models/ingredient_units.dart';
import 'package:cooka/models/measured_ingredient.dart';

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
      imageUrl:
          'https://cdn.britannica.com/94/151894-050-F72A5317/Brown-eggs.jpg'),
  Ingredient(
      id: '2',
      name: 'Milk',
      imageUrl:
          'https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Glass-and-bottle-of-milk-fe0997a.jpg'),
  Ingredient(
      id: '3',
      name: 'Flour',
      imageUrl:
          'https://www.unlockfood.ca/EatRightOntario/media/Website-images-resized/All-about-grain-flours-resized.jpg'),
  Ingredient(
      id: '4',
      name: 'Sugar',
      imageUrl:
          'https://media.istockphoto.com/id/1371245517/photo/granulated-white-sugar-in-wooden-bowl-isolated-on-white-background-with-clipping-path.jpg?s=612x612&w=0&k=20&c=fdfohHyZbusyq_67gMgIRbubn5hMZEw4KyhX3_dsh6E='),
  Ingredient(
      id: '5',
      name: 'Arborio rice',
      imageUrl:
          'https://d121ck0xk6rnj0.cloudfront.net/eyJidWNrZXQiOiJyaXZpYW5hLWJ1Y2tldCIsImtleSI6ImltYWdlcy8wMDA3NDQwMTkxMDQxMV9BMUMxLnBuZyIsImVkaXRzIjp7InBuZyI6eyJxdWFsaXR5IjoxMDAsInByb2dyZXNzaXZlIjp0cnVlfSwicmVzaXplIjp7IndpZHRoIjoxMjAwLCJoZWlnaHQiOjEyMDAsImZpdCI6ImNvdmVyIn19fQ=='),
  Ingredient(
      id: '6',
      name: 'Saffron threads',
      imageUrl:
          'https://www.thespruceeats.com/thmb/eJYslYlYwE5FiTce-7ax2-0GBZ4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/saffron-GettyImages-157531690-59b62582685fbe0011e9d88b.jpg'),
  Ingredient(
      id: '7',
      name: 'Chicken broth',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeDEmGVsaJta53GurDBbyJRKm0izXjmBFIwA&s'),
  Ingredient(
      id: '8',
      name: 'Parmesan cheese',
      imageUrl:
          'https://shop.ibis-salumi.com/cdn/shop/products/ibis-parmigianoreggiano_1024x1024@2x.jpg?v=1669909885'),
  Ingredient(
      id: '9',
      name: 'Butter',
      imageUrl:
          'https://www.botallaformaggi.com/new/wp-content/uploads/2019/11/Burro_BOTFOR024R317.png'),
  Ingredient(
      id: '10',
      name: 'Onion',
      imageUrl:
          'https://www.cuki.it/wp-content/uploads/come-conservare-cipolla-di-tropea.jpg'),
  Ingredient(
      id: '11',
      name: 'Pizza dough',
      imageUrl:
          'https://joyfoodsunshine.com/wp-content/uploads/2018/09/easy-homemade-pizza-dough-recipe-2-1-500x500.jpg'),
  Ingredient(
      id: '12',
      name: 'Tomato sauce',
      imageUrl:
          'https://mutti-parma.com/app/uploads/sites/7/2019/09/passata-700-1-411x1024.png'),
  Ingredient(
    id: '13',
    name: 'Mozzarella cheese',
    imageUrl:
        'https://www.assolatte.it/zpublish/4/uploads/4/salut_news/14694326891827206047_mozzarella.jpg',
  ),
  Ingredient(
      id: '14',
      name: 'Fresh basil leaves',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4aV36IudUUYyxtdEulfDkNzoYZIzgKolYBw&s'),
  Ingredient(
      id: '15',
      name: 'Olive oil',
      imageUrl: 'https://www.b2x.it/rest/images/2024/06/26/1514947.jpg'),
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
      dummyIngredients[0].id, // Eggs
      dummyIngredients[1].id, // Milk
      dummyIngredients[2].id, // Flour
      dummyIngredients[3].id, // Sugar
    ],
    measuredIngredients: {
      '1': MeasuredIngredient(
        ingredientId: dummyIngredients[0].id,
        quantity: 2,
        unit: IngredientUnit.pieces,
      ),
      '2': MeasuredIngredient(
        ingredientId: dummyIngredients[1].id,
        quantity: 100,
        unit: IngredientUnit.milliliters,
      ),
      '3': MeasuredIngredient(
        ingredientId: dummyIngredients[2].id,
        quantity: 2,
        unit: IngredientUnit.cups,
      ),
      '4': MeasuredIngredient(
        ingredientId: dummyIngredients[3].id,
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
      dummyIngredients[14].id, // Olive oil
    ],
    measuredIngredients: {
      '14': MeasuredIngredient(
        ingredientId: dummyIngredients[14].id,
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
      dummyIngredients[4].id, // Arborio rice
      dummyIngredients[5].id, // Saffron threads
      dummyIngredients[6].id, // Chicken broth
      dummyIngredients[7].id, // Parmesan cheese
      dummyIngredients[8].id, // Butter
      dummyIngredients[9].id, // Onion
    ],
    measuredIngredients: {
      '4': MeasuredIngredient(
        ingredientId: dummyIngredients[4].id,
        quantity: 1,
        unit: IngredientUnit.cups,
      ),
      '5': MeasuredIngredient(
        ingredientId: dummyIngredients[5].id,
        quantity: 1,
        unit: IngredientUnit.pinch,
      ),
      '6': MeasuredIngredient(
        ingredientId: dummyIngredients[6].id,
        quantity: 4,
        unit: IngredientUnit.cups,
      ),
      '7': MeasuredIngredient(
        ingredientId: dummyIngredients[7].id,
        quantity: 0.5,
        unit: IngredientUnit.cups,
      ),
      '8': MeasuredIngredient(
        ingredientId: dummyIngredients[8].id,
        quantity: 2,
        unit: IngredientUnit.tablespoons,
      ),
      '9': MeasuredIngredient(
        ingredientId: dummyIngredients[9].id,
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
      dummyIngredients[0].id, // Eggs
      dummyIngredients[7].id, // Parmesan cheese
    ],
    measuredIngredients: {
      '0': MeasuredIngredient(
        ingredientId: dummyIngredients[0].id,
        quantity: 2,
        unit: IngredientUnit.pieces,
      ),
      '7': MeasuredIngredient(
        ingredientId: dummyIngredients[7].id,
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
      dummyIngredients[10].id, // Pizza dough
      dummyIngredients[11].id, // Tomato sauce
      dummyIngredients[12].id, // Mozzarella cheese
      dummyIngredients[13].id, // Fresh basil leaves
      dummyIngredients[14].id, // Olive oil
    ],
    measuredIngredients: {
      '10': MeasuredIngredient(
        ingredientId: dummyIngredients[10].id,
        quantity: 1,
        unit: IngredientUnit.unit,
      ),
      '11': MeasuredIngredient(
        ingredientId: dummyIngredients[11].id,
        quantity: 0.5,
        unit: IngredientUnit.cups,
      ),
      '12': MeasuredIngredient(
        ingredientId: dummyIngredients[12].id,
        quantity: 1,
        unit: IngredientUnit.cups,
      ),
      '13': MeasuredIngredient(
        ingredientId: dummyIngredients[13].id,
        quantity: 5,
        unit: IngredientUnit.pieces,
      ),
      '14': MeasuredIngredient(
        ingredientId: dummyIngredients[14].id,
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
