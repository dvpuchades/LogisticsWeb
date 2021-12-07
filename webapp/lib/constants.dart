import 'package:flutter/material.dart';

class Backend {
  static const direction = 'localhost:2400';
}

class ThemeColors {
  static const green = Color(0xff37A959);
  static const black = Color(0xff2B2C28);
  static const grey = Color(0xffC9CFCF);
  static const white = Colors.white;
}

class MaterialThemeColors {
  static Map<int, Color> greens = {
    50: const Color.fromRGBO(55, 169, 89, .1),
    100: const Color.fromRGBO(55, 169, 89, .2),
    200: const Color.fromRGBO(55, 169, 89, .3),
    300: const Color.fromRGBO(55, 169, 89, .4),
    400: const Color.fromRGBO(55, 169, 89, .5),
    500: const Color.fromRGBO(55, 169, 89, .6),
    600: const Color.fromRGBO(55, 169, 89, .7),
    700: const Color.fromRGBO(55, 169, 89, .8),
    800: const Color.fromRGBO(55, 169, 89, .9),
    900: const Color.fromRGBO(55, 169, 89, 1),
  };

  static MaterialColor green = MaterialColor(0xff37A959, greens);
}

class LogoTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const LogoTextStyle({
    this.color = ThemeColors.white,
    this.fontWeight = FontWeight.bold,
    this.size = 64,
    this.fontFamily = 'Intro',
  }) : super(
          color: Colors.green,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
        );
}

class TitleTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const TitleTextStyle({
    this.color = ThemeColors.white,
    this.fontWeight = FontWeight.bold,
    this.size = 32,
    this.fontFamily = 'Intro',
  }) : super(
          color: Colors.green,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
        );
}

class SubtitleTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const SubtitleTextStyle({
    this.color = ThemeColors.green,
    this.fontWeight = FontWeight.bold,
    this.size = 24,
    this.fontFamily = 'Intro',
  }) : super(
          color: Colors.green,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
        );
}
