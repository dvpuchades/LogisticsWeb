// ignore_for_file: annotate_overrides, overridden_fields

import 'package:flutter/material.dart';

class Backend {
  static const direction = 'localhost:3000';
  //static const direction = '10.0.2.2:2400';
}

class ThemeColors {
  static const green = Color(0xff236c39);
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

class SpecialTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const SpecialTextStyle({
    this.color = ThemeColors.black,
    this.fontWeight = FontWeight.bold,
    this.size = 20,
    this.fontFamily = 'Intro',
  }) : super(
          color: Colors.green,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
        );
}

class NormalTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const NormalTextStyle({
    this.color = ThemeColors.white,
    this.fontWeight = FontWeight.normal,
    this.size = 20,
    this.fontFamily = 'Roboto',
  }) : super(
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
        );
}
