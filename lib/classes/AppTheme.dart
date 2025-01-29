import 'package:flutter/material.dart';
import 'package:yhwh/data/Themes.dart';

class AppTheme
{
  // estos son temas por defecto, solo sirven para que no se rompa la app
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    canvasColor: const Color(0xffffffff),
    indicatorColor: const Color(0xff242424),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    canvasColor: const Color(0xff000000),
    indicatorColor: const Color(0xffbbbbbb),
  );

  
  static ThemeData getTheme(String themeName){
    // esto establece el tema blanco por defecto al iniciar la app por primera vez
    ThemeData theme = light;

    if(themes.containsKey(themeName))
    {
      // para temas claros
      if(themes[themeName]?.brightness == Brightness.light){
        theme = ThemeData.light().copyWith(
          canvasColor: themes[themeName]!.background,
          indicatorColor: themes[themeName]!.foreground,
        );
      }
      
      // para temas oscuros
      else {
        theme = ThemeData.dark().copyWith(
          canvasColor: themes[themeName]!.background,
          indicatorColor: themes[themeName]!.foreground,
        );
      }
    }

    return theme;
  }
}