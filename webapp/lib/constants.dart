import 'package:flutter/material.dart';

class Backend {
  static const direction = 'localhost:2400';
}

class SubtitleTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const SubtitleTextStyle({
    this.color = Colors.green,
    this.fontWeight = FontWeight.bold,
    this.size = 24,
    this.fontFamily = 'Noto Sans',
  }) : super(
          color: Colors.green,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
        );
}
