import 'package:cooka/screens/create_recipe/add_categories.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_page.dart';
import 'package:flutter/material.dart';
import 'package:cooka/screens/create_recipe/add_information.dart';
import 'package:cooka/screens/create_recipe/add_ingredients.dart';
import 'package:cooka/screens/create_recipe/add_steps.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/create_recipe_provider.dart';

class CreateRecipeScreen extends ConsumerWidget {
  const CreateRecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, GlobalKey<BreadCrumbPageState>> _pageKeys = {
      'Information': GlobalKey<BreadCrumbPageState>(),
      'Categories': GlobalKey<BreadCrumbPageState>(),
      'Ingredients': GlobalKey<BreadCrumbPageState>(),
      'Steps': GlobalKey<BreadCrumbPageState>(),
    };

    final routes = {
      'Information': (context) => AddInformationPage(
            key: _pageKeys['Information'],
            objectProvider: createRecipesProvider,
          ),
      'Categories': (context) => AddCategoriesPage(
            key: _pageKeys['Categories'],
            objectProvider: createRecipesProvider,
          ),
      'Ingredients': (context) => AddIngredientsPage(
            key: _pageKeys['Ingredients'],
            objectProvider: createRecipesProvider,
          ),
      'Steps': (context) => AddStepsPage(
            key: _pageKeys['Steps'],
            objectProvider: createRecipesProvider,
          ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: BreadcrumbRouter(
        allItems: routes.keys.toList(),
        routes: routes,
      ),
    );
  }
}
