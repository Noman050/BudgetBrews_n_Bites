// ignore_for_file: file_names, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import 'package:foodies/screens/optionScreen.dart';
import 'package:splashscreen/splashscreen.dart';

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: const OptionScreen(),
        image: Image.asset(
          "assets/images/splash.png",
          fit: BoxFit.cover,
        ),
        backgroundColor: bgColor,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 170.0,
        loaderColor: buttonColor);
  }
}
