import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:yhwh/pages/BiblePage/BiblePage.dart';
import 'package:yhwh/pages/Buscar/BuscarPage.dart';
import 'package:yhwh/pages/PageSelector.dart';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  PersistentTabController _controller = PersistentTabController(initialIndex: 1);
  ScrollController scrollController = ScrollController();
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

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Inicio"),
        titleFontSize: 16,
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.book_solid),
        title: ("Leer"),
        titleFontSize: 16,
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.school),
        title: ("Aprender"),
        titleFontSize: 12,
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Buscar"),
        titleFontSize: 15,
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Ministro"),
        titleFontSize: 14,
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,

      screens: [
        EnDesarrollo(title: 'Inicio'),
        BiblePage(scrollController: scrollController),
        EnDesarrollo(title: 'Aprender'),
        BuscarPage(),
        EnDesarrollo(title: 'Ministro')
      ],

      items: _navBarsItems(),

      confineInSafeArea: true,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      iconSize: 22,
      navBarHeight: 50,
      padding: NavBarPadding.fromLTRB(0, 0, 16, 16),

      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5
          )
        ],
      ),
      
      popAllScreensOnTapOfSelectedTab: true,

      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),

      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      onItemSelected: (index){
        tabIndex = index;
 
        SharedPreferences.getInstance().then((preferences){
          preferences.setInt('bottomNavigationBarIndex', tabIndex);
        });
      },

      navBarStyle: NavBarStyle.style9 // Choose the nav bar style with this property.
    );
  }
}


