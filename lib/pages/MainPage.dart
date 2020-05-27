import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yhwh/icons/custom_icons_icons.dart';
import 'package:yhwh/pages/PageSelector.dart';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  ScrollController scrollController = ScrollController();
  int tabIndex = 0;

  @override
  void initState(){
    
    SharedPreferences.getInstance().then((preferences){
      tabIndex = preferences.getInt('bottomNavigationBarIndex') ?? 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageSelector(index: tabIndex),
      
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).bottomAppBarColor,

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
            icon: Icon(Icons.favorite),
            title: Text('Favoritos'),
          ),

          BottomNavigationBarItem(
            icon: Icon(CustomIcons.sheep),
            title: Text('Ovejas'),
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
      )
    );
  }
}


