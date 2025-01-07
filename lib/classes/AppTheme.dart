import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yhwh/data/Themes.dart';

class AppTheme
{
  // static ThemeData light = ThemeData(
  //   primaryColor: Colors.white,
  //   fontFamily: 'Roboto',
  //   canvasColor: Colors.white,
  //   brightness: Brightness.light,
  //   secondaryHeaderColor: Color(0xff414141),
  //   dividerColor: Color(0x77777777),

  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: 0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.white,
  //     selectedItemColor: Color(0xff202124),
  //     unselectedItemColor: Color(0xff5f6368),
  //   ),

  //   tabBarTheme: TabBarTheme(
  //     labelColor: Color(0xff263238),
  //     labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
  //     unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
  //   ),

  //   textTheme: TextTheme(
  //       labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238)),
  //       bodyLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff414141)),
  //       bodyMedium: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff777777)), //red: ef233c
  //   ),

  //   appBarTheme: AppBarTheme(
  //       color: Colors.white,
  //       iconTheme: IconThemeData(color: Color(0xff414141)), systemOverlayStyle: SystemUiOverlayStyle.dark, toolbarTextStyle: TextTheme(
  //           titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xff263238), fontWeight: FontWeight.bold),
  //           labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238))
  //       ).bodyMedium, titleTextStyle: TextTheme(
  //           titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xff263238), fontWeight: FontWeight.bold),
  //           labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff263238))
  //       ).titleLarge
  //   ),

