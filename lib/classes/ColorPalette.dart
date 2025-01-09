import 'package:flutter/material.dart';

class ColorPalette {
  Brightness? brightness;
  Color? background;
  Color? foreground;
  Color? color_1;
  Color? color_2;
  Color? color_3;
  Color? color_4;
  Color? color_5;

  ColorPalette({
    required this.brightness,
    required this.background,
    required this.foreground,
    this.color_1 = const Color(0xff000000),
    this.color_2 = const Color(0xff000000),
    this.color_3 = const Color(0xff000000),
    this.color_4 = const Color(0xff000000),
    this.color_5 = const Color(0xff000000),
  });
}