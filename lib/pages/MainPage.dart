import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yhwh/controllers/MainPageController.dart';
import 'package:yhwh/pages/BiblePage.dart';
import 'package:animate_do/animate_do.dart' as animateDo;
import 'package:yhwh/pages/ContactPage.dart';
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