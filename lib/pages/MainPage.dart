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
      setState(() {
        tabIndex = preferences.getInt('bottomNavigationBarIndex') ?? 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      extendBody: true,

      body: PageSelector(index: tabIndex, scrollController: scrollController,),

      bottomNavigationBar: Container(
        height: 45,
        // width: double.infinity,
        width: MediaQueryData().size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 3
            )
          ],

          color: Theme.of(context).bottomAppBarColor.withOpacity(0.95),
        ),

        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround, 
            mainAxisSize: MainAxisSize.min,


            children: <Widget>
            [
              
              Expanded(
                flex: (tabIndex == 0) ? 2 : 1,
                child: InkWell(
                  onTap: (){

                    setState((){
                      tabIndex = 0;
                    });

                    SharedPreferences.getInstance().then((preferences){
                      preferences.setInt('bottomNavigationBarIndex', tabIndex);
                    });
                  },

                  child: Container(
                    height: double.infinity,

                    decoration: BoxDecoration(
                      color: (tabIndex == 0) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.home, color: (tabIndex == 0) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
                        (tabIndex == 0) ? SizedBox(width: 10,) : SizedBox(),
                        
                        (tabIndex == 0) ?  Text('Inicio', 
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            // color: Colors.white,
                            fontFamily: 'Roboto-Medium',
                            fontSize: 16.6,
                            height: 1.4
                          )
                        ) : SizedBox(),
                        
                      ],
                    )
                  )
                  // title: Text('Inicio'),
                ),
              ),

              Expanded(
                flex: (tabIndex == 1) ? 2 : 1,
                child: InkWell(
                  onTap: (){

                    setState((){
                      tabIndex = 1;
                    });

                    SharedPreferences.getInstance().then((preferences){
                      preferences.setInt('bottomNavigationBarIndex', tabIndex);
                    });
                  },
                  child: Container(
                    height: double.infinity,

                    decoration: BoxDecoration(
                      color: (tabIndex == 1) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(CupertinoIcons.book_solid, color: (tabIndex == 1) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
                        (tabIndex == 1) ? SizedBox(width: 10,) : SizedBox(),
                        
                        (tabIndex == 1) ?  Text('Leer', 
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            // color: Colors.white,
                            fontFamily: 'Roboto-Medium',
                            fontSize: 16.6,
                            height: 1.4
                          )
                        ) : SizedBox(),
                        
                      ],
                    )
                  )
                  // title: Text('Biblia'),
                ),
              ),

              Expanded(
                flex: (tabIndex == 2) ? 2 : 1,
                child: InkWell(
                  onTap: (){

                    setState((){
                      tabIndex = 2;
                    });

                    SharedPreferences.getInstance().then((preferences){
                      preferences.setInt('bottomNavigationBarIndex', tabIndex);
                    });
                  },
                  child: Container(
                    height: double.infinity,

                    decoration: BoxDecoration(
                      color: (tabIndex == 2) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.school, color: (tabIndex == 2) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22),
                        
                        (tabIndex == 2) ? SizedBox(width: 10,) : SizedBox(),
                        
                        (tabIndex == 2) ?  Text('Saber', 
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            // color: Colors.white,
                            fontFamily: 'Roboto-Medium',
                            fontSize: 16.6,
                            height: 1.4
                          )
                        ) : SizedBox(),
                        
                      ],
                    )
                  )
                  // title: Text('Aprender'),
                ),
              ),

              Expanded(
                flex: (tabIndex == 3) ? 2 : 1,
                child: InkWell(
                  onTap: (){

                    setState((){
                      tabIndex = 3;
                    });

                    SharedPreferences.getInstance().then((preferences){
                      preferences.setInt('bottomNavigationBarIndex', tabIndex);
                    });
                  },
                  child: Container(
                    height: double.infinity,
                    // width: double.infinity,
                    // width: 35,
                    decoration: BoxDecoration(
                      color: (tabIndex == 3) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.forum, color: (tabIndex == 3) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
                        (tabIndex == 3) ? SizedBox(width: 10,) : SizedBox(),
                        
                        (tabIndex == 3) ?  Text('Orar', 
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            // color: Colors.white,
                            fontFamily: 'Roboto-Medium',
                            fontSize: 16.6,
                            height: 1.4
                          )
                        ) : SizedBox(),
                        
                      ],
                    )
                  )
                  // title: Text('Oración'),
                ),
              ),

              Expanded(
                flex: (tabIndex == 4) ? 2 : 1,
                child: InkWell(
                  onTap: (){

                    setState((){
                      tabIndex = 4;
                    });

                    SharedPreferences.getInstance().then((preferences){
                      preferences.setInt('bottomNavigationBarIndex', tabIndex);
                    });
                  },
                  child: Container(
                    height: double.infinity,

                    decoration: BoxDecoration(
                      color: (tabIndex == 4) ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(CustomIcons.sheep, color: (tabIndex == 4) ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).textTheme.bodyText2.color, size: 22,),
                        
                        (tabIndex == 4) ? SizedBox(width: 10,) : SizedBox(),
                        
                        (tabIndex == 4) ?  Text('Ovejas', 
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            // color: Colors.white,
                            fontFamily: 'Roboto-Medium',
                            fontSize: 16.6,
                            height: 1.4
                          )
                        ) : SizedBox(),
                        
                      ],
                    )
                  )
                  // title: Text('Ovejas'),
                ),
              ),
            ],
          ),
        ),
        
        // NewScrollBottomNavigationBar(
        //   controller: scrollController,
        //   type: BottomNavigationBarType.fixed,
        //   unselectedItemColor: Theme.of(context).textTheme.bodyText2.color,
        //   selectedItemColor: Theme.of(context).textTheme.bodyText1.color,
        //   backgroundColor: Theme.of(context).bottomAppBarColor.withOpacity(0.5),

        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       title: Text('Inicio'),
        //     ),

        //     BottomNavigationBarItem(
        //       icon: Icon(CupertinoIcons.book_solid),
        //       title: Text('Biblia'),
        //     ),

        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.school),
        //       title: Text('Aprender'),
        //     ),

        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.forum),
        //       title: Text('Oración'),
        //     ),

        //     BottomNavigationBarItem(
        //       icon: Icon(CustomIcons.sheep),
        //       title: Text('Ovejas'),
        //     ),
        //   ],
        // ),
      )
    );
  }
}


