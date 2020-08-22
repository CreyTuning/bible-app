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
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.book_solid),
        title: ("Leer"),
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.school),
        title: ("Aprender"),
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Buscar"),
        activeColor: Theme.of(context).textTheme.bodyText1.color,
        inactiveColor: Theme.of(context).textTheme.bodyText2.color,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Ministro"),
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

    return Scaffold(
      
      extendBody: true,

      body: PageSelector(index: tabIndex, scrollController: scrollController,),

      // bottomNavigationBar: Container(
      //   height: 45,
      //   // width: double.infinity,
      //   width: MediaQueryData().size.width,
      //   decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.6),
      //         blurRadius: 3
      //       )
      //     ],

      //     color: Theme.of(context).bottomAppBarColor,
      //   ),

      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       // mainAxisAlignment: MainAxisAlignment.spaceAround, 
      //       mainAxisSize: MainAxisSize.min,


      //       children: <Widget>
      //       [
              
      //         Expanded(
      //           flex: (tabIndex == 0) ? 2 : 1,
      //           child: InkWell(
      //             onTap: (){

      //               setState((){
      //                 tabIndex = 0;
      //               });

      //               SharedPreferences.getInstance().then((preferences){
      //                 preferences.setInt('bottomNavigationBarIndex', tabIndex);
      //               });
      //             },

      //             child: Container(
      //               height: double.infinity,

      //               decoration: BoxDecoration(
      //                 color: (tabIndex == 0) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
      //                 borderRadius: BorderRadius.circular(5)
      //               ),

      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(Icons.home, color: (tabIndex == 0) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
      //                   (tabIndex == 0) ? SizedBox(width: 10,) : SizedBox(),
                        
      //                   (tabIndex == 0) ?  Text('Inicio', 
      //                     style: Theme.of(context).textTheme.bodyText1.copyWith(
      //                       // color: Colors.white,
      //                       fontFamily: 'Roboto-Medium',
      //                       fontSize: 16.6,
      //                       height: 1.4
      //                     )
      //                   ) : SizedBox(),
                        
      //                 ],
      //               )
      //             )
      //             // title: Text('Inicio'),
      //           ),
      //         ),

      //         Expanded(
      //           flex: (tabIndex == 1) ? 2 : 1,
      //           child: InkWell(
      //             onTap: (){

      //               setState((){
      //                 tabIndex = 1;
      //               });

      //               SharedPreferences.getInstance().then((preferences){
      //                 preferences.setInt('bottomNavigationBarIndex', tabIndex);
      //               });
      //             },
      //             child: Container(
      //               height: double.infinity,

      //               decoration: BoxDecoration(
      //                 color: (tabIndex == 1) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
      //                 borderRadius: BorderRadius.circular(5)
      //               ),

      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(CupertinoIcons.book_solid, color: (tabIndex == 1) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
      //                   (tabIndex == 1) ? SizedBox(width: 10,) : SizedBox(),
                        
      //                   (tabIndex == 1) ?  Text('Leer', 
      //                     style: Theme.of(context).textTheme.bodyText1.copyWith(
      //                       // color: Colors.white,
      //                       fontFamily: 'Roboto-Medium',
      //                       fontSize: 16.6,
      //                       height: 1.4
      //                     )
      //                   ) : SizedBox(),
                        
      //                 ],
      //               )
      //             )
      //             // title: Text('Biblia'),
      //           ),
      //         ),

      //         Expanded(
      //           flex: (tabIndex == 2) ? 2 : 1,
      //           child: InkWell(
      //             onTap: (){

      //               setState((){
      //                 tabIndex = 2;
      //               });

      //               SharedPreferences.getInstance().then((preferences){
      //                 preferences.setInt('bottomNavigationBarIndex', tabIndex);
      //               });
      //             },
      //             child: Container(
      //               height: double.infinity,

      //               decoration: BoxDecoration(
      //                 color: (tabIndex == 2) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
      //                 borderRadius: BorderRadius.circular(5)
      //               ),

      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(Icons.school, color: (tabIndex == 2) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22),
                        
      //                   (tabIndex == 2) ? SizedBox(width: 10,) : SizedBox(),
                        
      //                   (tabIndex == 2) ?  Text('Saber', 
      //                     style: Theme.of(context).textTheme.bodyText1.copyWith(
      //                       // color: Colors.white,
      //                       fontFamily: 'Roboto-Medium',
      //                       fontSize: 16.6,
      //                       height: 1.4
      //                     )
      //                   ) : SizedBox(),
                        
      //                 ],
      //               )
      //             )
      //             // title: Text('Aprender'),
      //           ),
      //         ),

      //         Expanded(
      //           flex: (tabIndex == 3) ? 2 : 1,
      //           child: InkWell(
      //             onTap: (){

      //               setState((){
      //                 tabIndex = 3;
      //               });

      //               SharedPreferences.getInstance().then((preferences){
      //                 preferences.setInt('bottomNavigationBarIndex', tabIndex);
      //               });
      //             },
      //             child: Container(
      //               height: double.infinity,
      //               // width: double.infinity,
      //               // width: 35,
      //               decoration: BoxDecoration(
      //                 color: (tabIndex == 3) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
      //                 borderRadius: BorderRadius.circular(5)
      //               ),

      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(Icons.search, color: (tabIndex == 3) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
      //                   (tabIndex == 3) ? SizedBox(width: 10,) : SizedBox(),
                        
      //                   (tabIndex == 3) ?  Text('Buscar', 
      //                     style: Theme.of(context).textTheme.bodyText1.copyWith(
      //                       // color: Colors.white,
      //                       fontFamily: 'Roboto-Medium',
      //                       fontSize: 16.6,
      //                       height: 1.4
      //                     )
      //                   ) : SizedBox(),
                        
      //                 ],
      //               )
      //             )
      //             // title: Text('Oración'),
      //           ),
      //         ),

      //         Expanded(
      //           flex: (tabIndex == 4) ? 2 : 1,
      //           child: InkWell(
      //             onTap: (){

      //               setState((){
      //                 tabIndex = 4;
      //               });

      //               SharedPreferences.getInstance().then((preferences){
      //                 preferences.setInt('bottomNavigationBarIndex', tabIndex);
      //               });
      //             },
      //             child: Container(
      //               height: double.infinity,

      //               decoration: BoxDecoration(
      //                 color: (tabIndex == 4) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
      //                 borderRadius: BorderRadius.circular(5)
      //               ),

      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: <Widget>[
      //                   Icon(Icons.person, color: (tabIndex == 4) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
      //                   (tabIndex == 4) ? SizedBox(width: 10,) : SizedBox(),
                        
      //                   (tabIndex == 4) ?  Text('Siervo', 
      //                     style: Theme.of(context).textTheme.bodyText1.copyWith(
      //                       // color: Colors.white,
      //                       fontFamily: 'Roboto-Medium',
      //                       fontSize: 16.6,
      //                       height: 1.4
      //                     )
      //                   ) : SizedBox(),
                        
      //                 ],
      //               )
      //             )
      //             // title: Text('Ovejas'),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}


