import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yhwh/controllers/MainPageController.dart';
import 'package:yhwh/pages/BiblePage.dart';
import 'package:animate_do/animate_do.dart' as animateDo;
import 'package:contactus/contactus.dart';
import 'package:yhwh/widgets/Verse.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBody: true,

      body: GetBuilder<MainPageController>(
        init: MainPageController(),
        builder: (controller) {
          switch (controller.mainPagetabIndex) {
            case 0:
              return BiblePage();
              break;
            case 1:
              return animateDo.FadeIn(
                duration: Duration(milliseconds: 150),
                child: Scaffold(
                  backgroundColor: Theme.of(context).canvasColor,
                  body: Center(
                    child: Container(
                      height: 550,
                      child: ListView(
                        
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100,
                            child: Container(
                              child: Image(
                                isAntiAlias: true,
                                image: AssetImage('assets/portrait_logo.png')
                              ),
                            ),
                          ),
              
                          Container(height: 20),
              
                          InkWell(
                            onTap: () => launch('https://instagram.com/iglesiayhwh'),
                            child: Container(
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.instagram),
                                  Container(width: 5),
                                  Text(
                                  'Instagram',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                ],
                              ),
                            ),
                          ),
              
                          InkWell(
                            onTap: () => launch('https://github.com/llromerorr'),
                            child: Container(
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.github),
                                  Container(width: 5),
                                  Text(
                                  'Github',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                ],
                              ),
                            ),
                          ),
              
                          InkWell(
                            onTap: () => launch('mailto:yhwh.principal@gmail.com'),
                            child: Container(
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.message),
                                  Container(width: 5),
                                  Text(
                                  'Email',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                ],
                              ),
                            ),
                          ),

                          Column(
                            children: <Widget>[
                              Divider(height: 25, color: Color(0x00)),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Desarrollado por Luis Romero.',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Baloo',
                                          color: Theme.of(context).textTheme.bodyText2.color,
                                          height: 1.2
                                      )
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                              ),

                              TextButton(
                                child: Text('Version: 1.0.0',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Baloo',
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.bodyText1.color
                                  )
                                ),
                                onPressed: null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              );
            default:
              return animateDo.FadeIn(child: Center(child: Text("En desarrollo")), duration: Duration(milliseconds: 150),);
          }        
        },
      ),


      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24, tileMode: TileMode.mirror),
          child: Container(
            foregroundDecoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1.5
                )
              )
            ),
              
            child: GetBuilder<MainPageController>(
              init: MainPageController(),
              builder: (_){
                return BottomNavigationBar(
                  currentIndex: _.mainPagetabIndex,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor.withOpacity(0.5),
                  selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                  unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
              
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: 'Biblia',
                    ),
              
                    BottomNavigationBarItem(
                      icon: Icon(Icons.alternate_email_rounded),
                      label: 'Contacto',
                    ),
                  ],
              
                  onTap: _.bottomNavigationBarOnTap
                );
              },
            )
          ),
        ),
      )
    );
  }
}