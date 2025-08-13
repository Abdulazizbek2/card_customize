import 'package:flutter/material.dart';

class AppConstants {
  // Card dimensions
  static const double cardWidth = 300.0;
  static const double cardHeight = 180.0;
  static const double cardBorderRadius = 16.0;

  // Scale limits
  static const double minScale = 0.8;
  static const double maxScale = 3.0;
  static const double defaultScale = 1.0;

  // Blur limits
  static const double minBlur = 0.0;
  static const double maxBlur = 10.0;
  static const double defaultBlur = 0.0;

  // Predefined colors
  static const List<Color> predefinedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
  ];

  // Predefined gradients
  static const List<LinearGradient> predefinedGradients = [
    LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Colors.red, Colors.orange],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [Colors.green, Colors.teal],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    LinearGradient(
      colors: [Colors.pink, Colors.purple],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  ];

  // Asset paths for predefined images
  static const List<String> predefinedImagePaths = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
  ];
}