  //   iconTheme: IconThemeData(
  //     color: Color(0xff414141),
  //   ),

  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xffffffff)
  //   ),

  //   cardColor: Colors.white, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xff414141)), colorScheme: ColorScheme(surface: Color(0xfff4f4f4)), bottomAppBarTheme: BottomAppBarTheme(color: Colors.white)
  // );

  // static ThemeData dark = ThemeData(
  //   primaryColor: Color(0xff252526),
  //   fontFamily: 'Roboto',
  //   canvasColor: Color(0xff202124),
  //   brightness: Brightness.dark,
  //   secondaryHeaderColor: Color(0xff252526),
  //   dividerColor: Color(0xff5f6368),

  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: 0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Color(0xff202124),
  //     selectedItemColor: Color(0xffe8eaed),
  //     unselectedItemColor: Color(0xff9aa0a6),
  //   ),

  //   tabBarTheme: TabBarTheme(
  //     labelColor: Color(0xfff0f2f3),
  //     labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
  //     unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
  //   ),

  //   textTheme: TextTheme(
  //       labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
  //       bodyLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff1f3f4)), //Color(0xffd4d4d4)),
  //       bodyMedium: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff9aa0a6))

  //   ),

  //   appBarTheme: AppBarTheme(
  //     color: Color(0xff202124),
  //     iconTheme: IconThemeData(color: Colors.white), systemOverlayStyle: SystemUiOverlayStyle.light, toolbarTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).bodyMedium, titleTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).titleLarge
  //   ),

  //   iconTheme: IconThemeData(
  //     color: Colors.white, //Color(0xffd4d4d4),
  //   ),

  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xff3c4043)
  //   ),

  //   cardColor: Color(0xff303134), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xfff1f3f4)), colorScheme: ColorScheme(surface: Color(0xff202124)), bottomAppBarTheme: BottomAppBarTheme(color: Color(0xff303134))

  // );

  // static ThemeData black = ThemeData(
  //   primaryColor: Colors.black,
  //   fontFamily: 'Roboto',
  //   canvasColor: Colors.black,
  //   brightness: Brightness.dark,

  //   secondaryHeaderColor: Color(0xff121212),
  //   dividerColor: Color(0xff323232),

  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: 0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.black,
  //     selectedItemColor: Color(0xffe8eaed),
  //     unselectedItemColor: Color(0xff9aa0a6),
  //   ),

  //   tabBarTheme: TabBarTheme(
  //     labelColor: Color(0xfff0f2f3),
  //     labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
  //     unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
  //   ),

  //   textTheme: TextTheme(
  //       labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3)),
  //       bodyLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white),
  //       bodyMedium: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff777777))

  //   ),

  //   appBarTheme: AppBarTheme(
  //     color: Colors.black,
  //     iconTheme: IconThemeData(color: Color(0xfff0f2f3)), systemOverlayStyle: SystemUiOverlayStyle.light, toolbarTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xfff0f2f3), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3))
  //     ).bodyMedium, titleTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xfff0f2f3), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xfff0f2f3))
  //     ).titleLarge
  //   ),

  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xff1f1f1f)
  //   ),

  //   // cardColor: Color(0xff202020), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white), bottomAppBarTheme: BottomAppBarTheme(color: Color(0xff121212))
  // );

  // static ThemeData spaceCadet = ThemeData(
  //   primaryColor: Color(0xff2B2D42),
  //   fontFamily: 'Roboto',
  //   canvasColor: Color(0xff2B2D42),
  //   brightness: Brightness.dark,
  //   secondaryHeaderColor: Color(0xff2B2D42),
  //   dividerColor: Color(0xff8D99AE),

  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: 0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Color(0xff2B2D42),
  //     selectedItemColor: Color(0xffe8eaed),
  //     unselectedItemColor: Color(0xbee8eaed),
  //   ),

  //   tabBarTheme: TabBarTheme(
  //     labelColor: Color(0xfff0f2f3),
  //     labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
  //     unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
  //   ),

  //   textTheme: TextTheme(
  //       labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
  //       bodyLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffEDF2F4)), //Color(0xffd4d4d4)),
  //       bodyMedium: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff8D99AE))

  //   ),

  //   appBarTheme: AppBarTheme(
  //     color: Color(0xff2B2D42),
  //     iconTheme: IconThemeData(color: Colors.white), systemOverlayStyle: SystemUiOverlayStyle.light, toolbarTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).bodyMedium, titleTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).titleLarge
  //   ),

  //   iconTheme: IconThemeData(
  //     color: Colors.white, //Color(0xffd4d4d4),
  //   ),

  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xff44485d)
  //   ),

  //   cardColor: Color(0xff44485d), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xffd6d8da)), colorScheme: ColorScheme(surface: Color(0xff2B2D42)), bottomAppBarTheme: BottomAppBarTheme(color: Color(0xff2B2D42))

  // );

  // static ThemeData charcoal = ThemeData(
  //   primaryColor: Color(0xff264653),
  //   fontFamily: 'Roboto',
  //   canvasColor: Color(0xff264653),
  //   brightness: Brightness.dark,
  //   secondaryHeaderColor: Color(0xff264653),
  //   dividerColor: Color(0xff8D99AE),

  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: 0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Color(0xff264653),
  //     selectedItemColor: Color(0xffe8eaed),
  //     unselectedItemColor: Color(0xbee8eaed),
  //   ),

  //   tabBarTheme: TabBarTheme(
  //     labelColor: Color(0xfff0f2f3),
  //     labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
  //     unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
  //   ),

  //   textTheme: TextTheme(
  //       labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
  //       bodyLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffEDF2F4)), //Color(0xffd4d4d4)),
  //       bodyMedium: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff8D99AE))

  //   ),

  //   appBarTheme: AppBarTheme(
  //     color: Color(0xff264653),
  //     iconTheme: IconThemeData(color: Colors.white), systemOverlayStyle: SystemUiOverlayStyle.light, toolbarTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).bodyMedium, titleTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).titleLarge
  //   ),

  //   iconTheme: IconThemeData(
  //     color: Colors.white, //Color(0xffd4d4d4),
  //   ),

  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xff335f70)
  //   ),

  //   cardColor: Color(0xff335f70), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xffd6d8da)), colorScheme: ColorScheme(surface: Color(0xff264653)), bottomAppBarTheme: BottomAppBarTheme(color: Color(0xff264653))

  // );

  // static ThemeData pansyPurple = ThemeData(
  //   primaryColor: Color(0xff830b53),
  //   fontFamily: 'Roboto',
  //   canvasColor: Color(0xff830b53),
  //   brightness: Brightness.dark,
  //   secondaryHeaderColor: Color(0xff830b53),
  //   dividerColor: Color(0xffc285aa),

  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: 0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Color(0xff830b53),
  //     selectedItemColor: Color(0xffe8eaed),
  //     unselectedItemColor: Color(0xbee8eaed),
  //   ),

  //   tabBarTheme: TabBarTheme(
  //     labelColor: Color(0xfff0f2f3),
  //     labelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
  //     unselectedLabelStyle: TextStyle(fontSize: 16,fontFamily: 'Roboto-Medium'),
      
  //   ),

  //   textTheme: TextTheme(
  //       labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white), //Color(0xfff0f2f3)),
  //       bodyLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Colors.white),
  //       bodyMedium: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xffc285aa))

  //   ),

  //   appBarTheme: AppBarTheme(
  //     color: Color(0xff830b53),
  //     iconTheme: IconThemeData(color: Colors.white), systemOverlayStyle: SystemUiOverlayStyle.light, toolbarTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).bodyMedium, titleTextStyle: TextTheme(
  //         titleLarge: TextStyle(fontSize: 20,fontFamily: 'Roboto', color: Color(0xffd6d8da), fontWeight: FontWeight.bold),
  //         labelLarge: TextStyle(fontSize: 18,fontFamily: 'Roboto', color: Color(0xff444e53))
  //     ).titleLarge
  //   ),

  //   iconTheme: IconThemeData(
  //     color: Colors.white, //Color(0xffd4d4d4),
  //   ),

  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xffaa0e6b)
  //   ),

  //   cardColor: Color(0xffaa0e6b), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xffd6d8da)), colorScheme: ColorScheme(surface: Color(0xff830b53)), bottomAppBarTheme: BottomAppBarTheme(color: Color(0xff830b53))

  // );
  
  static ThemeData getTheme(String themeName){

    ThemeData theme = ThemeData.light();

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