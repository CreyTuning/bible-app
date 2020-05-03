import 'package:flutter/cupertino.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/icons/custom_icons_icons.dart';
import 'package:yhwh/pages/BiblePage/StylePage.dart';
import 'package:yhwh/pages/PageSelector.dart';
import 'package:yhwh/routes/Routes.dart' as Routes;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'BiblePage/BiblePage.dart';

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  int indexNavigation = 0;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0x00),
    ));

    return FutureBuilder(
      future: appData.loadSaveData(),
      builder: (context, snapshot){
        indexNavigation = appData.bottomNavigationBarIndex;

        return MaterialApp(

          builder: (context, child) // remove the glow effect.
          {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child,
            );
          },

          debugShowCheckedModeBanner: false,
          routes: Routes.getRoutes(),
          theme: appTheme().theme_light,
          darkTheme: appTheme().theme_dark,
          themeMode: (appData.darkModeEnabled) ? ThemeMode.dark : ThemeMode.light,
          home: Scaffold(
            body: PageSelector(index: indexNavigation),

            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: appData.darkMode ? Color(0xff1a1a1a) : Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: indexNavigation,
              elevation: 10,
              onTap: (_) async{
                appData.bottomNavigationBarIndex = _;
                await appData.saveData();
                indexNavigation = _;
                setState(() {});
              },

              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Inicio')
                ),

                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book_solid),
                  title: Text('Biblia'),
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  title: Text('Aprender'),
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text('Favoritos'),
                ),

                BottomNavigationBarItem(
                  icon: Icon(CustomIcons.sheep),
                  title: Text('Ovejas'),
                ),
              ],
            )
          )
        );
      },
    );
  }
}


class MyBehavior extends ScrollBehavior {
  // remove the glow effect.
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}





class ThemeChanger extends StatefulWidget{

  MaterialApp materialApp;
  ThemeData theme = (appData.darkModeEnabled) ? appTheme().theme_dark : appTheme().theme_light;
  ThemeChanger({this.materialApp});


  @override
  State<StatefulWidget> createState() {
    return _ThemeChangerState();
  }
}

class _ThemeChangerState extends State<ThemeChanger>{
  @override
  Widget build(BuildContext context) {
    return widget.materialApp;
  }
}