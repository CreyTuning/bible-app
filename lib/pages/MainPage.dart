import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/MainPageController.dart';
import 'package:yhwh/pages/BiblePage.dart';
import 'package:animate_do/animate_do.dart' as animateDo;


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: GetBuilder<MainPageController>(
        init: MainPageController(),
        builder: (controller) {
          switch (controller.mainPagetabIndex) {
            case 1:
              return BiblePage();
              break;
            default:
              return animateDo.FadeIn(child: Center(child: Text("En desarrollo")), duration: Duration(milliseconds: 150),);
          }        
        },
      ),

      bottomNavigationBar: Container(
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
              elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
              type: Theme.of(context).bottomNavigationBarTheme.type,
              backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              selectedItemColor: Theme.of(context).textTheme.bodyText1.color,
              unselectedItemColor: Theme.of(context).textTheme.bodyText2.color,

              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Biblia',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Estudio',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.music_note),
                  label: 'Música',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Ministro',
                ),
              ],

              onTap: _.bottomNavigationBarOnTap
            );
          },
        )
      )
    );
  }
}