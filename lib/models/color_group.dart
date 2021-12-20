import 'package:flutter/material.dart';

class ColorGroup {
  //Orange
  static ColorGroupType orange = ColorGroupType(
    name: "orange",
    primary: 0xFFFF862F,
    secondary: 0xFFFF730E,
    tertiary: 0xFFF96800,
  );

  //Green
  static ColorGroupType green = ColorGroupType(
    name: "green",
    primary: 0xFF38FC9E,
    secondary: 0xFF0EFF7D,
    tertiary: 0xFF38FC9E,
  );

  //White
  static ColorGroupType white = ColorGroupType(
    name: "white",
    primary: 0xFFFFFFF9,
    secondary: 0xFFEDEDED,
    tertiary: 0xFFFFFFF9,
  );

  static ColorGroupType getColor(String name) {
    switch (name) {
      case "orange":
        return orange;
      case "green":
        return green;
      case "white":
        return white;
      default:
        return orange;
    }
  }
}

class ColorGroupType {
  String name;
  late Color primary;
  late Color secondary;
  late Color tertiary;

  ColorGroupType(
      {required this.name,
      required int primary,
      required int secondary,
      required int tertiary}) {
    this.primary = Color(primary);
    this.secondary = Color(secondary);
    this.tertiary = Color(tertiary);
  }
}
