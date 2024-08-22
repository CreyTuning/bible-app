import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yhwh/controllers/BiblePageController.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yhwh/controllers/MainPageController.dart';
import 'package:yhwh/data/Define.dart';
import 'package:yhwh/pages/HighlighterCreate.dart';
import 'package:yhwh/pages/HighlighterPage.dart';
import 'package:yhwh/pages/ReadPreferences.dart';
import 'package:yhwh/widgets/ChapterFooter.dart';
import 'package:yhwh/widgets/SelectionAppbar.dart';
import 'package:yhwh/widgets/Verse.dart';
import 'package:animate_do/animate_do.dart' as animateDo;

class BiblePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark 
    ));

    return GetBuilder<BiblePageController>(
      init: BiblePageController(),
      builder: (mainController) => !mainController.isScreenReady ? Center(child: CircularProgressIndicator(),) : WillPopScope(
        onWillPop: () {
          BiblePageController onWillPopBiblePageController = Get.put(BiblePageController());
          MainPageController onWillPopMainPageController = Get.put(MainPageController());
          
          if(onWillPopBiblePageController.selectionMode){
            onWillPopBiblePageController.cancelSelectionModeOnTap();
          }
          
          else {
            onWillPopMainPageController.bottomNavigationBarOnTap(0);
          }

          return;
        },

        child: animateDo.FadeIn(
          duration: Duration(milliseconds: 150),
          child: Container(
            color: Theme.of(context).canvasColor,
            child: SafeArea(
              top: true,
              child: Scaffold(
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                
                floatingActionButton: GetBuilder<BiblePageController>(
                    id: 'floatingActionButton',
                    init: BiblePageController(),
                    builder: (biblePageController) => Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      
                      children: <Widget>[
                        //Genera efecto de movimiento en el Floating Button                        
                        AnimatedPadding(
                          padding: EdgeInsets.symmetric(horizontal: (biblePageController.bookNumber == 1 && biblePageController.chapterNumber == 1) ? 2 : 0),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),

                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          child: (biblePageController.bookNumber == 1 && biblePageController.chapterNumber == 1) ? SizedBox() : Container(
                            width: 45.0,
                            height: 45.0,
                            child: Tooltip(
                              message: 'Capitulo anterior',
                              child: MaterialButton(
                                elevation: 4,
                                onPressed: biblePageController.previusChapter,
                                color: Theme.of(context).canvasColor,

                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(0),
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 1.5
                                  )
                                ),
                              ),
                            ),
                          )
                        ),

                        Expanded(child: SizedBox.fromSize()),

                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          child: (biblePageController.bookNumber == 66 && biblePageController.chapterNumber == 22) ? SizedBox() : Container(
                            width: 45.0,
                            height: 45.0,
                            child: Tooltip(
                              message: 'Capitulo siguiente',
                              child: MaterialButton(
                                elevation: 4,
                                onPressed: biblePageController.nextChapter,
                                color: Theme.of(context).canvasColor,

                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 24,
                                ),
                                padding: EdgeInsets.all(0),
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 1.5
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Genera efecto de movimiento en el Floating Button
                        AnimatedPadding(
                          padding: EdgeInsets.symmetric(horizontal: (biblePageController.bookNumber == 66 && biblePageController.chapterNumber == 22) ? 2 : 0),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                      ],
                    ),
                  ),
                ),

                body: GetBuilder<BiblePageController>(
                  init: BiblePageController(),
                  builder: (biblePageController) => SelectionAppbar(
                    visible: biblePageController.selectionMode,
                    appbar: AppBar(
                      backgroundColor: Theme.of(context).canvasColor,
                      titleSpacing: 0,
                      elevation: 0,
                      bottom: PreferredSize(
                        child: Container(
                          color: Theme.of(context).dividerColor,
                          height: 1.5
                        ),
                        
                        preferredSize: Size.fromHeight(0)
                      ),

                      leading: IconButton(
                        tooltip: 'Cancelar',
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyText1.color),
                        onPressed: biblePageController.cancelSelectionModeOnTap,
                      ),

                      actions: [
                        // IconButton(
                        //   tooltip: 'Agregar al diario',
                        //   icon: Icon(
                        //     FontAwesomeIcons.bookReader,
                        //     color: Theme.of(context).textTheme.bodyText1.color,
                        //     size: 18,
                        //   ),
                        //   onPressed: (){},
                        // ),

                        // IconButton(
                        //   tooltip: 'Crear nota',
                        //   icon: Icon(
                        //     FontAwesomeIcons.solidStickyNote,
                        //     color: Theme.of(context).textTheme.bodyText1.color,
                        //     size: 18,
                        //   ),
                        //   onPressed: (){},
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 55,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text: 'Guardar',
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontFamily: 'Roboto-Medium',
                                      fontSize: 22,
                                    ),
                                  )
                                ),
                              ),
                            ),

                            onTap: (){
                              Get.bottomSheet(
                                Container(
                                  height: 115,
                                  child: BottomSheet(
                                    onClosing: (){},
                                    builder: (context) => HihglighterCreate(),
                                    enableDrag: false,
                                  ),
                                ),

                                enableDrag: true,
                                isDismissible: true,
                                isScrollControlled: false,
                              );
                            }
                          ),
                        ),
                      ],

                      title: Text(
                        '${biblePageController.versesSelected.length}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontFamily: 'Roboto-Medium',
                          fontSize: 22,
                        )
                      )
                    ),

                    child: NotificationListener<ScrollNotification>(
                      onNotification: biblePageController.scrollNotification,
                      child: RawScrollbar(
                        thumbColor: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.4),
                        child: CustomScrollView(
                          controller: biblePageController.autoScrollController,
                          slivers: [
                            // AppBar
                            SliverAppBar(
                              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                              floating: false,
                              snap: false,
                              primary: true,
                              pinned: true,
                              elevation: 0,
                              titleSpacing: 0,
                              bottom: PreferredSize(
                                child: Container(
                                  color: Theme.of(context).dividerColor,
                                  height: 1.5
                                ),
                                
                                preferredSize: Size.fromHeight(0)
                              ),

                              title: Container(
                                height: 65,
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
                                                    fontSize: 22,
                                                  ),
                                                )
                                              ),
                                            ),
                                          ),

                                          onTap: biblePageController.referenceButtonOnTap,
                                          
                                        ),
                                      ),
                                    ),

                                    // IconButton(
                                    //   tooltip: 'Marcadores',
                                    //   onPressed: (){
                                    //     /*
                                    //       Recuerda agregar biblePageController.cancelSelectionModeOnTap(),
                                    //       para evitar un posible bug al momento de entrar en modo
                                    //       seleccion y presionar alguna otra funccion en pantalla.
                                    //     */
                                    //   },
                                    //   icon: Stack(
                                    //       alignment: Alignment.center,
                                    //       children: [
                                            
                                    //         Center(
                                    //           child: Container(
                                    //             height: 22,
                                    //             width: 22,
                                    //             decoration: BoxDecoration(
                                    //               borderRadius: BorderRadius.circular(6),
                                    //               border: Border.all(
                                    //                 color: Theme.of(context).iconTheme.color,
                                    //                 width: 2
                                    //               )
                                    //             ),
                                    //           ),
                                    //         ),

                                    //         Text('1', textAlign: TextAlign.center,
                                    //         style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    //           fontSize: 10.5,
                                    //           height: 1.5,
                                    //           color: Theme.of(context).iconTheme.color,
                                    //           fontWeight: FontWeight.bold
                                    //         ))
                                    //       ],
                                    //     ),
                                    // ),

                                    IconButton(
                                      tooltip: 'Favoritos',
                                      onPressed: (){
                                        biblePageController.cancelSelectionModeOnTap();
                                        Get.to(()=> HighlighterPage());
                                        /*
                                          Recuerda agregar biblePageController.cancelSelectionModeOnTap(),
                                          para evitar un posible bug al momento de entrar en modo
                                          seleccion y presionar alguna otra funccion en pantalla.
                                        */
                                      },
                                      icon: Icon(Icons.favorite_outline_rounded),
                                      iconSize: 30,
                                    ),

                                    IconButton(
                                      tooltip: 'Ajustes',
                                      onPressed: (){
                                        biblePageController.cancelSelectionModeOnTap();
                                        Get.to(()=> ReadPreferences());
                                        /*
                                          Recuerda agregar biblePageController.cancelSelectionModeOnTap(),
                                          para evitar un posible bug al momento de entrar en modo
                                          seleccion y presionar alguna otra funccion en pantalla.
                                        */
                                      },
                                      icon: Icon(Icons.settings_outlined),
                                      iconSize: 30,
                                    ),

                                    Container(width: 5,)

                                    // Container(
                                    //   height: 55,
                                    //   width: 55,
                                    //   child: PopupMenuButton(
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(6)
                                    //     ),
                                    //     tooltip: 'Opciones',
                                    //     icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),

                                    //     onSelected: (value) {
                                    //       switch (value) {
                                    //         case 1:
                                    //           Get.to(()=> HighlighterPage());
                                    //           break;
                                    //         case 2:
                                    //           break;
                                    //         case 3:
                                    //           break;
                                    //         case 4:
                                    //           Get.to(()=> ReadPreferences());
                                    //           break;
                                    //       }
                                    //     },

                                    //     itemBuilder: (context) {
                                    //       biblePageController.cancelSelectionModeOnTap();

                                    //       return <PopupMenuEntry<dynamic>>[

                                    //         PopupMenuItem(
                                    //           enabled: false,
                                    //           child: Container(
                                    //             child: Row(
                                    //               crossAxisAlignment: CrossAxisAlignment.center,
                                    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //               children: [
                                    //                 Padding(
                                    //                   padding: const EdgeInsets.symmetric(horizontal: 0),
                                    //                   child: CircleAvatar(
                                    //                     backgroundColor: Theme.of(context).accentColor,
                                    //                     child: Icon(
                                    //                       Icons.person,
                                    //                       color: Theme.of(context).canvasColor,
                                    //                     ),
                                    //                   ),
                                    //                 ),

                                    //                 Column(
                                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     Text(
                                    //                       'Luis Romero',
                                    //                       style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    //                         fontFamily: 'Roboto-Medium',
                                    //                         fontSize: 16.6,
                                    //                       ),
                                    //                     ),

                                    //                     Text(
                                    //                       'Desconectado',
                                    //                       style: Theme.of(context).textTheme.bodyText2.copyWith(
                                    //                         fontFamily: 'Roboto-Medium',
                                    //                         fontSize: 15,
                                    //                       ),
                                    //                     ),


                                    //                   ],  
                                    //                 )
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),

                                    //         PopupMenuDivider(),

                                    //         PopupMenuItem(
                                    //           value: 1,
                                    //           child: Row(
                                    //             children: <Widget>[
                                    //               Padding(
                                    //                 padding: const EdgeInsets.fromLTRB(2, 2, 12, 2),
                                    //                 child: Icon(FontAwesomeIcons.highlighter, color: Theme.of(context).iconTheme.color),
                                    //               ),
                                    //               Text('Resaltados')
                                    //             ],
                                    //           )
                                    //         ),

                                    //         PopupMenuItem(
                                    //           value: 2,
                                    //           child: Row(
                                    //             children: <Widget>[
                                    //               Padding(
                                    //                 padding: const EdgeInsets.fromLTRB(2, 2, 12, 2),
                                    //                 child: Icon(FontAwesomeIcons.solidStickyNote, color: Theme.of(context).iconTheme.color),
                                    //               ),
                                    //               Text('Notas')
                                    //             ],
                                    //           )
                                    //         ),

                                    //         PopupMenuItem(
                                    //           value: 3,
                                    //           child: Row(
                                    //             children: <Widget>[
                                    //               Padding(
                                    //                 padding: const EdgeInsets.fromLTRB(2, 2, 12, 2),
                                    //                 child: Icon(FontAwesomeIcons.bookReader, color: Theme.of(context).iconTheme.color),
                                    //               ),
                                    //               Text('Diario')
                                    //             ],
                                    //           )
                                    //         ),

                                    //         PopupMenuDivider(),

                                    //         PopupMenuItem(
                                    //           value: 4,
                                    //           child: Row(
                                    //             children: <Widget>[
                                    //               Padding(
                                    //                 padding: const EdgeInsets.fromLTRB(2, 2, 12, 2),
                                    //                 child: Icon(FontAwesomeIcons.wrench, color: Theme.of(context).iconTheme.color)
                                    //               ),
                                    //               Text('Preferencias')
                                    //             ],
                                    //           )
                                    //         ),
                                    //       ];
                                    //     }
                                    //   ),
                                    // ),

                                  ],
                                )
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
                                      highlight: biblePageController.versesRawList[index].highlight,
                                      selected: biblePageController.versesSelected.contains(index + 1),
                                      verseNumber: index + 1,
                                      title: biblePageController.versesRawList[index].title,
                                      text: biblePageController.versesRawList[index].text,
                                      colorHighlight: biblePageController.versesRawList[index].colorHighlight,
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
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
    
    
  }
}