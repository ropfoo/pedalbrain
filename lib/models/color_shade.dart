import 'package:flutter/material.dart';

class ColorShade {
  // Orange
  static final Map<int, Color> _orangeShade =
      ShadeCreator().create(255, 134, 47);
  static MaterialColor orange = MaterialColor(0xFFFF862F, _orangeShade);
}

class ShadeCreator {
  Map<int, Color> create(int r, int g, int b) {
    return {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
  }
}
