import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cooka/providers/recipe_provider.dart';

import 'package:cooka/widgets/recipe_list.dart';
import 'package:cooka/widgets/ingredients_list.dart';

// import 'package:cooka/screens/recipe_detail_screen.dart';
// import 'package:cooka/screens/ingredients_screen.dart';
import 'package:cooka/screens/add_recipe_screen.dart';
import 'package:cooka/screens/create_recipe_screen.dart';

class MainViewScreen extends ConsumerStatefulWidget {
  const MainViewScreen({super.key});

  @override
  ConsumerState<MainViewScreen> createState() => _MainViewScreenState();
}

class _MainViewScreenState extends ConsumerState<MainViewScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeList = ref.watch(filteredRecipesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooka'),
        actions: [
          IconButton(
            icon: const Icon(Icons.kitchen),
            onPressed: () {
              // Add your action for the ingredients button here
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: const RouteSettings(
                      name: 'Information'), // Set the route name here
                  builder: (context) => const CreateRecipeScreen(),
                ),
              );
              // Add your action for the add button here
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add your action for the settings button here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey[100]!,
                      width: 0.5,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
              const SizedBox(height: 20),
              RecipListTile(
                title: 'My Receips',
                recipes: recipeList
                  ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated)),
                showTitle: true,
                maxItems: 3,
              ),
              const SizedBox(height: 20),
              IngredientsList(
                ingredients:
                    recipeList.expand((recipe) => recipe.ingredients).toList(),
              ),
              const SizedBox(height: 20),
              RecipListTile(
                title: 'Popular Receips',
                recipes: recipeList
                  ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated)),
                showTitle: true,
                maxItems: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
