import 'package:flutter/material.dart';

class Fonts {
  static int reduce = 0;

  regular(double size, Color color) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      fontSize: size - reduce,
      color: color,
    );
  }

  medium(double size, Color color) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w500,
      fontSize: size - reduce,
      color: color,
    );
  }

  semiBold(double size, Color color) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        fontSize: size - reduce,
        color: color);
  }

  bold(double size, Color color) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
      fontSize: size - reduce,
      color: color,
    );
  }

  extraBold(double size, Color color) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w800,
      fontSize: size - reduce,
      color: color,
    );
  }
}
