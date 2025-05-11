import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipebottomsheet.dart';

class CategoryDetailPage extends StatelessWidget {
  final String categoryName;

  const CategoryDetailPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final List<Recipe> filteredRecipes = Recipe.samples
        .where((recipe) => recipe.category == categoryName)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: ListView.builder(
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          final recipe = filteredRecipes[index];

          return GestureDetector(
            onDoubleTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${recipe.label} added to favorites!')),
              );
            },
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You like ${recipe.label}')),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Image.asset(recipe.imageUrl, width: 50, fit: BoxFit.cover),
                title: Text(recipe.label),
                subtitle: Text('${recipe.servings} servings'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => RecipeBottomSheet(recipe: recipe),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
