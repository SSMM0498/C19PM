import 'package:flutter/material.dart';

class Palette {
  static const Color backgroundColor = Color(0xFFF2F4F5);
  static const Color primaryColor = Color(0xFFFE004B);
  static const Color secondaryColor = Color(0xFFFE0096);
  static const Color lSecondaryColor = Color(0xFFFF36AD);
  static const Color tertiaryColor = Color(0xFFC009F2);
  static const Color healed = Color(0xFF1BB65D);
  static const Color fontColor = Color(0xFF1A1A1A);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor,
      lSecondaryColor,
    ],
  );
}
