import 'package:flutter/material.dart';

class FuncUtils {
  static BoxDecoration calenderDecoration(Color color) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );
  }

  static TextStyle dayTextStyle(Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      color: color,
    );
  }
}
