import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/MainPageController.dart';
import 'package:yhwh/pages/BiblePage.dart';
import 'package:animate_do/animate_do.dart' as animateDo;
import 'package:yhwh/pages/ContactPage.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark ,
      systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false
    ));


    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,

      body: GetBuilder<MainPageController>(
        init: MainPageController(),
        builder: (controller) {
          switch (controller.mainPagetabIndex) {
            case 0:
              return BiblePage();
            case 1:
              return ContactPage();
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
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.7),
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
                  backgroundColor: Theme.of(context).canvasColor.withValues(alpha: 0.8),
                  selectedItemColor: Theme.of(context).indicatorColor.withValues(alpha: 0.9),
                  unselectedItemColor: Theme.of(context).indicatorColor.withValues(alpha: 0.6),
              
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