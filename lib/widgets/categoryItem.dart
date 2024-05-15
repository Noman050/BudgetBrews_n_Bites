// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import 'package:foodies/models/screenRoutes.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;

  const CategoryItem(this.id, this.title, {super.key});

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      ScreenRoutes.categoryMealsScreen,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: white30Color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: whiteColor, fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const Icon(
              Icons.folder,
              color: whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
