import 'package:cooka/screens/create_recipe/add_categories.dart';
import 'package:flutter/material.dart';
import 'package:cooka/screens/create_recipe/add_information.dart';
import 'package:cooka/screens/create_recipe/add_ingredients.dart';
import 'package:cooka/screens/create_recipe/add_steps.dart';
import 'package:cooka/widgets/breadcrumb_router.dart';

class CreateRecipeScreen extends StatelessWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the routes in order of breadcrumb navigation
    // You can also use a Map<String, WidgetBuilder> if you prefer
    final routes = {
      'Information': (context) => const AddInformationPage(),
      'Categories': (context) => const AddCategoriesPage(),
      'Ingredients': (context) => const AddIngredientsPage(),
      'Steps': (context) => const AddStepsPage(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: BreadcrumbRouter(
        allItems: routes.keys.toList(),
        routes: routes
      ),
    );
  }
}

