import 'package:flutter/material.dart';

class ColorPalette {
  static List<Color> palette = [
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.indigo,
    Colors.orange,
    Colors.teal,
    Colors.purple
  ];

  static Color get(int index) {
    return ColorPalette.palette[index % ColorPalette.palette.length];
  }
}
