// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import '../constants/recipeData.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailScreen(this.toggleFavorite, this.isFavorite, {super.key});
  Widget buildSectionTitle(String text, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
            color: textColor, fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }

  Widget buidContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: buttonColor),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 190,
        width: 350,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = RECIPE_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.list_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                selectedMeal.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients', context),
            buidContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: buttonColor,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: const TextStyle(
                            color: bgColor, fontWeight: FontWeight.bold),
                      )),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle('Steps', context),
            buidContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      textColor: textColor,
                      leading: CircleAvatar(
                          backgroundColor: buttonColor,
                          child: Text(
                            '#${index + 1}',
                            style: const TextStyle(
                                color: bgColor, fontWeight: FontWeight.bold),
                          )),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    const Divider()
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
          color: bgColor,
        ),
        onPressed: () {
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
