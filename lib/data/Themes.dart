import 'package:flutter/material.dart';
import 'package:yhwh/classes/ColorPalette.dart';

Map<String, ColorPalette> themes = {
  "OLED": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff000000),
    foreground: const Color(0xffbbbbbb),
  ),

  "Natural": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff1b1924),
    foreground: const Color(0xffdcd9c6),
  ),

  "Verde Esmeralda Profundo": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff004D40),
    foreground: const Color(0xffA7FFEB),
  ),

  "Miel silvestre": ColorPalette(
    brightness: Brightness.dark,
    background: const Color.fromARGB(255, 20, 32, 44),
    foreground: const Color(0xffF8D673),
  ),

  "Azul dobre azul": ColorPalette( // MAS O MENOS
    brightness: Brightness.dark,
    background: const Color(0xff233b6b),
    foreground: const Color(0xffeef0f2),
  ),

  "Granate y crema de mantequilla": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff331922),
    foreground: const Color(0xffeddec9),
  ),

  "Verde oscuro y verde neón": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff23481c),
    foreground: const Color(0xffe9feb5),
  ),

  "Umber, nogal y hierro": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff101628),
    foreground: const Color(0xfff6f6f6),
  ),

  "ornamentales ": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff270001),
    foreground: const Color(0xffd8d584),
  ),

  "Estilo clásico de los setenta": ColorPalette(
    brightness: Brightness.dark,
    background: const Color(0xff1F1641),
    foreground: const Color(0xffBBBF95),
  ),

  "Muelle": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xfff1f3f2),
    foreground: const Color(0xff272424),
  ),

  "Jeans": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xfff3efca),
    foreground: const Color(0xff1c2c58),
  ),

  "Verde": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xffc7f6ec),
    foreground: const Color(0xff02231c),
  ),

  "azul": ColorPalette(
    brightness: Brightness.light,
    background: const Color(0xffE0E8F0),
    foreground: const Color(0xff8A140E),
  ),

};