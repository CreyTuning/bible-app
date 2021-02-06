import 'package:flutter/material.dart';

class AppTheme
{
  static ThemeData light = ThemeData(
    primaryColor: Colors.white,
    fontFamily: 'Roboto',
    accentColor: Color(0xff414141),
    backgroundColor: Color(0xfff4f4f4),
    canvasColor: Colors.white,
    brightness: Brightness.light,
    bottomAppBarColor: Colors.white,
    secondaryHeaderColor: Color(0xff414141),
    // dividerColor: Color(0xff5f6368),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xff202124),
      unselectedItemColor: Color(0xff5f6368),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xff263238),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff414141)),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff777777)), //red: ef233c
    ),

    appBarTheme: AppBarTheme(
        color: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Color(0xff414141)),

        textTheme: TextTheme(
            headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xff263238), fontWeight: FontWeight.bold),
            button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238))
        )
    ),

    iconTheme: IconThemeData(
      color: Color(0xff414141),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xffffffff)
    ),

    cardColor: Colors.white
  );

  static ThemeData dark = ThemeData(
    primaryColor: Color(0xff252526),
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Color(0xfff1f3f4),
    backgroundColor: Color(0xff202124),
    canvasColor: Color(0xff202124),
    brightness: Brightness.dark,
    secondaryHeaderColor: Color(0xff252526),
    bottomAppBarColor: Color(0xff303134),
    dividerColor: Color(0xff5f6368),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff202124),
      selectedItemColor: Color(0xffe8eaed),
      unselectedItemColor: Color(0xff9aa0a6),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff1f3f4)), //Color(0xffd4d4d4)),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff9aa0a6))

    ),

    appBarTheme: AppBarTheme(
      color: Color(0xff202124),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white), //Color(0xffd4d4d4)),

      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
      )
    ),

    iconTheme: IconThemeData(
      color: Colors.white, //Color(0xffd4d4d4),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff3c4043)
    ),

    cardColor: Color(0xff303134)

  );

  static ThemeData black = ThemeData(
    primaryColor: Colors.black,
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Colors.white,
    backgroundColor: Color(0xff000000),
    canvasColor: Colors.black,
    brightness: Brightness.dark,

    secondaryHeaderColor: Color(0xff121212),
    bottomAppBarColor: Color(0xff121212),
    dividerColor: Color(0xff323232),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Color(0xffe8eaed),
      unselectedItemColor: Color(0xff9aa0a6),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff777777))

    ),

    appBarTheme: AppBarTheme(
      color: Colors.black,//Color(0xff303134),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Color(0xfff0f2f3)),

      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xfff0f2f3), fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3))
      )
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff1f1f1f)
    ),

    cardColor: Color(0xff202020)
  );


  static ThemeData spaceCadet = ThemeData(
    primaryColor: Color(0xff2B2D42),
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Color(0xffd6d8da),
    backgroundColor: Color(0xff2B2D42),
    canvasColor: Color(0xff2B2D42),
    brightness: Brightness.dark,
    secondaryHeaderColor: Color(0xff2B2D42),
    bottomAppBarColor: Color(0xff2B2D42),
    dividerColor: Color(0xff8D99AE),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff2B2D42),
      selectedItemColor: Color(0xffEF233C),
      unselectedItemColor: Color(0xffEDF2F4),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffEDF2F4)), //Color(0xffd4d4d4)),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff8D99AE))

    ),

    appBarTheme: AppBarTheme(
      color: Color(0xff2B2D42),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white), //Color(0xffd4d4d4)),

      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
      )
    ),

    iconTheme: IconThemeData(
      color: Colors.white, //Color(0xffd4d4d4),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff44485d)
    ),

    cardColor: Color(0xff44485d)

  );

  static ThemeData charcoal = ThemeData(
    primaryColor: Color(0xff264653),
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Color(0xffd6d8da),
    backgroundColor: Color(0xff264653),
    canvasColor: Color(0xff264653),
    brightness: Brightness.dark,
    secondaryHeaderColor: Color(0xff264653),
    bottomAppBarColor: Color(0xff264653),
    dividerColor: Color(0xff8D99AE),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff264653),
      selectedItemColor: Color(0xffEF233C),
      unselectedItemColor: Color(0xffEDF2F4),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffEDF2F4)), //Color(0xffd4d4d4)),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff8D99AE))

    ),

    appBarTheme: AppBarTheme(
      color: Color(0xff264653),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white), //Color(0xffd4d4d4)),

      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
      )
    ),

    iconTheme: IconThemeData(
      color: Colors.white, //Color(0xffd4d4d4),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff335f70)
    ),

    cardColor: Color(0xff335f70)

  );

  static ThemeData pansyPurple = ThemeData(
    primaryColor: Color(0xff830b53),
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Color(0xffd6d8da),
    backgroundColor: Color(0xff830b53),
    canvasColor: Color(0xff830b53),
    brightness: Brightness.dark,
    secondaryHeaderColor: Color(0xff830b53),
    bottomAppBarColor: Color(0xff830b53),
    dividerColor: Color(0xffc285aa),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff830b53),
      selectedItemColor: Color(0xffEF233C),
      unselectedItemColor: Color(0xffEDF2F4),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffc285aa))

    ),

    appBarTheme: AppBarTheme(
      color: Color(0xff830b53),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white), //Color(0xffd4d4d4)),

      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
      )
    ),

    iconTheme: IconThemeData(
      color: Colors.white, //Color(0xffd4d4d4),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xffaa0e6b)
    ),

    cardColor: Color(0xffaa0e6b)

  );


  static ThemeData getTheme(String themeName){
    switch (themeName) {
      case "light":
        return light;
        break;
      case "dark":
        return dark;
        break;
      case "black":
        return black;
        break;

      case "spaceCadet":
        return spaceCadet;
        break;
      case "charcoal":
        return charcoal;
        break;
      case "pansyPurple":
        return pansyPurple;
        break;

      default:
        return light;
    }
  }
}