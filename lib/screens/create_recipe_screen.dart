import 'package:flutter/material.dart';
import 'package:cooka/screens/create_recipe/add_information.dart';
import 'package:cooka/screens/create_recipe/add_ingredients.dart';
import 'package:cooka/screens/create_recipe/add_steps.dart';
import 'package:cooka/widgets/breadcrumb_navigator.dart';

class CreateRecipeScreen extends StatelessWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // All breadcrumb items
    final allBreadcrumbItems = ['Information', 'Ingredients', 'Steps'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Recipe"),
      ),
      body: BreadcrumbNavigator(
        allItems: allBreadcrumbItems, // Pass all breadcrumb items
        child: Navigator(
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case 'Information':
                builder = (context) => const AddInformationPage();
                break;
              case 'Ingredients':
                builder = (context) => const AddIngredientsPage();
                break;
              case 'Steps':
                builder = (context) => const AddStepsPage();
                break;
              default:
                builder = (context) => const AddInformationPage();
            }
            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
      ),
    );
  }
}

