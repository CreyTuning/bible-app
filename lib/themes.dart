import 'package:flutter/material.dart';

class AppThemes
{
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.green,
    fontFamily: 'Roboto',
    accentColor: Colors.green,
    buttonColor: Color(0xffffffff),
    backgroundColor: Color(0xffffffff),
    canvasColor: Colors.white,
    brightness: Brightness.light,
    bottomAppBarColor: Colors.white,

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.green,
      focusColor: Colors.green,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green
        )
      )

    ),


    tabBarTheme: TabBarTheme(
      labelColor: Color(0xff263238),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.green, width: 3.0),
      )
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.black),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff6c757d)), //red: ef233c
    ),

    appBarTheme: AppBarTheme(
        color: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Color(0xff263238)),

        textTheme: TextTheme(
            headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xff263238), fontWeight: FontWeight.bold),
            button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238))
        )
    )
  );


  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.green,
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Colors.green,
    // buttonColor: Color(0xff1f1f1f),
    backgroundColor: Color(0xff1f1f1f),
    canvasColor: Color(0xff121212),
    brightness: Brightness.dark,

    bottomAppBarColor: Color(0xff1a1a1a),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3)),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff777777))

    ),

    appBarTheme: AppBarTheme(
      color: Color(0xff1f1f1f),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Color(0xfff0f2f3)),

      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xfff0f2f3), fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3))
      )
    )
  );



  static ThemeData getTheme(Brightness brightness)
  {
    ThemeData theme = ThemeData();

    if(brightness == Brightness.light){
      theme = lightTheme;
    }

    else if(brightness == Brightness.dark){
      theme = darkTheme;
    }

    return theme;
  }
}