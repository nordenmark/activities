import 'package:flutter/material.dart';

class ColorPalette {
  static List<Color> palette = [
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.teal,
    Colors.purple,
    Colors.red,
    Colors.black,
    Colors.orange,
    Colors.indigo,
  ];

  static Color get(int index) {
    return ColorPalette.palette[index % ColorPalette.palette.length];
  }
}
