import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cooka/models/recipe.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
      children: [
        Image.network(
          recipe.imageUrl,
          width: 100,
          height: 200,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          top: 0,
          right: 4,
          child: CircleAvatar(
              backgroundColor: recipe.category[0].color,
            radius: 12,
            child: Icon(
                recipe.category[0].icon,
            size: 16,
            color: Colors.white,
            ),
          ),
        ),
      ],
      ),
      title: Text(recipe.name),
      subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(recipe.description),
        const SizedBox(height: 4),
        Row(
        children: const [
          Icon(Icons.timer, size: 16, color: Colors.grey),
          SizedBox(width: 4),
          Text(
          '30 min',
          style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(width: 16),
          Icon(Icons.local_fire_department, size: 16, color: Colors.grey),
          SizedBox(width: 4),
          Text(
          'Easy',
          style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
        ),
      ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
