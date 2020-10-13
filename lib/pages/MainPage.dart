import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/pages/PageSelector.dart';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  AutoScrollController autoScrollController = AutoScrollController();
  int tabIndex = 0;

  @override
  void initState(){
    
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        tabIndex = preferences.getInt('bottomNavigationBarIndex') ?? 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageSelector(index: tabIndex, autoScrollController: autoScrollController,),

      bottomNavigationBar: Container(
        foregroundDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1.5
            )
          )
        ),

        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 1,
              spreadRadius: 1
            )
          ],

          // border: Border(
          //   top: BorderSide(
          //     color: Theme.of(context).dividerColor,
          //     width: 2
          //   )
          // )
        ),

        child: BottomNavigationBar(
          currentIndex: tabIndex,
          elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
          type: Theme.of(context).bottomNavigationBarTheme.type,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: Theme.of(context).textTheme.bodyText1.color,
          unselectedItemColor: Theme.of(context).textTheme.bodyText2.color,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Inicio'),
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
              icon: Icon(Icons.search),
              title: Text('Buscar'),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Ministro'),
            ),
          ],
          onTap: (int index){
            setState(() {
              tabIndex = index;
            });

            SharedPreferences.getInstance().then((preferences){
              preferences.setInt('bottomNavigationBarIndex', tabIndex);
            });
          },
        ),
      )
    );
  }
}


