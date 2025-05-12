import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cooka/widgets/recipe_list.dart';
import 'package:cooka/providers/recipe_provider.dart';

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
        title: const Text('Home'),
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
                title: 'Recent Receips',
                recipes: recipeList,
                showTitle: true,
              ),
              RecipListTile(
                title: 'Friends Receips',
                recipes: recipeList,
                showTitle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
