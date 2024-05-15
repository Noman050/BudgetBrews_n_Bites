// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import '../constants/recipeData.dart';
import '../widgets/categoryItem.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: RECIPE_CATEGORIES.length,
      itemBuilder: (ctx, index) {
        final catData = RECIPE_CATEGORIES[index];
        return Card(
          color: white30Color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20), // Adjust the circular border radius as needed
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: CategoryItem(
            catData.id,
            catData.title,
          ),
        );
      },
    );
  }
}

  //  color: white30Color,
  //     elevation: 5,