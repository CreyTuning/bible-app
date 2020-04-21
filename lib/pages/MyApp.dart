import 'package:yhwh/data/Data.dart';
import 'package:yhwh/pages/StylePage.dart';
import 'package:yhwh/routes/Routes.dart' as Routes;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'HomePage.dart';

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0x00),
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: Routes.getRoutes(),

//      initialRoute: 'styles',
      theme: appTheme().theme_light,
      darkTheme: appTheme().theme_dark,
      themeMode: (appData.darkModeEnabled) ? ThemeMode.dark : ThemeMode.light,
    );
  }
}