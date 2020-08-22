import 'package:flutter/material.dart';


class AppThemes
{

  static ThemeData getTheme(Brightness brightness, bool blackThemeEnabled)
  {

    ThemeData theme = ThemeData();

      if(brightness == Brightness.light){
        theme = lightTheme;
      }

      else if(brightness == Brightness.dark && blackThemeEnabled == false){
        theme = darkTheme;
      }

      else if(brightness == Brightness.dark && blackThemeEnabled == true){
        theme = blackTheme;
      }

    return theme;
  }


  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    fontFamily: 'Roboto',
    accentColor: Colors.blue,
    backgroundColor: Color(0xffffffff),
    canvasColor: Colors.white,
    brightness: Brightness.light,
    bottomAppBarColor: Colors.white,
    secondaryHeaderColor: Color(0xff414141),

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
      backgroundColor: Colors.white
    )
  );


  static ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xff252526),
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Colors.blue,
    backgroundColor: Color(0xff1e1e1e),
    canvasColor: Color(0xff1e1e1e),
    brightness: Brightness.dark,
    secondaryHeaderColor: Color(0xff252526),
    bottomAppBarColor: Color(0xff252526),

    tabBarTheme: TabBarTheme(
      labelColor: Color(0xfff0f2f3),
      labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
    ),

    textTheme: TextTheme(
        button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
        bodyText1: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xffd4d4d4)),
        bodyText2: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff8f8f8f))

    ),

    appBarTheme: AppBarTheme(
      color: Color(0xff252526),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white), //Color(0xffd4d4d4)),

      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xfff0f2f3), fontWeight: FontWeight.bold),
          button: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3))
      )
    ),

    iconTheme: IconThemeData(
      color: Colors.white, //Color(0xffd4d4d4),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff252526)
    ),


  );



  static ThemeData blackTheme = ThemeData(
    primaryColor: Colors.black,
    accentColorBrightness: Brightness.dark,
    fontFamily: 'Roboto',
    accentColor: Colors.pinkAccent,
    backgroundColor: Colors.black,
    canvasColor: Colors.black,
    brightness: Brightness.dark,

    secondaryHeaderColor: Color(0xff121212),
    bottomAppBarColor: Color(0xff121212),

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
      backgroundColor: Color(0xff121212)
    )
  );
}