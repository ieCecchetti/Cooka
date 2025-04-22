import 'package:flutter/material.dart';

import 'package:cooka/widgets/recipe_list.dart';
import 'package:cooka/data/dummy.dart';

class MainViewScreen extends StatelessWidget {
  const MainViewScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
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
              ),
              const SizedBox(height: 20),
              RecipListTile(title: 'Recent Receips', recipes: recipeList, showTitle: true,),
              RecipListTile(
                title: 'Friends Receips',
                recipes: friendReceipts,
                showTitle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
