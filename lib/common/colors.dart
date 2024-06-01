import 'package:flutter/material.dart';

class LOBColors {
  static const Color primary = Color.fromARGB(255, 39, 41, 95);
  static const Color secondary = Color.fromARGB(255, 107, 35, 35);
  static const Color backGround = Color.fromARGB(255, 231, 232, 255);
  static const Color secondaryBackGround = Color.fromARGB(255, 250, 227, 227);
  static const Gradient yetToHappenBackground = LinearGradient(
    colors: [
      Color.fromARGB(255, 176, 255, 226),
      Color.fromARGB(255, 255, 246, 200),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Color gameOver = Color.fromARGB(255, 255, 111, 0);
  static const Color yetToHappen = Color.fromARGB(55, 0, 255, 140);
  static const Gradient gameOverBackground = LinearGradient(
    colors: [
      Color.fromARGB(255, 168, 79, 1),
      Color.fromARGB(255, 166, 155, 237),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient cardBackground = LinearGradient(
    colors: [Color.fromARGB(255, 0, 4, 61), Color.fromARGB(255, 255, 255, 255)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient adminCardBackground = LinearGradient(
    colors: [secondary, Color.fromARGB(255, 254, 246, 255)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient formBackground = LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 255, 255, 255),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
