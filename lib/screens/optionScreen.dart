// ignore_for_file: file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:foodies/models/screenRoutes.dart';

import '../constants/colors.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/images/splash.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 50,
              color: bgColor,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(180, 50),
                  backgroundColor: buttonColor,
                ),
                icon: const Icon(
                  Icons.book,
                  color: iconColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(ScreenRoutes.recipeScreen);
                },
                label: const Text(
                  "Recipe",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: bgColor),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 50,
              color: bgColor,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.monetization_on,
                  color: bgColor,
                  size: 30,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(180, 50),
                  backgroundColor: buttonColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(ScreenRoutes.expenseScreen);
                },
                label: const Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: bgColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
