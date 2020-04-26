import 'package:flutter/cupertino.dart';
import 'package:yhwh/data/Data.dart';
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
          debugShowCheckedModeBanner: false,
          routes: Routes.getRoutes(),
          theme: appTheme().theme_light,
          darkTheme: appTheme().theme_dark,
          themeMode: (appData.darkModeEnabled) ? ThemeMode.dark : ThemeMode.light,
          home: Scaffold(
            body: PageSelector(index: indexNavigation),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: indexNavigation,
              onTap: (_) async{
                appData.bottomNavigationBarIndex = _;
                await appData.saveData();
                indexNavigation = _;
                setState(() {});
              },

              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Incio')
                ),

                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book_solid),
                  title: Text('Biblia'),
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.extension),
                  title: Text('Aprender'),
                ),
              ],
            )
          )
        );
      },
    );
  }
}

class BBar extends StatefulWidget{

  int indexNavigation;
  BBar({this.indexNavigation});

  @override
  State<StatefulWidget> createState() {
    return _BBarState();
  }
}

class _BBarState extends State<BBar>{
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.indexNavigation,
      onTap: (_) async{
        appData.bottomNavigationBarIndex = _;
        await appData.saveData();
        widget.indexNavigation = _;
      },

      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Incio')
        ),

        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book_solid),
          title: Text('Biblia'),
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.extension),
          title: Text('Aprender'),
        ),
      ],
    );
  }
}