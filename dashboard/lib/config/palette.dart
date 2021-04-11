import 'package:flutter/material.dart';
class Palette {
  static const Color primeColor = Color(0xFFF2F4F5);
  static const Color secondColor = Color(0xFFFC312F);
  static const Color lightSecondColor = Color(0xFFEE6666);
  static const Color healed = Color(0xFF1BB65D);
  static Color fontColor = Colors.grey[900];

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFFC7C7),
    ],
  );
}
