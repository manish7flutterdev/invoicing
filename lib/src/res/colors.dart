import 'package:flutter/material.dart';

class CustomColours extends Color {
  CustomColours(int value) : super(value);

  static const Color redColor = MaterialColor(
    _redColorValue,
    <int, Color>{
      50: Color(0xFFFEE9E9),
      100: Color(0xFFFCC9C9),
      200: Color(0xFFFBA5A5),
      300: Color(0xFFF98181),
      400: Color(0xFFF76666),
      500: Color(_redColorValue),
      600: Color(0xFFF54444),
      700: Color(0xFFF33B3B),
      800: Color(0xFFF23333),
      900: Color(0xFFEF2323),
    },
  );
  static const int _redColorValue = 0xFFF64B4B;

  static const MaterialColor greenColor =
      MaterialColor(_greenColorValue, <int, Color>{
    50: Color(0xFFEDFAF0),
    100: Color(0xFFD2F2DA),
    200: Color(0xFFB4EAC2),
    300: Color(0xFF95E2AA),
    400: Color(0xFF7FDB97),
    500: Color(_greenColorValue),
    600: Color(0xFF60D07D),
    700: Color(0xFF55CA72),
    800: Color(0xFF4BC468),
    900: Color(0xFF3ABA55),
  });
  static const int _greenColorValue = 0xFF68D585;

  static const MaterialColor bluePrimary =
      MaterialColor(_bluePrimaryValue, <int, Color>{
    50: Color(0xFFF1F6FC),
    100: Color(0xFFDCEAF7),
    200: Color(0xFFC5DCF2),
    300: Color(0xFFAECDED),
    400: Color(0xFF9CC3E9),
    500: Color(_bluePrimaryValue),
    600: Color(0xFF83B1E2),
    700: Color(0xFF78A8DE),
    800: Color(0xFF6EA0DA),
    900: Color(0xFF5B91D3),
  });
  static const int _bluePrimaryValue = 0xFF8BB8E5;

  static const MaterialColor blueAccent =
      MaterialColor(_blueAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_blueAccentValue),
    400: Color(0xFFD4E7FF),
    700: Color(0xFFBBD9FF),
  });
  static const int _blueAccentValue = 0xFFFFFFFF;

  static const MaterialColor orangePrimary =
      MaterialColor(_orangePrimaryValue, <int, Color>{
    50: Color(0xFFFFF5ED),
    100: Color(0xFFFFE5D2),
    200: Color(0xFFFFD4B4),
    300: Color(0xFFFFC396),
    400: Color(0xFFFFB680),
    500: Color(_orangePrimaryValue),
    600: Color(0xFFFFA261),
    700: Color(0xFFFF9856),
    800: Color(0xFFFF8F4C),
    900: Color(0xFFFF7E3B),
  });
  static const int _orangePrimaryValue = 0xFFFFA969;

  static const MaterialColor orangeAccent =
      MaterialColor(_orangeAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_orangeAccentValue),
    400: Color(0xFFFFEDE4),
    700: Color(0xFFFFDBCA),
  });
  static const int _orangeAccentValue = 0xFFFFFFFF;

  static const MaterialColor greyColor =
      MaterialColor(_greyColorValue, <int, Color>{
    50: Color(0xFFE9E9EA),
    100: Color(0xFFC9C9CA),
    200: Color(0xFFA5A5A7),
    300: Color(0xFF808183),
    400: Color(0xFF656669),
    500: Color(_greyColorValue),
    600: Color(0xFF434447),
    700: Color(0xFF3A3B3D),
    800: Color(0xFF323335),
    900: Color(0xFF222325),
  });
  static const int _greyColorValue = 0xFF4A4B4E;
}
