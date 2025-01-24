import 'package:flutter/material.dart';
import 'package:yhwh/classes/ColorPalette.dart';

Map<String, ColorPalette> themes = {
  "Muelle": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xfff1f3f2),
    foreground: const Color(0xff272424),
  ),
  
  "OLED": ColorPalette( // 1
    brightness: Brightness.dark,
    background: const Color(0xff000000),
    foreground: const Color(0xffbbbbbb),
  ),

  "Jeans": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xfff3efca),
    foreground: const Color(0xff1c2c58),
  ),

  "Umber, nogal y hierro": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff101628),
    foreground: const Color(0xfff6f6f6),
  ),

  "Verde": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xffc7f6ec),
    foreground: const Color(0xff02231c),
  ),

  "Verde Esmeralda Profundo": ColorPalette( // 2
    brightness: Brightness.dark,
    background: const Color(0xff004D40),
    foreground: const Color(0xffA7FFEB),
  ),

  "azul": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xffE0E8F0),
    foreground: const Color(0xff8A140E),
  ),

  "Azul dobre azul": ColorPalette( // 3
    brightness: Brightness.dark,
    background: const Color(0xff233b6b),
    foreground: const Color(0xffeef0f2),
  ),

  "Granate y crema de mantequilla": ColorPalette( // 4
    brightness: Brightness.dark,
    background: const Color(0xff331922),
    foreground: const Color(0xffeddec9),
  ),

  "Verde oscuro y verde neón": ColorPalette( // 5
    brightness: Brightness.dark,
    background: const Color(0xff23481c),
    foreground: const Color(0xffe9feb5),
  ),
};