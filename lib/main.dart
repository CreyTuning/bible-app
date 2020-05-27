import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/pages/MainPage.dart';
import 'package:yhwh/routes/Routes.dart';
import 'package:yhwh/themes.dart';

void main(List<String> args) {
  runApp(MyApp());
}


class _MyBehavior extends ScrollBehavior {
  // remove the glow effect.
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


// My App class
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    var brightness = false;

    SharedPreferences.getInstance().then((preferences){
      brightness = preferences.getBool('darkMode') ?? false;
    });

    // hacer la barra de tareas transparente
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0x00),
    ));


    return DynamicTheme(
      defaultBrightness: (brightness) == true ? Brightness.dark : Brightness.light,
      data: (Brightness brightness) => AppThemes.getTheme(brightness),

      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: getRoutes(),
          builder: (context, child) => ScrollConfiguration(behavior: _MyBehavior(), child: child), // remove the glow effect.
          title: 'Biblia del Ministro',
          theme: theme,
          home: MainPage(),
        );
      }
    );
  }
}