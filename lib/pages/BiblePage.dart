import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/ReadPreferences.dart';
import 'package:yhwh/widgets/ChapterFooter.dart';
import 'package:yhwh/widgets/Verse.dart';
import 'package:animate_do/animate_do.dart' as animateDo;

class BiblePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark 
    ));

    return animateDo.FadeIn(
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
          top: true,
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  
                  GetBuilder<BiblePageController>(
                    init: BiblePageController(),
                    builder: (biblePageController) =>  AnimatedOpacity(
                      opacity: (biblePageController.bookNumber == 1 && biblePageController.chapterNumber == 1) ? 0.0 : 1.0, // AQUIIIIIIIIIIIIIII
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: 41.0,
                        height: 41.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 2,
                              offset: Offset.fromDirection(2, 2)
                            ),
                            
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 1,
                              spreadRadius: 0
                            )
                          ]
                        ),

                        child: Tooltip(
                          message: 'Capitulo anterior',
                          child: MaterialButton(
                            elevation: 0,
                            onPressed: biblePageController.previusChapter,
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,

                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: Theme.of(context).textTheme.bodyText1.color,
                              size: 24,
                            ),
                            padding: EdgeInsets.all(0),
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(child: SizedBox.fromSize()),

                  GetBuilder<BiblePageController>(
                    init: BiblePageController(),
                    builder: (controller) => AnimatedOpacity(
                      opacity: (controller.bookNumber == 66 && controller.chapterNumber == 22) ? 0.0 : 1.0, // AQUIIIIIIIIIIIIIIIIII
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: 41.0,
                        height: 41.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 2,
                              offset: Offset.fromDirection(1, 2)
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 1,
                              spreadRadius: 0
                            )
                          ]
                        ),

                        child: Tooltip(
                          message: 'Capitulo siguiente',
                          child: MaterialButton(
                            elevation: 0,
                            onPressed: controller.nextChapter,
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,

                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: Theme.of(context).textTheme.bodyText1.color,
                              size: 24,
                            ),
                            padding: EdgeInsets.all(0),
                            shape: CircleBorder(),
                          ),
                        ),
                      )
                    ),
                  ),

                ],
              ),
            ),

            body: GetBuilder<BiblePageController>(
              init: BiblePageController(),
              builder: (biblePageController) => Scrollbar(
                child: CustomScrollView(
                  controller: biblePageController.autoScrollController,
                  slivers: [

                    // AppBar
                    SliverAppBar(
                      backgroundColor: Theme.of(context).canvasColor,
                      floating: true,
                      snap: true,
                      primary: true,
                      elevation: 0,
                      titleSpacing: 0,
                      bottom: PreferredSize(
                        child: Container(
                          color: Theme.of(context).dividerColor,
                          height: 1.5
                        ),
                        
                        preferredSize: Size.fromHeight(0)
                      ),

                      title: Stack(
                        children: [

                          // Modo lectura
                          Visibility(
                            visible: !biblePageController.selectionMode,
                            replacement: Container(),
                            child: animateDo.FadeIn(
                              child: Container(
                                height: 55,
                                child: Row(
                                  children: [

                                    Expanded(
                                      child: Tooltip(
                                        message: 'Referencias',
                                        child: InkWell(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                                          child: Container(
                                            height: 55,
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                              child: RichText(
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                text: TextSpan(
                                                  text: '${intToBook[biblePageController.bookNumber]} ${biblePageController.chapterNumber}',
                                                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                    fontFamily: 'Roboto-Medium',
                                                    fontSize: 16.6,
                                                  ),
                                                )
                                              ),
                                            ),
                                          ),

                                          onTap: biblePageController.referenceButtonOnTap,
                                          
                                        ),
                                      ),
                                    ),

                                    IconButton(
                                      tooltip: 'Pestañas',
                                      onPressed: (){},
                                      icon: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            
                                            Center(
                                              child: Container(
                                                height: 22,
                                                width: 22,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: Theme.of(context).textTheme.bodyText1.color,
                                                    width: 1.4
                                                  )
                                                ),
                                              ),
                                            ),

                                            Text('2', textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                              fontSize: 10.5,
                                              height: 1.5,
                                              fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                    ),

                                    Container(
                                      height: 55,
                                      width: 55,
                                      child: PopupMenuButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6)
                                        ),
                                        tooltip: 'Opciones',
                                        icon: Hero(
                                          tag: 'account',
                                          child: Icon(Icons.more_vert),
                                        ),

                                        onSelected: (value) {
                                          switch (value) {
                                            case 1:
                                              Get.showSnackbar(
                                                GetBar(
                                                  backgroundColor: Theme.of(context).textTheme.bodyText1.color,
                                                  titleText: Text('Resaltados', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                    color: Theme.of(context).canvasColor
                                                  )),
                                                  messageText: Text('Esta función está en desarrollo.', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                    color: Theme.of(context).canvasColor
                                                  )),
                                                  icon: Icon(Icons.error, color: Theme.of(context).canvasColor),
                                                  duration: Duration(seconds: 2),
                                                )
                                              );
                                              break;
                                            case 2:
                                              Get.showSnackbar(
                                                GetBar(
                                                  backgroundColor: Theme.of(context).textTheme.bodyText1.color,
                                                  titleText: Text('Notas', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                    color: Theme.of(context).canvasColor
                                                  )),
                                                  messageText: Text('Esta función está en desarrollo.', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                    color: Theme.of(context).canvasColor
                                                  )),
                                                  icon: Icon(Icons.error, color: Theme.of(context).canvasColor),
                                                  duration: Duration(seconds: 2),
                                                )
                                              );
                                              break;
                                            case 3:
                                            Get.showSnackbar(
                                                GetBar(
                                                  backgroundColor: Theme.of(context).textTheme.bodyText1.color,
                                                  titleText: Text('Diario', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                    color: Theme.of(context).canvasColor
                                                  )),
                                                  messageText: Text('Esta función está en desarrollo.', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                    color: Theme.of(context).canvasColor
                                                  )),
                                                  icon: Icon(Icons.error, color: Theme.of(context).canvasColor),
                                                  duration: Duration(seconds: 2),
                                                )
                                              );
                                              break;
                                            case 4:
                                              Get.to(ReadPreferences());
                                              break;
                                          }
                                        },

                                        itemBuilder: (context) {
                                          return <PopupMenuEntry<dynamic>>[

                                            PopupMenuItem(
                                              enabled: false,
                                              child: Container(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                                      child: Hero(
                                                        tag: 'account',
                                                        child: CircleAvatar(
                                                          backgroundColor: Theme.of(context).accentColor,
                                                          child: Icon(
                                                            Icons.person,
                                                            color: Theme.of(context).canvasColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Luis Romero',
                                                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                            fontFamily: 'Roboto-Medium',
                                                            fontSize: 16.6,
                                                          ),
                                                        ),

                                                        Text(
                                                          'Desconectado',
                                                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                                            fontFamily: 'Roboto-Medium',
                                                            fontSize: 15,
                                                          ),
                                                        ),


                                                      ],  
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),

                                            PopupMenuDivider(),

                                            PopupMenuItem(
                                              value: 1,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                                    child: Icon(FontAwesomeIcons.highlighter),
                                                  ),
                                                  Text('Resaltados')
                                                ],
                                              )
                                            ),

                                            PopupMenuItem(
                                              value: 2,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                                    child: Icon(FontAwesomeIcons.solidStickyNote),
                                                  ),
                                                  Text('Notas')
                                                ],
                                              )
                                            ),

                                            PopupMenuItem(
                                              value: 3,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                                    child: Icon(FontAwesomeIcons.bookReader),
                                                  ),
                                                  Text('Diario')
                                                ],
                                              )
                                            ),

                                            PopupMenuDivider(),

                                            PopupMenuItem(
                                              value: 4,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                                    child: Icon(FontAwesomeIcons.wrench)
                                                  ),
                                                  Text('Preferencias')
                                                ],
                                              )
                                            ),
                                          ];
                                        }
                                      ),
                                    ),

                                  ],
                                )
                              ),
                            ),
                          ),

                          // Modo seleccion
                          Visibility(
                            visible: biblePageController.selectionMode,
                            replacement: Container(),
                            child: animateDo.FadeIn(
                              child: Container(
                                height: 55,
                                color: Theme.of(context).appBarTheme.color,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        tooltip: 'Cancelar',
                                        icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme.color),
                                        onPressed: biblePageController.cancelSelectionModeOnTap,
                                      ),

                                      Expanded(
                                        child: Container(
                                          height: 55,
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                            child: RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: TextSpan(
                                                text: '${biblePageController.versesSelected.length}',
                                                style: Theme.of(context).textTheme.bodyText1.copyWith(
                                                  fontFamily: 'Roboto-Medium',
                                                  fontSize: 21,
                                                ),
                                              )
                                            ),
                                          ),
                                        ),
                                      ),

                                      IconButton(
                                        tooltip: 'Resaltar',
                                        icon: Icon(
                                          FontAwesomeIcons.highlighter,
                                          color: Theme.of(context).appBarTheme.iconTheme.color,
                                          size: 18,
                                        ),
                                        onPressed: (){},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),

                    // Verses list
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext buildContext, int index){
                          return AutoScrollTag(
                            key: ValueKey(index),
                            controller: biblePageController.autoScrollController,
                            index: index,

                            child: Verse(
                              highlight: false,
                              selected: biblePageController.versesSelected.contains(index + 1),
                              verseNumber: index + 1,
                              title: null,
                              text: biblePageController.versesRawList[index].text,

                              colorNumber: Theme.of(context).textTheme.bodyText2.color,
                              colorText: Theme.of(context).textTheme.bodyText1.color,
                              fontSize: biblePageController.fontSize,
                              fontHeight: biblePageController.fontHeight,
                              fontLetterSeparation: biblePageController.fontLetterSeparation,

                              onTap: ( ) {
                                biblePageController.onVerseTap(index + 1);
                              },

                              onLongPress: (){
                                biblePageController.onVerseLongPress(index + 1);
                              },
                            )
                          );
                        },

                        childCount: biblePageController.versesRawList.length,
                      ),
                    ),

                    // Chapter footer
                    ChapterFooter(
                      bibleVersion: biblePageController.bibleVersion,
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}