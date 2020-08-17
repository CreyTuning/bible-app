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



class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool brightness = false;
  bool blackThemeEnabled = false;
  
  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        brightness = preferences.getBool('darkMode') ?? false;
        blackThemeEnabled = preferences.getBool('blackThemeEnabled') ?? false;
      });
    });

    // hacer la barra de tareas transparente
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarBrightness: Brightness.dark
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return DynamicTheme(
      defaultBrightness: (brightness) == true ? Brightness.dark : Brightness.light,
      data: (Brightness brightness) => AppThemes.getTheme(brightness, blackThemeEnabled),

      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: getRoutes(),
          builder: (context, child) => ScrollConfiguration(behavior: _MyBehavior(), child: child), // remove the glow effect.
          title: 'Biblia',
          theme: theme,
          home: MainPage(),
        );
      }
    );
  }
}