import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yhwh/pages/Home/Schedule/ScheduleAllDays.dart';
import 'package:yhwh/pages/Home/Schedule/ScheduleToday.dart';
import 'package:yhwh/pages/Home/VerseOfTheDay/VerseOfTheDay.dart';
import 'package:yhwh/ui_widgets/HomeFooter.dart';
import 'package:yhwh/ui_widgets/SliverFloatingBarLocal.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark 
    ));

    
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Scrollbar(
            child: CustomScrollView(
            // controller: widget.autoScrollController,
            slivers: [
              SliverToBoxAdapter(
                child: ScheduleAllDays(),
              ),

              SliverFloatingBarLocal(
                backgroundColor: Theme.of(context).cardColor,
                floating: true,
                snap: true,
                elevation: 3,

                title: Row(
                  children: <Widget>[

                    Spacer(),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Mi', 
                            style: TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 20,
                              color: Colors.blueAccent,
                              height: 2,
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 0.8
                            ),
                          ),

                          TextSpan(
                            text: 'nis', 
                            style: TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 20,
                              color: Colors.green,
                              height: 2,
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 0.8
                            ),
                          ),

                          TextSpan(
                            text: 'te', 
                            style: TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 20,
                              color: Colors.orangeAccent,
                              height: 2,
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 0.8
                            ),
                          ),

                          TextSpan(
                            text: 'rio', 
                            style: TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 20,
                              color: Colors.pinkAccent,
                              height: 2,
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 0.8
                            ),
                          ),

                          TextSpan(
                            text: ' YHWH', 
                            style: TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 20,
                              color: Theme.of(context).textTheme.bodyText1.color,
                              height: 2,
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 0.8
                            ),
                          )
                        ]
                      ),
                    ),

                    Spacer(),

                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: ScheduleToday(),
              ),

              SliverToBoxAdapter(
                child: VerseOfTheDay(),
              ),

              SliverToBoxAdapter(
                child: HomeFooter(),
              )
            ]
          )
        )
      )
    ));
    
  }
}